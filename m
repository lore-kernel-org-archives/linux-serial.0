Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9213DEAF9
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803079; cv=none; b=YUlcLiYq6QTA1fjrf8lChTDfvi2pFXPgIGt50J8oomBUXkXyG/K3NWCpkfeDcL3GPoadB558zwRJlPokuGHoBagjkc9+UKTNNkNleMV3+cOcNf+VCWiKrYLrMt3RbTkkeUKwjxS6/3u1HSF9OkLKxfjBPEIyzBHT2EuLWI20nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803079; c=relaxed/simple;
	bh=JKyBYy0ZVb6KOG4qaXsDDYoua79I9QXXZhqASx+hdt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSpI1z5LvYoHxcx+SjVh7OUpATQeAoqJRp1jUfooyS00X3aYIZuaF1pYOpsJ37W7ccYixz+9gawiKYAI5gjhBNpisHt5s1cOEs5X+8UrCmAPnLF9q6jUP6keJboYwAGWR7Yi6j4XbKhfZ1t1onm/76OJywWbfklbWuk9icLN6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZvRaH7U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZvRaH7U"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3266678f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803076; x=1777407876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44WhVXZvjCMS4S4DPww0qJ5SDrGxnVaZzuAI8zkpcIo=;
        b=PZvRaH7UKY74vnuvMushXEuI3LObwz8j0Zug5v+Auv+2Ijs4qH/K+GfNaOxggj72h1
         0NICWHh9lnCJiPbeSp6cKg1Gt0ikxXMu9DO0xbSa5ar8PO2d+SabMGgXqktxEfrOkT8D
         7/a6w8CdFoal4gJzWt2C+9n6XmK9gxMJyc4fCv+ngwHX1qZkhR2QePZ9znzGaCV+JE5R
         w+Jyx7yz/YOYNG0XDFdL8IMGp0gXQ4Xwiwq1T7TkS10WEgPEKYlVDadwP30QGUFTvJAD
         Mk6CYf8ZMJk9xTjCkHyAJj6pYrSMi3ibMTxVipnhcWoFgpzLUIDl2N+kQWdQLf1ilqTc
         Lp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803076; x=1777407876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=44WhVXZvjCMS4S4DPww0qJ5SDrGxnVaZzuAI8zkpcIo=;
        b=Ly78bUWoYi1YVjOsoz/DG95PIbYncDjgVMxccw5q/rapIiHTgAqr28MxQX6vaGA8zy
         22TBRa8oYI8jgAL4UY9yPssBMaOMdzTRaWYh6yfu0ldppwlzOx1oGUSdmxkm/c/FNw+G
         l6qAXWoK1nQl8ssGd/KyAVtz77z4P2MA5ekvaGbjZJU/sjPrLR9gvi2MFkP2GuLw9+mw
         WQ/6VYYrhi7tnITko/WDdGHjTwcInXIrfdD4ViIt0o+Wsk64OBTtOav1QvjzP7ZqJd6V
         x4qCInb7XuzEOhErZ66U4zx50D9tdmTK51L4tn1JGw797Qa848/oF5o0X2YKcwao3f8G
         NNcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WH33Ue4ldY+3cfKXZ9sjAu1UNUVJEdFSZ4Zz3OaSyeilh8OunFI1Hk88JMHklKU0N0xMmkv2GgEPXRs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNJP8TSspDone9iQtD0sGD9ugCcDCMLtd+J5WUVKpB3L/c5Mo
	/QKaD18LJFLe8sIhLUc8FlVQ7YoPpBxw15v0mLpmRrDDTTMB0VrSvdU1
X-Gm-Gg: AeBDieuoqA4Nlt9V78QxFDzF+XoAVD3bxMgGc+WahNRB4wp1hgAikNkzojbQp5h5S8E
	ZMV5bJ4MlSfKpBKyLRuvSA/gclvPwplXFGYG96Sqjhi29izPzwyb79/OGVe5sp1sSUB0WvQO2gT
	x+wHdYAssZKa0OKH4Y2f9sKL/WnZXZCh9Kf52GQOKyW3g/5YTdVhtJ4QT9053+5k7tDVshALbE3
	5A1NZhAGCQL5lr5WP/Vve2S85Zc7gSrEpRx2GlHbygpIm4FE3x9/3YczW6JgUrErwhAZVpkdKU+
	aKcmbYMaPsUGMfcuitEjGcZjWT5S/y/TkFz5HT1I0q2hFh+KDuoZFUS9MeyQkoa5qxtCIgsNUnT
	l6ApxA4B8oMR1Livnhp+tVN3Y4cOxCHWrqrSWtOAc2xUnNsE9u1fZUhNbGh/B45fOy+mlDhBqYQ
	tdJPOVeUx5RpTCrY1SQmCLG2x97/ZLL7PxosyDCIEx/jjK
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr289331985e9.24.1776803075829;
        Tue, 21 Apr 2026 13:24:35 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm655989805e9.3.2026.04.21.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:35 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Tue, 21 Apr 2026 23:23:16 +0300
