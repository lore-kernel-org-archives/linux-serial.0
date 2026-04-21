Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2953DCD8D
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803046; cv=none; b=txges/Yh/PvCVoeJjXOSzehhZP8dZUCthh7Sx8vRLatTEOuw8+IwpZOV25WEbIp9suCzvej7knQZNll78fFUvalOgVICS+/rESK3DKMdcWkvBz6KD1PqlnHDRk3bQ23AUptDOzcFfUT2uZ6WUKZiC3C8kWTBEHawdoeBxCXrGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803046; c=relaxed/simple;
	bh=IKEL43NSinu6t7Q8gt1WDq/DxEu9a/UHjuRo8ZnIalM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lijMR97S2j+iYIRUl0oedU/uSpE0G81qY1jJu+uWTxZjJ+po7gTr2yc/ErgK5aOBJ0K4lJndhV2pLzDrAovbrymyZ80aIDwJMXjdZTPT1EwBiH+YmZobDByIZue37MHndptc+rlfQ1VTOvX8DlRiIeCwD6MYqg8yed+XxOQC7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7iZewH4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7iZewH4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so40086455e9.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803042; x=1777407842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O442+Egbvi36hD3DqizBKuf/dIOz63obRWcb0/Kx/dQ=;
        b=b7iZewH4vxv+W+AAYekT3G+4Gpyb4MrxUzmOZgNM3lmMuMnLGHNCcC2nwqXDhDcJ8c
         vaopN3E1YBZRErtyL5QpqTweUe3zqaOyTd1McdXNYLxadllOavIo0rRn6MGpQCb1VG6Z
         D4mewAJZHFFrqF1fTFccW2So8P77pZzk0xJ/baHWbOGw50MimeQXXbG68/eTXOnegieh
         q4iutFE3uuUnJqXo0Zn2pYZpRJDStied5VbLdLpkrtT3mbI3z8fn/k4GxpbrGkXPZ4yM
         AuSBF5gF5BI7ES04HyW0JgL8DWkZECJpgC5DXbhIXMG+BinBxEg7Oq0HiWzC2tgDeVIq
         6PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803042; x=1777407842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O442+Egbvi36hD3DqizBKuf/dIOz63obRWcb0/Kx/dQ=;
        b=cYcirRptQxDJtkjdPfYbLkHeyqqSQQ4lsUnRO5MABoUN2oGEo+K4E62h4ITPBOSBLq
         FUYGgKna9Z2HEoTB5YmQuMkz+hsTDibvbAGsA67Gvt4McoBWJNpng49pJY5HYr+yOF/V
         U5YX8hhGDplgFcvB6NNFI14hea7xNQqdxKDgEJsyDXSmZ9RhZ9ufV6yIU3w0PBeJVvRo
         HC4AUlTaWhiCNOeSKQF6vw7B777W6wtqRTnRZYO0KVaWelFr/UP4QK22yTcTGXKtiTpD
         0trQuKPoRNz0tXlZahmEJTalQD6C8VRyzDGPpcf71LTWuAj0a8U9bUczPtmPseFj9XII
         QwXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ktaG1o3QdfhLG8/GC4qBnPF5o7n/EN14PXk9mNlKzqCuNmuQehwX/khjN8asD6aDnGGq031UUaKn6vgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHVkdZk1CtQur+njdzc0DtjnhrNLwKwGK87M2FsldPg0Fix+y
	Bfc/YI8LY1pkq8fBj9aS9J/ySPZsujZbIepiJzXgSBDjkWeT1N89L+K7
X-Gm-Gg: AeBDieu/ua4So/xNUxqBjXai3db4iji9zudZKRtf5q16GfMVPx6O4pRBAIoKGi0BFuz
	gG+fUxdWkhbbUuksAwMueduG/EjBv7D8Kq37TePr6XQZKxSI2jpQ8Xu40oW15WNgQ6PevEFg5J1
	mQZ9y6wK+tgFy99nXq74drS1OwLu9qcdnoXITqgEgESQe9pJh5+CZVIHfbGnAjyDHJ2fzw57xc2
	OZ1syqguLNhjEvkM1cYnF43L07rq4Rss/GK0LUwWDvgDOveTbmKiLlaAGuTUb1d7z5d+5hxe1XE
	Fw2QTjTfB5u2C61VroHtDGdgk8RUpUl95EMeYc9XgUupD7uuXESFKvOIS+lrN9KJzfZTCclb6OA
	z/vBT2f+OMvLMcuQYVMlF0L2G8Vh8WFGUHo1WgyJJWrk5yGTnQzK2op+RWCsVKxApooeu5ovpGn
	GTgBrlVK7Tv4cATzSuMgQs1aosQuT/CkPhNQN/cY4ksoD7
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr160368425e9.6.1776803042257;
        Tue, 21 Apr 2026 13:24:02 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm655989805e9.3.2026.04.21.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:01 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Tue, 21 Apr 2026 23:23:09 +0300
