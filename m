Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5D423A6C
	for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490065; cv=none; b=oCoDe1iyoEydtJPQE8V3ADzm5G2sNCGRbVSeFibGvlHNsQyUIwCTbCbYNdSBfKQEJ8b2Ut7vv1GzEmLMTqXNnrWxDlVKelCu1QOBUgh9O+HjnJPyTdpgIzWBNG+v+sNRn7l0fqPIOyxo37tArOk50PeGRjqO/V7nex9MuNox1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490065; c=relaxed/simple;
	bh=M2o/Qr31tdSVgMGK7MGptHsdQ8CYwaC7nU5G71DmAdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gyw/12LO46GVZPDusHWpt2C62m6JXkGjdFIgpiOwfi9zVEau5iuK0/Q0zc7YVKpu9Uqqda7kKW5y35m5xHKQ1CGTNz8xoZgirMnt0J5ZVe18FcRhGXnZy6LW0KLIfrIl8Xk4sGC9zAUKfCfVMMmMSAtlA+6uEhistQdgLKU7MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Rtm46n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Rtm46n"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso713425e9.0
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490062; x=1778094862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a6WmnzhZriHz9vEWPuhbpYJDMw8zDZc78JguLRxNCc=;
        b=A0Rtm46ni4w/Ru5gDjXHtP1tn3O1nTf5+Kk9fA11Nv6zpFfI+OYuBE51MT+p72Vdm9
         xGqo2J9Pxhd1KasKV6D42koZjj25O2a+0jmylgX/kgan14pdNB+M3BxEbXJDP6gg6AfP
         og5H2Pv1+25MXPYHrwKf/7fa1l56Z6BwW/vYoxZIGx7FuKZLhQzsH5Yt61mdrv9i4gAT
         OInD0Tlv22PxQl4DXmnzDqljn3bqdmUriuN7+QcvN80ma8dZeC+TArF5KJ2kjDxaYBsG
         /UXWOOMvSSb6G8TwK1zbCQcVHTQZ2rX2ojPe0aqOuUa/sL/cnCKFmVoEUVrR0BmMe0xL
         7cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490062; x=1778094862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8a6WmnzhZriHz9vEWPuhbpYJDMw8zDZc78JguLRxNCc=;
        b=TEEm1EpDjl9ag4gOsg0lt2iWv6n6na4/WoFu6A/RIIZ4dnbe07bvGjbPlMCr0NR0Ic
         Eddbbcfc27ZKT5eSc10iuqEL1IvGYS0Xqu306cuStcTnVfLWlT87bWej5TlRVvVHvO6o
         hbZ93+uuYW3ktqPgv2dhXzCuCoJikf07LjD9ouWYGrFmWSKGv180Vc92Bumm82lbllUI
         TxvgVG1nCDCELYJiywQ2dmHpJnAucqdHYRkcfTPsOGzg5fQrOzE8zFOX3l1T0FoqTSrQ
         ZZPgdGc1+ZJq5T3A1LAZEcaCiJjOxNh5rPRl8b3UIIccBMFJSR2fZFfo6/SPvTo0mEe1
         Qcfw==
X-Forwarded-Encrypted: i=1; AFNElJ/cj1o0gEp2103x35mPXBxtjKgF9NZprArs6QjRDUe+z6aTghtgLUJBTRPadO5kGVADg1hnQTJykglKSp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpu9aFuVWHbw+q6wMW+j8goSak+K724lL9X39pyCej32c9/9P
	giCZ8hyiav+u7gXjUzLkOA0cVhaZEed5uMxUvdfNr8gEAU8U7TLzsXuy
X-Gm-Gg: AeBDiesnBMuStNq5HeMXE19ONM2CKGuQ0tt4L+SaMyj+Hbe4n6+pl1RrRX/ewxLi565
	zuXK+xkXK4zgsnOveMsbyHrprBNwwrf/ei/Scwjau0UpOkiHUslNxpNBLqVPnAuZWxzjI9LhCLm
	LTMTK1fFjp3HkWaxcjbk9B50V31FHlzIARDr6+DBk91TWlLTRuFowuOy8AjGrTXjAcBn/DmFgaK
	Ql4dQkZHd5uRQhnrdOUwmjkj3djDn1P1EtbRxj2DCEyqJS8CFv8eAxZokW0D37HT+8PbGryIBxH
	PHzzwbJQ3AIlUVoiHAq82gA3csQlpwNwyw5cHEYcX0XdlMxtgRkpWzLTc8sdsyQaTaQ3NuSeRY9
	CBa7Tl9V++LtbsbvBB5MbDufevLjJQYM9awYyxLzhjlkcqb9MQ1jOaM2n1UuyoAQ+dj+ECFbcnN
	RwbapftZSnYb16f/f5gwXono07+ibG0cTe9zzZVIvnP/Epch3DyOfhVA==
