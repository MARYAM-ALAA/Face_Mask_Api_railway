# 1. استخدم Python 3.10 (أو أي إصدار حديث)
FROM python:3.10-slim

# 2. منع البايثون من تخزين الـ pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. إنشاء فولدر داخل الكونتينر
WORKDIR /app

# 4. نسخ requirements.txt وتنصيب المكتبات
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 5. نسخ باقي الملفات
COPY . /app/

# 6. البورت اللي Railway يفتحه (بيقرأه من متغير PORT)
EXPOSE 8000

# 7. أمر التشغيل
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
