Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63943909A4
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370782; cv=none; b=oBFPyDzbm/8hBfeYgU+L7Gc8cKeHxerjyCVskURUeHzqlRzcV9Dp/arWGywckUyxsyDoWB6TzUDL6QuK8hIW/fJ7mJTKJFnwj+QgkT90Gzpmae1iNgoCW4Zy2RQ9uZ4mOasSPwsadT778HkjxIQQCOCAX3QtPdBpSwm1AVTlyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370782; c=relaxed/simple;
	bh=hk7gHqziEvl2uxbuMiqD2c3qOIkx82OYMM6dUc4onOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrbWjf+azMSqa6ewCtJj45jSZaDmQfELfFv87RgtjFyASLxLUeJ5Gk2TobQoqAK2444bOF4bsePTZIH9sUs3xnvq7jOF80/ZYIoDWTAR8nsZnUGarhgaf0KaNrKQwmYXBrSBHnqher42sYMsgiN3JMQvW1X9Tcf7mLfXo3c1u5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feyzsq0y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feyzsq0y"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d70b3e159so2355547f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370773; x=1776975573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x1tfBa9GBrx6AqH/jEGu51e9qcovSpp1FPQ93EZUqY=;
        b=feyzsq0yoGRX7e6BvjOjV9Dm4i1HEh+ucP1S8kxUqoU8+YZOrLx3AMdodkr3gFzkqT
         1jAdENsCvtKenFh0hVqz4RuNR0qdSrmormDt6wnWl5f371EBCJvHqYwnlwyUUzcld2K7
         +0nnMDqxd2FGDq/N24TElZlVC62vz2TAfcrb2F90UJbnn8lzMQDaynBT/fYtVsMeSyW6
         3+5ZUEMRiB+GqBDwMAsf8+mnZcaT8UOe9Py291L4zP5bnzJcS7yCIyuQ18ffj+AdF0a7
         IRBnR+FhS/mZHAcMpxcZjIciENXxudrzYP0KDP53dFQ7cskMhk7Xps5aRW9X9A8K+nK0
         N0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370773; x=1776975573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8x1tfBa9GBrx6AqH/jEGu51e9qcovSpp1FPQ93EZUqY=;
        b=JIEUznlqzpB/tqREwaRWpCvCHt753J4i8lTD9HGaE0AViNsVl/7+IjbFMS0Pg9n7sf
         ll6QxlKeTHXpN63ELdONKpLC50i+1fcjulpf3jqdDcACmAfrlS0NslG+OmMJ1+BTz/5u
         WTNSnLrNKIf2Spox4sDnRsdjIIGQ+H1IA2L32agnfwDPMwfylsgv5YSz0Jx+UPpB1zIb
         c2o9bomrNQqf5CGpCtpap6z3uudQ/wkKW+qm3xnCR1LhpGI+XVbe4NLh8SIbNlQ/EK5J
         CtlJwoyek+C2hZGnGbgVZPgsJWxN8/AmUKDr5BNokm+hTaLLo/4q9TbPz25gq+OUQf5Y
         v+Pw==
X-Forwarded-Encrypted: i=1; AFNElJ8LcC1dYbQ0BM7qCpntKdRBy9jGSC39o3G42lM32VU4PwcNLcKD8DBQR+KG2vS9VFhkcDfHy4K7TuLwh34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbMc4Hi/+AKRRM+4W+SBMoW6nmbf8qS7V1FRayY/EJ25E5bG3
	j8rTsOXlvEoJBsrWvEz5T+3Ko+yhsQ/wBBJsyLmL2aHklmRP+/fKxge5
X-Gm-Gg: AeBDiesctQHwDhriamtjTM3MYT1KWF464uXFRoik5tY6RUWJ3eYfSbJiwr0KAQ8xY35
	VIL0IvJ/n7bfIX6AvKoHS6FT4xSWei+r84nMAAmwGnXGe+QKqG7REaeIMWykhZaXnS4kP5WB2A9
	ziFKmW6+uAOdZNv7bKpx227B1hnbdoQJTgqBsQKwEz65vx1foMP/fSS3Dl22f+oGTm5Ay6pFKWZ
	9mOZ9X2PxCu9DqhJofMW4NCNXKTQ2I4D1WKFJdtBOi4PoDYx3ByMv94fYYTkAsroVrqfOj8PBa5
	Yn6UJwxI6SHUK1USOmqXZPLLxKmvwhoYgTd5HcxwSGT2+E9u/ZgxVk/QJmmiKVPgMN2LSI4Lt2F
	rJWh8d55D5NHpnwZzm7DlebAQz0B7rcGGhvsJj9An6AWKgoHgNt8MtAGOAPU5+l00VT6CfEOLd5
	IkqHWvAUkKlModl45D3MmMY29ZaWxC77SLdaK+eOlurdtXbg==
