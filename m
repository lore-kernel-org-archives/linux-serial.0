Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BA313E1D
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477272; cv=none; b=cwuzfvjXOMmwhuhdEX4pot2sOJQ4M6Iw4U0VR1jcp3bKMzflRv7e8ROT8uQvr1jQ0eyi8e2ZbJLrJd5PgjATKVWTWcjt08hRn2w+REgUCxxSJYozDMWsiHXogXZ8FMWDZoLuuzuqfnfAsIMY6G1z4+dpRTWpfy3ctP+crvJo3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477272; c=relaxed/simple;
	bh=ooKaWydLYAU6ZinUS3YSKV/BPM0KTw6HZzaYhJx/zZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRykarMIXa/VseMWVESPnQEEWRJ0mIC8qBh1IcWRQq+Ij3oWLTj7/P7W1TaeRNgps4uQpfG3s2320zvvxyhKyjKIK1EmIoDY7pfb8gemh0HcgTVnVDKDllxKPv2I2B3ujQK4QY2bwaLauDYevbwgn874ffeb2cf4NOTIQHae/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=O5lnGvCp; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="O5lnGvCp"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so1524285c88.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477270; x=1769082070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=O5lnGvCp5bru6pC2QaWeoBDVHfK15uwu/E3xAeyAUrr9SjEKNdMJFD808ELIWWp8/P
         cT1hffs6A20FXgIcfPjrhRBE/hnQ4mT7Cdn5difSKDrwyd2hfnL+VBgve9xW0YEZo/mK
         BWpmhZEsY0pVJb3Ze+8VNhQ3fjwCJFeMmyElICoDzR9t7Tm46dWQKLCA3fYhx4CQVHT2
         qxTosX+FWOY8D4BqXIDxbpEGADEzw9xh+L8NnwM67RGSd7pTqsiUedvqnRJm6445hNaA
         pK/cG0ss6J5hDKrm1Ag3z2x/qoAeHC3xbnYbZ8jcUMwAMJUqeCEBR1fGzp9vT/vOqmX6
         FI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477270; x=1769082070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=hrHvV9cfAEmKtcw2xvlry6XxCbYxMuape0uuTr+VgF4NpLbPj3hJ/ZIRvtITWoj6ao
         A6bznw3c2e0E4pFz0WxemgOf7DMP/vjk+42ieHbQdM+8ffvWiruYY0gfMRqZqiKOEvfQ
         YBc5sft3YKTES8XCHP0+w4sA210wBMmxdyPiAwyp8e/h07oQA7BaIr8aTLnj/DytkmhG
         /xFa9dCFsZRfMIMQ316wMI3RqtBh7vijHEDsZiXs/iAAER3MiOtLWTApZy4ir302Xrfa
         u3TVq0zazorFpOa42ZytCvjq2C7pU3l4eN1dmZ80eFH8HwpSiZojJDkmWtqhwBuCk0/v
         MdCg==
X-Forwarded-Encrypted: i=1; AJvYcCWasWqzEcgKbTXYll2sQ8z8pw+EY3J4xHvfTOUpnQ3hstX4kUqnx10Fm5IXsEOBhH8Q867pEwzTEtKILn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxguyS2TC5scol/zqybFK8IFgn900mf0OA3Gpj9Jo3pdkAEl5v/
	UuVRPMVtGLHWMjhUpTwkPvFp/T8+GEITFjN33kABK33HHy2boqib/0i8zlzdJlDC9tk=
X-Gm-Gg: AY/fxX7j+EVbRwnuMsPcJTsgFCCRr+EazCBHMEwYGaVXEwTgLDopw/4LVbpBU0xOYAc
	L7bTxV8LuHADDIcR2uyEZSkGcUrGGJcrO0CJeFqUBxxFjBrWXIyAw3FRUKwGkNol2AhjkRy+u5X
	xcKCGM8gyuLvpGVxrhalxhjgjOLAxhcSckMZoPiqQbrSS4Uicou3anSLW/DEFC79r9LpXZV9VoJ
	gIhC8zdQPUc3OoqgeB0Firz4QtV2Pgp2Z5YBOc5v+O8NCiByI/zn+M3OukMCAKir3GiPEfRqfR/
	K9G5ABQ4U/H50T/eWTQzyUnyvRwkQWQK1pRYTqKYqWvygkqNbQmxxGOl9+eGs+JIwo2XOGvx/gV
	U7UEfGR3wIPvfy+8v+a0GT8WVtVOapfVmeDPuYIQ6VJSCVo7CjXYVKcx98OQeUFw1iVqiGV1uMJ
	swuv/yzqBGtO4QW1M7VcStLz/iPWm5hGTpGaKYyBGgwYdOGvT91LgPVOl1RCGg2Kx+X/a1nW4e3
	UooPjY5
X-Received: by 2002:a05:701a:ca0e:b0:123:2c98:f6af with SMTP id a92af1059eb24-12336a45a0bmr7461678c88.14.1768477270097;
        Thu, 15 Jan 2026 03:41:10 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:09 -0800 (PST)
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
Subject: [PATCH v5 04/11] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Thu, 15 Jan 2026 12:37:29 +0100
Message-ID: <20260115114021.111324-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0

