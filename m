Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769C33893C
	for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816745; cv=none; b=UchzkT2vWvASa6hd0xW1T1sH9+Xg+MY9am+dyGbAEE/kezE8d8qNz60lIQVDDvVi/MIo2nhTc7laINw0FU2qE7bfF1IJkh7+02S1vB3VflWfx0lV091FQj+2TpIXob0VeiK0z9j0NtxzLvBQeWr9Z7gSBz+a7mUuaW6bog+1b50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816745; c=relaxed/simple;
	bh=E3VI+rCrnmESMLY+TqQMYn/Qmb4uG9OsOtBt2o1msik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNIHghPlsvJdcvGwewQwpw5iLPZOEBU9vRsQiogyFOKuazgRXICpXTVHBPutnFIaBl4SgIet8i1YQ764wpQdy3bKvw68WIE1eMxC1WW4dGc3ZkKTJCZR/y5v5490m41TOPYUxpyXb7xaUBaswZ4Isw3KCOdhXcpZ5j4uA52Mico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=wO7dD4TP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="wO7dD4TP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so26282945e9.0
        for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816735; x=1766421535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0/OVgNCzmU+9SvTTiS2Q9ByKJcSPr0aQjDQgeNdxB0=;
        b=wO7dD4TPSyGMuRk0L6Ap9dSOcZI1MZ1dmXvZP//4NxH9Ao2EtrEp1gij5AvQqRBoEf
         8/YKWDj0e6ORbpDGL0K2pmL2kANfBBtNcCXZ/FLKXdN0Aak9995tfCaYWT0liApnYAF6
         /k7QAludqmVxhJoPW8yzEenGG98K3ZS6GslinItJqraPWqJ3aAhA2DB7tElRJBStUOGT
         TGig3lOlaSKRh0ClgQL5MNGq5Q++TY3eJbJMEXqClIM2iIQPS4jenSvoWsXF8TDQ+U+C
         5ddf6xKmuhevQI54uTki1bmtabDkq+fkecpTNbUxb3Fr7saSEf26UVilsblB5krE+rZi
         rwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816735; x=1766421535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0/OVgNCzmU+9SvTTiS2Q9ByKJcSPr0aQjDQgeNdxB0=;
        b=eDXBnuaGDbm/f7GYFMfBWyXj6xrkocDCAUKJCRuJKp/+DZjay1F0WbKoW8Ckidmh3l
         k1pnMdAEiuHvnW1k6/LbHEA5DuEfB8zMMcLhldRLmOaLxxR3yIkFTHaAe9EnDynWwe8O
         dm7q+8lMjnQEu8X9tVQjK5zAvKeEuk6Xu3rBA+syEUvacq4V5hMW2jdWbFMR1ONCvTTg
         SLDpQCpVb0W8nhwykOhw6EVG80Qfnt8g/YL8xPHTa+JOhE8zIhsqIbqKG8nmiVkccwLG
         DGEYY4PAxWFc1DYopB7XEcQmmbbwFCNwu8jjHEA2GaKNr976DlnclitpGmggxHTthBhw
         zVyA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+VJI9SOQ9k67wBwHYjN6AQsPCVxDSXF74D7KA/7vtR7K/f1NPsQUHmj/uugpZDzOmz3WBOFeqxIF0dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhDC4t0fBS+BC4e7p5fvGFbuMis+sJhGiw0ze1uEWRVT3j3ns
	v0LJ59AtEoa9nTEeMvZaAoAXvWuDpbJ3B0wHEfwRpExhNQLeGizA8OYIycPx/VMHs3U=
X-Gm-Gg: AY/fxX55Uq4Itbc+tUEZQU+BmB0jL91sR49kjbZFDYCchGqlsWhWBLgxsxSaKPmI/+5
	axz3QbCFReuu3dWM8untQaJgqAK6LPy6JasmiTZsMbuPmwKokbWa7BYkmWK+jWjsLu6UnXulRwW
	nPKrzDOWzEjB23r/ucC097uJoDL7+jrlg58yS7U0hWNG9+k233eEDJ9JlwC17iU2U53tDKDoNeJ
	3Y0fJPH0dL+OWU6EJEykRetKiOtphRipp9BIgB18PQWv/hn6Yq/QTfuUj5SDgb/BGo2rTiTWCQ3
	nRCZ6be2hpow/SobspbJT4ytFI8WX4mwhGjHqYMAAXj0f+L99+v7x1/YnuSGGp3h9nx0S4MKNWm
	EZGqgCdSnMqIA+DLFOuMfNZ5oRuJFRVPzdFCZIGvJEV7WvAp8R+Bv77+b9M6ubx0rin6Ye98Yfc
	6t8IjlX04c6Kk/6lcqQ1FCA+P5/N1QNm+DzNeK+A9IHlLj
X-Google-Smtp-Source: AGHT+IGUYIEgjlTnPr2tLcPVUCL9l3M6N90prpNBbolsxQuhh1uHZmWWgCbqjrFvhJbCg5Xq2mMw6A==
X-Received: by 2002:a05:600c:a012:b0:479:3a88:de5e with SMTP id 5b1f17b1804b1-47a8f92029emr95523575e9.37.1765816735298;
        Mon, 15 Dec 2025 08:38:55 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:54 -0800 (PST)
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
Subject: [PATCH v2 12/19] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Mon, 15 Dec 2025 17:35:29 +0100
Message-ID: <20251215163820.1584926-12-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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

