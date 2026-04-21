Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BE3DDDD0
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803069; cv=none; b=XiujIkh8mgMdqslJUVsK3yuT/KLAhMV2WhglPx8TAu4JYgxVNU99Qr7PpkuOXHe5GYrJ6nWQvsN4jATzMWbLkyJ59h5Xe8I3yIlWjWiLeKJ9ZIywTfT+wc6e1txYh/6KKSHQ2Qo9ejqJn4S/qNApPDY1ZRcO2jcoS0IYkcJOA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803069; c=relaxed/simple;
	bh=AZZ3BtHPYsdTJleQOEnSYeQu81ZAvH9LguAUd+n0Z5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBFfX5J2smCBPXtH8oHod9BauM/XFHzArklsfYF1NIqRq1A+NdJcnT6sZcXkjPCQ4VmpKWCumZXOi1/NLwvTwRchApD4h2zUzesWpdnqWxK2kydOhN2c0EmFp0MLJs6waQBRq6UPkZ/2cyW2jCzckgd4WcXpCVuFSJNM09PTcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCfCnfbZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCfCnfbZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891cd41959so27632735e9.3
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803066; x=1777407866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln8CSZ8Zjp4CpkydhHUfH+wLZviy2qiJkheYqbMUKrY=;
        b=pCfCnfbZrfsZNX9M+IeFazTLvT6iHIEYa+XssNYKv3BEjSaHapinyV2FPgBv2K5ncy
         nSV6u2Y7dHXqc0/LXNN4NtEl9xBH2g7IKQH7uV/XoZIbNljJRy4syTV/lXwiAnYMyVcm
         0VsMKoWvbuE7mPl7dmg+TsukyH7YHbT4xITDcwNiFo2aL0tloivkkHDEVBG/H3B7nDUR
         r0Q8SJP5DmapuU0pnLXvNvksgUxt9iQaMJswFmT1V7EYdAIaoiqQxa8S+/FHzHMj2en8
         8G3gNmRGK6O95U867Xt0DnM5lOIL08bD2xGYDK2CxTuaYvOZE2/B38jPWrGg6ObtlBwi
         0WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803066; x=1777407866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ln8CSZ8Zjp4CpkydhHUfH+wLZviy2qiJkheYqbMUKrY=;
        b=aZuUmdCv7zbdpSN8la0jh6eFUWptJCDXkyZWajuz6/U5AykfDeHD96rHHnwHGoSLr5
         J2AuEMQRiickRftCtXuyiFde47MTftho/wsMFKhZgArfW0vMfJ6qHVv3YhXkUT/z7/4X
         vtW+9u2mx5ykDvdAiR7t8qbIKLQVWFMm9uCvqjxrpUHem/0VyWDoC2zg8EvfvTZebrf9
         uc4KNAamZGBa5iVyqFl/WjwOPHZEs+iJeEJTBlqf4HlF828sdWE3W1NDsWlAdo3RIuAm
         CbSnbiXx33klNQZu6UCm0+tcJ+Lfb/5aeMVSGj+GWUsbuhLTtyhrv0vyEFwa4maNrZoH
         VLTw==
X-Forwarded-Encrypted: i=1; AFNElJ+Af44Hjr2krgZGz/ERrniNBDIp8kYtGYru9zUCm2MtrF857uaag0vrFSUwBYPnUal5J9/Qpy2GipwaQKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8IfhKvdLwsNCNHSKGJtrbG241IOJLMgz5XzuvDY6T8KRvll8Q
	k11C4cAjeh9y2LJi6aqsE41G+rWZfsL7yqzU1k2wGmvsfWgjyNVivn/r
X-Gm-Gg: AeBDieuycgUGyMudZukTGhuRzfhVOrF6VcCcmrKUV9US+xp7fTYy5zqLrykpchig4I7
	+Xnbnr7WXZOxRRqQKwbOJjUauz2k3KKv7ZPXo8is0AINfYlNauPA5gQs24Ye4ZbUO4zX3XAUHcl
	4R4rhjKY+9enAFppQwrV/h5X2lMCrRQfNMISP9N74mIjytO9K9yVrMGmYRSEv+b5T+LltdgM/uG
	ZX7DGDoakWTLculEtz6GrfduAvaFVJ0I8UXkcy1d20hqYuX/XgCTEpamFnhxRh49z5d4Grwtxcr
	BNtYderMecDecJ+N6FxIKSqLZ2ihOMm0X8ekdDdjodmXVXM+LpbcwD1re8NPwW8nY56kEwun34x
	F7HLx0t0+B6KO8KislFIaBAtsCBkuC3VQu8DPyjp208Dla88JDQhpxWUaTlgKbjc4vpwGdOxlvn
	4eHzP6YqbTuJx9IXcIARcT4kazVgyFZ/c3ZKOGByNIbZA31uerZ8yfE7Q=
X-Received: by 2002:a05:600c:1554:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488fb77810bmr289995225e9.14.1776803066229;
        Tue, 21 Apr 2026 13:24:26 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm655989805e9.3.2026.04.21.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:25 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Tue, 21 Apr 2026 23:23:14 +0300
Subject: [PATCH v5 6/8] amba/serial: amba-pl011: Bring back zx29 UART
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-send-v5-6-ace038e63515@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=AZZ3BtHPYsdTJleQOEnSYeQu81ZAvH9LguAUd+n0Z5M=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp59zXHYk8QOPpNQCe1Wwk6mIgsZ2Nv+zsJP4PY
 KWIaQ2iFOCJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaefc1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKiQg//Zn2a8aaTZQuSyt4cwOh54RlDf15xzdQ
 txtA7aqXssFF/JqZI7GOWW8JhQFJ7mudZDNWHj53GnkJ+N0efuz+vAmSSM0WzemjCIOv/AjnQfs
 xM1HLgxBUk+iNuV1IhoEZXRAYHi9kPaZTyIVWJwOSaTK1p25+oHaarMzaw0ha2iuHPDm85HX8Qc
 pjo7Z4HI7M1cBoHAtMUZNQl1wX+H7QACSGNczRRSUrzBm3N2eieQDrp7LGTCwMKKkKVqQ9EQmSR
 2RhVVi4qrzczHyTKhay88YorRUM7oMQBMfmtZ99qfNFpOjEG9P7f8pXklKuvIrDLW33fof3b54U
 ScQCF5mFC91rEKZFKsUyrK9inaaVV2+BcnvGsvC6uAnR27SNUYupEWKDo1LfFyKwgIc6uYWcfHN
 ATJP3//SliWsOvAaJOt83pn9Ehw1MiyPRjXpP+bCJFiIzzy148+Xrxu1pcBoE2PVa5OH+uuRXeu
 dyRui4+9dHU3z1/VY7Bq3GelKMFweEu9+TtAUquxeD//hrOfjKwo+TU94YQxI69V6fGUFm1bp5F
 yFhtFMKOnxda5r5rQW0WMIKcpI9B3i1kWlysqUnppG2Es8v1fSopis5Rq4jfkBCi6RTgW4gA6MV
 vSbrrsbXxHTulM9noIeSe9O+3MpHrqXMbGmrnpaBcFBQvEultgIE=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on code removed in commit 89d4f98ae90d ("ARM: remove zte
zx platform"). I did not bring back the zx29-uart .compatible as the
arm,primecell-periphid does the job.

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

