#!/bin/bash
# ============================================================
# X18ex Whitepaper → Netlify CLI Deployment Script
# ============================================================
# Hướng dẫn sử dụng:
#   1. Cấp quyền chạy script:
#      chmod +x deploy-to-netlify.sh
#   2. Chạy script:
#      ./deploy-to-netlify.sh
# ============================================================

set -e

echo "🚀 === X18ex Whitepaper → Netlify CLI Deployment ==="
echo ""

# Bước 1: Build mã nguồn VitePress
echo "📦 Bước 1: Khởi tạo build VitePress..."
npm run build
echo "✅ Build thành công! Mã nguồn tĩnh nằm tại thư mục: .vitepress/dist"
echo ""

# Bước 2: Kiểm tra Netlify CLI
echo "🔍 Bước 2: Kiểm tra cài đặt Netlify CLI..."
if ! command -v netlify &> /dev/null; then
    echo "⚠️  Netlify CLI chưa được cài đặt."
    echo "📥 Đang tiến hành cài đặt Netlify CLI toàn cục (global)..."
    echo "   (Có thể yêu cầu nhập mật khẩu sudo của máy nếu cần thiết)"
    npm install -g netlify-cli
else
    echo "✅ Netlify CLI đã sẵn sàng!"
fi
echo ""

# Bước 3: Đăng nhập Netlify (chỉ cần làm 1 lần)
echo "🔑 Bước 3: Kiểm tra trạng thái đăng nhập Netlify..."
if ! netlify status &> /dev/null; then
    echo "➡️  Bạn cần đăng nhập Netlify. Đang mở trình duyệt để đăng nhập..."
    netlify login
else
    echo "✅ Bạn đã đăng nhập thành công!"
fi
echo ""

# Bước 4: Deploy lên Netlify
echo "🌐 Bước 4: Bắt đầu Deploy lên Netlify..."
echo "💡 Nếu đây là lần đầu tiên deploy, CLI sẽ hỏi bạn:"
echo "   - Create & configure a new site (Tạo site mới) hay Link to an existing site (Liên kết site cũ)"
echo "   - Chọn team của bạn"
echo "   - Chọn site name (Tên miền phụ của bạn)"
echo ""
read -p "👉 Nhấn Enter để bắt đầu quá trình deploy thực tế..."

netlify deploy --prod --dir=.vitepress/dist

echo ""
echo "============================================================"
echo "🎉 DEPLOYMENT HOÀN TẤT!"
echo "============================================================"
echo "💡 Bạn có thể quản lý site và cấu hình Domain riêng (Custom Domain) miễn phí tại:"
echo "   https://app.netlify.com"
echo "============================================================"
