Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152183BFAF2
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708114; cv=none; b=OnfPnBhcsgHlRVieGly7Ae+zNMW61SnD+v9nXx+HWKtaESQ3Jx1wWrrHT5uiRFahf1kDfFlO9Ld3bX5SjN45ZrGvbyvoQUebuq5YEkjDGxx9qRKwakcf7LB2J94823Jrw1KW1dHT67zOer1xcdseXIdvGTgl5xLAK1/ImL2PLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708114; c=relaxed/simple;
	bh=6jLv9uRwNNN8SJgSF9nQymP0EEzhFiRyXMtCm0W4pdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIneDayQ0fzy8sDmMsfmobePhDcH7Bf0vCQfMj2s1sXx+3+qYzLJFa4rdiAXITiUxiKXt6o0etrbh8mr7lWuSXxAgWKcQd+bpCFPVoIjgDydRKyuAVUfYagT3SvDxHdi30+kF67rhQKU8ECwOTl84Jk2Zq7Mpc3E68pAjtF2rm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9sWzEFG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9sWzEFG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so75248555e9.2
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778708107; x=1779312907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub44tcHR3rZ07I0PG7j4tYlcseLLTdK0dv8xseUhhuM=;
        b=s9sWzEFGzAbqkY7TTzWUWEDcVVWgWpQDAnbpaSxk4dtimZQ0n8lpfnsVHsuD0TbeQY
         tkSvukidSI5CnvQ7Z+G0l+XTycR+iyzoV1mUIBvnnfgJsCRB50yXlZ43IJKbeMHiiuVm
         hEvEB9En8TjL6VXjArEwAOv2jEgHkqb8izrzGMnr/tVzh0uNtTdfbqg/eiPyeDU/OO87
         sMaEz0zY6Apzo2HNBpwsQjSaAUxLFEjramUHQJJrHf2D+P2lS1myRIMOhQTEO2hIdPNl
         g4gM6QEjavx5c/cx79yJiOszGW3+1+9gUiTlJXqKPtSwLmg5vSBOVU+Ane63IWil62bh
         4Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708107; x=1779312907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ub44tcHR3rZ07I0PG7j4tYlcseLLTdK0dv8xseUhhuM=;
        b=Tw9/tkcoWNH4oTKPS2K7BZHfQ1G1+eLATTzkjwhW/IexMWSSAVfzSU+4P7JtRGIot0
         yloWnO7kdIDmr8VgM5tDEBuEGRNmNoYUDgkRRiHx8k+TYWMCEuIa4BYoB932ky8CH/y8
         ZpVLb09OJia+RXwtJFTRC0v+XKSbyOaspMZ5GqGeYmoBDiEZVXZtCIh38tqb4/ergs9B
         nPDfXbNeSu+wR9xMCHqutNLHqb4wBC/KMnupHqEzILTGPRsMrjI5KaFjy+FjdTbj9yCB
         XXr+7LSLAZ1vcMxo9Y1O1+Xb2VCjxgvzScbI4QcnH90KhUMDQf+F0UVGZcqAQNUWzjCF
         sVaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+InTWQ2nDZq+EYCcDsK1DgJiEbeqT7Y92pQppkw4f1+XNUXGFA6fTgc4M/oYrVjHix2DgArovWuJNC4iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+Rl8bnDW84V5b3IwTCsjA/3CaRaNurWWkEyAnnXDwiW+lISI
	xLe4o3jltXXegtj91JHIjGdQgN7NztwxX9xJVTFrcsIp2lSzouHxU6S3
