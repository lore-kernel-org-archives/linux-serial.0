Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854E336ECD
	for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816736; cv=none; b=RPMFVKCY/+owfydPkbfaRSOx9NSsvxe4MXOTf7/c+Ua+ZCSkuAszcTZwDdS+wy4HYGeZEFoyR5NjD9juIdFpqB676KFCOkFjn4SIBSgzP/FVWUkuyDWrUgsF1LSEbERs5UgLlwq5qJ7uy7JtzEf/I1mD3pwHeJ2dcdXoIAzdmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816736; c=relaxed/simple;
	bh=scXnJzjuPLNSqcnBYVeFur/Bhfo2CWH8BsQkTIJqlg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH/y7fYfexX0XGPMCbgh+/fQSOpDPIE2+zc+h26v7TwoC7DLsFm4zCmQ12rYimNzesbNptJFTXaWWuBxOkJ7/a6NeNoxwMjK9P9wD0OeE10ZyssmA/N/wG1d/33oQUa8MWE+CcYqAsVLdjMji37a1GPXZGv9KCjeOO0PvcROS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=f/Uk4jf/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="f/Uk4jf/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso28047265e9.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816726; x=1766421526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=f/Uk4jf/MCQ7QC0/lGEeRSSR47tTDriJfcTMv27DyQbaioho2/kAASrIt4a5+bYcYp
         ZJgpkKLA0nJDcMozIad6cn7rJdLc8Tm2E1zkk7ff/1FaOdqF6orReOxSR6o9vC5O1ckZ
         lZ9v2aWwesGBbtKVw8svbs7pCmctke6m6FrgROnx6TyUHDH7tYZCV89BQ7uHWWPIfCyj
         4CPf0hQ7/AU3x6gjMkqA/nU8pR9spOwxinJhS1d59wtu9cEJrWe623vqvNQad+4XGDc+
         z0nYFmsZ5fenhMoFo4LqgmQjgdpmhimZkSqa2fAEsMpfbFFZXZ1Z/36xrTxv6Fyz1wuX
         7d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816726; x=1766421526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=Fv0seh0r4TNp9TZwHVCuH2MMe4InJv8tjxB95cs7mPa02qoQCJvF53bCkrABPW3NkN
         2wwe7nqYCbZj4Nxj++7YlGkPRy5a2ehSmc1dsB6kFpjgCGTM6bKbDU9P2kPgTrBrWc9C
         gx13hrC8bnzAthhUeUdhvndOsQmE/UD0ZR31ZIH1otrXh4ToQc3rcUZVW+PxfZcnfpWl
         YLx4/Dml51+f1DA4fDkQnASMnwgeYBEvTRtodwse9Sfx6uxaPWr7++Ad2kfetwkLm3it
         daR+TXoyPVxFV7umjvUU/O9I7+8ATszGsjQ59syqZYYhbs7cOuygPtzkrR7fCl+ADmd/
         sdZA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsacE7ItScTfrojoDSPRGuP0PzURrUZ7qkYWuHHQOBbXkcqkNUfNxEelSQP2Ul+eji1bIJVX+KnSCccA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmnDIRN830ch0At45L9+KO939sFKdgV0rvF/1JjC5Vg4RLlyO
	LXNFJMpybk6VsbZhFkCo6xsAdZ3rLCHQaUjVq3OUOpEKFH5Vb5F6jiTLStCKKxpknE4=
X-Gm-Gg: AY/fxX4Y23nXqQaiBcpCa8Sux6DOtY8a4+FZzoLtaeVddmVsgLp/CejdplPecMAw4oN
	RBki3coMpuUfF8MlbVWwF7xRmhRdToylZFMtnQbXaapZS1dgAwulcvQBPr3umsI7TKFpFOGCiEC
	3MJ+c+qXFfSFePTeWCSyCdcV1s6U/7Zl1EmHYFEWydu+lBGxrF+868CPHigIv8AL//Vx2S8CaJg
	N3YBl3qqcea93ceM4D6TkZpEBweM3unYaCZ5bCw04FTP1nrVFB8cb6bJxuQbcY+NwGbtewzRz8n
	df69Tz72YhkmAMPNpzlH4BOoA0wm3RiMwyPQW4z8pizgJWqW5hNv3VDRm+M6y4Lax3kaatSGLoN
	duL5Wy1LB3aVyi6BPHbkelRaWuIt/uPvMa7rplYjO88eTULYf1HBDjEf5B41xVEv3QYU8hLTVGq
	36RvjBTJOIQTPVsKmC9LKQALrtm/XAg+54U+vPH1VT7bWc
X-Google-Smtp-Source: AGHT+IG3as62jY6VN+R9xsd44rJLyQGjfxg1Etzm6TzvOyKAMBySitGXaUcEuYOfJtLLJDAMKGWwPg==
X-Received: by 2002:a05:600c:1c29:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-47a8f917acdmr137389255e9.35.1765816725969;
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 08/19] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Mon, 15 Dec 2025 17:35:25 +0100
Message-ID: <20251215163820.1584926-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 11885d0cc209..a8539b68a2f3 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -19,6 +19,7 @@ properties:
       - const: atmel,at91rm9200-spi
       - items:
           - enum:
+              - microchip,lan9691-spi
               - microchip,sam9x60-spi
               - microchip,sam9x7-spi
               - microchip,sama7d65-spi
-- 
2.52.0

