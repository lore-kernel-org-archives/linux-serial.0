Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AE33C51B;
	Wed, 19 Nov 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544308; cv=none; b=k5CRxsKsucxYzLv7F2Qp9BUXew+EDvNjmOrDMGZ1FiAb2iA0ZwCkl00aUJ4/Ccfrt5oBAw1MGD4fqZdDPmHOrLhTshkhBib+bcBNbdDEx1YJYlzh/6JXELKygFjIKl6JgPTeCWOpuO0soFlimOPayiKpF3s2J5+DkmDQlTpmkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544308; c=relaxed/simple;
	bh=YN7iNHw8GZr8vTTesVQDSzRNnf/apZ2VOCuWIEqlkM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tkb9Jd/sfcvSTrbybJV5n5Pw00l6hZ9/AgVsOh2If58mfwNB1AFj4VgKEh7x/NKzcNbLSLrFGiasN2NVfyqeALE4oKi8rzvdaExWmYIy6Qq+DVpZrRHYlH6V5r8eQ/cswwc8XpICeQfXOz6XqQ4n/+ZnMaW1F5tkr/YY90MupQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTNPOAwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTNPOAwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7ABC4AF17;
	Wed, 19 Nov 2025 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544307;
	bh=YN7iNHw8GZr8vTTesVQDSzRNnf/apZ2VOCuWIEqlkM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTNPOAwPwdd6F93If+NOZM7oi1S/TrPgyLbyQmov1H+xWqP+JctUxOy15QVedm0rp
	 61Mqg6S7yXFVuxksu5m1G0dfur2W9x62KIGiWlonkKz0EUz2w8mSmyTEFNKIVwUcLh
	 1Y5BG5LuPLQIiSmYDGV++skLWH9TQ38rvv3XOhBiJPf35SRzZOPWnpV2fSMVcyd/EZ
	 F9Dj32VXmupmvMFIEIDsTjBcncW1Q+8pZNuwCIrS24OoNBFbzWPCRufFp1RJHWKnQA
	 IsQcYB1rA/RA2AJW68DMwsRxF8InnTGqxcTHfUlecfJeVURHsy7IQDroMKZG7t26Dy
	 27cO7B/ekGIgw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/6] serial: drop SERIAL_8250_DEPRECATED_OPTIONS
Date: Wed, 19 Nov 2025 10:24:54 +0100
Message-ID: <20251119092457.826789-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 3.7, 8250 was unintentionally renamed to 8250_core. This happened in
the commit 835d844d1a28 (8250_pnp: do pnp probe before legacy probe).
This made 8250.<xxxx> module options effectively defunct. Instead,
8250_core.<xxxx> worked.

In 3.9, the commit f2b8dfd9e480 (serial: 8250: Keep 8250.<xxxx> module
options functional after driver rename) made the original options work
again by introducing a hack.

Later in 3.9, the commit 9196d8acd7f9 (TTY: 8250, revert module name
change) changed the module name back to 8250 (from 8250_core). Since
then, the hack was there to support the transient 8250_core.<xxxx>
options. Those were present only in the 3.7..3.9 range.

These transient options were deprecated by 9326b047e4fd (TTY: 8250,
deprecated 8250_core.* options) in v3.9 too.

Now, after those 12 years, it is time to get rid of this hack
completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 arch/arm/configs/aspeed_g4_defconfig        |  1 -
 arch/arm/configs/aspeed_g5_defconfig        |  1 -
 arch/arm/configs/hisi_defconfig             |  1 -
 arch/arm/configs/lpc18xx_defconfig          |  1 -
 arch/arm/configs/shmobile_defconfig         |  1 -
 arch/mips/configs/bcm47xx_defconfig         |  1 -
 arch/mips/configs/bmips_stb_defconfig       |  1 -
 arch/mips/configs/gcw0_defconfig            |  1 -
 arch/nios2/configs/10m50_defconfig          |  1 -
 arch/parisc/configs/generic-32bit_defconfig |  1 -
 arch/parisc/configs/generic-64bit_defconfig |  1 -
 arch/powerpc/configs/44x/akebono_defconfig  |  1 -
 arch/powerpc/configs/microwatt_defconfig    |  1 -
 arch/riscv/configs/nommu_virt_defconfig     |  1 -
 arch/xtensa/configs/audio_kc705_defconfig   |  1 -
 arch/xtensa/configs/generic_kc705_defconfig |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |  1 -
 arch/xtensa/configs/smp_lx200_defconfig     |  1 -
 arch/xtensa/configs/xip_kc705_defconfig     |  1 -
 drivers/tty/serial/8250/8250_platform.c     | 27 ---------------------
 drivers/tty/serial/8250/8250_rsa.c          | 24 ------------------
 drivers/tty/serial/8250/Kconfig             | 17 -------------
 22 files changed, 87 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 28b724d59e7e..45d8738abb75 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -117,7 +117,6 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index c3b0d5f06889..2e6ea13c1e9b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -138,7 +138,6 @@ CONFIG_SERIO_RAW=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index e19c1039fb93..384aade1a48b 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -35,7 +35,6 @@ CONFIG_NETDEVICES=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HIP04_ETH=y
 CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 2d489186e945..f142a6637ede 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -90,7 +90,6 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c1fd469e2071..0085921833c3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -75,7 +75,6 @@ CONFIG_INPUT_DA9063_ONKEY=y
 CONFIG_INPUT_ADXL34X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index f56e8db5da95..d10b3d4adbd1 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -51,7 +51,6 @@ CONFIG_B43LEGACY=y
 CONFIG_BRCMSMAC=y
 CONFIG_ISDN=y
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=2
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index cd0dc37c3d84..ecfa7f777efa 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -119,7 +119,6 @@ CONFIG_INPUT_UINPUT=y
 CONFIG_VT=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
