Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281F158870;
	Mon, 24 Feb 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400796; cv=none; b=q8C7YodA4gFykt51HJtDe+VQ9R0ZuoUXTbz9ACQgtiWIR1zUNwfGPtWXdufyBuBCSsuGl23Ey9slj3Nl8y2zk4S0AR73tqi2DrgqpqS/cqasK1M2I8/eTSXq6otKlDo/foV9nmvkd64u2rtFvjRS8khf8Syp5xv3wVSfsUxv0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400796; c=relaxed/simple;
	bh=mQrSem63eAwDgMpxp7wwl6JnlMigX+QUakiidqHVY9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii87wXEy78axIi+C7aiA/bJErv6IsvCQ7tnQAa8P6/upq1ma1SeiKT8OnNHxSLuHouu12HKTB0GaQfXjXiyC7POCGevn5HXpkZXihEdMjQU3mY17Z1KMKv6h4NNLH3iiwH75eEWQXz16Fem5S8U5n4z2Feu6vJ+58KBubd7Yo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReeIzSqj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReeIzSqj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0bb7328fbso443836085a.2;
        Mon, 24 Feb 2025 04:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400794; x=1741005594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=ReeIzSqj6pKo34STxlr6+eTUeuVjEczlCOfo6NNSEM7AH0N7eQ5cyhOiLNqtNNShh5
         wb6yoZOwNVwsVc0Ml5O5pzBR2sEQ8LP4+Y6BbThQQ7/JFp7wV35HF1iBfHMhniboZeY4
         eMcLOfva+tS000aMwwUzAqmiKYu0qD0CHum+3VFcSjVM6tqm1N7gbHudYUqQNMfUCQpX
         lfWD3KsU338LvEk9zoj1CketIiqMxawpS90miYF5PdXCsqUuNrN+bhrCHBryOGYhtd7I
         FbUiQmePovVe0Y0ilZNb1ChQCdQ5UvqnNywlWjRQBWXFTdWbmWR9rTEW8QxNpqnZVhfV
         SFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400794; x=1741005594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=TIT/iX4bhTK/Enc0ZcS83Lj0lMvbLyLoLmtNUEHxx37NhuspKA1wsGJqQPdtZFajE8
         AI+W0cmS+i8zlY7U2x+6xYU9cdJjBvU4CsBaEwd7TA/PYDweEF5gjJJPPEWHL4dhgHxm
         Ck8UmC07lzsqqUK3H7GqyRDfzb3bCQXlTqJoqqYs7enXgMWxykd4VLMlw+c7nOXDTS5s
         AjqwU1lteJpPI7D+EbhaaXp09yNg/Q99Lvb7wUrrzIjovF3s249818uuvlOOv0zsbMfd
         riO7vuG+7oy+lv01ccykFimRpZzA67cbSR7IEhk5TupUvFFbrPGXOMho5mTvYFMHjGkm
         ofbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaLddLV7osz8CtGsjmgDqq9A9lsTJeX4Q6s7KxSymQWf8wj2GGVOc8LpaWDFB7HL+LFXeVAYkRs5FNVr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wlCmypY1hbzRMyZ1Pf4Sn1YsiA+3vICp6V0vRu21Ef1if54b
	qQ43PTz2aJ7cMuElEz1Yvxc6qgAAIYIjfNmmwSWCIX6tzLd9P6iCoew6g6X7
X-Gm-Gg: ASbGnct1f6Jy2QZ/gbJ0Ap1w7Y7AnRDC0K5eBHfQe34BVKHAbTYXZPJ6iZjA+WY64WV
	hK+cOhjjV4TvHil4ea0PmMSbyptLVjTL7V892sqFl/jaDMyYMPRHbowT1iHTx3Jlr77bb4hEA85
	b2cGwo0s8bKi1wSHBoPo9usGIAfUh+FiDH4AOnM47mNE9Okb7u4dltU6eni58tKY3bKtJ/TetNZ
	Gou2nKiFLQdnZWnpe++ArwnV7znBgrUie43rqyCbgqhgtNJ4H+266adqQoj0D6/+VPEylvwqdom
	NTGk/9EPO0PDfou4Q9BY2hKP1WOY639b7lHPKaD6J9mooivB44w7INTQm2MT3Cwz
X-Google-Smtp-Source: AGHT+IGewqI0D6fSQ2f8amV5opff91jk74/pka41GoNB6s8+FHOKcD0/Vres07yKplxXkxSF6rC/Ng==
X-Received: by 2002:a05:620a:45ac:b0:7c0:c4a0:bff2 with SMTP id af79cd13be357-7c0cef66bb4mr2353012885a.54.1740400793915;
        Mon, 24 Feb 2025 04:39:53 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3cb7:1064:72b6:f891])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad774f81sm831922785a.37.2025.02.24.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:39:53 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Mon, 24 Feb 2025 07:39:14 -0500
Message-ID: <20250224123915.2859682-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224123915.2859682-1-adamsimonelli@gmail.com>
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

The new config option, CONFIG_NULL_TTY_CONSOLE will allow ttynull to be
initialized by console_initcall() and selected as a possible console
device.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/ttynull.c | 20 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..b4afae8b0e74 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,20 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_CONSOLE
+        bool "Support for console on ttynull"
+        depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is similar to CONFIG_VT_CONSOLE, but without the dependency on
+	  CONFIG_VT. It uses the ttynull driver as the system console.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..ec3dd3fd41c0 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,13 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+
+	/*
+	 * Match the index and flags from other boot consoles when CONFIG_NULL_TTY_CONSOLE is
+	 * enabled, otherwise, use the default values for the index and flags.
+	*/
+	.index = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? -1 : 0,
+	.flags = IS_ENABLED(CONFIG_NULL_TTY_CONSOLE) ? CON_PRINTBUFFER : 0,
 };
 
 static int __init ttynull_init(void)
@@ -90,11 +97,22 @@ static int __init ttynull_init(void)
 	}
 
 	ttynull_driver = driver;
-	register_console(&ttynull_console);
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
 
 	return 0;
 }
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+static int __init ttynull_register(void)
+{
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
+	return 0;
+}
+console_initcall(ttynull_register);
+#endif
+
 static void __exit ttynull_exit(void)
 {
 	unregister_console(&ttynull_console);
-- 
2.45.2