Subject: [PATCH v5 1/8] ARM: zte: Add zx297520v3 platform support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-send-v5-1-ace038e63515@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10856;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=IKEL43NSinu6t7Q8gt1WDq/DxEu9a/UHjuRo8ZnIalM=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp59zXBkQGCj7PQDDmAmvr9J3zmL6Sg29zUCGYg
 kWtIYN782CJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaefc1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLXwhAAm7/tP2itZti6unY8GRajuT/4E8zWmCj
 3qrhvVTUHFR7q9FyUrQDhZCqWNxPd6MKpOMVhqE/CISz9kNahZsyXJdj1H1PTze9uGzMSW/rw9l
 QSGlBAeMgAD6FfeLgfS1krFb870af1fAitlwEGIpjaaDFFo4e0namgMbCcL9FakLwUEKzO0F7Yx
 Zxm8jkQkBUbrNp3JkodQBnipgaTHm24R3QslAXg7cXSOOnWQQGOFujEyA1cEFi/gEHFAjq2uTft
 P+OYWW2gu7B0nkdAc0ufIsVT4WU+5qx9PX39/87CzZKVXal326TB7/2U12BrCA88RA9iwRlgtEg
 i/4oNbvbh8pW/Fy+uUJ9mQTkkdBmuGhIQ5xOEvlI5z0Vhj+TZZrrHtvYId6PMRoEHTnmyxtfAJE
 JUAcUwpbmnYahkvmHzITf0zy+4pHiyE00tI9QN4vf6JLaLPJQmFTYNF1C/nGa3SGmCWYIPoN1dv
 aIawNhiGUTFSiq4sUB688kRrmwJQ7tyO5tBOahtVtaKu2rMZyXEgLi4jpUT7O+e/k17IMFWTl1L
 fghrehQVDfZGQNMyWdbZtdhv5CzjxOs7Ddz3niEDGqEvtggYwKEa5zhspf/MerEc0Wumbx+K+fT
 CLi0AkweVrUv47zt21v4b0h/5v1v4CDq2ParfWWhZN2b5dCF9cvk=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This SoC is used in low end LTE-to-WiFi routers, for example some D-Link
DWR 932 revisions, ZTE K10, ZLT S10 4G, but also models that are branded
and sold by ISPs themselves. They are widespread in Africa, China,
Russia and Eastern Europe.