X-Received: by 2002:a05:600c:3d90:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a77b1781cmr145135425e9.17.1777490061506;
        Wed, 29 Apr 2026 12:14:21 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c316d7esm23315005e9.24.2026.04.29.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:14:20 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Wed, 29 Apr 2026 22:13:14 +0300
Subject: [PATCH v7 3/6] ARM: zte: Add support for zx29 low level debug
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-send-v7-3-b432e00d2db8@gmail.com>
References: <20260429-send-v7-0-b432e00d2db8@gmail.com>
In-Reply-To: <20260429-send-v7-0-b432e00d2db8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=M2o/Qr31tdSVgMGK7MGptHsdQ8CYwaC7nU5G71DmAdM=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp8lh1uHld2kPX/8v2HJbRvy3ZwFQDa0OSTcuv+
 3Kf5aBkmCiJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafJYdRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLcqA/6ApdrD8oX5RPE4JAHnJAWFBos5HFL/o2
 XpNBXS+K9DRL+91EY4to310L+6z8TQUfVqrk6vT7uP51Htp4rLo/uARsSbhPjQy1cNh3ao1SJDE
 QSKaiv7L6V28sOG3uZuFOr8tv0vpjoIeYnquTU0Gatryy6thQB8C/MkegTMkAnAC6cxYcHt8OD/
 b5r0sKjrMOJW5th8V6XCxmGEM284cWRjPuVCrhHf7+hBLRzu6eyMJITtCVq/PwWc6ORnu01LuEP
 tFBEjZcpB2AbeDG+Jadntjmrnnlw8UYCHth1SgL2z6Dp+HIqj4xUPu+cLoZiY/QpDHqW5bNyipa
 IrwZqC5FWMt+sSEHGAeTOaLIlgvbGgFrVX00vAk0llThQglR2tPjYi7LxhoF9w2OOc7DhaGD2uB
 vVM2bxL0GQxUB+O1ksEb4lW/cuySwq9iTj1xmwTncmyq/YtwpXrLybTkrMx6/Qg4ThWwsZqNnn6
 irosXvwUcEXciS1mNGEz8hhwrVmFo4y8q/vyn+TV2GMeLIH+lqeg+v2aC1JlY6mgqvR3y9LGLxB
 huWQ2AZwCam0n0gUIZj7xS+yXFhQTxgjPGbMsjhGqVh5leaw4Rvft7M/rnjjBbQOy3ALyM8WkJy
 8A116eIV8pRrCb6eTl0JrllUjOb02B99OzBB0OidNpqj3+C9ANvw=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on the removed zx29 code. A separate (more complicated)
patch will re-add the register map to the pl011 serial driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---

I am unsure about the virtual address. It doesn't seem to matter, as
long as it is a valid address. This address is based on the old removed
code. Is there a rule-of-thumb physical to virtual mapping I can use to
give a sensible default value?
---
 arch/arm/Kconfig.debug         | 12 ++++++++++++
 arch/arm/include/debug/pl01x.S |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 366f162e147d..98d8a5a60048 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1331,6 +1331,16 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_ZTE_ZX
+		bool "Kernel low-level debugging via zx29 UART"
+		select DEBUG_UART_PL01X
+		depends on ARCH_ZTE
+		help
+		  Say Y here if you are enabling ZTE zx297520v3 SOC and need
+		  debug UART support. This UART is a PL011 with different
+		  register addresses. The UART for boot messages on zx29 boards
+		  is usually UART1 and is operating at 921600 8N1.
+
 	config DEBUG_ZYNQ_UART0
 		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
 		depends on ARCH_ZYNQ
@@ -1545,6 +1555,7 @@ config DEBUG_UART_8250
 
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
+	default 0x01408000 if DEBUG_ZTE_ZX
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
 	default 0x01d0c000 if DEBUG_DAVINCI_DA8XX_UART1
@@ -1701,6 +1712,7 @@ config DEBUG_UART_VIRT
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
+	default 0xf4708000 if DEBUG_ZTE_ZX
 	default 0xf6200000 if DEBUG_PXA_UART1
 	default 0xf7000000 if DEBUG_SUN9I_UART0
 	default 0xf7000000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index c7e02d0628bf..0c7bfa4c10db 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -8,6 +8,13 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_DEBUG_ZTE_ZX
+#undef UART01x_DR
+#undef UART01x_FR
+#define UART01x_DR     0x04
+#define UART01x_FR     0x14
+#endif
+
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS

-- 
2.53.0

