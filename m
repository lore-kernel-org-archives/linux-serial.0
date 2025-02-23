Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5B23F419;
	Sun, 23 Feb 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343510; cv=none; b=LQYu2nUKTf8zMwWJyJD/1srDw17LGjK+3kgH9vBqgx8MdyxKiadb2xT7uYM/M6rHjbzT1bJkZv9mShm9Sz92K2Ss6EnNKsXhfqMD7OWh3PhXXPqqVeb3WtDGT5d2ard9YTXQ6YHY3fedWJs7y4idDhG7iA1bslFNSH7W/tBZIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343510; c=relaxed/simple;
	bh=mQrSem63eAwDgMpxp7wwl6JnlMigX+QUakiidqHVY9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqFmMtRwdVUysmIl/AeJWmrnOVycEqtSmF5Uj0yJA+OLH+rJwaLCe03/GiSfNctkU1NnY3KBMDt4i73R40CdaRKUVPG2BQEGIcxR12EXwdjB5oEdDV5cpDc8I7AM0k2MbZ+ndr4SWGWJKwWM0c/Y4JCS/yQwUl2HqvFFQ+VHZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuytDwKv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuytDwKv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c081915cf3so487536685a.1;
        Sun, 23 Feb 2025 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740343507; x=1740948307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=EuytDwKv1fGfLNDvRj5ZazsYUyOHs+zNIDrAaNwNH4K2NiJn3xGeO4Fg67knePBalq
         ITTCYLj5hnmrrUb7oaR9Xq1k0Xqk6O6X9rXr5R7dPh7L2eRPk3ixoNOdOuRosiTVC/4v
         O0h8hkvN/U6wwxgVas76sT+WcK1tRXwD9SYC24qHGcuxM8vIg7NoKcxefLepr0abOtpT
         fQMUdc5yKaGgV3b2qxSNpUK/rkDQ4qoN1oCTYqcsHOVFYcxX8KUubPdTfg3ycYyuBvaX
         YR0yhK8QtiCJDZzmsSdx4/UsX8wCoWGb6dMZAYfWaZN7ha5b2ph+cgW1hbGcQEePl0EN
         kwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740343507; x=1740948307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8MZETuC7V5G05JHalHsVh6dmDPdjiPVSG77k65pQVg=;
        b=ksR11oFRKniBEHvdkJP4viivPcnHy0uuO2jwRcXY/Jh8izmxDlGhHgerYJdW5Mfc24
         dJmmpJBqL2LnPiWIyQAwCMw7ESrmrjxENC5jZeu4Ou+mX1JER69cCvPmbeFAnBgn08z3
         UQf4qUEOHL3lnWXeGvQ6UAj5Z66AzbzXFpJpKMWZeIUGQWpSaIVI1FoyUdiQ6fuwFUFJ
         I5CwhKrQ/r3uh33pDDmN0KgQx++9KHjloTI7ofgZcfcF1JcArboRAyX8Z+KNZU7UHTx2
         tt1XKVD05lDmh9KOiMJdowGfRJIkQosYrJfZoPxjUd+y/AZ1XomSAO+YNm67ZZW+38HU
         Y7SA==
X-Forwarded-Encrypted: i=1; AJvYcCXqwxp9Zn0QHLdUUh+pcJ6C0YF5gkrdKAdbYC05b2n1NXbEOJRk4oAZ4m+UvQYnOmaDcP8OYk2aavXVPTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PNBKnQDqXqxqvEAo0ch8V9Vx592nxjoUCnZy9CFov5/JgzU3
	dgw3v8sNyq6E0OSpWs/5L2hN/j3YsrTvaPctYRsc63leUgr+BevD4TzcmaHf
X-Gm-Gg: ASbGnct0SxYExmFgdDW6B4XvlCApT6+AStZmbAVCILLOizqr1CZZGK0Pu4t9UJV+J5i
	B9LSO7bNd41hOSKhDf6Dj2JI4LDX6/v9Rc69S0kAhtgfJ41sww4h9RIlODZOtvdRQBMcD8Gm+td
	/7Yt/19VbsOO51RTZQR85NAijdkuRfiNPFK6v/gkfMWLvfaidONfxN48dwhBkdA65bFLIuasAx8
	xXJbeb/R9KyM5iAmfmj/URsf8LRrkWTyXpdDQHYeCR0tQdkKQbqghJu+wacOE41L6Mp+7qAYzgH
	P2cLIlYKQq+EqsEtIGuWrUpqNRqnqjubcc6uCr609BRa7m+J7xAZX88+7aTFQPs=
X-Google-Smtp-Source: AGHT+IFcM7fxCcq9pZwvlNsKbfMN9aqgQm/6fH6qt0rYFkOEaQz/Qo06zqJi4bXoyxUyZJOYlerX4w==
X-Received: by 2002:a05:620a:1912:b0:7c0:ca97:465c with SMTP id af79cd13be357-7c0ceee3277mr1314675385a.11.1740343507069;
        Sun, 23 Feb 2025 12:45:07 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:7a4:75e2:6847:49c9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bc8819bsm919914085a.74.2025.02.23.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:45:05 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v4 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Sun, 23 Feb 2025 15:44:55 -0500
Message-ID: <20250223204456.1913392-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250223204456.1913392-1-adamsimonelli@gmail.com>
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
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

