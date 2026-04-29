Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CE421F10
	for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490072; cv=none; b=J50Omcf4pEDu/wirqOlkCYfSIDEINV8+nYLkH7aojl6CKbW1k9A4+/iOOyQ7tyqeTbOwO++WhQp9oj4/+JJ+eah7TyUdC12YsNuInbdKDggJwL+9UFiJyUrRcbk88ZUlRlihOkA19nwkg0sxS2RUwKFuEGongdB+dr3gECsxmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490072; c=relaxed/simple;
	bh=OFELZprfvGMngJiiwTNQcz/opzneDKzuYgSzdRQRbGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpYX0k2PQmC+QS0mi4rMq5AOw3cxZbL+IT2U3sxT+QGI5R8uIV5tPiU+fJ/m0ELcNGd1P81AitSgcqYVjEd9imvPrEOHyOEVoqQvYAhS32gOIatfbhq4SzoPu3NCKFw3RvldzaxtwojGWucSYSnnGr4xW2avQXw4EtqsysjSYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/zf9yje; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/zf9yje"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso1192765e9.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2026 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490067; x=1778094867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=G/zf9yjeagLTiNgf6bSM5KSNQ0D+WwKDjEJ3VqR7j9DHbqEiBQvyY/HM+JybJ9aAda
         hV1Oy5POy/usigKepZknhPQZSTn8/LJvuqH2unBNhRQ3ISFmqpf/fKhqwkKJ1dLB/Mp4
         sC+2eSLACT0K5xyc42hE76dl1+NncI8Dq48NBDCaM+pf1ugOFExwd+nUJtf8PYKb2Kim
         1gjydcXHwAzl8L6ziKlAxp0fKe/LiR3hXUX7lNlRzX3mb03zxVsioCvXiszgG7m4GeKD
         JzOoMP+zjoEWC+9wIKXmmUP6V86MAOBDpuvTAtMU3d8Q9VCT/AX5lmHs2EKHUWJUsL3/
         UK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490067; x=1778094867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=bH8AoNoxYIJgbznc8l/ZVShj8Y5Mm+3zew1PYi7o0Vpw0jexRGfKfdzP+jyoCIk1vk
         s99R8TL9wGUDxk3xzjE4ysJ0fu50vwG2apthaZpfi4skIawa//OuHdsEweUZ1ZTjZoQJ
         kA8Oga1DXgX+aUrA60B8GXTB9qQeqyflsFzWKefwDaFMsa6xsPXnrUDxRtHX+uYfGcKl
         tZZl9N2sy+zhc+h/qQHTSwWDcfZ0p/1Q9e0tp+0/MoBkH+WZZq1JCBqaTXIkpU/kaOfK
         ZN1Qyz3SLGzf5L//jwaG65LY+2mkHgCGP/5vptUHVvbOWxejZ+JFj1A7FWCPVDepJurE
         oz7Q==
X-Forwarded-Encrypted: i=1; AFNElJ829Zg63NeTzuY+xqkZb7G+DDCT//1ILucI87nrzA9WlloIcpEU1Nvdbxg+NQWPeNfy0JMC7Cq/JtxOqi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHiVVn+vi2nKhcgTatF7YH6Pw7iPgzVg10BFqgckYin0dswp6
	KnzafxbCmY9WesLY+ZS+i2NVBqRYYW+gIGFOBkrSd1FmViGa80gxIRKr
X-Gm-Gg: AeBDiet/cArmkN0odp5NhQpb+ZsDuJBbaGTV+/eiNtx0CYnadUnV4OUxyLro68nFo/0
	wnXUw8arGTDas8VZV+KADniZfxI6PX6waY0Wkzp1vlCvdAMDuT0+if1S3Ok8nWWyLZPuVavLhjN
	xBPTLXPsxaL34mxg8xoeETxlnQ+vHEsopEKH+/ttESUaPFoEqLs0vfJeJaRpkCLLH4BozgiJ4Ih
	WEyJobskyL1tgpYmp7Qc2x0Ven1Lom9NCBbtF+y0/tT9JteX4AlH5ckAQutH2AHVTDqN2fDclun
	v1N8omz+4XuGwNfAWFGC++7Qo5hSN4GG0plG0clDFD+DlqL6cOi3FAFoWoBRCDph6yiYRWjalKj
	uGTl7INmGLaHFaX+zKD7YKCHZxdjDFZ/yARJvPXgmD9DBV6Ji9gg3k8TUkY7L7aD3Sn+yn5nsIw
	C64ukOnK1So2UKTs1ylyjeLvhLmuwlFAgPQt9TmC6fcWw=
X-Received: by 2002:a05:600c:c4ac:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48a7b531966mr84488605e9.17.1777490066947;
        Wed, 29 Apr 2026 12:14:26 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c316d7esm23315005e9.24.2026.04.29.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:14:26 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Wed, 29 Apr 2026 22:13:15 +0300
