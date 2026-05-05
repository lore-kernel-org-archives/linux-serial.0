Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED252D3EF2
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944073; cv=none; b=p94L6P9qOElmlSiA1HhssxKZyiOE1dijfcvoFoUv4D+RDTe/oNlGPMrGK5gh3BG1C+T7zYB3WtfsDu/AEfthN8HAWnV6uoFYJkPE9nZjc9F2dpj/b3nT4COmx9P9+haIhw+jujfw4W07FFhBNnLHOF78o8A+Cw44BpAj/jiSqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944073; c=relaxed/simple;
	bh=mX3Xo3gc1C+Sni1H8ngLP+KJGci9ByShm5HZuHWHbvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRZlecNEaRfPq66+EFchiLpWyDL3aJPqRIGtkfwNNQdGp0CAHqGtSprJLcVibOl+uyEWIPNlLQdm9wDTnIi2HO0+2v0u6l0fzJ+NrOm/IZMHvbL2PHJlsCokQJRrObeTFSQIxNOTT/I8kDasNHaCb1LZeTFzDpT6DNNjQyZRIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtB+bvSm; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtB+bvSm"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c19d23b19so6873371c88.0
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944071; x=1778548871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17Os3U3wjaLl0JPWE80T6iqUrb19S1uMR0P3szfQKEU=;
        b=jtB+bvSmKld7LDp+CycwJqHL4Xl4GZREi1f/XIcO+4EhLq1mtOIKWs9nUPpBmesfhQ
         xSK359/2qgSPaaATaYWZ9BuHwF3Xwwsxx4i5Tcli4i3vvli5d4WZMyqiExuiEGVBq6Ez
         aAZO+udCcfdu9wEWKJzv2SyZcDvCnp32pC6kug/tOM1ELOZjIxbE+5wTkxofKXpCD2i0
         wRAhiaGr2Q6y4yr7HtT4kIKL7U91jLORSRxkhb5IYeMRSNIeCIpBa0Y64tgqeZaWbpQi
         NWf16wjhVxH1IA9+pcyrqdlUQSiytbW3FULDAbIv46l7Tj7mpetVLiXiGDH7666B4+C8
         y+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944071; x=1778548871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17Os3U3wjaLl0JPWE80T6iqUrb19S1uMR0P3szfQKEU=;
        b=VAhfOserrejeEtkLY1DGhrS6vo9elAE9lfcAZJew5ccwELGrbcQYQpOTgCXSh35kpN
         V/1waBGgUg9kD2reo/LkMO+6yWAuOPTWCCUlwK7A/qHwOJ3l/nR5RmN9pbGD55whcCFc
         xbI59wL2PPEuHBvJmgW4QxydevMjF2BW4d2L+kHe02roxZT6YE7bxYV+VC0hnESRDUv8
         T5mnSk++4/rtp513ZEhlYUggafH1ZAMUQNpyJLiwPf+ZG8l49rmINwd0jU6HRZbHvDaq
         eLfTbpJko+HPETk5DYssjjsyTkb80cMZoWJuWx5BZKALltR+o/Pbo7CkiRC6X9M+mdig
         79Ew==
X-Gm-Message-State: AOJu0YxrtALZN/sp9PDNyFe+qkdC+nfj7Wmz2jlE6Y+BzF7CYefkvp5Z
	wlXLmWbZpox2hnzS36Mo+Yisk8UMelIKwOYEJdNIU7HIg06wCMOMpuZ2S80yARwj
