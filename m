Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404E364B9
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEJPd3X1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so2372373a12.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jan 2024 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704797028; x=1705401828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcmeoD2bJyWOf7IQDedH3O4hl0wwNrcGm20KYO0O+1A=;
        b=BEJPd3X1ZD+SsQR2jygF6SztWcrt2Z5mVswkZFJtY+9fkl7ylLYjmn7vjhHSDCUDRg
         AqKIsyQidaF+Dr1s1xZpI7Kya0N+vGV6oQPd+7pD+LbjYbR4vyVrkplOpu9QEyy8Tr0n
         nN0H3qE8tQm+evoea1UomIyMm/2u1XE/WtXltxG1nPALCais93S9+feY4PKaprCQ7xYJ
         J6vH6JH+2x7/mLmjADDBteXb5nAsoqjk9jSFMw0EEYliUrVGr7IwfFbPdPxmuGjjZnAC
         9W28VC9qoSHLNdqRPTxZVte3GLJ1unTvMRNsrJwsP/zWiRkV3d667ruQhEHr5gbn+wiN
         upRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704797028; x=1705401828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcmeoD2bJyWOf7IQDedH3O4hl0wwNrcGm20KYO0O+1A=;
        b=o8V/CvVrFSWZ/y9uLk5KXdyfkQhuSdeMdQHYb8wYDlYRf9dR0TPdSBHqloe9w/HzpQ
         sE0NV9qMQqc2/dticmZOrtkz6+acWXK7+kkGUoyZUb4aRE/EwNxPaZRgiMV9+bVDvQ4J
         gVL/aaPGir7UzQL8GH46bKHuSdDc3onVZ9VaMSgOeEADqhJ9Bty1Xt9Hs9Ix0bqFy6g9
         5qcZwgEc0/rLEATTnikFmJMvXtfm5ez/ym0veTvEvXCVPbci08CuC9JAO4uJP74PU2io
         nakDRysALmMk2F+jQxDjw0VbpoWK912ycEgVQCiKgoC88pmVZbdMiKwPNZovphl7+eAX
         +wkA==
X-Gm-Message-State: AOJu0YwVz4pi3XcTRrWDqgu0IOQqfbwca5hT8cHkpfsCeNsmxgFLJdFN
	K55IIfnRDC0mzjIPZ/BEoCM=
X-Google-Smtp-Source: AGHT+IFhW9tG28oYinC8x3ZP208EX7BmIi/dgQ/XdSAQoM6jXrBFu4Ih1oXzLW4gaZyFaVJgmWKdng==
X-Received: by 2002:a50:a68b:0:b0:557:1006:40a8 with SMTP id e11-20020a50a68b000000b00557100640a8mr2993861edc.5.1704797027831;
        Tue, 09 Jan 2024 02:43:47 -0800 (PST)
Received: from [192.168.1.2] (ip4-83-240-121-90.cust.nbox.cz. [83.240.121.90])
        by smtp.gmail.com with ESMTPSA id p16-20020a056402075000b00554753ec02fsm815020edy.86.2024.01.09.02.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:43:47 -0800 (PST)
Message-ID: <598ab459-6ba9-4a17-b4a1-08f26a356fc0@gmail.com>
Date: Tue, 9 Jan 2024 11:43:46 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] tty/vt: UTF-8 parsing update according to RFC 3629, modern
 Unicode
Content-Language: en-US, cs-CZ
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, roman.zilka@gmail.com
References: <14027090-ca91-45ca-90d4-75456c0f2c76@gmail.com>
 <2023121201-ecosphere-polyester-8d37@gregkh>
 <834b6344-55dd-4a92-b1db-8d60d2b40a3e@gmail.com>
 <e5e7fd4f-acac-41a0-8a36-1f4f71eb7c18@gmail.com>
 <2024010413-quickly-crinkly-6c5b@gregkh>
From: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>
In-Reply-To: <2024010413-quickly-crinkly-6c5b@gregkh>
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
   the rejection step. This is indeed what Unicode suggests ([1] chap.
   23.7) (not requires), but most codepoints are !iswprint(), so selecting
   just the noncharacters seemed arbitrary and futile (and unnecessary).

This is not a security patch. I'm not aware of any present security
implications of the old code.

[1] https://www.unicode.org/versions/Unicode15.1.0
[2] https://datatracker.ietf.org/doc/html/rfc3629

Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
---

v2: A more elaborate commit msg, e-mail formatting corrections.
v3: Shortened patch as requested. The gist of it is unchanged. Added links
    to commit msg. Changed base to current tty-next.
v4: Removed func doc correction as requested. Updated base to current
    tty-next.

 drivers/tty/vt/vt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..35c2ab8c5280 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2593,7 +2593,7 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
  */
 static inline int vc_sanitize_unicode(const int c)
 {
-	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
+	if (c >= 0xd800 && c <= 0xdfff)
 		return 0xfffd;
 
 	return c;
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
 

base-commit: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056
-- 
2.41.0