Subject: [PATCH v7 4/6] amba/serial: amba-pl011: Bring back zx29 UART
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-send-v7-4-b432e00d2db8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=OFELZprfvGMngJiiwTNQcz/opzneDKzuYgSzdRQRbGE=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp8lh1w5z33TZAF5+1T30Qwz8S7JO6ytEAYV3FR
 q8rCJM03hqJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafJYdRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiK9qA/8DlDCl2L85oAjJdHuvdMuhm2cJ1nBxA2
 avmcsgKIetHjmqNpP2zk44VFNS0dvdbyQb6XCWZlJSB57i/DMG7Nrsa7S64wEgA8Y+6D5Qghn2+
 5t5t45tmsS9zRNhQ5D2L65vq+NlrBjMsLJkgTM7LqY/pa0eu4en+6m1yHzsCR4bSsNUNvUGRqUS
 cilD+V8lYukNNOVNqI+N4hLap2VQ7Imy2OiCfb2pYMMKrHCQWTI0ddPGoK96O3iS3lhPpapDw8e
 IfSUgNKcut7khIXfSbo9XjinyTCVA/c+1YtZGccPu1QaBY/BJUVCmtXQkrMUkdJbZbLSrZZqLTV
 WwYoEqc4ncyISaPD0WKxhMReXZgOPltignhMr+V1pFTgAifaBDcjkUX9ntUWkzhVHFikhfxXHSf
 MiAyq2OacP6I6AnNKaoZ7D+7qRZzrNaMIsha2atpd+e+ZfyzyFQWIdGNinY1g3XxrI4OmkCXf9d
 3kGa4F+MPE6ixR4HZTp+D0Uxk2UM5tE5CKOnZjBgU8ujQ/3yRIIRT3vgOs5Xp1HFMDkHmnTKeW+
 QnQ2JAVva/sKSGsFSLkndoiiTS8H/gfPrPP+XFjTXkEX6rrfeRhdqWW82AJNEvKloPoUWF40y3s
 cquVgQ4HLe54W/tgOpl04w/5zr4hv6CyqdSxxvBnxer7zeoY+O5U=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on code removed in commit 89d4f98ae90d ("ARM: remove zte
zx platform"). I did not bring back the zx29-uart .compatible as the
arm,primecell-periphid does the job.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---

Changes since v4:
Use ZTE's JEDEC ID instead of 0xfe for the DT-Provided AMBA ID.
---
 drivers/tty/serial/amba-pl011.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f17d288c807..f24cc403d9e0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -216,6 +216,38 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
+	[REG_DR] = ZX_UART011_DR,
+	[REG_FR] = ZX_UART011_FR,
+	[REG_LCRH_RX] = ZX_UART011_LCRH,
+	[REG_LCRH_TX] = ZX_UART011_LCRH,
+	[REG_IBRD] = ZX_UART011_IBRD,
+	[REG_FBRD] = ZX_UART011_FBRD,
+	[REG_CR] = ZX_UART011_CR,
+	[REG_IFLS] = ZX_UART011_IFLS,
+	[REG_IMSC] = ZX_UART011_IMSC,
+	[REG_RIS] = ZX_UART011_RIS,
+	[REG_MIS] = ZX_UART011_MIS,
+	[REG_ICR] = ZX_UART011_ICR,
+	[REG_DMACR] = ZX_UART011_DMACR,
+};
+
+static unsigned int get_fifosize_zte(struct amba_device *dev)
+{
+	return 16;
+}
+
+static struct vendor_data vendor_zte = {
+	.reg_offset		= pl011_zte_offsets,
+	.access_32b		= true,
+	.ifls			= UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
+	.fr_busy		= ZX_UART01x_FR_BUSY,
+	.fr_dsr			= ZX_UART01x_FR_DSR,
+	.fr_cts			= ZX_UART01x_FR_CTS,
+	.fr_ri			= ZX_UART011_FR_RI,
+	.get_fifosize		= get_fifosize_zte,
+};
+
 /* Deals with DMA transactions */
 
 struct pl011_dmabuf {
@@ -3081,6 +3113,16 @@ static const struct amba_id pl011_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_st,
 	},
+	{
+		/* This is an invented ID. The actual hardware that contains
+		 * these ZTE UARTs (zx29 boards) has no AMBA PIDs stored. ZTE
+		 * JEDEC ID (ignoring banks) and the "011" part number as used
+		 * by ARM.
+		 */
+		.id	= 0x0008c011,
+		.mask	= 0x000fffff,
+		.data	= &vendor_zte,
+	},
 	{ 0, 0 },
 };
 

-- 
2.53.0

