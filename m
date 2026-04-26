Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9735FF58
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204518; cv=none; b=TizwZrxEXZNmOm7XdJN32qb4RtVWqri2sl3txvW2gIQPrdOHTsoc3KUYsh75PqBe/SvlDHTu/rIJzHp9fj1lsvnNPZvovGKSeCjdHuuOLlYVy5/WyAL3c0ZMtQ83bLzhXJot/sODGzf+2mMasVkrM+asaFWCzUG7EXYzsSvnmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204518; c=relaxed/simple;
	bh=Raw3nnG6txGxRT2tuucK4Vyk8RJ3aJNJodqKknAtnWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2j1mZvIO7Rl3D4J1esZ3vtp7e/e7vTABg0i1KF1LulqPh44vbiOvM86IGDxhv5Ruc3IeqKAhPN03UH6O797UcCVCVXDl44BixF3fQIUanCGCJzxHPVBwz004yYoTNmQa26xs7dhVbuDnbDKx6ElrnFXvjXKmGrNUBybMH5d4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRfZudTL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRfZudTL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so48204985e9.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204515; x=1777809315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fKUgxBCx0mNxBEJyRtsEMEQ1iRhj1qvL3+7BPzmL+U=;
        b=bRfZudTLbNCAqhkAFb6JHn+ijFsSo2YeAn0zTIrXFjHWVfh4XB+y40Npnint0ijgKp
         YA/Myk5kMWHRTqS8+QKJ9DPFZsNVk6TuCTIxZd82xgjaV1yIJDYRsqPuG5zxy0Ay/hut
         GqLVwEtr+Ucn2W4k3SNVxDBeNP7+/tYNdRRnkzy5SKatjO1cAxI63HbRU6PADSMhQqdq
         RrcV4ne7b0fP+mNAF/lIKdiq0z3uYAkc3mH5YY9mzgvKHUTUnfnqt0r0XzxZXD9ikZrv
         75wAHohNqwsCxPv8MQ4bkEKb6D6E1NYCdlApLLHic1E0hsc2OJdUv5v1/jSknGwgkxmc
         AZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204515; x=1777809315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6fKUgxBCx0mNxBEJyRtsEMEQ1iRhj1qvL3+7BPzmL+U=;
        b=m/O9MQmRoXrBRITfddUX6WUPLYE0tPP2xig4q+BhlinQcTmdyyWVLLAAjPTdlkL4kG
         KjKhrIOY4lcGq5IxMvuPAqg/3NtNS6ZttiLE6vx7uuyBLNeQhO700cZbwl1nEmjh6Twz
         SY0zl5qtM/NYVImdr/c4eeRLLKCPzu917Twk5eKQm+zBq2CtMsLfG8Bu79o8UKG3+y8C
         98nIxaN2wH8SnC9EuqBNyM2BTyBw4u3bsNFOzBH2Wwk6q1nJ7Sp6qu8zmzn4vvpPpnzD
         fDexMTlXUu6ooFcyjVkfwLHTcf3aqp72i2MAOpXI/DVjv08VeUhmH719N4qoEtyF7x6Q
         +OIA==
X-Forwarded-Encrypted: i=1; AFNElJ8wlRXIxGYI4hxlJZvUDDRmKV0dTv0yb5MgGvav2C5OSnwVIud9HcZH0kn90QN/TWuH6mBrgqoajDMM71k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPms/sAPyXDognCIVGfyOf6DILlsp6FLQfdgkt6aRPH3Ja+9YI
	7FAaDuIOO5x7Wby9NI6+InAE+GLiWlAemXyvaPklAiTZAmwmTfENkH2j
X-Gm-Gg: AeBDiescmseQ2jixEqfxN/hqrJ3xYL84V8SsxIAVi8rDWWbM3JOPftI20T0uDoXXawW
	PpkDOIXc3Hx1JQz4P19DK/h3gVgMwQbPRt/SAw/Y8GbUuPtnSeJJPuBT9O5u7FfBRDmbYaYbJPC
	NHncNe/qc0r2a8NfiKoDj9fB10r8S013U+cKiRZRwUm+n97L41RQKOfalgg0iV/MhxzUzeHFoxK
	EQVcqOdfEip5tjNv/ENPv1EclwGIsrONzxKA+ntNxQ8G0J6bDf1E5ybS7OZnkWY2lrxKrr2BN//
	bPy8FKltBifmEqRU1/2rEusdaqO2Ma2nXaUJ3o2A8LcN812XSXq8FxWTrMYSA/VG6hM+epBOkE4
	/0M2TvFwHPVkZXik7JdpgN5CqqevCwOvDfSY1kFyFkX3UZPNALUnzv1IdFDd1FUpjDcsdgI4lkS
	qLzlWa2roTHbMWT5CfO+oVDnZSJMHJ15hJlfawS2QX
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-4891d7a463emr404448875e9.3.1777204515083;
        Sun, 26 Apr 2026 04:55:15 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm424018575e9.0.2026.04.26.04.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:55:14 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Sun, 26 Apr 2026 14:54:19 +0300
