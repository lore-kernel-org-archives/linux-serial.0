Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D11FF1AF;
	Fri, 14 Mar 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956774; cv=none; b=h4gm24KKFGWLdh+mUQoT4KU7UtaTXvpHPLKax8Unt0nHyMFBvE5y32vEA7N3OdFMto+m8oCtSS800vN437YutD2HW+KoXidxJP/Nlzc/8/wwwYId6epHOQmJrlP7gb++yYmfcI4ke6+ZxkFGHZ7aJnkRu+BKMLc1iAWEf/DjLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956774; c=relaxed/simple;
	bh=fDt3heHVgF5nXN+CajqnryXUFXdO9sFJxPCYZR2gZ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZntVvzPnx3sgDAUN/HIg1OZRRFFpci8fLnIDJQsquCYafQXybeb6kVV0vExoMBatHYXBZqNtaU8a0IZzxao2fdiALLIq/BjHeaEugYo1iRDVm18z4sx0SYTtuLRQ2gqFxepSJQ0YtXyBb1tijWuqHs8FkfCkEUah6R1pFjZPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqJZNw1c; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqJZNw1c"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47677b77725so21304841cf.3;
        Fri, 14 Mar 2025 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741956771; x=1742561571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0xFI2+QSYasRMgy9wYb0x9yjaRi0AK32Vgihx08DHM=;
        b=RqJZNw1cvdn0EGYRzTw0Fw5zu0C3uSohGEciZPwXnBBQsJT5EaGR+lcqZ8I445aOAN
         0DGthC9bFKBYqlhVkBfvY3ghVnd/BVRhoVdybM+olcgLO1mMQyxs/xtPBBpEtmOl2iVb
         Yc6S5ECaVhEk8Jm6gCXM2ruN2802tCm3W9M7KL67Uy2hX1horHVHVnaSDrV754tHWCI5
         JfIQsBYgObdh9Nfm1Y69+u7IS1u4P5fh9hNtYpqWx3gd5KIgqQR41vDt5ixD1T/n8yEF
         Q6jIV8JrXmyWFctHqYSY81KxmQrysDqeCOsZ3fmnXeM3kgRrk1Z2jWr4xM+VqqLqaNch
         /VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956771; x=1742561571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0xFI2+QSYasRMgy9wYb0x9yjaRi0AK32Vgihx08DHM=;
        b=KBCCCeFVgX0j+mzT5Et+35bUIsXOYMOc5UwwpsckDHGQdskf8CurF43yMzC9GYYnzA
         Rwo0ZkSmIZlq2PM+Q5+qa/EUgowcwmcsDnSz5N3OG7WzPIxtDvfB9i+XjcBarWK23m5o
         SRSynwDVDsp1Hrb4n7qaKoI3X3zbYq41esDXx8R3eqHtbMW6kSPvVWSYUcDrIbO5CM70
         q9GQtnBgPFdVo/K6Xho/kd0ibCSjctkGB5y+mUZSHADV4XA3G4EsQHjWIVt3pz3FJc8E
         2OeutgZmuz3yE7c1O1IOmZxw910dtU/9X8FX0DSPGg2PFy9U4Y+u0LiwwvTchCR8oXav
         zmKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8RQWBcJXSE0PqCddvm3QtGzWfmukNr6vXK4zLCpLcZzxlyjHvPugcy4fvmgpOY9vtBluTwNIYTa3ElAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgN3YFyIesY0Oe2y71ymURjhKbZvE0166S54wIHZfakrrp3g/w
	XwhXAoLSCt+1mvIRIpoxxvUbSfDO5dOEdX3y3HdBeL3NobeREYgYfUlGeljW
