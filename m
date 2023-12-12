Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTt+aow8"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67191D3
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 12:26:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-55202565d48so26158a12.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702412815; x=1703017615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwW372HIyXXEZbOKIIfkQaQvi+3LIG/VtEtwTWD8RlI=;
        b=cTt+aow81z/4/6Let5IpuPVYHYFKSpSLiTRfYWOU0aUYpCBVvxPxFInXSwptNXn9HD
         m2ZiUEg+fNZfoHSK3Fn02C+c+DOgXyCfyBHKJwR9VMN4X8iQ+8rTPC+PSGPzMu96nYBR
         x89znHNyAgMLO4XZIf2AiNruW8jqV29CGwK2j6TrU+WAe1OdW0JWww9IOnUN9oPsbkX3
         am9HZI2O9XBblmra0RPi9IRNg9zXxopR9GOy9RrWSFqibWDSUqnIpdCTkGRlEWJCRH3s
         fhPVLAjfVD3IdQ53A/z58CmBxxmZORD2CyAglKHkR2r7om7boKVHl8U/JRIBkPC7UkT0
         0DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412815; x=1703017615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwW372HIyXXEZbOKIIfkQaQvi+3LIG/VtEtwTWD8RlI=;
        b=MKRyumFCSTLcpeM2jcyimkjW3L+67NIs2tuuw/XH7whwxbljmFs0kHCARgxeW3+NfF
         NPU18+0emwrXdEH1LAuSVNq74NVg0AOFyJQVQnRdwT7EmQ79uLoXZlJtKt/Ixbdw1T+0
         Hp5J3m2/qqNhmBmTuDRJwfSwJiDhdBGH2jk7XfLtrY888COSzb2thJpuyD3kaUtWZWGn
         A+iYEeY6vL4t0e60kSeBz5yx/FRl6uHtcu8onyKm03+UObMp47xyzo4IlqCSU84lRDSO
         jRFAsjXKVMC28ELZWFV+8NzMdg9TRbu4q4mPuwajr0Hbmg03MjUpXYDX5JRSilz5Z3Qh
         TVrQ==
X-Gm-Message-State: AOJu0YyrTC4sZ0xrnQiDOhji5AcEBSiJWp/NW49eYsh0BQFBQ+YaouuZ
	WI8UJt1MOQYDMqZoDSeEGJk=
X-Google-Smtp-Source: AGHT+IGyhnvYIP84XzNqjR7F2Ls3HfCIKoArmF8mNh4ZUYHtskB6v3FfRxUQrUTwZCrTXUlAqBcJpg==
X-Received: by 2002:a05:6402:5175:b0:54c:5351:3546 with SMTP id d21-20020a056402517500b0054c53513546mr3957659ede.64.1702412814519;
        Tue, 12 Dec 2023 12:26:54 -0800 (PST)
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id a4-20020a509e84000000b0054ccc3b2109sm5192317edf.57.2023.12.12.12.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:26:54 -0800 (PST)
Message-ID: <e5e7fd4f-acac-41a0-8a36-1f4f71eb7c18@gmail.com>
Date: Tue, 12 Dec 2023 21:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] tty/vt: UTF-8 parsing update according to RFC 3629, modern
 Unicode
Content-Language: en-US, cs-CZ
To: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, roman.zilka@gmail.com
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
 <2023121201-ecosphere-polyester-8d37@gregkh>
 <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
In-Reply-To: <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vc_translate_unicode() and vc_sanitize_unicode() parse input to the
UTF-8-enabled console, marking invalid byte sequences and producing Unicode
codepoints. The current algorithm follows ancient Unicode and may accept
invalid byte sequences, pass on non-existent codepoints and reject valid
sequences.

The patch restores the functions' compliance with modern Unicode (v15.1 [1]
+ many previous versions) as well as RFC 3629 [2].
1. Codepoint space is limited to 0x10FFFF.
2. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in
   Unicode and will be accepted. Another option was to complete the set of
   noncharacters (used to be just those two, now there's more) and preserve
   the rejection step. This is indeed what Unicode suggests (v15.1, chap.
   23.7) (not requires), but most codepoints are !iswprint(), so selecting
   just the noncharacters seemed arbitrary and futile (and unnecessary).

On the side:
3. Corrected/improved the doc of the two functions (esp. @rescan).

This is not a security patch. I'm not aware of any present security
implications of the old code.

[1] https://www.unicode.org/versions/Unicode15.1.0
[2] https://datatracker.ietf.org/doc/html/rfc3629

Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
---

v2: A more elaborate commit msg, e-mail formatting corrections.
v3: Shortened patch as requested. The gist of it is unchanged. Added links
    to commit msg. Changed base to current tty-next.

 drivers/tty/vt/vt.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..373f94f55ff2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2589,11 +2589,11 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 
 /**
  * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
- * @c: the received character, or U+FFFD for invalid sequences.
+ * @c: the received code point
  */
 static inline int vc_sanitize_unicode(const int c)
 {
-	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
+	if (c >= 0xd800 && c <= 0xdfff)
 		return 0xfffd;
 
 	return c;
@@ -2602,8 +2602,8 @@ static inline int vc_sanitize_unicode(const int c)
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
@@ -2611,10 +2611,7 @@ static inline int vc_sanitize_unicode(const int c)
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
@@ -2660,14 +2657,7 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
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
 

base-commit: e045e18dbf3eaac32cdeb2799a5ec84fa694636c
-- 
2.41.0