This SoC is a relative of the zx296702 and zx296718 that had some
upstream support until commit 89d4f98ae90d ("ARM: remove zte zx
platform"). My eventual goal is to enable OpenWRT to run on these
devices.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 Documentation/arch/arm/zte/zx297520v3.rst | 158 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   4 +
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/mach-zte/Kconfig                 |  26 +++++
 arch/arm/mach-zte/Makefile                |   2 +
 arch/arm/mach-zte/zx297520v3.c            |  19 ++++
 7 files changed, 212 insertions(+)

diff --git a/Documentation/arch/arm/zte/zx297520v3.rst b/Documentation/arch/arm/zte/zx297520v3.rst
new file mode 100644
index 000000000000..6621ea72769f
--- /dev/null
+++ b/Documentation/arch/arm/zte/zx297520v3.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================================
+Booting Linux on ZTE zx297520v3 SoCs
+====================================
+
+...............................................................................
+
+Author:	Stefan Dösinger
+
+Date  : 27 Jan 2026
+
+1. Hardware description
+---------------------------
+Zx297520v3 SoCs use a 64 bit capable Cortex-A53 CPU and GICv3, although they
+run in arm32 mode only. The CPU has support EL3, but no hypervisor (EL2) and
+it seems to lack VFP and NEON.
+
+The SoC is used in a number of cheap LTE to WiFi routers, both battery powered
+MiFis and stationary CPEs. In addition to the CPU these devices usually have
+64 MB Ram (although some is shared with the LTE chip), 128 MB NAND flash, an
+SDIO connected RTL8192-type Wifi chip limited to 2.4 ghz operation, USB 2,
+and buttons. Devices with as low as 32 MB or as high as 128 MB ram exist, as
+do devices with 8 or 16 MB of NOR flash.
+
+Some devices, especially the stationary ones, have 100 mbit Ethernet and an
+Ethernet switch.
+
+Usually the devices have LEDs for status indication, although some have SPI or
+I2C connected displays
+
+Some have an SD card slot. If it exists, it is a better choice for the root
+file system because it easily outperforms the built-in NAND.
+
+The LTE interface runs on a separate DSP called ZSP880. It is probably derived
+from LSI ZSPs and has an undocumented instruction set. The ZSP communicates
+with the main CPU via SRAM and DRAM and a mailbox hardware that can generate
+IRQs on either ends.
+
+There is also a Cortex M0 CPU, which is responsible for early HW initialization
+and starting the Cortex A53 CPU. It does not have any essential purpose once
+U-Boot is started. A SRAM-Based handover protocol exists to run custom code on
+this CPU.
+
+2. Booting via USB
+---------------------------
+
+The Boot ROM has support for booting custom code via USB. This mode can be
+entered by connecting a Boot PIN to GND or by modifying the third byte on NAND
+(set it to anything other than 0x5A aka 'Z'). A free software tool to start
+custom U-Boot and kernels can be found here:
+
+https://github.com/zx297520v3-mainline/zx297520v3-loader
+
+If USB download mode is entered but no boot commands are sent through USB, the
+device will proceed to boot normally after a few seconds. It is therefore
+possible to enable USB boot permanently and still leave the default boot files
+in place.
+
+3. Building for built-in U-Boot
+---------------------------
+The devices come with an ancient U-Boot that loads legacy uImages from NAND and
+boots them without a chance for the user to interrupt. The images are stored in
+files ap_cpuap.bin and ap_recovery.bin on a jffs2 partition named imagefs,
+usually mtd4. A file named "fotaflag" switches between the two modes.
+
+In addition to the uImage header, those files have a 384 byte signature header,
+which is used for authenticating the images on some devices. Most devices have
+this authentication disabled and it is enough to pad the uImage files with 384
+zero bytes.
+
+Builtin U-Boot also poorly sets up the CPU. Read the next section for details
+on this. It has no support for loading DTBs, so CONFIG_ARM_APPENDED_DTB is
+needed.
+
+So to build an image that boots from NAND the following steps are necessary:
+
+1) Patch the assembly code from section 3 into arch/arm/kernel/head.S.
+2) make zx29_defconfig
+3) make [-j x]
+4) cat arch/arm/boot/zImage arch/arm/boot/dts/zte/[device].dtb > kernel+dtb
+5) mkimage -A arm -O linux -T kernel -C none -a 0x20008000 -d kernel+dtb uimg
+6) dd if=/dev/zero bs=1 count=384 of=ap_recovery.bin
+7) cat uimg >> ap_recovery.bin
+8) Place this file onto imagefs on the device. Delete ap_cpuap.bin if the
+free space is not enough.
+9) Create the file fotaflag: echo -n FOTA-RECOVERY > fotaflag
+
+For development, booting ap_recovery.bin is recommended because the normal boot
+mode arms the watchdog before starting the kernel.
+
+4. CPU and GIC Setup
+---------------------------
+
+Generally CPU and GICv3 need to be set up according to the requirements spelled
+out in Documentation/arch/arm64/booting.rst. For zx297520v3 this means:
+
+1. GICD_CTLR.DS=1 to disable GIC security
+2. Enable access to ICC_SRE
+3. Disable trapping IRQs into monitor mode
+4. Configure EL2 and below to run in insecure mode.
+5. Configure timer PPIs to active-low.
+
+The kernel sources provided by ZTE do not boot either (interrupts do not work
+at all). They are incomplete in other aspects too, so it is assumed that there
+is some workaround similar to the one described in this document somewhere in
+the binary blobs.
+
+The assembly code below is given as an example of how to achieve this:
+
+```
+#include <linux/irqchip/arm-gic-v3.h>
+#include <asm/assembler.h>
+#include <asm/cp15.h>
+
+@ This allows EL1 to handle ints hat are normally handled by EL2/3.
+ldr     r3, =0xf2000000
+ldr     r4, =(GICD_CTLR_ARE_NS | GICD_CTLR_DS)
+str     r4, [r3]
+
+cps     #MON_MODE
+
+@ Work in non-secure physical address space: SCR_EL3.NS = 1. At least the UART
+@ seems to respond only to non-secure addresses. I have taken insipiration from
+@ Raspberry pi's armstub7.S here.
+@
+@ ARM docs say modify this bit in monitor mode only...
+mov	r3, #0x131			@ non-secure, Make F, A bits in CPSR writeable
+					@ Allow hypervisor call.
+mcr     p15, 0, r3, c1, c1, 0
+
+@ AP_PPI_MODE_REG: Configure timer PPIs (10, 11, 13, 14) to active-low.
+ldr	r3, =0xF22020a8
+ldr	r4, =0x50
+str	r4, [r3]
+ldr	r3, =0xF22020ac
+ldr	r4, =0x14
+str	r4, [r3]
+
+@ Enable EL2 access to ICC_SRE (bit 3, ICC_SRE_EL3.Enable). Enable system reg
+@ access to GICv3 registers (bit 0, ICC_SRE_EL3.SRE) for EL1 and EL3.
+mrc     p15, 6, r3, c12, c12, 5         @ ICC_SRE_EL3
+orr     r3, #0x9                        @ FIXME: No defines for SRE_EL3 values?
+mcr     p15, 6, r3, c12, c12, 5
+mrc     p15, 0, r3, c12, c12, 5         @ ICC_SRE_EL1
+orr     r3, #(ICC_SRE_EL1_SRE)
+mcr     p15, 0, r3, c12, c12, 5
+
+@ Like ICC_SRE_EL3, enable EL1 access to ICC_SRE and system register access
+@ for EL2.
+mrc     p15, 4, r3, c12, c9, 5          @ ICC_SRE_EL2 aka ICC_HSRE
+orr     r3, r3, #(ICC_SRE_EL2_ENABLE | ICC_SRE_EL2_SRE)
+mcr     p15, 4, r3, c12, c9, 5
+isb
+
+@ Back to SVC mode. TODO: Doesn't safe_svcmode_maskall do this for us anyway?
+cps     #SVC_MODE
+```
diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..974d7a98956a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29200,6 +29200,10 @@ F:	include/linux/zswap.h
 F:	mm/zswap.c
 F:	tools/testing/selftests/cgroup/test_zswap.c
 