X-Gm-Gg: AeBDieshBCSKOx+r8BnYPP7RR6RNAEBrG2L/lRw/SQ2xk+ArPj2QISej6GaMoWBkwaG
	Cg2IFCTyR2cdmeBYQUjgWVUGE6Nqc+5PtX0usZkU3O/mLXnoijG+vRrEbM5ts6pgyscK7TlODqy
	b7qvGEYRgy+gGMR9Gd1FEWGO6k4wAwHm1SEO9cEfz2zqho3ITGAZFOPYxjPy05X7KadzCyHsc6R
	1D/kzJeB4lWTtSa1M9+3bEZJWR7nDg7YsLCznJrAkWOmriirlD9Ypwyiz1VKGykYeeaK2VrNgpc
	etLAf/ecdJc0be4HTNHLXl4/WwwydoYXtNFAYmwSLqHUf+riWcWAo47UqJsIVDMV5VLVdo7Ix7/
	jPrFgnhRHpqWsTyiyJuOESDFc6MZ5bau8T6Gh6GsgDZidi9H7k8qbniuaf2jS/bTszvgMS6DUlx
	sVC2ikrZOYkbxYjtAGERgmagkUZiwfEY34G5PccU2rQEEyYth5TBGIRgwCmupTBpcd0YDQzCDbx
	E/8oT+hU1bUf8gSxZ3iH6Vozk4USztByyh4D3Iaqp+Q9vTg6tdwhlERIKLan9ISmaF1ooUpsqpl
	iTcNA9R5X0VD3vOCTlENsgoabKut
X-Received: by 2002:a05:7300:fd12:b0:2f3:a348:a2db with SMTP id 5a478bee46e88-2f3a348b6a3mr1499224eec.10.1777944071272;
        Mon, 04 May 2026 18:21:11 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm24060034eec.1.2026.05.04.18.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:21:11 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH 1/3] tty: move remaining serial drivers into the serial/ directory
Date: Mon,  4 May 2026 18:20:34 -0700
Message-ID: <042d993686c87fdfd4130f11b57c3b559944603d.1777943090.git.enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777943090.git.enelsonmoore@gmail.com>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few TTY drivers are outside the serial/ directory despite being for
serial devices. Move them and their documentation into the correct
directories.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 Documentation/driver-api/serial/index.rst     |  1 +
 .../{tty => serial}/moxa-smartio.rst          |  0
 Documentation/driver-api/tty/index.rst        |  1 -
 MAINTAINERS                                   |  4 ++--
 drivers/tty/Kconfig                           | 23 -------------------
 drivers/tty/Makefile                          |  3 ---
 drivers/tty/serial/Kconfig                    | 23 +++++++++++++++++++
 drivers/tty/serial/Makefile                   |  6 ++++-
 drivers/tty/{ => serial}/amiserial.c          |  0
 drivers/tty/{ => serial}/moxa.c               |  0
 drivers/tty/{ => serial}/mxser.c              |  0
 11 files changed, 31 insertions(+), 30 deletions(-)
 rename Documentation/driver-api/{tty => serial}/moxa-smartio.rst (100%)
 rename drivers/tty/{ => serial}/amiserial.c (100%)
 rename drivers/tty/{ => serial}/moxa.c (100%)
 rename drivers/tty/{ => serial}/mxser.c (100%)

diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
index 610744df5e8d..f92581fc3478 100644
--- a/Documentation/driver-api/serial/index.rst
+++ b/Documentation/driver-api/serial/index.rst
@@ -18,3 +18,4 @@ Serial drivers
 
     serial-iso7816
     serial-rs485
+    moxa-smartio
diff --git a/Documentation/driver-api/tty/moxa-smartio.rst b/Documentation/driver-api/serial/moxa-smartio.rst
similarity index 100%
rename from Documentation/driver-api/tty/moxa-smartio.rst
rename to Documentation/driver-api/serial/moxa-smartio.rst
diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index c1ffe3d1ec46..6a08aebbc47c 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -70,6 +70,5 @@ Miscellaneous documentation can be further found in these documents:
 .. toctree::
    :maxdepth: 2
 
-   moxa-smartio
    n_gsm
    n_tty
diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..c99671d465af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18022,8 +18022,8 @@ F:	net/dsa/tag_yt921x.c
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-F:	Documentation/driver-api/tty/moxa-smartio.rst
-F:	drivers/tty/mxser.*
+F:	Documentation/driver-api/serial/moxa-smartio.rst
+F:	drivers/tty/serial/mxser.*
 
 MP3309C BACKLIGHT DRIVER
 M:	Flavio Suligoi <f.suligoi@asem.it>
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index df6832a4c237..63b378e44a59 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -208,29 +208,6 @@ config SERIAL_NONSTANDARD
 
 	  Most people can say N here.
 
