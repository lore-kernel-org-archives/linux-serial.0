Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13871E2858
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521228; cv=none; b=Fs4mLAPy2dgxtZUzgQDzpVGT6+k00/ayuV2fTfgx6lxotWGRIttjNiQ+91OVYdhc52oz0+eFXQc8A8DM6rUXrgXCCX0SNH6Vj6wkMSRkT6aQ0aZ+UZV+T03dUoJvbhQ/w6jGs37oG5YOpM7/9tst0/RGnXsCmkLkdcZ/DkzStJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521228; c=relaxed/simple;
	bh=HaP35Mv3tJhzA+ZM5JG9j+YNJFp/ZeK++35o7px2hP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuEHvs7/ub6vT7zRSYInAiT1KmSwtznAtsE/Q0TSpkzK/NDjnZFmqpbja5W/tW2f8MvsPOIAcoENbfYfWy/jGZhShdWbbXJZEQ/YPnvIHUamFAHc9cZ1ET3AyArERme60w1TOw8bMLNJKTf6E468hJPyX8chFiz2KYBjBZGGyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WPMJMxT2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WPMJMxT2"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so4802744b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521224; x=1767126024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=WPMJMxT2Z86tRUSGNKn0CYAH7lwYVAgIaWB3yVBHo64gd/T2s91doAUDCV8wqm3d1k
         DqXXsn9br1YlTxfvMupgH3TmIT1S0x0xNftveqUk5jLtfQ1ixzf9b3ZSBozDvQE2pyQj
         hhOrWomNhyMz/EC5b18RIvwIaScGg1TC0qvDuhlBcWJ6GfC1lTqE2K73G9hASX2Oxm6M
         /UgVfZTNLJNSpUC4EIkLNjKwAmUHnH4XO05eDMmPyIj+hi6/jvMdE4U0XPk1o+gmoLW5
         VBVI94hQaZ0XoDa6zJ3zoBMsb5xR+5HTpnU/B/bPo4koRUuMa3SXd6NekJ9GtM3jn5gy
         M6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521224; x=1767126024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=dA7AsU29H3E+vMRojP4YsdWcqehSxXFyuRQvDQ5coWkgUZ+nR5E0/9rurbyMsUMEdC
         NkUVV5pT2hhoN4HsEE9FTkKZpB72hC0zpKgNdqhVf9vvjlno6sJvfR9QIEvrNNGUpaIn
         ZgyCogP0lj8rzhLf2Cf7qy6474JKoHjFOdZPvflMqiFaqSLvp1sP4SZBPlLNqNyUM/MF
         dFLKTTR70tYhr1Rn5IAmrU481wUwHDANK8CG5UHwh1oq1VmEAKyI7ngf5MlAGC1ocUH6
         h/iQrP1CYgR5VmcF0DoNJ1MKyhXs7OhJGjPoOSN1RnuzVW8tCKV44HgUCRXOWcx5Dd4s
         QUsw==
X-Forwarded-Encrypted: i=1; AJvYcCXfWPrGMSObbpj7ySbkMsP+LD/P/7Wtu28h0Xu9WGeRrKSdfv9petYFHvgXlobR86BBjoR5l6RxSxjeGjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVlXcx1SQblsNnab3dF1OVP+mFo+YJSB/1kucAnNCG+VouM8q
	KJE5hWGaQ7hBNCT8CMzO3JxggcJ3nM3rIjIWLc7RFkqE91pzWho0Y+WEC6s8Zr1lpNg=
X-Gm-Gg: AY/fxX7i0cyGVrizypu58cVkxMkw+crZNXuDpD3/40O9u5KOwU5MzMebzHYIZQU1CGd
	qbfFIGFCqb1TchABwt9La8Hi8oE6zNCkd6q9NAs0XSuhNkkhs9Oc/niKMgPFPT+BYzunODwRk0H
	PBi52xGZrl7TZsBDXBXA0QQY9I+dVsxhwgY/5XWh/v88HaEnAiqveNzdvgsp/DhL/zXKDYBFuk1
	bfUl18yKI0lvVdrdMKEwqqKAGpR6XV076j6cxlwerLEnKO5QFs8hf2/TSKaDmuaH5bS0R/ex37H
	uKBSSFXCcFYD8oDn5gDOi3Hzdm5GUOCMH5Ht1UFun9SJSSMwiwAANT7upnD22O+89DCkW2GqpBm
	6yWQBUcwMDXUldi1yAYGB1ISWM+QSKJn1P6mhhb/pb4ZmXSIHuGMCZ6mIjbLHnmoTCQpdZV5V7Y
	DcD9g9qr5AQRLechRLQfRr6nlTRDbOFaDsjK23ZOMIFMBCRfhHAa9anqJa4HVCEzJAAjaYxAYJH
	/s4lb4b
X-Google-Smtp-Source: AGHT+IHEkRqkF3+ulFb7YQxPiXmGF+AIEzrSLTHIV/1Chrc5EC4Qv4EqGmxiVXP6kKzXYBSaNsC5Ow==
X-Received: by 2002:a05:6a20:3ca2:b0:344:a607:5548 with SMTP id adf61e73a8af0-376aa8f3946mr15876623637.58.1766521223699;
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 05/15] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Tue, 23 Dec 2025 21:16:16 +0100
Message-ID: <20251223201921.1332786-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

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

