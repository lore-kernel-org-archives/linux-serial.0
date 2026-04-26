Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681D345CA5
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204497; cv=none; b=JnZEJy6OBgi6c+P2pT6jlJzbT+16blJSMYRLZRDh4XQjkBP1ZdqfTxhJrE3pCBfdcRL9BLIi9QE8Q0rYfvzVPiEc6iz+E+3ZA6lyPxUF/Gpwuwa2UToIaXhr/Lz5XTgqjTZDS/F8HBfulEuBsWZwkilmxxKCppF7PxDC4sFQTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204497; c=relaxed/simple;
	bh=ME0gwHw/Kxyb6HlTRgui0vBk9ztmkUUdS59QuMFbKKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhsbQg6j+JtAd8WTAyxmN2j7Kp6JzKwpEwkJzddgS495HfrYyWHMBGRMH1T8qZ+0TxdgMBGn2XiU0fZgigBDbjWT2L+0JFufx9zS8g1xMWbwTkL8T0mGbEE2tZZewDVHI/jWZKFc4o0oqPgK7F12+lt2/HzZm7KPv26K367dVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqWU0ZSf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqWU0ZSf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so77962455e9.2
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204494; x=1777809294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvzfilwosZg+Y6Y5D0mnaXMiTMzbnTm7xoCYs/xtKvU=;
        b=MqWU0ZSf5QYOogxzEOZr+RmMQPv4TFk0Cz21HT/S6/Z1oTViH8irG5mU9KUJ37fUmo
         EqTrW6WoZrTtICt4Aly61pZ1WkHrPs2uVO8JvDrXNS/V9er+z3mProiQDwe4L2vzI7oB
         +Sn8yJ+iCvvMQYUimWTxpbB+tTcW9EOqu89eFkjrb3a198DAtWUw6f1p3FjmKLe4bvRg
         oRSVIWtT2iqQLaz5GPOK2AStM4XQbUJDfJn+NZrwj/nY17/AFWf+OhaLXcXEoGkXrPkO
         /ut5cMUumU0RPuA1s5bPZgvicXMWYJ9e5/HCCVNQafRmrhyHKRVrmFYrJ8+yt3UjdaFS
         E+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204494; x=1777809294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvzfilwosZg+Y6Y5D0mnaXMiTMzbnTm7xoCYs/xtKvU=;
        b=rjsBB4HjvZ0MJP27yZ58Saz4jBd7vA2zjIGDH1VeM/035vQ8GAwJTr3W+6FRAjovkD
         s9KW0OHZRseV5W7t/IdpJHhOVzoWXFDtNCBEwiebTJMPL9+BcMV94t1tH0N/mddbbzWs
         C26tpDmwyoNqmetTEI8zUOKcG4q4CdZ0+67Y83u4b4EfH8jLgYzuciXI8dUx7isT7dHr
         eWitGi0ym7Ys17geaO0FY0c6joFBYwf5mxESRLESyfiYXRMETzSqSqK7lQhckqwXHlTR
         JhXegKJR/b5zZCvCJ97adXQgurxDa6nXs5K/G1gFKdqluPPlpR3t4qY3RAQB0z4iTdgc
         OBTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5k5JrSdjl3fMXIZbjcnAc0ELs01QYNcExTQsg4TQYO8jdU0gsjK9eK7BOQK5BRjyz8Gi5JtcIvpq11Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXCqn0EAGDflmcqDWVmRs0AylRtEUkMEB2Y/PJJ7YSdYRMN2u
	afKzrcAUDuniJqt5j9GAHyJ7g2VkyiRVzfDCYZU2ItWdmCbA8LCDH/x+
