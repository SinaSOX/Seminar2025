# راهنمای راه‌اندازی سیستم کامپایل LaTeX فارسی

## خلاصه

این پروژه شامل یک سیستم کامل برای کامپایل خودکار اسناد LaTeX فارسی با پشتیبانی از XePersian و فونت‌های فارسی است.

## ویژگی‌های اصلی

✅ **پشتیبانی کامل از زبان فارسی** با استفاده از XePersian  
✅ **کامپایل خودکار** با GitHub Actions  
✅ **کامپایل محلی** با Makefile و اسکریپت‌ها  
✅ **پشتیبانی از فونت‌های فارسی** (B Nazanin, XB Roya)  
✅ **کامپایل با Docker** برای محیط‌های مختلف  
✅ **پشتیبانی از کتابنامه** (Bibliography)  

## روش‌های کامپایل

### 1. کامپایل محلی (Local)

#### نصب وابستگی‌ها:
```bash
# نصب TeX Live و فونت‌های فارسی
./scripts/install-dependencies.sh

# یا با استفاده از Makefile
make install-texlive
make install-fonts
```

#### کامپایل:
```bash
# کامپایل ساده
make all

# یا با اسکریپت
./scripts/compile.sh

# یا دستی
xelatex -interaction=nonstopmode -shell-escape seminar.tex
bibtex seminar
xelatex -interaction=nonstopmode -shell-escape seminar.tex
xelatex -interaction=nonstopmode -shell-escape seminar.tex
```

### 2. کامپایل با Docker

#### ساخت و اجرای کانتینر:
```bash
# کامپایل یکباره
docker-compose up latex-compiler

# کامپایل با نظارت بر تغییرات
docker-compose --profile watch up latex-watch

# پاک کردن فایل‌های موقت
docker-compose --profile clean up latex-clean
```

### 3. کامپایل خودکار با GitHub Actions

با هر push به branch اصلی، سند به صورت خودکار کامپایل می‌شود و PDF در بخش Artifacts قابل دانلود است.

## ساختار فایل‌ها

```
├── seminar.tex              # سند اصلی
├── MyTemplate.sty           # قالب LaTeX با پشتیبانی فارسی
├── .github/workflows/       # تنظیمات GitHub Actions
├── scripts/                 # اسکریپت‌های کامپایل
├── Makefile                 # دستورات کامپایل محلی
├── Dockerfile               # کانتینر Docker
├── docker-compose.yml       # تنظیمات Docker Compose
└── .vscode/settings.json    # تنظیمات VS Code
```

## عیب‌یابی

### مشکلات فونت
```bash
# بررسی نصب فونت‌ها
fc-list | grep -i nazanin
fc-list | grep -i roya

# نصب مجدد فونت‌ها
sudo apt-get install -y fonts-b-nazanin fonts-xb-royale
sudo fc-cache -fv
```

### مشکلات کامپایل
1. اطمینان از استفاده از XeLaTeX (نه pdfLaTeX)
2. بررسی نصب تمام پکیج‌های مورد نیاز
3. بررسی نصب صحیح فونت‌های فارسی
4. بررسی خطاهای نحوی در فایل‌های .tex

### مشکلات GitHub Actions
1. بررسی لاگ‌های Actions در تب Actions
2. اطمینان از commit شدن تمام فایل‌ها
3. بررسی صحت مسیر فایل workflow

## دستورات مفید

```bash
# کامپایل با نظارت بر تغییرات
make watch

# پاک کردن فایل‌های موقت
make clean

# پاک کردن همه چیز شامل PDF
make distclean

# نمایش راهنما
make help
```

## نکات مهم

1. **همیشه از XeLaTeX استفاده کنید** - pdfLaTeX از فونت‌های فارسی پشتیبانی نمی‌کند
2. **فونت‌های فارسی باید نصب باشند** - B Nazanin و XB Roya
3. **پکیج xepersian ضروری است** - برای پشتیبانی از راست به چپ
4. **کامپایل چندباره** - برای حل مراجع و کتابنامه

## پشتیبانی

برای مشکلات و سوالات:
1. بررسی بخش عیب‌یابی بالا
2. بررسی لاگ‌های GitHub Actions
3. ایجاد issue در repository
