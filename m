Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D571FFC51;
	Fri, 14 Mar 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968478; cv=none; b=I9qeO+lZbXfjI72hrg+kAXGa+poQXQpLIJ18YwOW73lO3Aq7oN7PUTZ2YfrjWZ+Cf6yvyiXS+9AzwW56Ub1EEKivOKtOtgvn4oKc+0ypWWykPLMqTAuJAlWlWjZgXbOMWR2MkEI75qeizEl+pDbn5GSX0rTwj7K1svlmLxVrM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968478; c=relaxed/simple;
	bh=hJd3S0ULD/q25z7id8N6pgWMNPrJttI4xcYF/tqXA/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a17fnPVHF5N4gtuUv4RBwXjy43JVTHoUZNNM/W9+TBH6Mx3DYCio6CV2py0FlmNo7y8qpZ96sZsfaWKvR8mXhp8ob4MVXiOsSPJMWKFkoeJx4QBdHP0hDjIl5ZQKFIVAf2GyKb/k/IUMxzFcN1+lX3hilq4QflUcrBjBW7jU8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dfw7S/4/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dfw7S/4/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c081915cf3so285843885a.1;
        Fri, 14 Mar 2025 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741968475; x=1742573275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIyxtkfUFQjWH3lgWgwkO6/LTZqpnM3ua4bX2tkjtzM=;
        b=Dfw7S/4/LPOXuPHkFAM0t2dfzqyGKQP57xolctzjIjR/OR5sx7xxrUijlity2s6Txz
         9LLIvi/Ac16u5fCL8Q0aBVbIWqPpqbJqYNnnAER+2CQICXj6jJv+LpJfeyVyZWAgfiRw
         u4fNAMFzH1xV9kFnlqEkwm2QQYe30kTa7bTocgFVRIep26Izlp94f5O/d4HiNEBQs/Ht
         lNu5iQoIDkhmVZcGyvxmGJLYOT0s8OeuiyN5y+rLxZ/g6qhawRIc4ewnafxdJ9OPZnEC
         Cs0e4Aec5WhA2uUA33Hs1Gsa0xVvv3Cr7Z4oM+QgsLgzbuzirshFV+HoHXKkZhTwwfuf
         gLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968475; x=1742573275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIyxtkfUFQjWH3lgWgwkO6/LTZqpnM3ua4bX2tkjtzM=;
        b=dXs+3NpX2q6FL/igjpCmcC1lRe8/JkFGMaMXz/edp34W5IxybRKqgBpEgjX/BsMTDn
         h/waElBoUiJavdN+y/VxlaC0gXaKsNlLz4otd2EmtP5TIgvnC2UgXm5lUIMniIlNHlcr
         1hW+IWOD+kWW52MO0uodjGLO03ugVGpMVXohPvWoxFYeFiPA3II7qAmXnVb5a+1w2Oru
         VbeVbnPoouVa5dd60cd05NjkwXPw3S6jJj+3xoYmPGpntvtGD2iF0RFsUpHbqNyz+QET
         3GdKTm07asZp5o4YJiIDOkIiTvfvPjljDpKUxTAboLaalPFa6vOiPNahfIsmD130nikv
         3l0A==
X-Forwarded-Encrypted: i=1; AJvYcCVfuZWTtV1xKbHYcR3IMkMxeo1JdIjA2wLnr7brYQziTeO3hQjzPPyaY+gaB7FnKOimKbq4yjuzCiNmkM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eovNpT+tK6kUtuNB9uj+/JYQ8vCTwzLoXmtjmWcylAkb83YC
	0VcPJWloSVoVaVCqwfp7wk9ZA7ABFOcGzrywQ/o7DAqhv28kagc2j+tcO+cu
X-Gm-Gg: ASbGncvTb6IsGn3IPcNQ0DeI+YHtHvi/pahRyKFAWKXfYrUVt+ZrwV1Ab1URS+XiwRy
	iQ/gQNFClzFHpezw5U8dX+LzAEkYpXX+TkcshOpyYptgo/mkY49nqsk+sfkD1JEucTIZUZ5ybNf
	5fv0ouFS+p8OLJSYVvofNrbc4T3zcAjoZcC0dF+qN6DaqzOclpF+nNELNWH0INM34b0dGlsmG9+
	gJEYAhc1pZ0/O/9LDWIWzquBdgJNzVUslngGaS9E7THYvkH08UJ2DyOiyZSE61G4HHeXWIpmSoi
	ZY8xVuHADSXM9YI5zqyf70YHZLw0q1agq1GfdSUIcYFTLh3MNuykFIcjYxk8ZLgIoze7/mSvk+p
	pZLZFzq0=
X-Google-Smtp-Source: AGHT+IEtxvCYX9wYR7uLDmThHHiHBxePURG5uQfxOW8bsysxzBrj+e91QJ+VxwLPkCTH9n8ySC5SRQ==
X-Received: by 2002:a05:620a:22e8:b0:7c5:3e76:bcd7 with SMTP id af79cd13be357-7c57c8fcdbcmr332454785a.37.1741968474674;
        Fri, 14 Mar 2025 09:07:54 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:d731:b11a:3691:3fd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fc94sm274048285a.74.2025.03.14.09.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:07:54 -0700 (PDT)
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
Subject: [PATCH v12 1/1] printk: Add an option to allow ttynull to be a default console device
Date: Fri, 14 Mar 2025 12:07:49 -0400
Message-ID: <20250314160749.3286153-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314160749.3286153-1-adamsimonelli@gmail.com>
References: <20250314160749.3286153-1-adamsimonelli@gmail.com>
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

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
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