X-Gm-Gg: Acq92OGuwx6PQ9ozOuhhds30VvlDFHxmb/5sGpMOZ22ZmWfz7lPONGUR4h7C4KKrqIq
	iHENzGILTrRTYjc4RrDLorYA5jJZuyR9T0fI2/f8fXyvPDJ3hQt4K9j5YFBBzMzu/4A+aO4FyQS
	+46Ja767HFmr16s5XEH+tPQIvXdluwRY0I4B9rW768E1EUoeXDYYWgrzg1oKdLPHzjPnExnJD6I
	gQWzZDWv7p0miIEHPpl4IQtjJ0lAD9/Vnlt1fbtLk49G12c6O2clL5DUHgM35ISzYd9G4k5cwQi
	LVhSAXv6+KgV7/Hia83zZfDAszRB7vVVL1WDJJkPKHGOKkdUq8PzQTmmnrldC+e+65QMY/NAr2T
	C9oiasFZjbR5eIAEQ7mWZID1H5qzihOopkfFmZE5Z2L9GWO22zMhS2p3s0Exd0ibH2GOYkkgCK/
	WvvbprMtHfcRAK4wyq7KqHwS1dLTpFqRC+1izd4RyJoXE=
X-Received: by 2002:a05:600c:1d09:b0:48f:99a9:bbd6 with SMTP id 5b1f17b1804b1-48fce9f74f6mr69685145e9.24.1778708107012;
        Wed, 13 May 2026 14:35:07 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb1fee9csm2553055e9.0.2026.05.13.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:35:06 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 14 May 2026 00:34:57 +0300
Subject: [PATCH 2/2] amba/serial: amba-pl011: Bring back zx29 UART support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-zx29uart-v1-2-68470ecc3977@gmail.com>
References: <20260514-zx29uart-v1-0-68470ecc3977@gmail.com>
In-Reply-To: <20260514-zx29uart-v1-0-68470ecc3977@gmail.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=6jLv9uRwNNN8SJgSF9nQymP0EEzhFiRyXMtCm0W4pdQ=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBqBO6DGgjg1pmMCmXfe0b2mXxO2Y8S1PUj7OB1T
 EVseGuTDNaJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCagTugxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJhGw//URVWivsSPit9lucIR3mmnK9TcanFuu5
 elxMLlXanP9eg8sPaRKspxh5/x2PAyYZBnQH4z+enLCz5T4Y7ITkrjVSEucTIqqTYtEmiChhuLH
 DbjpjLfGOnn5/Ew+9PISZVxhkXYejmQArMUtMrXodpadKU8RmHCnYGtwea4fmBaBNdPh1drJ4dN
 pQWSsCaoK6G1kdXUmvexrmeseetSKwb//WgWwU6Dgurzmr1J5H3VLWt4AMOz41nEgWTiFvUKN3l
 VcJ26w5v8CTTzkC6tLatNo7B2l/UwL8SZLKXKQ64Fo5SAsV5TuFzcE5mG1IxzkeOf+tyYlaC0PF
 WsEwkWXsJz6pgi9++ozgbFWXhYkyhbOuIrrSPCZeGNk3lCdEF9N8BBsRlE58cEWnYXTgrEF8w+I
 iv/VfaNCP66C+7aYg+0Q0te20+5yit8tBfz6Z3LM3hzFvNGFi/1nXlUDHDXxkYWmpjS6LgZ8fuW
 SOMB3jIpWpRw3yv/zin/0Q6jigrzTqb5F8vKsfbSLfxP2DqhtjSLv62LP69vAZ1e5vy/E0x7/bS
 8PFyBXCTlj32UrFu6lViT+ZvodU4bSBYIep0pLMP8EVJqOa76sdjCXbwMFE42O0ZJMFaTnHT5Xo
 rna3J9r0ar6T8aOGAHs3J7p1A4bbDNHCCq6oTH7EhQbj2w8Ft1io=
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
index 028e37ad8d79..8ed91e1da22b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -240,6 +240,38 @@ static struct vendor_data vendor_nvidia = {
 	.get_fifosize		= get_fifosize_nvidia,
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
@@ -3180,6 +3212,16 @@ static const struct amba_id pl011_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= &vendor_nvidia,
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

