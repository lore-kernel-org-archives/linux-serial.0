Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A437C11F
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477320; cv=none; b=TZfZHOZQ+rhRNRCIEqIMImxRx1TtzUXsD2Cnlt1Y1sNBtSOYmIFCEi6kz6K63VeDfww0TCMZbn4ByRM8G0XN+g7Lk1TAHoYgZGJjEm4zUoubgfWz2+7p+cmATWnvIA45K06ke88vNKmdG2rc2OcKGf/0JOvY7FemyOAoYPSljC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477320; c=relaxed/simple;
	bh=mkQUI++SFEZY6715sy/bRzpJpUAliolL1r9lnHRs51k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpQ57DQThQVYfcBsrBwgmcxrCn4e5vmVFqLWGraxUq0FY0E8lamb5Fgkm1kiDqzD2rZE3nbk982+qm/vXUMwZK++NgOShc5V/DwHWXZeduVYfM/V6+isunEmx0+xspYNF2Wjjktq56KAlXZn1ODpSMcJ0CbzA10r1qhbqIIDgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=l53qBHHO; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="l53qBHHO"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1232d9f25e9so1439698c88.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477318; x=1769082118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=l53qBHHOC3NN4gnjGmjzOZAahtk/NF+6fvAt9wqb9Im8E7JMc1M/45s2CqXUlB4W0a
         uuZHwx4eFrwNmU2bh3yp7Eoqb2WQitklVmlOsuVApYFjbE5nlv2cINFaj7P3hSAHunTe
         pxT/zsrKT3jXCVb542lNbKos3OrWTtwoQdJiYrKU1WflD0OQ1m8m/renMuVafFd28Gqr
         rFCo2UZhdRHYm+CMV1XgbKCZ7bJhNoY4ZNLDTqzC7wzp28ixZ0q/WqsPxCq8rlwFUG0k
         0Z/Wl4MKmwhFIkRPobQHpEa7OLi5f2q0uVYnp7z22N78r0M+hg8tJi9X5eKpxq2Z64yw
         mk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477318; x=1769082118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=XfU58oRCCKUdMU3mjy6o43oF6BRSqvoc4dzv1r7ryv4EhfTp1Pza2diBIJVZWKWavM
         6KxS+2/WpHXcz1aad9gPRf2YFzexw/XCZh5CMZoRVZVA71ESWbzvl5KYnbQXC5mzQlND
         DtExl8ezOwKLprZ4JGPdGSgolkQBM0CXWyiLt67vnzg0lfnhML3RzKKuIzfWBA2O7vQo
         uQ+EKVdHHABL2oIidFX23nt2oFCx179n1K1IuMG6QUw5S2rr1MnzOhYwSSavVgP3GITd
         nsJ6/Knp8xGwleX06AgXU9nRT2KJqmMXC5dlmL/4Y71IQpez9ngLa6JsqW/lLSJA62Hw
         Qo6g==
X-Forwarded-Encrypted: i=1; AJvYcCWgwS9CZBojDLHAIOxTdronRHHJJMwUZD7WT2gx1BJeWktP283JkNTzr6D14AW6qQShEX2Dn6gtEJcRocQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dFRsf9ab/Pi0rWZgO5SJBt/P75ld5YgF9/8fODDO8U/qWiM7
	fumdKGcic3fXbydVggCBWaZ6nhIZ6fwaH4hFUAD26vtZHdgnJJNqLvEwOtlWTkombo8=
X-Gm-Gg: AY/fxX7oiyiKT8I1Dg46LPcah7ENE1oMI7AifMzIxYpGqJMwDkvAnfPlotmSAFy9TN3
	LYPbCslOmdR46gfFB7o4Yw9GeGcaPguD8Zq4Bwk+GqxQoVFODkiwLMKUfs0QW6MCO3+N/IdLt6D
	eKxsAZK1gnSp7QyuLjZHfXZ4CIIP7KoApMt6rzrBp5nIx5Q4240rY5vQF3L5VZ4VHInZo3uIwHU
	xY4/PzWy1u0UCE7ZxrEpqVpNV35yCMxBfTkmMHusjdIezxB6f8A3I3wA8RGLEYksiWCVgfLjhdi
	H4DC7KuKsmkYfJLG3xFc+km6itEuHSENWGMx3m/CFKRa52NoG9qxhlOv7V0pLcBKtndVs11BVo8
	0pM2z0xSdaSpXI8WyAiE9hKEf1CzguKcWUc5mx383vx3nRzRFq4SCPN4tosxeXFCrFjZ4b7xqFW
	yluGL+z/0EG4h8mmhQWwgNfUn+3WFHy74R5rDxw0W066oDsrZS9d0/D57AHu44Hv2dwG26qxCt4
	apj6lLR
X-Received: by 2002:a05:7022:6184:b0:11d:e2a3:2070 with SMTP id a92af1059eb24-1233778b5f3mr6944456c88.44.1768477317748;
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 10/11] dt-bindings: net: sparx5: do not require phys when RGMII is used
Date: Thu, 15 Jan 2026 12:37:35 +0100
Message-ID: <20260115114021.111324-11-robert.marko@sartura.hr>
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

LAN969x has 2 dedicated RGMII ports, so regular SERDES lanes are not used
for RGMII.

So, lets not require phys to be defined when any of the rgmii phy-modes are
set.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/microchip,sparx5-switch.yaml     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5491d0775ede..75c7c8d1f411 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -151,10 +151,23 @@ properties:
 
         required:
           - reg
-          - phys
           - phy-mode
           - microchip,bandwidth
 
+        if:
+          not:
+            properties:
+              phy-mode:
+                contains:
+                  enum:
+                    - rgmii
+                    - rgmii-id
+                    - rgmii-rxid
+                    - rgmii-txid
+        then:
+          required:
+            - phys
+
         oneOf:
           - required:
               - phy-handle
-- 
2.52.0