Subject: [PATCH v5 8/8] ARM: defconfig: Add a zx29 defconfig file
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-send-v5-8-ace038e63515@gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-0-ace038e63515@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2988;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=JKyBYy0ZVb6KOG4qaXsDDYoua79I9QXXZhqASx+hdt4=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp59zXRxxeM3L6LvFEMDOBnIMJkPxSOas2y9Hdv
 YIpcJkPyi2JAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaefc1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLiQBAAiaNU2eJnnUvEamsnIJPjVgniN25uL7S
 Yz5non9ycX+C5T/F5q/bvsnDlJnrp67/GJdSQV/6xw51Wbf76xQKhVCWDajplvbXeoRwEVAXm/z
 bNEXRIrKGFwCpfzOWEeeV5YKbTOvanUR8ihbUD/yyC5v0o8FjKPE1dlQLjKXXpFxe87lGLqMIQv
 8b5qZZQ7TkXTXRUJF+ewbW0+R+a2DngtivcmR/gyiYp72726qmz8vPgc3FJCRAfikX8CqFDV4BW
 QRGrbyhs1vGvmK1K0dIlozq300idh70L2qHfXaIcJyIsAUYVoEmgX3FEoo93hjLzYDt1+/lVM6o
 jhv0NYcLZY7IlgEqXcwVt5/3qI0CanPXu+Gpt0TeadNgb6bqLFqqHZ0F5OiOI3AbksJtM6SvTR3
 ikgM2RCl+rRsSFm4wj/FrVWP1UUikjbhsZVOdQvG31kpNXH+8ZNikjOjbDHzqhpg9e3IyQ58Zc0
 NMO2ZT0kLeKpRgZLm0f6SHN+1iQeONIkpMVicPQ6lDnmG0B6/F2IhtMQezweQeNFBZPpdsuCuO1
 tydkNzBBPsH/0bd3Ln/4D1lWz5tCnU4UBHva87yQuhrCkbdthOv7M9YjQpj94glLXh5ODR4iLFl
 CZ4xgNN2zsYRGwj6oc8p7fs45yQLWU/ebZ3Fggnl2Wztnt11p1v4=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This enables existing drivers that already are (UART) or will be (USB,
GPIO) necessary to operate this board even if they aren't declared in
the DTS yet.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 arch/arm/configs/zx29_defconfig | 89 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/configs/zx29_defconfig b/arch/arm/configs/zx29_defconfig
new file mode 100644
index 000000000000..a78decd1d525
--- /dev/null
+++ b/arch/arm/configs/zx29_defconfig
@@ -0,0 +1,89 @@
+CONFIG_SYSVIPC=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_MMU=y
+CONFIG_ARCH_MULTI_V7=y
+CONFIG_ARCH_ZTE=y
+CONFIG_SOC_ZX297520V3=y
+# FIXME: There is no PSCI on this board, but ARM_GIC_V3 depends on it
+CONFIG_ARM_PSCI=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_CMDLINE="console=ttyAMA0 earlyprintk root=/dev/ram rw"
+# CONFIG_SUSPEND is not set
+CONFIG_BINFMT_FLAT=y
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT_PLATDEV=y
+CONFIG_PM=y
+CONFIG_PM_CLK=y
+CONFIG_PM_GENERIC_DOMAINS=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y       # FIXME: This is specific to my initrd. Remove before upstream
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_KEYBOARD_GPIO_POLLED=y
+CONFIG_GPIOLIB=y
+CONFIG_OF_GPIO=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_MFD_SYSCON=y
+# CONFIG_HID is not set
+CONFIG_PINCTRL=y
+CONFIG_GENERIC_PINCTRL_GROUPS=y
+CONFIG_PINMUX=y
+CONFIG_GENERIC_PINMUX_FUNCTIONS=y
+CONFIG_PINCONF=y
+CONFIG_GENERIC_PINCONF=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_POWER_RESET=y
+CONFIG_RESET_SIMPLE=y
+CONFIG_LEDS_GPIO=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_GADGET=y
+CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_SPI_MASTER=y
+CONFIG_MMC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_PLTFM=y
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_PLATFORM=y
+CONFIG_MDIO_BUS=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_SRAM=y
+CONFIG_MISC_FILESYSTEMS=y
+CONFIG_JFFS2_FS=y
+CONFIG_CONFIG_TMPFS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_ZTE_ZX=y
+CONFIG_DEBUG_LL_INCLUDE="debug/pl01x.S"
+CONFIG_DEBUG_UART_PL01X=y
+CONFIG_DEBUG_UART_PHYS=0x01408000
+CONFIG_DEBUG_UART_VIRT=0xf4708000

-- 
2.53.0

