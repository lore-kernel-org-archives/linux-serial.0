Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C4378D7A
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477248; cv=none; b=sYjAFkZkKyj5Fd0QwSfACIvaZho89TqJOcCY614ppcWoZOtlJVwkL4IAsmzsv/OIp2mzrJ/dp3j8k5NTcaCVqnwKl3wpBEzoLnDK+gcAEvayODlPQ0G51c2x8g06t21YDLieNBwgJl+5bT/AM/Y/TF6TTiPdnZ7i5gXelDTjvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477248; c=relaxed/simple;
	bh=WWvO7fvS51VGIasNJgUp3QyEPuObUZpxHbR7pn28FTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY6f81Fmbr159wriL6HuLExZV654EP+nExJ2+RVEtc1D5/o1Vdt2F9rO0Y8VDigwDZ0uUE5CgLpFjTqncGs19Fe5ZTLiyi6vCLxP7b42kBWiaRdOKX3jmj3sesQGb17AdUYHf3SChXSDKIBsGbuFOgjG7+2j9dAPm4V5VmyCQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UVcP/v20; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UVcP/v20"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-123320591a4so789739c88.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477246; x=1769082046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=UVcP/v20an1Ri/KQX0pwKtk8IAvtwsby0xjBw61cKlNrVlC3TDhaqpNaluYDS/2jIM
         BWRr1w+09ZCctBa2GQGQxakTSqfDNXYv3gb9kcXbnYzK/j3ghIrArgDxhs6vWGUp8+oz
         8LISVjzM+5XaCtbqkAGVoGpwEvW6JpAY2v1pvUMP1+rMTXo3eg4HGJn1CxRU2zsaJeGx
         hvT4IEdvfB/SCQiQLmtXEG5pFMpWDJRIQvvpl4zxcqkYCpHN4rAu2SCJ/cI6615bsSsL
         suoU/9ddLvKABiycIMuTvbtzXnKVugaz1cHH7XQ61XUJVkJFz4lhWMBiVYPlKlSIoXT0
         2QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477246; x=1769082046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=a6sX/6WxShGpKMxHtVFsxbvy7Yr+Jp/dHNRsw63GOKzK42N9QgRKc4CVj3czEy6bx0
         MLj7i5tSHpoXZiE0DSO0I6MIQIAI8PkmvGcENC8ARXASgFAB+HTTFCkN3BENI391xJcY
         848SToJeKKkokycnezXXbSg/zczXkPG23jPeie2wsH+Nne05yIjnb8R4Gp+4ib80fQS6
         23t7Ia5hf7By9V9ziv5KkGqD7st/DIQyS9XT3GiSLUv7p7+NItNNmgUgLwatEZn4qI7N
         ylxCqWCWK5Od1ZDeYVDV43KhXk3usXV7trWkqIAYKyEZCu70e3bljsuwRH3QH8fliXey
         YrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXZghPKRj2H/CGMSXqYjyT11/FYyK+bkv4nvr3/Y9liU2K3aTAI02KakrK2WA78KOLNwsp513GGxnHkoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5oF64qUhGGJQwgCGuKBtcvAz0r+fpoRnZ/vbM2ARBpU9tDPy
	ftRU9QdoiPJcBQsthpGOmk7ZycuXDn/ZduFCcZNSH4me0asQMkbWssKcFl9k9WlMyCQ=
X-Gm-Gg: AY/fxX5hM8SdxOxNP/HzAuuXpfXPrPVAqLcHHRGDHeCFCVaVcLcDvCKFOOwxP/zRhme
	WYF90fN9W8Y18eUGl6P+4/09x80WmktkBIg5zPnDsrB3fEj89mfBW6mw+nzODnoeJ15ljrYHZ78
	rMA4cZIoqpMadqs+6sfW8dTZ/QaSeb4osxos5yMLrLBAPjz24T+uC52BQvG/M65yMrH/xd69wjk
	PVNWTQM6XJCtK5goBp7SHVOKGwb0o1QTdIm5GqaN43WcYSAIEndCzQhSXbo77sVs8gK/imN6KfH
	/zfxMpWsU4bVeF5Q2FNjJ2VWaOBP3Jz0nIAEZP+W57Wv2qc3kA00sDv1wlSiNoLmj1EibSU0vGY
	V2YrmBSIbeNoyU/HcDDaO/1RPzW/YpctmYorFWtV3Bru6Kf4fO+77LpvzktO7EvH0awlEWwOIzT
	KknC5+zZ19zbK8gFaiWagt4/S42JBYqUSwZYXmf8/0ptOYXp7jdAU/Iq3onZMf93vqt04qfXb59
	SdXiNXM
X-Received: by 2002:a05:7022:4392:b0:122:2f4:b251 with SMTP id a92af1059eb24-123376fccd9mr8604410c88.21.1768477245907;
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
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
Subject: [PATCH v5 01/11] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Thu, 15 Jan 2026 12:37:26 +0100
Message-ID: <20260115114021.111324-2-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index c7d6cf96796c..5e5dec2f6564 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -20,6 +20,7 @@ properties:
       - const: atmel,sama5d2-flexcom
       - items:
           - enum:
+              - microchip,lan9691-flexcom
               - microchip,sam9x7-flexcom
               - microchip,sama7d65-flexcom
               - microchip,sama7g5-flexcom
-- 
2.52.0

