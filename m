Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8878F4ED;
	Fri, 14 Mar 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912882; cv=none; b=hq15R/GedfE6MnEoD4d1HUUP/CffHrH9bE31XgskzSGfQSC84P69UIbrxDYxBu4VQVwt1ld6jm+CcMAzvMwUAc1NBql38nMXbnfBKLytwueZ1IQSrErdgC9ItkqUL743J+D8T3kIenuoBkQBhIzKhZxXS4InPxPiyjfLQFkpmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912882; c=relaxed/simple;
	bh=puU1bHFiU5inwl9HmwCRVdncgYNYAqwTC5uCk5bhI1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr7TfopEf7EKMTYMUVdEQKr5euO+M/lQJoq5GPaMUQO0qWIVjgQqvxaa9JFQk2kSLldmtt8I6mjyVWkT7wGnVaLCkVWJq1QMdnLWgi8p3GollT7NYBX1She5EzpoWX4tbzKanNPfbO3ZjiwhNjD31CnCrfd0I6tYiKPiOia8glI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNQ/GK/z; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNQ/GK/z"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8fce04655so14552236d6.3;
        Thu, 13 Mar 2025 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741912879; x=1742517679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TyJv3aBtqANNrc9XOtcnT9cACWaAnIt9dOvIl6e/S8=;
        b=JNQ/GK/z78P0nBJHonywjBt7My4TO9kKobjuEcL3FyyAHUP1YV+GOu84PSj90gBeuG
         8M1MeHW8D0LIVo6Zj0cBeGCptef4EjUbATiL9Ur+VfXyWHp6Z0bNCPIwobi2q0d+l10r
         9+6FCAvMDqR5WK7lyt5/RNChr5QtDqOcLOQgIt8LI+I64GhXZFpnZe4FsHZCnZwVDI+X
         2FASdS9BMLF/II4ZFVL20xCVK5TFKjqNBUR6SvTzABMK/QuXh8cFkpTOBA7+2dLOxkX+
         m5y8PCDWXBnNG3/bzplfUBExkxbeb235rV2ym6YGqPCG/+0NsAQifsXycOdKnTTH1gy4
         yxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741912879; x=1742517679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TyJv3aBtqANNrc9XOtcnT9cACWaAnIt9dOvIl6e/S8=;
        b=qFhNA1l6NwI+kpPWaTAO5YCzsoMZTIaInbj6m7eIbnWhqy1Fc7IHC/ilmUGdjE8Fhl
         IfBCimfZXzx9YLrn+EvQ20lVpQcX4X30HEyBDIOaKfl+df2UP3ogTTvB1RqvJWREWEtE
         tHEv1Vg9e/gP/BQFoBdit9l9u2rFAUj21YFucfmJ4YJ1m6QkF6dxSmu69iFfsUHLL/fG
         l8cGr1JkXyaSdyjl2t/nQKlwx/I8Kl75IsIBo0NpuJDaaW6Ca2ukNYsBEvGJtbc1iDGF
         DApQDm9a0/nID/WGUKPw/d/rr2VFYA6Yuq0gFcsGLxi2hRP81PTSlsLmmrc8aGa6yO36
         6qOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTtg4dXIcFMwS+8/r3Z6c1c2zLNiCKVRGxiY4rlPY9H11eMvxxP6HieY7YODRySokjCn/Xw1wy7ouGSB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3/6j4vkdtjjdZeyq4L0a+6g1U+0NYlMT2v02ex8OQwYoZRwQ
	MonlAxBylqyr5VBjEKVTqG3C7OVIUsg0utTBZqDWfLouJs1kLpIXGHYUwOw6
X-Gm-Gg: ASbGncvZVHk7B8FTdpdiYfw76iCtXroy1HQZ/MqTZz+NK/IiQPaf1Zdw3NJuhG+nJw0
	JbNFWFyZ/Dg8orFl4yeTOwYrT2U5sdFLfNCSdi9MdX71r6gqgq+Vx5Gp6LkQxtVXOGhQ8A8gvJY
	4K0oTiNA9UbatQvSHtHlChF1t6yKXJrlE5PbhDp2A5TK6RE7K5eoi+HfyciaCtNTbyT4LOX6K0p
	XtT8dz/K1aTVEv4PkwewQH3ETX7GbXoTduUpDwwaoosCUdFXOxo2oAiao24cQTnBKS6vZ+nDHvI
	teGe/R/LTH7noSi1AaZ4U6fRge7AajRSsT7lL0Y3g7ivT1zZkCEeMBXZZBu954r9zIXQ4TrBxIj
	SRfEbJng=
X-Google-Smtp-Source: AGHT+IEeKk5YbtbY5M7tlNy1klgIqaEhKCBLUEODeBnBdY47Tlknvg5FbKxZ0dHnwPnyQ09v2cxD1A==
X-Received: by 2002:a05:6214:20c3:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6eaeaa08761mr8488496d6.10.1741912879224;
        Thu, 13 Mar 2025 17:41:19 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1190:f8d0:801f:5e0a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c121sm15807876d6.107.2025.03.13.17.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:41:18 -0700 (PDT)
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
Subject: [PATCH v10 1/1] printk: Add an option to allow ttynull to be a default console device
Date: Thu, 13 Mar 2025 20:41:04 -0400
Message-ID: <20250314004104.3103656-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314004104.3103656-1-adamsimonelli@gmail.com>
References: <20250314004104.3103656-1-adamsimonelli@gmail.com>
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
primary console device, based on the link order.

ttynull will be the only console device usually with this option enabled.
Some architectures do call add_preferred_console() which may add another
console though.

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
console behavior is not dependant on hardware configuration by default, and
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
index 07668433644b..9dd807717cd4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4277,6 +4277,11 @@ void __init console_init(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
+#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
+       if (!console_set_on_cmdline)
+               add_preferred_console("ttynull", 0, NULL);
+#endif
+
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
 
-- 
2.45.2

