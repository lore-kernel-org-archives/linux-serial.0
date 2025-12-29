Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4923358BE
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033621; cv=none; b=eTYuD4BdjMuXGh9+DMNwB3NBnhtDhGY8Fn+vj3hPlQysg1XmLZLqmlT8J/B9qT0FTgmb2UBlGyCmfai2Cldvfp21jazY6bwVohaDzQaoDQgZkKHN9fu2vb9xQJbHCiywK6+uEU9iXoLaj6tnGgG2izopGtBsGaEP0UUMEuW4jiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033621; c=relaxed/simple;
	bh=lnkhvIt3TrOEyzf6TQ1BG1hfakQAvNrAup7QLQoickg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ZrAvitOCbMYqgKITm/KDXOS8kzDopnKYFAWKlxMFNCUFCXl6E6J3WnTMGK3VcaF8zCZjkpp4ECcIp3Y1vutuO6JJhlLE9Jmup5ldTdX/+L08mpNk9h3DyJBRVlw7NtDE2dSEgvnYdmoDx73NJvLkaA61XSvDteM66guuMOppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=EtboB3HH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="EtboB3HH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so71187715e9.2
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033617; x=1767638417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=EtboB3HHe08w0XqyvQc3lIhAD3Wrb3A+jSxyRDBnGZHNNGsDYTpopftjz07wgCqGTg
         wVeB0SBg0sYtcFqQU94CuwWFrINZ8JOPcHYxaQ6Eqrk7RF9dttwfVjkFrtKvAte42QKe
         r+FYs+x/gVWoMwshb1deUAAslnK41Cwlqc6VYn9NzC9sJc0HbsKoDjg1tHFyEjsIuV1E
         ATaaF/DfSISmFUI6qUXqycxRqvEHQLBI94pKcPYVDNRLhHS4veRqPGH7ev44aJH8hGtb
         2pYEvIocOndgsPPLrTFgpsyOh5/kaYmScXGx3p7T8JaO6Sc3tDW4z8sPJigQKU51gN30
         qWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033617; x=1767638417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=UX+3EONS0NDUOgIYSzV4d2gERZHdrltXu5Zd+E1qSjlMQseuCXlaE4AitP5Fej9qiG
         PejRzRaV9rX1EE7nuxMmRLA8W5AkunHBOyf6gzAiU/b4UWcHt9gYCbCYUaVfOO2/1l1X
         Bl2eI30BSia9UJzU7eblnC7Juc1hJ2r3nsIUYirnjwe7CqKWZjiPfrqQSI0vOHmbccJ6
         o7fLxgYr4lKEDFWUkMhVS7L9xVfUtc4gxxPyEYt0yrbyIX4t3kLCK0VapvjsLbptTMNG
         yebd6j+7/aJLu6USha0Jgv9vYRBgK6BD+2AtCqTJPL7q3ATcbcp8DzvZLX3H10HzSfgg
         +ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCULFuO9o8XBxCmr97T3PcNvldTMiY8T3i8cbNYyIQMdkUROexBy5rDxtTWCY1DUA9XlCDSXQ2zCoN8TMYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A5cPsodIAWEHL3ZJQwch4l9mnwX6qxdm2SRC1yg1fv2nIwia
	6iLZ+K7GMeRswkhvFBNBvuHxGiVGHELrIgHk3OYofnf+P9L6rDeh/syCzWHblmKyU7o=
X-Gm-Gg: AY/fxX7/aBJie9W1MKNeRi0pcGxLuqWC68ybqZF99BBEzH9e0XjkwyYMFqTzSy85WoS
	FIfRgrvje3Hdoq9f+IsLNj9z3QvMK0Gf0LXhZK2+RGuGGSlzlcbktgRgUZMgsbQGdw5DvcLIMTE
	W1du2f3klLNlG++k42aZ0zyM+csrw5ntmxvyGhibag6WhRO4yutfeGG2khPNr31fPeXIjTgX8bs
	KZYDG4uFu2S581eH6MXGkY6dqfOhPOSz0mwfNaq4dAXOqsu2Zm+/HSyiwStNghuhz6Ma2P/ZgD6
	ViU51DC/N0zqGHlbhE0LLqq8hgWDH0wZ2B8G+dB+BSG5nJoQPfigH1x2pQ2jrU779hAc9v9NjHl
	KfdJgPlRy/t01N83jNGgZ785AwUON9nm928KfNeOBTGkfGYBadt5ZyMx8ZnETupQ7wIzSfVRzZl
	LFKQy35xQf4MwVTookOwQkE+RMxSs3aahuuIe1S1u8ByC7GYiIBShCvzPmqelzBqxJ/KxsbEA1B
	EzN1o/un0m5e/X10Puh3o3bOdPLClZVUd8kC+M=
X-Google-Smtp-Source: AGHT+IGjzQS21rGuoSBITpTDpuhXFeVyR+ePrw+9us1bVyog91e0BDAjrgenQhgGZwBix2fL5K0wjw==
X-Received: by 2002:a05:600c:1d0a:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d1959f72amr367970555e9.30.1767033617043;
        Mon, 29 Dec 2025 10:40:17 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:16 -0800 (PST)
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
Subject: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Mon, 29 Dec 2025 19:37:43 +0100
Message-ID: <20251229184004.571837-3-robert.marko@sartura.hr>
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