-config MOXA_INTELLIO
-	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD && PCI
-	select FW_LOADER
-	help
-	  Say Y here if you have a Moxa Intellio multiport serial card.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called moxa.
-
-config MOXA_SMARTIO
-	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
-	help
-	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
-	  want to help develop a new version of this driver.
-
-	  This is upgraded (1.9.1) driver from original Moxa drivers with
-	  changes finally resulting in PCI probing.
-
-	  This driver can also be built as a module. The module will be called
-	  mxser. If you want to do that, say M here.
-
 config N_HDLC
 	tristate "HDLC line discipline support"
 	depends on SERIAL_NONSTANDARD
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 8ca1a0a2229f..fd88830b925d 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -16,9 +16,6 @@ obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
 
 # tty drivers
-obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
-obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
-obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
 obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9aa61c93d7bc..999f56307445 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1592,6 +1592,29 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 	  but you can alter that using a kernel command line option such as
 	  "console=ttyNVTx".
 
+config MOXA_INTELLIO
+	tristate "Moxa Intellio support"
+	depends on SERIAL_NONSTANDARD && PCI
+	select FW_LOADER
+	help
+	  Say Y here if you have a Moxa Intellio multiport serial card.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called moxa.
+
+config MOXA_SMARTIO
+	tristate "Moxa SmartIO support v. 2.0"
+	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
+	help
+	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
+	  want to help develop a new version of this driver.
+
+	  This is upgraded (1.9.1) driver from original Moxa drivers with
+	  changes finally resulting in PCI probing.
+
+	  This driver can also be built as a module. The module will be called
+	  mxser. If you want to do that, say M here.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index bba7b21a4a1d..246e0cf29fcc 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -10,9 +10,11 @@ obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
 obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
 
-# These Sparc drivers have to appear before others such as 8250
+# These drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
 # names change and other unplesantries.
+obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
+
 obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
 obj-$(CONFIG_SERIAL_SUNHV) += sunhv.o
 obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
@@ -53,12 +55,14 @@ obj-$(CONFIG_SERIAL_MCF)		+= mcf.o
 obj-$(CONFIG_SERIAL_MEN_Z135)		+= men_z135_uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO)	+= milbeaut_usio.o
 obj-$(CONFIG_SERIAL_MESON)		+= meson_uart.o
+obj-$(CONFIG_MOXA_INTELLIO)		+= moxa.o
 obj-$(CONFIG_SERIAL_MPC52xx)		+= mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_MPS2_UART)		+= mps2-uart.o
 obj-$(CONFIG_SERIAL_MSM)		+= msm_serial.o
 obj-$(CONFIG_SERIAL_MUX)		+= mux.o
 obj-$(CONFIG_SERIAL_MVEBU_UART)		+= mvebu-uart.o
 obj-$(CONFIG_SERIAL_MXS_AUART)		+= mxs-auart.o
+obj-$(CONFIG_MOXA_SMARTIO)		+= mxser.o
 obj-$(CONFIG_SERIAL_OMAP)		+= omap-serial.o
 obj-$(CONFIG_SERIAL_OWL)		+= owl-uart.o
 obj-$(CONFIG_SERIAL_PCH_UART)		+= pch_uart.o
diff --git a/drivers/tty/amiserial.c b/drivers/tty/serial/amiserial.c
similarity index 100%
rename from drivers/tty/amiserial.c
rename to drivers/tty/serial/amiserial.c
diff --git a/drivers/tty/moxa.c b/drivers/tty/serial/moxa.c
similarity index 100%
rename from drivers/tty/moxa.c
rename to drivers/tty/serial/moxa.c
diff --git a/drivers/tty/mxser.c b/drivers/tty/serial/mxser.c
similarity index 100%
rename from drivers/tty/mxser.c
rename to drivers/tty/serial/mxser.c
-- 
2.43.0

