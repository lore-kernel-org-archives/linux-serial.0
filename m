Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440431;
	b=ae8kNZDGsib7KmMp9FlLPTrdQURTa2mrOLb+txpl2H2A13oAzAUM6EllG/2TaGoeEpeq
	 VzSOTPruqa+XBcymz2F9JaZ/PHmBFlZTNstR4xTwgbrFgoUvTfOOOz5NQ0n3el9aLbMwj
	 cHOM4PMz/kGxWbTFemBuqN+JAMy6lsRl5VNN+1RoXZMhyUgyxvKHNVGjKbTutuxr4vlha
	 4ynHprkhery6FZU5gjBl3jtE6Ggtvlop5c+OjzJUzS5MbsjMyBFHAStv1bCCRoCjPE62O
	 hYikaHh43l+bmH0xK/nHsD7hOCBU3n9TmqeRCo/LtcHYQae/Ybu3epxdUyrTKkW4cqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vseRokM4wlUiC0msrJS1ImPrMKPknh69JMExUys+m18=;
	b=GU5GLp4kSdg1E1D/qD+Tiy3885D5DZ7xCNY5DtxIacgiV8CNTxd7CX4oDE8EeSn/sjy4
	 K62eEO70Fkokw5RNhxhdTA1WvcXfVn5A7cI30ozdBty4hxdM28Du0l7jpi6LiMNrYOqq3
	 Nr6dpKn40drMAahnu8c8FBMcoHJ19Hg0BpoHc6isd8MlSGx00NE9D1oVQI5Zz844JhPih
	 sSsbM+/CrosSSPCZDcXcgIrmEGKVdBn4ZhmmLb6eX1L+CabkyTrQM6/efKrN1xEJAEjpT
	 n3a3NnBcfAVt8M2h7kxeDv4ZEsdkVy6mnebKQTd/M48nL8VO4R6uJvUXcQDNg6TqXtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lFjW6Ke7;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143ED606A31D
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143ED606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lFjW6Ke7
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eabf243d05so706118e0c.2
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440429; x=1793045229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vseRokM4wlUiC0msrJS1ImPrMKPknh69JMExUys+m18=;
        b=lFjW6Ke7fqt2qCOeXGHITKP2EScCXZd0ELJY6MwJisMJLOS1qIFTPrCr2eT4uKGhi0
         T5rEMvzdIhWysJgwDefpXyrveKX86LjLk54uzPkVPcXWmnq5GEU7kK1sVjVfixysUKev
         DW0Wx7GlV0E9+QE/Px90najt976ve8wiR+8LBZbn5krM0VxARSo2DpoNA8XI59F4GEGw
         sifqaooDNtbypP+kdTAeQ7BQHM5U8i1KoZ/+8iA4csVYkrzTj2liwDSKipLoNeRmaF0B
         ylXiAzMMZk2q4DeYUYeSZIkyBtQExkQ6YGXjL5fWK0fcZAl1h4/pTfL6d0XjFoRD1Z7r
         xVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440429; x=1793045229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vseRokM4wlUiC0msrJS1ImPrMKPknh69JMExUys+m18=;
        b=IplWYPknNKYESMRqN4mDLaoCV88yAFVinPgrtG/h05ryJALTZJ7/wks3+zLXZ/QEoy
         1V2bnnvE9yX/G736yzrd+R7CwBBCKgvqaHKMTG5EMfb1nOsyABXfEMyY4UIjB8A5xLPs
         rhjK2Zu9uhcjRJRljf3wN714zcstcBCWhS9Pwx3BSAYMvM+yMka/RJKyBqvVibgVGMaz
         BpwEvuj+mVbXeHgfxKfeCVNw/pHqtYN8gIFXWv+EwTTO2A8H1YPtEkUjgailIIIuRgCC
         fzzNcGXLDxS4UORcIlwq0dIaMFhGjlXfSzAOgrYZbBiFfniWO6y+8tsSxg5kzPs5VnbB
         tPnA==
X-Gm-Message-State: AFq9FYJMuwDdH+SRkj88KKBf85057Lb1SHTEroj75oeLLitTgagQTDIE
	7t1/QfnSTLZtm90y4VUcjjHK8SxUFh5un2eLgpvcssQUj0rHvD7xkGdWqqH5LwJZzsdoYA==
X-Gm-Gg: AYBFou2F8CQMBgjfKpV0HZeN2q6DqGodZq910lmqViOWmK8CV8Pgy7GeqbFoZnw1f+h
	ZnQt8eU0+RxmOWUqFMb/qMLhcRfU6qNDQLdrAOzLO/DmR49nhRWT0lDjQ+dqUYMWyFW3oW3ozwk
	l5FJFBlOv9LbuJctRefQyYVTAH+Lwstw5D9nwGBdVGCGfax8et0y8oSIfCloNIntVxGevx/XBGh
	WFKiKwT8EyEx2mNQpyrZmuscofbLa1T1Uj53LiahyOVkUwBjNE8fO5mZW2Rlb9UMK6WU/yP+tPz
	ZcEl3eDX5tQ7oRehEjYYQXcwkoAELE+K1Bh8Trfy//BwDcTWM/G6Y3qddLDCewbyRAm1f4Am5O9
	OSCVPEIlvFxbF/e8pYYTjgInGL/cN8ZTlpyYGTn7CSHKpjsutljx4S9CqPRDkrSbyozkNmAgQhx
	7mRuaNUqnO5CuD2LhlUlH/aTaXo3sj75Rj3+nI+4uAc1eT61FyikqjDQQVc1VEZwp0rHXeIzVSC
	Hfb02PEcRvyDWehtqiDlu2UUQG5ht4AwZugUV4jlOW7OsAcvdWI0pf9gUD6qbsf1++KT4pgUS/E
	8Jrd65s=
X-Received: by 2002:a05:6123:2eb:b0:5dc:d0cb:7d6b with SMTP id 71dfb90a1353d-5eaaa65aa82mr3039279e0c.14.1792440429039;
        Mon, 19 Oct 2026 13:07:09 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.244.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm10451611e0c.3.2026.10.19.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:07:07 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/4] dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
Date: Mon, 19 Oct 2026 17:06:12 -0300
Message-ID: <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A733 UART is a DesignWare APB UART, but it needs
SoC-specific handling so the driver can avoid stopping its clock during
termios changes.

Add an A733-specific compatible, with "snps,dw-apb-uart" as the
fallback.

Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..532392dd54cf 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun60i-a733-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