index 8b7ad877e07a..fda9971bdd8d 100644
--- a/arch/mips/configs/gcw0_defconfig
+++ b/arch/mips/configs/gcw0_defconfig
@@ -52,7 +52,6 @@ CONFIG_INPUT_UINPUT=y
 CONFIG_INPUT_PWM_VIBRA=y
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_INGENIC=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
index 048f74e0dc6d..b7224f44d327 100644
--- a/arch/nios2/configs/10m50_defconfig
+++ b/arch/nios2/configs/10m50_defconfig
@@ -51,7 +51,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_VT is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_ALTERA_JTAGUART=y
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 52031bde9f17..5444ce6405f3 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -119,7 +119,6 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 CONFIG_LEGACY_PTY_COUNT=64
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
 CONFIG_SERIAL_8250_EXTENDED=y
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index 1aec04c09d0b..ce91f9d1fdbf 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -158,7 +158,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_RAW=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
 CONFIG_SERIAL_8250_RUNTIME_UARTS=8
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index 1882eb2da354..02e88648a2e6 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -85,7 +85,6 @@ CONFIG_IBM_EMAC=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index a64fb1ef8c75..d81989a6f59b 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -62,7 +62,6 @@ CONFIG_LITEX_LITEETH=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index d4b03dc3c2c0..0da5069bfbef 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -48,7 +48,6 @@ CONFIG_VIRTIO_BLK=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_LDISC_AUTOLOAD is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index dc942bbac69f..7b3f234b337c 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -81,7 +81,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 3ee7e1c56556..c1b766a77a1e 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -79,7 +79,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index c6e96f0aa700..27b126d4e7bf 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -81,7 +81,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 373d42b9e510..dfb3d921b850 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -83,7 +83,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 5d6013ea70fc..472568b85fb9 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -72,7 +72,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HWMON is not set
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index b27981340e76..38b158ec4725 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -390,30 +390,3 @@ module_param(skip_txen_test, uint, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
-
-#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
-#ifndef MODULE
-/*
- * This module was renamed to 8250_core in 3.7. Keep the old "8250" name
- * working as well for the module options so we don't break people. We
- * need to keep the names identical and the convenient macros will happily
- * refuse to let us do that by failing the build with redefinition errors
- * of global variables. So we stick them inside a dummy function to avoid
- * those conflicts. The options still get parsed, and the redefined
- * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
- *
- * This is hacky.  I'm sorry.
- */
-static void __used s8250_options(void)
-{
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "8250_core."
-
-	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
-	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
-	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
-}
-#else
-MODULE_ALIAS("8250_core");
-#endif
-#endif
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 40a3dbd9e452..3b9c00515407 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -201,27 +201,3 @@ void rsa_reset(struct uart_8250_port *up)
 	serial_out(up, UART_RSA_FRR, 0);
 }
 EXPORT_SYMBOL_FOR_MODULES(rsa_reset, "8250_base");
-
-#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
-#ifndef MODULE
-/*
- * Keep the old "8250" name working as well for the module options so we don't
- * break people. We need to keep the names identical and the convenient macros
- * will happily refuse to let us do that by failing the build with redefinition
- * errors of global variables.  So we stick them inside a dummy function to
- * avoid those conflicts.  The options still get parsed, and the redefined
- * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
- *
- * This is hacky. I'm sorry.
- */
-static void __used rsa8250_options(void)
-{
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "8250_core."
-
-	__module_param_call(MODULE_PARAM_PREFIX, probe_rsa,
-		&param_array_ops, .arr = &__param_arr_probe_rsa,
-		0444, -1, 0);
-}
-#endif
-#endif
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f64ef0819cd4..58f0142a59ff 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -34,23 +34,6 @@ config SERIAL_8250
 	  Most people will say Y or M here, so that they can use serial mice,
 	  modems and similar devices connecting to the standard serial ports.
 
-config SERIAL_8250_DEPRECATED_OPTIONS
-	bool "Support 8250_core.* kernel options (DEPRECATED)"
-	depends on SERIAL_8250
-	default y
-	help
-	  In 3.7 we renamed 8250 to 8250_core by mistake, so now we have to
-	  accept kernel parameters in both forms like 8250_core.nr_uarts=4 and
-	  8250.nr_uarts=4. We now renamed the module back to 8250, but if
-	  anybody noticed in 3.7 and changed their userspace we still have to
-	  keep the 8250_core.* options around until they revert the changes
-	  they already did.
-
-	  If 8250 is built as a module, this adds 8250_core alias instead. 
-
-	  If you did not notice yet and/or you have userspace from pre-3.7, it
-	  is safe (and recommended) to say N here.
-
 config SERIAL_8250_PNP
 	bool "8250/16550 PNP device support" if EXPERT
 	depends on SERIAL_8250 && PNP
-- 
2.51.1

