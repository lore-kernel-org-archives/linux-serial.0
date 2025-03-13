Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35A1F4C85;
	Thu, 13 Mar 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899841; cv=none; b=HkbHyen98G1qfgm2IbEtbiXu+7F8eMGFrap2TLQdxpvlFxmj1NOvkvQ0QWiFyE4qL8dJa/uX1QyEg/NGC8FxpsM6dt5WFPVi0/y1kYWEWCk0JetmEOIosqNJDXqWXROO6z8BpXMbGrFlqgxqqQ4XC4prsWidDvpQ8Kf9aOKL3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899841; c=relaxed/simple;
	bh=iKQPiq98F3heppyHhPCoHb+bXtJgl3X0cWhi9ep1rKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/VoFzewfiAn4IB7z+YATOsW0bRsDtGqckeu5GjfFsFfXSDNoCbgY0iP7T4UO1UqFH748SNc/QBzd5Ag37MOQSpq32mXgHMY1g4gQx/ZNupmCX9BReo3lCuZFQrQ058sU6vVJqYRulrwdMFpQKUaOnGebOm1hqGvB4rh0Ogueyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW5alY6l; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW5alY6l"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c54b651310so185459585a.0;
        Thu, 13 Mar 2025 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741899839; x=1742504639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQloQ+vFTmiQf4YQHHiMt7KOVOFvvdrTCx8XvhMrsL0=;
        b=UW5alY6ld8sWXGvQD9+iPm7QnaLjTH39QIkSUtTzGwtNWttCDPI7btzsN7H7Zzh/J/
         cfFtyj5O32mE8RweCzsATw7r7hJ9TfDeQogysUIlpjTg97iR4VLtaSGTcBhsO8zY6qeG
         3+09t6SVCYr9Qn0iuKMmr1UbfIiA2ICaQMmVHQxR6dk7t8geEN9FEMvXMftGo+6gKlLL
         Y5to8t54UvcsFfjjXon8mx/bCL5LB+B4NULKMFF94chtmyVLZpuxEJTmXzYDFhaS3fEG
         eYVEPHaV/R8249zMZAYe6YEpEIHugJCrFx9gsgVwr96q+Batx2UlEjXI2lWhACEYxIlS
         95jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741899839; x=1742504639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQloQ+vFTmiQf4YQHHiMt7KOVOFvvdrTCx8XvhMrsL0=;
        b=WlapFyTx68KHbGlMp2ZedsTValGJPbyJWCiFjarxd4KvGd6yMBWhmYudlVsGweb87z
         CJAFWTxE8/VDmNvf+ezDUmgHU7ZL2QdzahtbGamcLE8ZCXCkjuUVvA+GpVh0c3i7xsJX
         N7KKGrQoZozfN2erAmZQuv1/lhAQhSaTa6n9odh3kQl6sLytVmi6BEGYjWCagYr5rTqz
         Ip8Wsmlz2vKwBuhgz45wjQbv1L7vT3U/INH8lPC++3a4Di8pzU8S547BMtVfd6wk1DmA
         pBkWjVLaaY8gPGe+fcjsE0GISSVxlPzWfcCkI1eRwhqHJJ3bGDp+nvS8s5b87Vxc8VT6
         U35w==
X-Forwarded-Encrypted: i=1; AJvYcCXCHc3TZeV23VyUTiOrau7LOhdIAdB0APTSLj8lG41m9RXkG7pDst/PQNgtdAWOkJ0Sm7PuZT2lM7ZBkfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPX1EFDSKeM0tBa0itV8H3IHkoW+IGivymPvnJhKZOXseU2RH8
	HIlyov9jhfzWHc/z60ApAREIenijV5ZkJBwW5k1Wc0kHGV5dlYJJKpd2LtKM
X-Gm-Gg: ASbGnctElAbfq+L1DJZsYfubDRv/KgkG/yF0Z562r8bhegX2FbOd2YJrad9t5KIAoUj
	42wQopq6c6vVWCDJMyzWJkfVRTGdvdSeNUVLI4TK3myHYg+HgREXFc6hzEgpSiCijbPu83BuDzS
	jA6zcUyyX7yiKwmm7wZUpaASpiaYPtnm1WaCXflWbi+4gL3yvEy8nFMR7ftSuvJErvF9xOwEE52
	4f+cwCElzSolqFiQA0HzhZ85Adb7a+R3BG/0g5odZs4D19QILuBjOZWVFzkAvRiqRLuUlsayadZ
	iXFUNL40OCepq3uNb8XhWmoIdLOoRaycXXw3vJd6cluEr6l2c/lL//hp92Kn889OLyIPqmN/My9
	agovbm8c=
X-Google-Smtp-Source: AGHT+IFwt6k8wZ4Q8EOJbR7UPu93MWWj0xKS7xJ//ufaAR9JaSZk8QoEQKuKqoUXETqu/qvVWsO35w==
X-Received: by 2002:a05:620a:6881:b0:7c5:5cc4:ca6a with SMTP id af79cd13be357-7c579f8fa96mr207892985a.41.1741899838688;
        Thu, 13 Mar 2025 14:03:58 -0700 (PDT)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:1190:f8d0:801f:5e0a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm13223601cf.30.2025.03.13.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:03:57 -0700 (PDT)
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
Subject: [PATCH v9 1/1] printk: Add an option to allow ttynull to be a default console device
Date: Thu, 13 Mar 2025 17:03:47 -0400
Message-ID: <20250313210347.2987535-2-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250313210347.2987535-1-adamsimonelli@gmail.com>
References: <20250313210347.2987535-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disabled,
ttynull will become the default primary console device, based on the link
order.

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

The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
maintainers an option to avoid this. Disabling CONFIG_VT and enabling
CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
is not dependant on hardware configuration by default, and avoid
unexpected new behavior on devices connected to the /dev/ttyS0 serial
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

