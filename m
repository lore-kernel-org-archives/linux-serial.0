Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C15C616
	for <linux-serial@vger.kernel.org>; Sun, 11 Feb 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666669; cv=none; b=JhOLyn0KXTIAKrLxDCMDbw8FLCqyG+ENzXWu3ReYnMMSWXfIxcX/Ymrm3PtnCsgMerBM+ReTG/47LIQC0lEvHMS6Zc1hhwg+VbGGDe0qwWhJW0k2GFDUWOidDTE/rK3yDgiZkJNqja+vt7GRriLnlKmO0WqoCGqs1EaJlTRgecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666669; c=relaxed/simple;
	bh=C7G58o7Ad8N4MtzfXnXVqvo8i3Tm7f1f7W4QBsDnRQg=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=r3ZCEONwXDgV1WzU85o+Eaoe6Uqr2ytazUjIYJASp0P9QFg61A3242jiaEr0DaZQjS8pl9x3g46LxKTCtXUoZgQVtoqxqk41T/SyUqeGFMSSmuS1H9uugxL5bpRIcZq3SKvuKGItekbL+TsEFauGzRGi+0CHK7LK2ZQfRGsrzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaSlt5j+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaSlt5j+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b670d8a74so1518030f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Feb 2024 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707666666; x=1708271466; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJxHIzmGK5Bhrv8PKsT8eLxAYluXxcfu1uDCBGfJ8Uw=;
        b=ZaSlt5j+5RY/GIyJN0Khh0uEybc94aHOszg6aVcTKhVKSF0a0qAREGrBAhjHiAOnmt
         XPviAT6AzcDlm0hP9i8SjBNY215qQf6Cdmq4BxvervMT6L00mAaC7vYRSZ0meNKhIbsC
         Lzt+akzMJt/7vvCBTAz85SMX6HVd1a5JwYItrBKKBU4ZwT1Jty8nDbgGxN6aWzDusPet
         zYhN2cglLD3rYhEKJtFjwkc86iaACdxcELryCP3Zt7bAawOUPZp0sKDrEoRI53izwjVC
         RtSnnIuHaDoCZ9WPF2L6r7E5Xy+7ffBlBMRRu/ZrDg+yxm1ASKpG+Rngj7mZmDEuSxik
         7SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666666; x=1708271466;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJxHIzmGK5Bhrv8PKsT8eLxAYluXxcfu1uDCBGfJ8Uw=;
        b=umZmU51Ldn7Ti9n7oK+vEy0lgSi+CH4XBS449lCVcD8zghODHuktqGmhHGKDiVxncn
         OS+mgfSwIbnXE1hOrnWPpE+9xr/RRHxpaFe8Fz3fP1ISO5jkVUw0XOkLsVJBsubnTvmY
         sWkm196fq932H06AgZGjn7bJ8T5B1/5Yjnr9GrEqu6LQp0KJKLOsDlszUsI6M5gJp6O1
         odqmHtCsyBKqeLAJ+dBL+PWjctXjZ4AB7AiO2NOfH+ZJhEeDxXbJ51dh6XvCrApABPhO
         OOuytg1KQu4n23HlBJQOfUsYL20axiGEUE8gAMoRq5rGnUoSzmk306QfsuSnpzl0NLQ9
         fDDw==
X-Gm-Message-State: AOJu0Yw12viAqLN7D6iE6OLJtoLmWuXWahbj3zHD0jGPg293JJXRAtLo
	sx6u6IR+aa/sGUSXJThN3SRAhfjwI3YQZgF8UtCnV7IP4VkSr8eE
X-Google-Smtp-Source: AGHT+IE3r6r7wXEMqRmv+gP5LQLG7AgJQr8L3AAjrDPNXAF30Wd2hr2k3/5OqsHEnNj0z0PZYMdnog==
X-Received: by 2002:adf:a389:0:b0:33b:131b:d8c1 with SMTP id l9-20020adfa389000000b0033b131bd8c1mr2337155wrb.66.1707666665850;
        Sun, 11 Feb 2024 07:51:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnfbSWzw9WdGd7Y2XrNhVrazYTzAU7AGaiAdK4Ba3Ms9PgGacqYRxs26ngQsGpyfJMS3ZPj1aeE3cwSsC20D5yLli82PTGmtaMg/YhYGYJlhPbSZtxp6DYfSQu
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id bq26-20020a5d5a1a000000b0033b4335dce5sm4570906wrb.85.2024.02.11.07.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 07:51:05 -0800 (PST)
Message-ID: <bee9faa8-0ea7-4411-bf77-3cb2e06385c7@gmail.com>
Date: Sun, 11 Feb 2024 16:51:04 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs-CZ
To: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
Cc: linux-serial@vger.kernel.org, roman.zilka@gmail.com
Subject: [PATCH] tty/vt: Corrected doc of vc_sanitize_unicode(),
 vc_translate_unicode()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Corrected the doc of vc_sanitize_unicode() and vc_translate_unicode(),
tightly coupled functions which parse UTF-8 byte sequences.
1. Desc. of @rescan corresponded to the meaning of the return value -1.
   Corrected + added "Return:" section.
2. Replaced the ambiguous "character" with "code point" or "byte".

Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
---
 drivers/tty/vt/vt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 463be4e48dc8..4342c47285fe 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2780,7 +2780,7 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 
 /**
  * vc_sanitize_unicode - Replace invalid Unicode code points with ``U+FFFD``
- * @c: the received character, or ``U+FFFD`` for invalid sequences.
+ * @c: the received code point
  */
 static inline int vc_sanitize_unicode(const int c)
 {
@@ -2793,13 +2793,21 @@ static inline int vc_sanitize_unicode(const int c)
 /**
  * vc_translate_unicode - Combine UTF-8 into Unicode in &vc_data.vc_utf_char
  * @vc: virtual console
- * @c: character to translate
- * @rescan: we return true if we need more (continuation) data
+ * @c: UTF-8 byte to translate
+ * @rescan: set to true iff @c wasn't consumed here and needs to be re-processed
  *
- * * &vc_data.vc_utf_char is the being-constructed unicode character.
+ * * &vc_data.vc_utf_char is the being-constructed Unicode code point.
  * * &vc_data.vc_utf_count is the number of continuation bytes still expected to
  *   arrive.
  * * &vc_data.vc_npar is the number of continuation bytes arrived so far.
+ *
+ * Return:
+ * * %-1 - Input OK so far, @c consumed, further bytes expected.
+ * * %0xFFFD - Possibility 1: input invalid, @c may have been consumed (see
+ *             desc. of @rescan). Possibility 2: input OK, @c consumed,
+ *             ``U+FFFD`` is the resulting code point. ``U+FFFD`` is valid,
+ *             ``REPLACEMENT CHARACTER``.
+ * * otherwise - Input OK, @c consumed, resulting code point returned.
  */
 static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 {

base-commit: 6cc3028f797a549f256d593867a769ab6a8265f2
-- 
2.43.0

