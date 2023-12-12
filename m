Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0WS2y4y"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39132D5
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 08:23:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so7583058a12.3
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702398183; x=1703002983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClmSAuo0m3ZuREjyuQqDjMrvQUtQgKWFV+hoH77ZZag=;
        b=e0WS2y4ycorgzwoOwQTmBH4ojJfIFo5R3f1q1d/VFuewnKcbFb6KrRTgXrNPXUqxvY
         cTjAM2F9et15cSIF5PmRkk4I+aC/7OU3DJ+ZOiiBZcG3GwZ+T3S/EkB+rqxgKJQC8Diz
         0Q7XRtNTettdVE+/SZtW/olfoRjG18PEDs3eVahjFC78B/Zmn7GUZfC+ASHCWj0v2s7/
         gZHDoeG+sCUP9CN9UaW6VCrukpKdyf5w9/N88duVVFQ5IVsat9wNng+Inx7dHuW8dd/g
         m6G6RriboK83nBm3Bw7xwYFzGq8z9qXa8xZOc9GRYUjZkZmPkc/vh3yEhi8Z/ekGxB34
         UUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398183; x=1703002983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClmSAuo0m3ZuREjyuQqDjMrvQUtQgKWFV+hoH77ZZag=;
        b=qmmDVz6FeRaWv92/8x+/VBy7ZbRZLR9mpaxl4WQslljvwOfFAT/3DX1roqUgdBkOsF
         pgCswXE3Syrii+9ZZSJWKqyPG7HvaKKY651mHTpLqOW9406MDpI/qWkKApWWaFEMPwvz
         SykY0X+ADq6uuq+oue4d2uIYb+dkIqOMqSXRB9tpNRW/i9+lGLZfhX2OU9lKnL19ppi5
         lwY6LdKw0IWGIui40+MFtqBayxLxTC6nJqZe4xdr+r2m72l5How/rQEnzbxRgX1e7GVE
         9sNUfZwL8yPIP7Zf+JE9301XB3Sd5E0c7DTwTpnNcFTsDQU/Gt+sxc3JymZTun70BTX0
         UUHg==
X-Gm-Message-State: AOJu0Yzh45xGYbYqtC95iIr7BKxwzOebgKweFxeIE3ncgxGyCLI9lxJ1
	dZW0gJJo+e8x98yNTwG9oplinmG9V8Wc5J0h
X-Google-Smtp-Source: AGHT+IFV1Jx5BpqRwEwnsM8IuWOZcwU8wUPjNX/NDf2EVqcRO22GJ0uj6bBy0Tc9X336XMaQ/1Vg8A==
X-Received: by 2002:a05:6402:5c1:b0:54c:53a6:c49 with SMTP id n1-20020a05640205c100b0054c53a60c49mr3864028edx.16.1702398182458;
        Tue, 12 Dec 2023 08:23:02 -0800 (PST)
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id ev14-20020a056402540e00b005519a444a6asm549932edb.71.2023.12.12.08.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:23:02 -0800 (PST)
Message-ID: <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
Date: Tue, 12 Dec 2023 17:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] tty/vt: UTF-8 parsing update according to RFC 3629, modern
 Unicode
Content-Language: en-US, cs-CZ
To: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, roman.zilka@gmail.com
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
 <2023121201-ecosphere-polyester-8d37@gregkh>
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
In-Reply-To: <2023121201-ecosphere-polyester-8d37@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Roman Žilka <roman.zilka@gmail.com>

vc_translate_unicode() and vc_sanitize_unicode() parse input to the
UTF-8-enabled console, marking invalid byte sequences and producing Unicode
codepoints. The current algorithm follows ancient Unicode and may accept
invalid byte sequences, pass on non-existent codepoints and reject valid
sequences.

The patch restores the functions' compliance with modern Unicode (v15.1 +
+ many previous versions) as well as RFC 3629.
1. Codepoint space is limited to 0x10FFFF.
2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in
   Unicode and will be accepted. Another option was to complete the set of
   noncharacters (used to be just those two, now there's more) and preserve
   the rejection step. This is indeed what Unicode suggests (v15.1, chap.
   23.7) (not requires), but most codepoints are !iswprint(), so selecting
   just the noncharacters seemed arbitrary and futile (and unnecessary).

On the side:
3. What remained of vc_sanitize_unicode() is in vc_translate_unicode().
4. Corrected vc_translate_unicode() doc (@rescan).

This is not a security patch. I'm not aware of any present security
implications of the old code.

Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
---
v2: A more elaborate commit msg, e-mail formatting corrections.

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