X-Gm-Gg: AeBDieterkWUN/Fn+9TBf3Nueyv94LhSie5+H5CumCO/S5cF40p9M42hgH5fbo3Bmrv
	dAr1vP+21gqIxzI3tu3hvu/eGAtmCx2LZjL3txlrDgcyWnVEqxGz0JFNBX1l3oyPFYKsVH4+MlH
	1xJh/HooiVTquSJa3Lb7VugghQhFiMB0da149jAIAwQw5e2Yxhpjfdd+t/jQgaYSf26OG4nCW1o
	2him3/LO1WNHkOhojeCtA6R/SGYn/FkYHpSG6PaVq5L4hE4v/FwER40unqeVDesPC8fR6+S+F7V
	b6VxTHFDartmQ7wsvLyUeHNa28DrlXDQzaWP3dgKxCm44oUU3sm6KaRD0j9C0vWnEW4sR8Mt9In
	sQHEFeqyS+p3RTXx2oHbLK9jOc8Lsv1VgXJmXmiLIRVnJFmxfnLlKWH9/yL4AOYr4HKzlcoKvHh
	WU793Z71ddyX3exeqfmn7T/3jX/4zCi2cCCfgUpgmW
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr413222665e9.11.1777204493975;
        Sun, 26 Apr 2026 04:54:53 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm424018575e9.0.2026.04.26.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:54:53 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Sun, 26 Apr 2026 14:54:15 +0300
Subject: [PATCH v6 2/6] ARM: zte: Add zx297520v3 platform support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-send-v6-2-d49efa72bb09@gmail.com>
References: <20260426-send-v6-0-d49efa72bb09@gmail.com>
In-Reply-To: <20260426-send-v6-0-d49efa72bb09@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10898;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=ME0gwHw/Kxyb6HlTRgui0vBk9ztmkUUdS59QuMFbKKk=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp7fz+5rqb7/wOY73SzfwAKT3EoBc4iJMYIq1p0
 Nxs0iSmlXyJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCae38/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiL4Uw//bc4lSWYVeJwYU0FBPtKfzHG/AurjEY3
 jJ7Lg2hjt70n9MFelIrbL625dU73rhdpkT/0FMiikyrw6GpYwbosBQExJzcbPs+pqzY3NwGTfM2
 daeiQflzsigDNtGCY0IB73gEg7xXBopqPVAYtEa2U3DyuRi7hqbHU3231LFggDyNuRKSdmraubj
 xTwQFs9gMc1mF9wO7MF3ziE48j47/ATOqDSL5liNXRq2KbVkk49TFVy0cN2wLK6CO6hQhU1Uucp
 wiMi3jzDwXnXilBO7G7hljDsglYL2oqeI4h4p+G4v1iyPwAC3Ylp+X8O7sfUjk2+a+NCNvfHwa2
 rXSO2L0HeB8HimXbwgyUG9iCNcZ32ZUCzn/a+z/M9CxDlfk4TgWsPKs/uXjCsLtrnfjoWdo4Oog
 +lJbra3zpfdhFxTuIZdUrOwX7AeJVHCHGKCevf3J/tiUGEZWtaO+HDGr2IpreZSU0QUsXufy17K
 EBFvd+ZmaUy8tZBlwcrp7QnJ0hhfBnzQYvheNuP59R+96b5EH9L+O+ekx1p1+1ru9BkjPHxnoPG
 m6XTZG8cvhzgxW0kMYJ2s4fAbPZ5n1Ah4nkgbpOwoiKPhTFZ40K90ykBwdflX1JbtNKuzMzgaBS
 qvrU1oF2fcJ5Ybv8SoRm8bZecb5Ca/iJOTK+HNAGDDrGIDwQq2V4=
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 Documentation/arch/arm/zte/zx297520v3.rst | 158 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/mach-zte/Kconfig                 |  26 +++++
 arch/arm/mach-zte/Makefile                |   2 +
 arch/arm/mach-zte/zx297520v3.c            |  19 ++++
 7 files changed, 209 insertions(+)

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
index b768b9da37a4..e707176c2114 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3775,6 +3775,7 @@ F:	drivers/video/fbdev/wmt_ge_rops.*
 ARM/ZTE ZX29 SOC SUPPORT
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
 F:	Documentation/devicetree/bindings/arm/zte.yaml
+F:	arch/arm/mach-zte/
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@amd.com>
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

