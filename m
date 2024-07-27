Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0F4653A;
	Sat, 27 Jul 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082499; cv=none; b=mbJlrLOYy0jQ4ER6y/U+BgCgeWeACrm4brJLpXD1RnYBNobQ1NY2AkcjeOyl9xxUfUqA01x2Px4Q63O+krAn4Q12BQmcsrwypHeRt/HO50MPA2i6uW0ktORuDmjga1p65ch5+JOURe4SSrWbG/PmzKUhuMdmVpXF/QG61AMUPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082499; c=relaxed/simple;
	bh=Ifo17bDlurXIrUa8FVbIZ6wZk3uJ7gITQ26TKwOYGzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxejDzL6EjQQLBFERCVf9hlikvtPcnoOot7erbvLGbRxjc3MURWIN9XnzI1NrK+dOptLPXRT2JMVJLktsMchHGzadasPDifw3M18/ZoTR1yRnsa9bl+xgjN+CJh7fF97hXto4IY3VnHOs0iec9QdxoEgI4GRXGUUjvF5g1ISKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK1tSTHv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK1tSTHv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so3608864a12.2;
        Sat, 27 Jul 2024 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722082496; x=1722687296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXRD4T8Sdv60h0uyEFXaREU3np3ECNbip0ZEKAYODiY=;
        b=YK1tSTHvmpYUgpbulpjy/9XEPOLC9DqY+jAa/21UXy4UHKPYuCiHxshByGAedUpS7Q
         khNwWQsezKMnpw2TFcuc+5gipu2ry0A+icFM65cDG79dfxVJNNe8LHWX1iMqZx43F2dy
         j4uWDpr4WT4Jm7+nmqONqBsylHa3HrV9p6TcO5077w2xn3vQZroqQ3W2iOLOvvOkcmyi
         jkQhDFjeUTSpdKOheBfI64VztofKsxrCJfNxlb3o0Lm0D/B6UloPDhevMElXgYI81hJx
         25GwKYl5caZcVdvA/rK7efGxVHish9K9NtE6o/JvMfuELYFBBFtY4NYDRVKBJT3qDmpa
         LlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722082496; x=1722687296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXRD4T8Sdv60h0uyEFXaREU3np3ECNbip0ZEKAYODiY=;
        b=TaoudYD1w1nNMydt4r96uhUzvN8iEkzKHkhyEkQRwvGWRo+DACyP39SipLx9U14256
         kJREf7p1qRwTLKZNNnT38YRCSmtS0J8nYQyuAWgUnusz1f23CTzaYDb/UMG6EI8bDlfp
         xp7rTPhJwmY9bhE4d6MTqOPgvhxs1ay0orSoG2E8G3WpQXbKG/k4iGLKdnyAwNjsMmf1
         i6bbSCKQ0qjfk4hmTIVXsxAP9n89i1WimcGj/iOKVuDTIsCZBr98yD8P1NTw/M7tD2+5
         Y6b1rSwEbAIUpKRvlCQ7SFyOdSdsAmoRtWCXxuj9gaHi/o8/n66jm8oYAgT4zRtOjqaw
         ycvw==
X-Forwarded-Encrypted: i=1; AJvYcCUVfQTZSZeNtt9YHkt7NrFn0QRwN1vTIAnkBYK/oe+sMcTWtR7XUZSSYrZqPZzOUaizL2qRJDD4HKOhtpQZMUWJYLqobo+rmmNwjA==
X-Gm-Message-State: AOJu0YxK+Hq4ujeGgj/BFSvay7WUwjEHj2el6BiVGqAkfjr4ufT+UuP3
	h9WdF9BvPDvRok3WCbSPTmuTDV4WU5b3njKx6+sET/mhGRNfxuxw
X-Google-Smtp-Source: AGHT+IER/q48nsm2HXaWn1x7wbcIBLaFCPE9pn0FAuXkO7Bu1saORaSRwYXlWLaLbIV0bcZFhQUgbg==
X-Received: by 2002:a05:6402:4303:b0:5a2:8c11:7e05 with SMTP id 4fb4d7f45d1cf-5b020102e6emr1627536a12.6.1722082495704;
        Sat, 27 Jul 2024 05:14:55 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e73sm3005180a12.35.2024.07.27.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:14:55 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	John Crispin <john@phrozen.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7981: add UART controllers
Date: Sat, 27 Jul 2024 14:14:47 +0200
Message-Id: <20240727121447.1016-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240727121447.1016-1-zajec5@gmail.com>
References: <20240727121447.1016-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 has three on-SoC UART controllers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index b096009ef99c..5cbea9cd411f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,6 +94,39 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		serial@11002000 {
+			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x100>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&infracfg CLK_INFRA_UART0_SEL>,
+				 <&infracfg CLK_INFRA_UART0_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		serial@11003000 {
+			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x100>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&infracfg CLK_INFRA_UART1_SEL>,
+				 <&infracfg CLK_INFRA_UART1_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		serial@11004000 {
+			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x100>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&infracfg CLK_INFRA_UART2_SEL>,
+				 <&infracfg CLK_INFRA_UART2_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
 		i2c@11007000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11007000 0 0x1000>,
-- 
2.35.3

