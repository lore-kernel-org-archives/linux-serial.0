Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95A37F74E
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477283; cv=none; b=lngZPCCocNGI6b+sGj0XtgcNSHaYHAQK8wK3yooLR9rqZjfN2iEpbsWOgS0dTUu0b5H+JAwildYn8/SYRhdmqu/mgGKaMo2PXXM+9vemnrNIYl3BwXurwcaQK/QJ/CNgly/AdhnzBJNsZNJ/zmTSNLKkf0X4KUQK5QWgkPfdODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477283; c=relaxed/simple;
	bh=oZkxyNVxYkEwJ2vPpe6uc3+Y+pRPWdMC9g09igJuSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CobTbeJSUlvObzQpjX4dlhat4MOWeOVTSkBfDBsHIYL7y3xIvVtKqv0kG5LdIwUrU17rhCWrQuZ+zclFppbjxM/cS4MEVG8OBk9HHYer4fwi88FiTd6pWevWvE855mZu8vBoG+cBoYHk9gShtCXGDPlLBuAcjCEb2mEaeJdB+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CtS//emF; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CtS//emF"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121a0bcd376so2135307c88.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477278; x=1769082078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=CtS//emF+yK1ZnuPnD/oY+JHTsYeSeCJRHslgL13DIGHhrYLJR2WCsrABgc0FDz8tN
         B2v3/aJaX0rqioEPj7o6UvPnblVbJ5BPUMXs2FXhaRbIxfK0vsBzIbFeVHwdxxFaji4E
         8mHJHdwEiS4v814l7OR4XJBze1m8pxWiBGpMmTX0hbE5Ny43XDLAq0XZ01eYty2yYqYg
         SionVUSa0Q6EdmpcsoBEeUJTyDPEqbksBJ6YtE3S4YwwYt7lrHjinWVWjcSd5Dvm+0KH
         MeOibqCGEgq2WYCsaOOHC/5sPhmbpR56RhjmRHy6KRPCGEJnYoaNT8ETSEgIZnm5Y8Qr
         HoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477278; x=1769082078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=oGWg2lJNqt3LNiXPeED2A3hID+ciH3kQl6QulIDMSS2UHqxNeoonVQ0CPdZMOMULQX
         b2r5ELmtsadhUVCFkdkhA/YewqoceHRCJ7+OHv3MAqn2YiO3AAGhAcp9C3JngAg0b8Ws
         mgsJRWR3k6iek0hgKMkdPdhPiysQYsXeBOexOMD31xUZTPzuD9EbyjBuB6gX7paz2fA/
         VSrmMWU7WjFx12jch00e5bkkBvw+yOM/QLCL1R7viem+kZCILlQEqgLa1pT3DoMWf62y
         Bsc280zcKy5k2uyts5wwqZCfRQxowXtOVOZesqzoRlBUCJBW126JQsxzPHb151Zevjq4
         X5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWFbrWQ1xp67jwNXaNppHeXXwzzIGsN1vI5YQ6L51wOCp96FQGelmdzC3kAmwpb1Y4geEQw1u9bQcjjAkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5QQ4tpwLk84STXPcFof5j4ucFPUjCfRW8zRkhLBepYIqAGfd
	CaJUIR6dYA4fZ7JaqZjThsH1KpJOIwjtTyLNHLhGAXhMhjfAQJIY+o5EWmhwR4Y+drg=
X-Gm-Gg: AY/fxX6G70d/UwXID4EBjeDn+SLX6n5/Em/BJeOkl+/nnm93RpHVN91x24LOYIhKOnh
	kjUby0b4JXcccbQFfEBK1K6BrNs79q0BIBC2kDf3IZY1vPptTzBqPj5MRhQjnlG/HRH+7Pp1qaX
	T8rFBNfxb2qhlYeEyFBXIBu0MexP0ph1UHWLOwKjjVzKaqa7mjdfHDZSxQ2aWJz21ayS2WwENZ3
	iz9UzgyjIEOfCXUKGbd2LZFWTxp3XJQ48ZdWdgXKVOGMggChOLCrxwtq/2CZtnRbHAXyKwPkcuB
	EeaHu+apO3SK0hMKMtlVoFkmAd5W0G+45RKjQr5AtBLXbe+edSfIrfclA04hFI449hf6NfzjxUj
	/rJ0YFoDuhts45Ve5gKr4Mx79CnfyrsY7ZQpmEWbaSAAWnXq+ld/1pNyBbl8N4+r3SJ0/Nnsrsr
	U5XmJGgGBD8ZL5gj+/pQKtQufiTPnfhzj4vnHAKrXRE5t46hc9lnPC7bU+WphHAFZJfLYeScaLJ
	29M9EyE
X-Received: by 2002:a05:7022:c90:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-12336aa83bcmr5197544c88.48.1768477278199;
        Thu, 15 Jan 2026 03:41:18 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:17 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 05/11] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Thu, 15 Jan 2026 12:37:30 +0100
Message-ID: <20260115114021.111324-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0

