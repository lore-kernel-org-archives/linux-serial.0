Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88366339872
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096057; cv=none; b=rIXxot10ugfqAERdvIk51Ar1IcMB/9f5LPj1JaFknD5ckJyra4CQBIXcQ7cUXcHwbWsiVGk7K/Ftv9Q8gOkg8VtGwNC2kVbdW2PByuY7A+yllu788QiHNoT6HBB4SZSPkHnQTGB3TDJLB/Y5ffYTOfct9NdH6U9y1XyT/PfkqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096057; c=relaxed/simple;
	bh=OFELZprfvGMngJiiwTNQcz/opzneDKzuYgSzdRQRbGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=une+LkR/JUe11G5tjI2Kcw2Z93mdpX1mKXfXj9AprddveTd+FalJQ0xhbxYXIuJ0C6nGYeXEA2RgS4OIo81V6YW3D2sHkzOGjyVbiW9UeRK660jgJEzQSZMbewNMTSa72aneujsmGAzEFzkQYccGZ0w4RKGl9nzA7joIK0ow8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvXIWN0H; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXIWN0H"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso51907f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096051; x=1778700851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=BvXIWN0Hp7tcLVz2GNZ2iWw71AB9ju+Hkwm/Ysa1HW05LIcDNUtMnAhfp25GDljgeE
         isvweMyg4P/aBEQo74H10z2T2qxXr0O6E/+xNti5X7pr9zCX/8Xef4mKMcb8d0EulVOb
         i25U+16K+5rSbDxKCRAHZh8nk1JtHoFLhEFvzO+kBLAzQHWH4LB6mHbdqIrjQOxhJkvo
         2AMvIpgFSTHIKTE8CRGbzBL2ol+WdgD5c3FvK2QNTPDch3zjTWwDBOWK/MimPsCrqk/W
         aazJ4oHFGB/Z5OwRmjemabRVty/DhLR83ak/6yD08RY3eJw7l5hhTsdTP/UwI8EvXPPc
         mQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096051; x=1778700851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=Cq+GJVKZBcc20m8eDYmG7KPHXHkbpA3CbN9YcciKzs39/Hb86xroUnrs5ina+KjmX3
         Pq3c+T+OkpypZ/pTkJVyzqp64DacDqj/60v610lSujn3xtPYy0jMtVKAM2v5s/oEZr56
         u1Oq20GrmclcRisE1CUUugACGCn5rDHSHZOAHsspr3W0Jp7siUiXVqk/sGrSPdcUDqKn
         D+3tQN/UmYPMv67WteqQguyVTpD6FvHfTko0YeVN71CUHQhWQ4vIBtxIFBsqVDRpaPhJ
         78QX6+HsmK6xMq29S8RQhcm7pXPAlxLds7vBrCviA6oLYZiH0AjitI0R57GVwbx/0WJt
         xVXA==
X-Forwarded-Encrypted: i=1; AFNElJ+RQgj52Xh7kowDwrMnwqqTKVCQnEmY4ApFyXTrjLE3GcX8clmwv5jKzZsKhRQgnHSblnoMSe+0kg4uFbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJXTj4rGKU0N1WSjaCPL0xrFZTlt1RlR3zDX/H1c/9EpyZJD+
	0gwiC0rHqfvESrwrln58XzulUgwMYrbKBEfLkhRraL3PKaj1h9QrWgqR
X-Gm-Gg: AeBDiesSt6xmz0T2lC74aCX1+ok41peXCC1oCfQdnmLfrPq+WBF0VNOhAI58wnm5uDA
	kXoa/CfCvTwLgO1Lehatz13CJK9GGWH7NUOYPDCITBYjueGJ1fPwkJFfZpsDW/e/+FmAxQF+lEJ
	VQOh5s/PLokBFvnHQn1gfWwoRPbMl71ooX+GfJ0fVUHT+x/54ENbIqfIPfPvhm0EHqPXCeQe+UY
	lGRFNyD9sgR8SU6xBCdufTR2eEyEFgXhVPlCPGyAzplG33JGacDEoW5bGwjHFkrZFVEyMwhZOud
	/TyCVGHB+2ayG9nKfr+Z5YsHPZUHNKT+Gn79hbwRRn44dA3zzg2mLrW+wkX+RBfE9uFipVCwlap
	hyS6BhTVHFOfEM/KwI77EMxAlXFj8B0/U8Whupuslya0Zy9+3PupqopVWtAUJyLNy68qgBJ+aCY
	K+fnNhVQU4+EGSamuCnbKeW4TMgKGV/OXZ1JJSIvfLRF4=
X-Received: by 2002:a5d:670f:0:b0:452:75ca:3fab with SMTP id ffacd0b85a97d-45275ca3fe3mr1840819f8f.38.1778096050623;
        Wed, 06 May 2026 12:34:10 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm14895673f8f.26.2026.05.06.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:34:10 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Wed, 06 May 2026 22:33:21 +0300
Subject: [PATCH v8 4/6] amba/serial: amba-pl011: Bring back zx29 UART
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-send-v8-4-f1bdf3243b34@gmail.com>
References: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
In-Reply-To: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
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
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp+5eWEF9Smqy9/+ZqLj+fvYU3rR6MQcKz77DkM
 QtvC+gIXhWJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafuXlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiIx/A/+Jj3LBH9tnjU1WCvDlmvuDKP60pwv77H
 9cpKC5X8jU9Rk6vURr6BpE8J21cX+UHaMCaKC/Cf+xiQjWpQDugt4fK44PCsOUg6F7a7+jGOWY8
 LL8LpnoGzjHW1NVmdbkeIqLE5Z7NBnnIsVb/f1Rm+I/Tw0MN30e9KM5Xfdi4iXUdyMh3pLKzLY3
 +USPgYvQz6P341ijtBwuMeYsMccIDefew83LipWaF+qR59w2l/s5dZcZHpWddYo80R+tS5HSACY
 MDD5qa//5HcW+9N3ya2Syb+bqG6LBe7ydReM1FxRWUPxBmcSSOQSUaBncNAGvKdQmGqfk9EQCrV
 sveBZA+Gm42mHgoXEghXSHEtf7qtxmr6rIiim6j/+MvLnoruinWXl1ift6t+tNM+wzcbRVXN9QY
 xxflUe2qn0gUmUOAYSRP5Dp3hnWvMs1BGlVRZ+rRaqDrxGI3MX2KBKDiIjhZR9Mi+j+IdTXdJYe
 dWE2CP3QhYQ23VqOhadxflZUQTwJi7pdOndO6VpPcW4uMJ0uxIp8RprT04JnghBw8juuFGjogmf
 qFdCVa2SkLAjHfVIzqLJwt4vQpVMbX3bKKVTOEv4m+UEZUB105F8UckcQ94A4XmVy4NU42WvjmF
 cGzwd9WYmlmtk1x1/KjQgxjaMnfuCad5XpV0o/9care4lwus9wwc=
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