+ZX29
+M:	Stefan Dösinger <stefandoesinger@gmail.com>
+F:	arch/arm/mach-zte/
+
 SENARYTECH AUDIO CODEC DRIVER
 M:	bo liu <bo.liu@senarytech.com>
 S:	Maintained
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec33376f8e2b..4217ed704e48 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -464,6 +464,8 @@ source "arch/arm/mach-versatile/Kconfig"
 
 source "arch/arm/mach-vt8500/Kconfig"
 
+source "arch/arm/mach-zte/Kconfig"
+
 source "arch/arm/mach-zynq/Kconfig"
 
 # ARMv7-M architecture
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b7de4b6b284c..573813ef5e77 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -223,6 +223,7 @@ machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
+machine-$(CONFIG_ARCH_ZTE)		+= zte
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_PLAT_VERSATILE)	+= versatile
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
diff --git a/arch/arm/mach-zte/Kconfig b/arch/arm/mach-zte/Kconfig
new file mode 100644
index 000000000000..2e3abee94994
--- /dev/null
+++ b/arch/arm/mach-zte/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig ARCH_ZTE
+	bool "ZTE zx family"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for ZTE zx-based family of processors.
+
+if ARCH_ZTE
+
+config SOC_ZX297520V3
+	default y if ARCH_ZTE
+	bool "zx297520v3"
+	select ARM_GIC_V3
+	select ARM_AMBA
+	select HAVE_ARM_ARCH_TIMER
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Support for ZTE zx297520v3 SoC. It is a single core SoC used in cheap
+	  LTE to WiFi routers. These devices can be identified by the occurrence
+	  of the string "zx297520v3" in the boot output and /proc/cpuinfo of
+	  their stock firmware.
+
+	  Please read Documentation/arch/arm/zte/zx297520v3.rst on how to boot
+	  the kernel.
+
+endif
diff --git a/arch/arm/mach-zte/Makefile b/arch/arm/mach-zte/Makefile
new file mode 100644
index 000000000000..1bfe4fddd6af
--- /dev/null
+++ b/arch/arm/mach-zte/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SOC_ZX297520V3) += zx297520v3.o
diff --git a/arch/arm/mach-zte/zx297520v3.c b/arch/arm/mach-zte/zx297520v3.c
new file mode 100644
index 000000000000..c11c7e836f91
--- /dev/null
+++ b/arch/arm/mach-zte/zx297520v3.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 Stefan Dösinger
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+static const char *const zx297520v3_dt_compat[] __initconst = {
+	"zte,zx297520v3",
+	NULL,
+};
+
+DT_MACHINE_START(ZX, "ZTE zx297520v3 (Device Tree)")
+	.dt_compat	= zx297520v3_dt_compat,
+MACHINE_END

-- 
2.53.0

