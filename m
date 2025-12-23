Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839934D907
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521209; cv=none; b=Ts8wKav5eX2zgFoV+p3ZQZOWc2yFPr73IYYgtKuJI+2wu/KZTj/zPC301VIxj5elzlNurhccVIYa+RDL8M0TN1R/Drmoqi/XRzJ5FlYRtIDuwSCUgYifSCoF3BBOKPqkDzhrn1jn+jYv7HqaXwNteJWRCTZULT91VBRG2HuuBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521209; c=relaxed/simple;
	bh=lnkhvIt3TrOEyzf6TQ1BG1hfakQAvNrAup7QLQoickg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl4E2iGokw+aRB+pKcKwibew+z2vxJT+JHXbjxaAmmDCjihIgPJozPgn/9al6z87W6PU8kKFDp60+LaD08H0i7hyel2zH6HRGbU0sSs+I4pouxy8YL5gNPaI4x0tXIVMKa40NQYj80xdgwlrcTqnjchxjuhzHfajB3vgFt6Cyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UajBDKTY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UajBDKTY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7f121c00dedso7147771b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521206; x=1767126006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=UajBDKTYlKcruvSkRnlFr8tjHgo7vqKYdeF6g6i2LgrtBlAxi/x6/j2FzFA7aa8IFJ
         zCbk+kIU9UJjaY8OIT95qG20Y9itoXB0IHgRnrBEMTEvoYeZOBFiUZ+FDnpmRXib51JM
         VlieXBhkKajYtWxLUzmgiSHsdXHz3zT/Iqy7FF7c8goVaCwQ7p9fsGuBegWYWqK+Jb8n
         9jJK6EEPqAU5wS6uLrfhFlUXf2YYvHGfb6tTbrFyqsIqLuSPy6BdmhvfuxR/0v/GvHPn
         PnUCBlucC/3gAqVgR3ks06eKS/hQ6am0E1QuYjf8Chz+G9uMrPAlcGrBGz7oOlpk1iTI
         ZzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521206; x=1767126006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=L2vijB+LV9E72+shRZWwzzG2PINOA8y09/vHO7Xq36NJ/O0epgcCh2MxS6OTmoKnhA
         9RiglI4po6uhTYEd+oT47xuzNCJJD1P/KjvoZlZghGQaNHzguvjGnJlnpXb+mV8sGzEi
         mYYV626ltBWUw52Z8AZK/a/uW1oARUNRawLn2EAFQowiWpCUjGA2u8wLWacrp6qtYHV6
         I1xGOxTn6SPuQTlFWK6hOQ41u42+mm4qidyiKZ+0hTmtCRd0cuOd+azRfKZr9XxZQMkY
         9AhpKHZKho+sqAgHwwmshBmOAMsT46kMkPblcp7GK80FDk5yMuubHOq+NKdUkziVd8Nu
         irkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKq0+TkEXUD3PkUpLYE55bpidICvXb/dW+va+BGJmK+PT6ftFAW3gnUzVsf14gVnMvxYG1TLGFgv0DmQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ipl+C6lNu+e6pMp5ebxQRX7+k+NaagQx256i5W9w2uE5Flzu
	BrTXALm0VE548WtS3I6nYvoxh0ssT1BuUqfqi+fJqx21Qyn7uUu94XtGLag7GHxW/4s=
X-Gm-Gg: AY/fxX5zpR+l32V6QvvPwfFn+UbuAvQ3F4LQ6MEYFZ5we54W3BcvYZ6RZZ+NFZpt9no
	k1Y5+lOkR3j1nEcWqkiLpnsjnsd1mNC0m6sUI4q5eQhcntEpbYlUdJQfJ6DivLCCg4X8KF6v9NM
	eykzVCtMmkrJDh7Y3JLX5jn2ryQym1fH2AuOYZJtCRtSzapi3WWI1vsZGP2hPsn7DvCYbr0P0eh
	AsPh8OQgxpnYdVgwO8cx3YEa/xu505zNw3O1wwXKkef1COr8AWRrEuJgLc9tb1wSk+ofG29ODjd
	+ciaLYJsI7ysjUUHu21JTDPWJrtOOrKFrJv69kIond1ht8BMeuJv8OYAgQMMubG+cBpGN5r3T+R
	01zmrdCXJdCrdSDl3LgAPIRuyKVG/gQJOnbTr7+lOu6RIJArX5E1AOdzGV228pTDL/pwnuhrn4h
	SJgUQvljw/INXMnHCv6xw1V67tREfhaT46lMHPZKyQx7za8adySTP6mWF7wKDkwcMi7pff0JoX1
	HJc0Vns
X-Google-Smtp-Source: AGHT+IEAtWdhcWPCbENBvZFgr3c7IxJWeT0r5R2X+lgPN+f3cgKBnmk37uhjXoH7niVY6cpG/hJphA==
X-Received: by 2002:a05:6a20:9146:b0:34e:959d:e144 with SMTP id adf61e73a8af0-376aabf97b6mr15698314637.54.1766521205797;
        Tue, 23 Dec 2025 12:20:05 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:05 -0800 (PST)
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
Subject: [PATCH v3 03/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Tue, 23 Dec 2025 21:16:14 +0100
Message-ID: <20251223201921.1332786-4-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
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