X-Gm-Gg: ASbGncsskg+PKxiLbEf7rZHXvEJH4iHPldYog0HSbLlpVcuOJ0HMmn9mVvytnST0xMZ
	LgSMl4AOfx9vmJykfVMY9ouqjI5gt3Css4rQB2rqi4V/xKi93vN//Onjb7m0nXcuzaoCl5jYpyO
	pMUk/X7QZkgU4Ijlg4WFYT7fLhiF4LDr6PW6tbp0WUdzug0XPcOVFvJoHhT9y9B6eRi+vNDUjYF
	xWZA1hL8RE2iLAfyKaq/B/2MRMQwdNW/Nx3GKg4a2LOHGds6EmHu3AR5SIcnnXsCyR+qndWqhic
	UaY0N8Z9eJkr1SdB0fEhU9wGJvGH8UIn63rs1xrSgPeCVzV6RsdZcrkWhMQ9C/URjSXC4iwIICT
	0cI8ARPXXLiqjQRiqKw==
X-Google-Smtp-Source: AGHT+IExtGduUq+XkNqXSbQzLtfJEDA6mXVXmrUAkmuMcruPiaZg9uOc5cXIZiw4bwnUWDTTe4VWXQ==
X-Received: by 2002:a05:622a:8e:b0:476:ae71:eabe with SMTP id d75a77b69052e-476c81edfdfmr32547351cf.50.1741956771330;
        Fri, 14 Mar 2025 05:52:51 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1b2c:8d81:f410:30c9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82e879sm22346121cf.71.2025.03.14.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:52:51 -0700 (PDT)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v11 1/1] printk: Add an option to allow ttynull to be a default console device
Date: Fri, 14 Mar 2025 08:52:44 -0400
Message-ID: <20250314125244.3202791-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314125244.3202791-1-adamsimonelli@gmail.com>
References: <20250314125244.3202791-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.

if enabled, and CONFIG_VT is disabled, ttynull will become the default
primary console device.

ttynull will be the only console device usually with this option enabled.
Some architectures do call add_preferred_console() which may add another
console though.

Motivation:

Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
if CONFIG_VT is disabled, the default console device falls back to
/dev/ttyS0 instead of /dev/tty.

This could cause issues in user space, and hardware problems:

1. The user space issues include the case where  /dev/ttyS0 is
disconnected, and the TCGETS ioctl, which some user space libraries use
as a probe to determine if a file is a tty, is called on /dev/console and
fails. Programs that call isatty() on /dev/console and get an incorrect
false value may skip expected logging to /dev/console.

2. The hardware issues include the case if a user has a science instrument
or other device connected to the /dev/ttyS0 port, and they were to upgrade
to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
sent to the device connected to /dev/ttyS0 unless they edit their kernel
command line manually.

The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
distribution maintainers an option to avoid this. Disabling CONFIG_VT and
enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
console behavior is not dependent on hardware configuration by default, and
avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
port.

Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
---
 Documentation/admin-guide/serial-console.rst |  4 +++-
 drivers/tty/Kconfig                          | 19 ++++++++++++++++++-
 kernel/printk/printk.c                       |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index a3dfc2c66e01..1609e7479249 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -78,7 +78,9 @@ If no console device is specified, the first device found capable of
 acting as a system console will be used. At this time, the system
 first looks for a VGA card and then for a serial port. So if you don't
 have a VGA card in your system the first serial port will automatically
-become the console.
+become the console, unless the kernel is configured with the
+CONFIG_NULL_TTY_DEFAULT_CONSOLE option, then it will default to using the
+ttynull device.
 
 You will need to create a new device to use ``/dev/console``. The official
 ``/dev/console`` is now character device 5,1.
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..7fb81bbaee60 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,24 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  NULL_TTY_DEFAULT_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_DEFAULT_CONSOLE
+	bool "Support for console on ttynull"
+	depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device by default.
+
+	  For example, it might be useful to prevent a VT-less kernel from
+	  writing the system log to a random device connected to the serial
+	  port.
+
+	  Another console driver still might get preferred via the command
+	  line, SPCR, or the device tree.
 
 	  If unsure, say N.
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..2590498d8353 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4277,6 +4277,11 @@ void __init console_init(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
+#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
+	if (!console_set_on_cmdline)
+		add_preferred_console("ttynull", 0, NULL);
+#endif
+
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
 
-- 
2.45.2

