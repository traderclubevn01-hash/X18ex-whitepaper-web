#!/bin/bash
# ============================================================
# X18ex Whitepaper → GitBook Deployment Script
# ============================================================
# Cách sử dụng:
#   1. Tạo GitHub Personal Access Token tại: https://github.com/settings/tokens
#      - Chọn "Generate new token (classic)"
#      - Tích chọn scope: repo (full control)
#      - Copy token
#   2. Chạy script:
#      ./deploy-to-gitbook.sh <GITHUB_TOKEN>
# ============================================================

set -e

GITHUB_TOKEN="$1"
GITBOOK_TOKEN="gb_api_eY5XR27m9vngfWRkHgpkgX1mNRcMcy2tC7FtM41m"
GITBOOK_SPACE_ID="AKSeuxkI1NWTBcb7GBV0"
REPO_NAME="X18ex-whitepaper"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Thiếu GitHub Token!"
    echo ""
    echo "📋 Hướng dẫn lấy GitHub Token:"
    echo "   1. Truy cập: https://github.com/settings/tokens"
    echo "   2. Click 'Generate new token (classic)'"
    echo "   3. Đặt tên: 'X18ex Whitepaper'"
    echo "   4. Tích chọn: ✅ repo (Full control)"
    echo "   5. Click 'Generate token'"
    echo "   6. Copy token và chạy lại:"
    echo ""
    echo "   ./deploy-to-gitbook.sh ghp_xxxxxxxxxxxxxxxx"
    exit 1
fi

echo "🚀 === X18ex Whitepaper → GitBook Deployment ==="
echo ""

# Step 1: Get GitHub username
echo "📌 Step 1: Xác thực GitHub..."
GH_USER=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user | python3 -c "import json,sys; print(json.load(sys.stdin).get('login',''))" 2>/dev/null)

if [ -z "$GH_USER" ]; then
    echo "❌ GitHub Token không hợp lệ!"
    exit 1
fi
echo "   ✅ Đăng nhập: $GH_USER"

# Step 2: Create GitHub repo
echo ""
echo "📌 Step 2: Tạo GitHub repository..."
REPO_CHECK=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$GH_USER/$REPO_NAME")

if [ "$REPO_CHECK" = "200" ]; then
    echo "   ⚡ Repo đã tồn tại: $GH_USER/$REPO_NAME"
else
    curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"name\": \"$REPO_NAME\", \"description\": \"X18ex DEX Whitepaper — AI-Native Multi-Chain DEX\", \"private\": false}" \
        https://api.github.com/user/repos > /dev/null 2>&1
    echo "   ✅ Tạo repo: github.com/$GH_USER/$REPO_NAME"
fi

# Step 3: Push to GitHub
echo ""
echo "📌 Step 3: Push whitepaper lên GitHub..."

# Configure git
git config user.name "$GH_USER"
git config user.email "$GH_USER@users.noreply.github.com"

# Set remote
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GH_USER:$GITHUB_TOKEN@github.com/$GH_USER/$REPO_NAME.git"

# Force push
git push -u origin main --force 2>&1
echo "   ✅ Push thành công!"

# Step 4: Import to GitBook
echo ""
echo "📌 Step 4: Import vào GitBook Space..."
sleep 3  # Wait for GitHub to process

IMPORT_RESULT=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
    -H "Authorization: Bearer $GITBOOK_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"url\": \"https://github.com/$GH_USER/$REPO_NAME.git\",
        \"ref\": \"refs/heads/main\",
        \"force\": true
    }" \
    "https://api.gitbook.com/v1/spaces/$GITBOOK_SPACE_ID/git/import")

if [ "$IMPORT_RESULT" = "204" ] || [ "$IMPORT_RESULT" = "200" ]; then
    echo "   ✅ Import thành công!"
else
    echo "   ⚠️  Import HTTP $IMPORT_RESULT — có thể cần vài giây..."
fi

# Step 5: Set visibility to public
echo ""
echo "📌 Step 5: Cập nhật settings..."

curl -s -X PATCH \
    -H "Authorization: Bearer $GITBOOK_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"visibility": "public", "editMode": "live"}' \
    "https://api.gitbook.com/v1/spaces/$GITBOOK_SPACE_ID" > /dev/null 2>&1

echo "   ✅ Space đã public!"

# Final info
echo ""
echo "============================================================"
echo "🎉 DEPLOYMENT THÀNH CÔNG!"
echo "============================================================"
echo ""
echo "📖 GitBook URL:"
echo "   https://app.gitbook.com/o/UmakPuqAR5AkhGWY1eS5/s/$GITBOOK_SPACE_ID/"
echo ""
echo "📦 GitHub Repo:"
echo "   https://github.com/$GH_USER/$REPO_NAME"
echo ""
echo "⚡ Lần sau cập nhật, chỉ cần:"
echo "   git add -A && git commit -m 'Update' && git push"
echo "   Rồi chạy lại Step 4 (import) hoặc setup Git Sync trên GitBook."
echo "============================================================"
