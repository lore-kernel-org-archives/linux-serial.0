Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQnW8shr"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A3AA
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 07:13:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so87148151fa.3
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394002; x=1702998802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKc9gj2X/D2+ZWR333vy3zHWMTRptAn3tWjYltjpELA=;
        b=UQnW8shrnbg1K6oCt1kuirKiGh9hZgfVEIDRncHMrL4/GbehvrlCN29nmPOposmrvI
         ocin8bvzBTu4gPOniX6SbKO3vbE38BXMQPG2zK7Wpr/3gpcENfseXvDKtyGhgYS7F2x5
         UqVyLVHsDoD9iVFBYg5tG6vLDWozqSA+X3jSkxHo3CBzzICvZemFUws1Jnt+p4JxrRCg
         HUzB5cZvgIOPaGXBZp94zJeJGSGBZH9RyIfIJKK3MdXGLL8o/k6cD8Q8M+Ae0YUkTi5v
         m5EG3yYwooQaaDHm/J0aJjjYrP9o913LdoOZ7g8IjGAx9o80yY6ILk8MKcDlQaXjp/9e
         NxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394002; x=1702998802;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QKc9gj2X/D2+ZWR333vy3zHWMTRptAn3tWjYltjpELA=;
        b=q5VI2smKROi0kmhDiOiJAAEXbr32s6o8FMysEBIVElpgMruMqIPdIZnUzUFWC3E02C
         gfZPFY99PxfhSzv1/FQCbM57WoktcM5CwmTHw5t4vPvheGk2zXAqKz3pUw+FNSByqyqJ
         HXf0/uFtV3CXhiD5wnNGrTdqYlEj7U5gMIztTjvZo6GZmsWik0ErAEMuztc691MoYO7E
         9NgdQefWYv2qcYkDXiFMaii1h6dvBZBdUdcwsffanbCux0d6Oi3FGOP98EYbVHcoG2z+
         Hb+Z5qNKUfBnufOLEhR50gzvrddJI8uHRkG8T/lDAz936Swc9zZPSLWvNg2y5p4ag09c
         mM+A==
X-Gm-Message-State: AOJu0YxNj/nSRW/bqkY4VbGB4nvhjkHbQk8idDJ5QJJSMXJYK4BGU4ml
	Y6nbPGunzTJq/A73Qgfkc6jcuBxcUBPrAjbI
X-Google-Smtp-Source: AGHT+IG7i0EsZyhSJojU7B7COrfU04W+pxYFufq8v01s2IIG6PIvhTr5mzvDgLlQKGrYSh7Fq7w9xA==
X-Received: by 2002:a05:651c:997:b0:2cc:21cb:4192 with SMTP id b23-20020a05651c099700b002cc21cb4192mr2928811ljq.97.1702394001612;
        Tue, 12 Dec 2023 07:13:21 -0800 (PST)
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id bq18-20020a056402215200b0054db440489fsm4711537edb.60.2023.12.12.07.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:13:21 -0800 (PST)
Message-ID: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
Date: Tue, 12 Dec 2023 16:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs-CZ
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
Subject: [PATCH] tty/vt: UTF-8 parsing update according to RFC 3629, modern
 Unicode
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, roman.zilka@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vc_translate_unicode() and vc_sanitize_unicode() parse input to the
UTF-8-enabled console, marking invalid byte sequences and producing Unicode
codepoints. The current algorithm follows ancient Unicode and may accept invalid
byte sequences, pass on non-existent codepoints and reject valid sequences.

The patch restores the functions' compliance with modern Unicode (v15.1 + many
previous versions) as well as RFC 3629.
1. Codepoint space is limited to 0x10FFFF.
2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in Unicode and
   will be accepted. Another option was to complete the set of noncharacters
   (used to be just those two, now there's more) and preserve the rejection
   step. This is indeed what Unicode suggests (v15.1, chap. 23.7) (not
   requires), but most codepoints are !iswprint(), so selecting just the
   noncharacters seemed arbitrary and futile (and unnecessary).

On the side:
3. What remained of vc_sanitize_unicode() is in vc_translate_unicode().
4. Corrected vc_translate_unicode() doc (@rescan).

This is not a security patch. I'm not aware of any present security implications
of the old code.

Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
---
 drivers/tty/vt/vt.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..215e162ec8af 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2587,23 +2587,11 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 }
 
 
-/**
- * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
- * @c: the received character, or U+FFFD for invalid sequences.
- */
-static inline int vc_sanitize_unicode(const int c)
-{
-	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
-		return 0xfffd;
-
-	return c;
-}
-
 /**
  * vc_translate_unicode - Combine UTF-8 into Unicode in @vc_utf_char
  * @vc: virtual console
- * @c: character to translate
- * @rescan: we return true if we need more (continuation) data
+ * @c: UTF-8 byte to translate
+ * @rescan: true => @c wasn't translated here and needs to be re-processed
  *
  * @vc_utf_char is the being-constructed unicode character.
  * @vc_utf_count is the number of continuation bytes still expected to arrive.
@@ -2611,10 +2599,7 @@ static inline int vc_sanitize_unicode(const int c)
  */
 static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 {
-	static const u32 utf8_length_changes[] = {
-		0x0000007f, 0x000007ff, 0x0000ffff,
-		0x001fffff, 0x03ffffff, 0x7fffffff
-	};
+	static const u32 utf8_length_changes[] = {0x7f, 0x7ff, 0xffff, 0x10ffff};
 
 	/* Continuation byte received */
 	if ((c & 0xc0) == 0x80) {
@@ -2629,12 +2614,12 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 
 		/* Got a whole character */
 		c = vc->vc_utf_char;
-		/* Reject overlong sequences */
+		/* Reject overlong sequences and surrogates */
 		if (c <= utf8_length_changes[vc->vc_npar - 1] ||
-				c > utf8_length_changes[vc->vc_npar])
+				c > utf8_length_changes[vc->vc_npar] ||
+				(c & 0xfff800) == 0x00d800)
 			return 0xfffd;
-
-		return vc_sanitize_unicode(c);
+		return c;
 	}
 
 	/* Single ASCII byte or first byte of a sequence received */
@@ -2660,14 +2645,7 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 	} else if ((c & 0xf8) == 0xf0) {
 		vc->vc_utf_count = 3;
 		vc->vc_utf_char = (c & 0x07);
-	} else if ((c & 0xfc) == 0xf8) {
-		vc->vc_utf_count = 4;
-		vc->vc_utf_char = (c & 0x03);
-	} else if ((c & 0xfe) == 0xfc) {
-		vc->vc_utf_count = 5;
-		vc->vc_utf_char = (c & 0x01);
 	} else {
-		/* 254 and 255 are invalid */
 		return 0xfffd;
 	}
 

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.41.0