X-Received: by 2002:a05:6000:22c1:b0:43d:1c39:593c with SMTP id ffacd0b85a97d-43fe149179amr1138509f8f.30.1776370772892;
        Thu, 16 Apr 2026 13:19:32 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:32 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:09 +0300
Subject: [PATCH v4 1/8] ARM: zte: Add zx297520v3 platform support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-1-e19d02b944ec@gmail.com>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
In-Reply-To: <20260416-send-v4-0-e19d02b944ec@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10835;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=hk7gHqziEvl2uxbuMiqD2c3qOIkx82OYMM6dUc4onOI=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URKVRp9LPZBhue2GOaHomSTeD/Gp1fHCTg41
 Uz6tG26J2KJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFEShsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJfrQ/+P3fGJXzxn1sflX5Pjfuy7W4TtLxwSKi
 fSnS/XOTr0Eel5I62azooXZtop3ZAmSFEXw3vKRNBidG6WMgt+mFw4+Tma+y4AE55u6WQ7GDe1C
 xwF9JbjxH+6ver2B7pIsSZeUPW79COb6f80ualn23iZOkN80+4gSjk46Osf3GYWCvcLDTZsEa9q
 5AGpOX4qYHTSTpTeasAP4YQx8lgBPUGKLgfA9di5S+a1iBYduufAbcUudl/czmEzNPYIbXax5E6
 V+8CqcPIP+LtpU5mbouvUCBmmFcRDsw4hwrTNaZkjO+FpeQSrKuF3L4uwUjHp7QQD6JjFK8OrES
 +l8ef3bFseEvd1EhnEkkJDy5kkgHdnQVO4fQl2dkN9vrg94nZhkEiqc91YqfRc/TtPkMDhjXg6L
 HZbgpOnP6XG0xIPGiZsWWl9UqGuA9sPaoKdYIhRQL8k6wtK3qEwNabtlOXC0imFYECdku+bG6Vb
 8pYcm1gstCs1lxJL/WEjyLL+vKWCxeGqlyWhIRTWURvw5cbOzVQZpRxFSO6ERfW6fiHQVOFWTb6
 ANF4NH+npF+jpoG9Lovv61isMzG6xLpouDtEL8VphAE5dRfUrWYWW3d9BLsB2sk0ZpoWljvci/4
 mOvpHg8VFq78szjpdUYvUc71kZZr8UTq5jYUtXlN5HC97QFGNzqg=
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
 arch/arm/mach-zte/Kconfig                 |  24 +++++
 arch/arm/mach-zte/Makefile                |   2 +
 arch/arm/mach-zte/zx297520v3.c            |  19 ++++
 7 files changed, 210 insertions(+)

diff --git a/Documentation/arch/arm/zte/zx297520v3.rst b/Documentation/arch/arm/zte/zx297520v3.rst
new file mode 100644
index 000000000000..a0f25ade0a3d
--- /dev/null
+++ b/Documentation/arch/arm/zte/zx297520v3.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
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
+run in aarch32 mode only. The CPU has support EL3, but no hypervisor (EL2) and
+it seems to lack VFP and NEON.
+
+The SoC is used in a number of cheap LTE to Wifi routers, both battery powered
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
+i2c connected displays
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
+custom uboot and kernels can be found here:
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
+ldr     r4, =#(GICD_CTLR_ARE_NS | GICD_CTLR_DS)
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
index 000000000000..24699256863b
--- /dev/null
+++ b/arch/arm/mach-zte/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
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
+	bool "ZX297520v3"
+	select ARM_GIC_V3
+	select ARM_AMBA
+	select HAVE_ARM_ARCH_TIMER
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Support for ZTE zx297520v3 SoC. It a single core SoC used in cheap LTE to WiFi routers.
+	  These devices can be Identified by the occurrence of the string "zx297520v3" in the boot
+	  output and /proc/cpuinfo of their stock firmware.
+
+	  Please read Documentation/arch/arm/zte/zx297520v3.rst on how to boot the kernel.
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
2.52.0

