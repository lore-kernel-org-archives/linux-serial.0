Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5833A6ED
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033633; cv=none; b=JH+/xsWFuSCaGTB9qTUhqSpSxCu4s2Rbex79YeAL6Z97UoWhsmLxasfHlH1pki+Yq29n7gYA7AHaiKZeHFqJZi3sX08s5pEsQQbH789zNLay9NAqTHrjBWNYKfA5MEaa8PAySLAgQJgwBAjt9SpAzKxMOOnVgzKxUf4IC93+BXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033633; c=relaxed/simple;
	bh=7hKH5EzmH1tw2QTQXNXPEJl0sVHK/le/PcpUxmqe6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAimOsZI/zpShQcLrtU8p3keq8jzpAg0Ur0ca52pJpzbrYSF6XiKZIY7vF3BRJrEotfk+6NCOKGVchjBbRK/LGcyJkPBcUnoFgbbsI98S5EoOFM74Hh/r0f1r/QtaRYYDAx/v9WAIdSqBlpqgZu9su7t94VbaOy11OPW7rChQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=u+C/t36R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="u+C/t36R"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632d9326so57773125e9.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033628; x=1767638428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=u+C/t36RxL2h1deDF2NgdB+V/8PFIJNoVWYqFiBvqPNfeDhDg8nP4BHIkKa+gcW6Kz
         oZyl4BCY1ZY0UlTWbp3WqvUDh1jCR0nluG0nE8iXrs7pjzmjBbQHIbIPL+8dTif2iApy
         49ONVh5e7r1p1beaG0DMCImekdmaXwxCCIx94h6Iy5ESduLUfRYjQji8QXQDkAohfmk4
         FFH7obpel1rzxwvDQjHUy+5M6GtE/DPaAt1uTJE0l+zC7cPSxPsPuUtaftvHqc0L54Uw
         F9IFWNLp3CuSTGSt/Oey3Exa3OKO39cdnJXeJo/5uJiqKIWjp4l6/JJxmT9Pm8bsytkv
         193w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033628; x=1767638428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=jzE5BX1ZtZsfEMpPRi/TF6oHxFD2SZUt0RxHwGM3RyUDXCRrMRoyT7Q1lqesG2udBy
         oYoahqPk3A0FEJ07w1bkTBR8eHE6VRlok3repbnPy/0R7YDHdvV9WT8oOD7RQulDwYbN
         N0cA6NWKcmoKZSrfO0HBh70nV5U2hYRLnAkwnA1/1mNF7e6ryT2PnS4GE73CBmqMaNp+
         WjdKeQ/uFN8eJSq6x4lDuTZejr5L7cvC3aJCfAFe3KhWj51PanjTe0Ua5ChK2aWMfcGh
         2cp6D6pCEv4z1ViiQsUbGfTDLyRqc2yWd1Fa1V9UH9erEJWz+G7DxhSRYbeMn7+f3FiC
         4gUg==
X-Forwarded-Encrypted: i=1; AJvYcCWLXZ42wtzFdSy1+beirkn3mJ7ebTGO+iZFtmcEt0yb4TD3FFFLu5B48eQs5RLuJVHOQ8/s1TaZ+NJ41aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsG64Z8WFiZmC9S77AsJ7mKLcyQ/lEwAj1SPTvJKws7O7wRAk
	j4axzBmvIgmcGU2kk5nT7C/JHJibWfSWURCPDBpGahsDHd9jlBlJKKHr8tzd19CV4dA=
X-Gm-Gg: AY/fxX6kx/3yhWWrOxLg1Rv/Lv6WurNuCq19/APuXRkAKXIHAh3dN3woNi7CzRFdkIb
	xABz5p96u+HMbt1uaJfT8cNUdhbTceh1JKq26iR1ZzrtwO98bgn0AzWkBWy9hnyVG1SQIBnVhUq
	47QHhRYVx4D+dk0XYX4TB/b7Q4RTX2JWcZ0rBFpSZ6Us7Ynf7BiDnwQOSrX0Sko2QhjJWfmCRnd
	EmBwxL6DYPK0u4KL0rLZL0K1ONPPZkbkrMhMioDU0k+WsLPNwPBOB01dSRfDJvKsqpACsoVFzhD
	KRBeVhz0EgKu8RsW1w09bYX1qcd6Z+3quiJnfg0r66u9LH5sqMMWGIIMHnBF92OYIvUjnCLHFik
	4t6D9J48cq9OarnlYu7cO1zfZSgLtASYyo5g3zE2It4gCRtGZgaOYcjxWyznzLAneay1rZPHmPd
	QlEbkZJU/4nN/k2KvH64e3lQLHn6mcHO6gBYmCcJuD4c2q+n0cToT5NtvF6Hl/ReZh1HcQiS3AT
	n5Pyge7/JEOZxbHciKv4Vb1hQDt
X-Google-Smtp-Source: AGHT+IFilbmrX7qgCmCad3pYK4YkE2820iFvJcnWl298VhAC/QPnRoMoqJ3XAnKO9WPGPH+NwyaEYQ==
X-Received: by 2002:a05:600c:468b:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-47d195670b9mr338260535e9.14.1767033628587;
        Mon, 29 Dec 2025 10:40:28 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:28 -0800 (PST)
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
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Mon, 29 Dec 2025 19:37:49 +0100
Message-ID: <20251229184004.571837-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
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
---
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

