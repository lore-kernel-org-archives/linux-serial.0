Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnb3bHV1"
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFFDC1;
	Wed, 22 Nov 2023 06:42:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a02c48a0420so242878466b.2;
        Wed, 22 Nov 2023 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700664173; x=1701268973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/z7cZGo4AH+Kl8ZoU+fwv3avNMZa+bBMOnxsl0hk6s=;
        b=Vnb3bHV1JbdTYXWbsu/s6zo/wqMgMMHR2tKZvwdXhUti/Mcik4WVDa7oMLFVP3biSe
         sZm2hcWMkp8E4d1uDp5Hl9kDxGjrUqoJgGZSYd6H7sXYaeNJmryFqJcOyB0dbHIj2+mF
         Ob8Yl9prjNZWzvMQUkb8GvT62viaiGLmkBSraqG/XC+Cy8W7aRTWPowRxTuK1N3fWSyr
         Or8QAy77PGPh72FuLLNm+evXkVdbFORm6N+S3ConScyOqSFB44aMJVopZsw/CDaUvfQv
         M11axw4z6LeOWFoiYd0t0IEZuuTmO27Zgmezbl7ngWdXis2smPmjhaCcvPNb6sLVLZiz
         pXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664173; x=1701268973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/z7cZGo4AH+Kl8ZoU+fwv3avNMZa+bBMOnxsl0hk6s=;
        b=k8oc1kgeZTGlm8QgJoqOPoph271fQaxkjkOXsZDgwLvdJ6IvnHS0ZsM0D00LVN3L0C
         1gCJ66qERX4wZKvEXP6aVcaa6tS2owHAXMlIlmk5NvPCQ1uxqynrC6/aYXPSpV5lU48T
         G5/iH0I1fQhAImbJ+KojPlBMfhVyxYsKZzfdOpbUMrIXSn96S3A5/l0S0ZEXrd0BPr5Z
         VYF9TF12DF+XVf1l85kWuPtiYLjSU1HsKy8hSF9tpK3ZDIwPKknPsUXR6aGGOdbnDGqk
         hhN6t8Uz4HMplPXIX8j9JsWoB/lWRz5bPd+wruEdcuM3EqFAR+bkgCTvLRWOHzQ+v0se
         vubw==
X-Gm-Message-State: AOJu0YxxLAX+97Zb4uBsVquwqaklPkyrzRXS8Fizl7aoCED6vA3L/2eQ
	waxC4JqU3MRXKAqBRLDu4p0=
X-Google-Smtp-Source: AGHT+IF1aP/JjzO5QLHkDyw0DxwVXFxJ66Wo6X0nSHSrkxOrvZ4EAyRq0kZ8ShpYsGik/R3NH1gCCw==
X-Received: by 2002:a17:906:4096:b0:9de:cfa1:f072 with SMTP id u22-20020a170906409600b009decfa1f072mr1808752ejj.25.1700664172980;
        Wed, 22 Nov 2023 06:42:52 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906349a00b00a0451802b3csm941221ejb.4.2023.11.22.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:42:52 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] ARM: dts: broadcom: Add BCM63138's high speed UART
Date: Wed, 22 Nov 2023 15:42:08 +0100
Message-Id: <20231122144208.21114-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231122144208.21114-1-zajec5@gmail.com>
References: <20231122144208.21114-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

It's designed for hardwiring Bluetooth devices to it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Update "compatible"

 arch/arm/boot/dts/broadcom/bcm63138.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm63138.dtsi b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
index 93281c47c9ba..4ef02283612b 100644
--- a/arch/arm/boot/dts/broadcom/bcm63138.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
@@ -232,6 +232,12 @@ nand_controller: nand-controller@2000 {
 			interrupt-names = "nand";
 		};
 
+		serial@4400 {
+			compatible = "brcm,bcm63138-hs-uart", "brcm,bcmbca-hs-uart";
+			reg = <0x4400 0x1e0>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		bootlut: bootlut@8000 {
 			compatible = "brcm,bcm63138-bootlut";
 			reg = <0x8000 0x50>;
-- 
2.35.3