Subject: [PATCH v6 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-send-v6-6-d49efa72bb09@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=Raw3nnG6txGxRT2tuucK4Vyk8RJ3aJNJodqKknAtnWs=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp7fz+M0hRXrrwNqabGR+NCrUNYSmRCVX6ergHK
 bOFKsauVLmJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCae38/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLHPRAAi3pLix3iMnS3uZh2OrPDjkqvSa7mpTD
 d0PlJS2eCaRq9cokUGhS6Ct/U+NxZNcLbWVfp9VhwWMG0L4fc1xHeMqN28GxYygjPnhPQorJtWH
 QYhzxkSK2E74XF9olD/dZmF59i6peH3tgPqOmaI5DAKE6UmaEHvEcCjC5ewGEhd9Fm1Ow8keCnA
 sUvYYa1mYYqn/NP9a62cXctazUXReIWpOeN00iYLSs8fPjT1AggopF09nG/5IsbHAFtCl8NLxNz
 Ukel+ORqYPSl+09l/e9cHgJ9lRA5RN4yHfBIMdjmDrJfqZClc7LiV/V4mNAb56ababFgYVzEgGN
 mSmWhRmdk8Buw2ekEJV0uGMnT4keHgkC30GB5Wsk9F9C2WYmPO21swBsdv+c8NDJ0q1to1NxaEM
 FBkyiMIwd688VTYeJ+QIxwdx/BWiabY15haY3eRiLbGDXfOU8zqdX5JV5peoOzrpuV8xrPa/Fz7
 LOsTe+shwhxDYPvILQS42pdSGBYYq2Sr3oE0GOCqdv4Ow7XwTTtoTIqsq6rrLg3X0STvE218nM1
 L9HIbyzoTcbXU9GkTe0j1pt8BNQrNMpNJ54eGBs5d0UFaM0ky6rlly3OwRJroyXBZaEKshyZfeS
 Q7kuOKJAY2Ro9vDrKc3r12tUQ2Az33/A+D4SmPrEdQbUiPev+77s=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This enables existing drivers for hardware that is present on this board
even if it is not present in the DT yet.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

Changes: v5 to v6: Regenerate the file with make savedefconfig.

An open question: What's the appropriate name? zx29_defconfig?
zte_defconfig? zte_zx29_defconfig? There's e.g. stm32_defconfig without
an extra mention of STMicro in the name.
---
 MAINTAINERS                     |  1 +
 arch/arm/configs/zx29_defconfig | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f51ba1c5ada..5dc52b84cc09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3776,6 +3776,7 @@ ARM/ZTE ZX29 SOC SUPPORT
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
 F:	Documentation/devicetree/bindings/arm/zte.yaml
 F:	arch/arm/boot/dts/zte/
+F:	arch/arm/configs/zx29_defconfig
 F:	arch/arm/mach-zte/
 
 ARM/ZYNQ ARCHITECTURE
diff --git a/arch/arm/configs/zx29_defconfig b/arch/arm/configs/zx29_defconfig
new file mode 100644
index 000000000000..54fa62ed56e7
--- /dev/null
+++ b/arch/arm/configs/zx29_defconfig
@@ -0,0 +1,54 @@
+CONFIG_SYSVIPC=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_ARCH_ZTE=y
+CONFIG_ARM_PSCI=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_CMDLINE="console=ttyAMA0 earlyprintk root=/dev/ram rw"
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT_PLATDEV=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM=y
+CONFIG_BINFMT_FLAT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_SRAM=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_PINCTRL=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_POWER_RESET=y
+CONFIG_MFD_SYSCON=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+# CONFIG_HID is not set
+CONFIG_USB_DWC2=y
+CONFIG_USB_GADGET=y
+CONFIG_MMC=y
+CONFIG_MMC_DW=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_RESET_SIMPLE=y
+CONFIG_JFFS2_FS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y

-- 
2.53.0

