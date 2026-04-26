Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FA35E529
	for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204508; cv=none; b=SkNYK9796Z+up4TM8dbw1pkqvj/8okxpm8eSyYlyQUQ/UTAc9bBNc4EP3Csr6KSPDQdpoj1auLKIRXixMy9UCl7ln0FkOPUztIy2Y8Gq35JcRuqu06X+TY5NlNknk59ebsSlQqmW7+/h6j/Q2H0eUUTKSvPungQ+oVSrVKaKNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204508; c=relaxed/simple;
	bh=OFELZprfvGMngJiiwTNQcz/opzneDKzuYgSzdRQRbGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5ugU+Yn+FtEFjlFuo7v3/usqjD9BLrNnK4KGz2KL5+nT7lBTmKzpywY1pr2M+tHnnWIUpgJso4ub/OgZMdhtOH1coXZdqNMhSoE0JdWYVkGwhm00Hm8VPwMsBhifM9gB9UKaZdBGPeeS71aGz5GOjq+SyvWeAU4iDpfLycJRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovGTBQHj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovGTBQHj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfce3a195so5268549f8f.2
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204505; x=1777809305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=ovGTBQHja/6rRV7Jvz8dHi5ujl2/wK4UeThRMD8+rrKkz6MG6xVDv6ECHoy99n+Le5
         ZYlVUwa0sABtDr5HSPl4k9ejZVjaA3Nt2NjTlFtjicBDBlkCtbCJuOEgOBRKYEZQ9rfx
         jgKwH4RUQdp9iuV0PF58FtEE+Yb5f5ZFiDv9MqQ8oEs9dLtmlfYwbWiJsGXfHYdYAHaj
         39NPM99K1T2E3HtnXaKCk67XVBMRZj9L8zx5WNF1OOHM7LuIKv+XAAUSNAg/o9sNFDPf
         QcRoIcJzrpkwDoh5fLgfiwzmVBF82CTd6ZB9H7IZfjmt8wfrVwgC+YQnDFdkHKnGYiXy
         zLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204505; x=1777809305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkcOvOZZBBJ6rw+XBoAkJNNzNDgTfzBSBc4KLO3hr2I=;
        b=O+F7gyeXnqMNrzwrxrGOglg+M8+cLlbvFpQ1utE2kS0kcbJBdAimjb079A7TckUs/9
         EafYTz+aKq+5j4+8CpTfzcfnxyZhb8lSeWo/f+ex0Mnt+kts+5zMhXN7d61TnRO2P0K0
         oRnMnXnP+la23zOh8FGLj4ljUHLYkEkfVbqJvbaB8C/yIgW06I1OxV140ui+4X/hn6/1
         hwAn80Nge70q1SDpdDNUa1LVu+JxRVKWeEafETBliV7EILdGkYhGX3BXAs+dFjlaN17K
         X+2Z+P7ljucc/w2RsiBuVz/gYRKGNHZrrP8iP7MIMRL2j7ha+5GcJOPc7HBpW4OgBQ9u
         jarw==
X-Forwarded-Encrypted: i=1; AFNElJ+vbxUPctcthPmLtF0tkOjYLhwNkQh1YKWcRDRjBuIx4aP4k4LIgK1tax0yytUF3Ud/O6NKXucLsEAmwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jNV1mnFHAqR7bxfCsQhRsk3DlO38OVKjPKOhV1yJTOKtoyue
	Hekct6087gTUW0z84Xr7w0VeVebKJ+eT0t3PVyZqRc8E/Y6GGWX/OGGv
X-Gm-Gg: AeBDieuT1jqHc0ERbI24CJgqiSdzWulQhlHmNhjkyBNdTkjSgkVq4NFgNyz/Zdsghr9
	0rN5T5Ot+KoZLwbmlfv05Dm4en+2LEYOOj6iU2Qa0qXFvqGhRrw4NWF3mjaFmIkcdIpjH2JUP7v
	jbBp/Yk+EehADBcCXT6DR8uYeLNEnPlNgq/4T7hHgiGqMtgwgMIqyj4IaF5HPHpRihbbp1rGJ6E
	3li++7r+SukK/gJLciNCptXlXMt4AlSMcJuNe/Qe0j62FN0u3RDZBJRpkGSzbP7IrnH4cAJ4lNY
	a+OX2hgap7ZQAcv2IiOzQi+t/OL/UbHt+3EtWeMSCHBYSvCb4DluPymTBosi2RQNSvgViRdluzv
	vCe3pEYtRLN7KVKwhXraOIDjW6IlCb2tQ09rAh3R5eg1jEE6AmEHeNSAdLTahXzxwnd0do7GyPZ
	te+EDgfu9Y7MlSENyUhht+81ZAHZJYNOJzviPofRYybofCUpSmb38=
X-Received: by 2002:a05:600c:3006:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488fb739f86mr308742125e9.2.1777204505424;
        Sun, 26 Apr 2026 04:55:05 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm424018575e9.0.2026.04.26.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:55:04 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Sun, 26 Apr 2026 14:54:17 +0300
Subject: [PATCH v6 4/6] amba/serial: amba-pl011: Bring back zx29 UART
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-send-v6-4-d49efa72bb09@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=OFELZprfvGMngJiiwTNQcz/opzneDKzuYgSzdRQRbGE=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp7fz+u/+qpPe53sgA9IGeQxT3jxCmJ4DtmSGvC
 U4HoXZLR8CJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCae38/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLafQ//TFrg6fVGLeFet0jt8eE0RSlbETUAuhe
 Y1d5O5EVEObWTh1jBB8JPUT3ZMr9helrlQYwToexGoTQfpSWSh2y7cnmeHUOVgNmMTRNJAuUso/
 jrrVPSqGIcUqtxoBdnsvzSa90oTzQCm+JRHjGgcYAwdrCEnArO99rOMFt/YyqLEqpntXHuUBOsw
 EeCZQY1SXWS+c4h8fhIiiW6XE6XxCUD6hNk6MYFY3KFG9h5qTNy7pSt9aYtUFSnrmi8m3ZI5fAH
 jDuPQIyemgkEdEydS4g9gPCvjhQUcfRBC9hi/2ElHHk5D+QzEM2Jiqe3XgxYz4LmIZrTgDwB+89
 LLZeTrUrEwPHURqLvlqh1ryypR05fts94XcfLO6co10aJDrcPRtNciW+QtWkmQDAACHymkqkTFQ
 I22mqAZvxR9UwaIHeMv3ryypBbv/LFD/tUGxrP791tf/3gigCKCS1wh2niV0tTGg5Z5ZJ+tZFkg
 OMy+aMsWJJhXSQPKTGTvi2sREMqhUdyxim/FnY/x5Eobdm8l7n54KB7aywTfJW7iZjzEYnPjeGl
 XNH7zOkcpMKILqKmG/lpaiJunscs002+uMD0iNosFvzrKvY0nsvrzm1d3PPV6hj4t1LVlqLrfUK
 uzQ3rgUYa4CP/LgeP+54Wk0INmumy1gDlodGjGyuw2lAbqwrnNZM=
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

