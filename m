Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E02DAFCE
	for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925495; cv=none; b=LmHG4ynXzdNbNQfL8DlpZbABXsDSkmxY+JyPa1Ty6lSMMR2/DM+HsiS+bEJg6DuFhvkfZGla8R2CzItVi3r9Vm3UrOMEYashe6U0VLtUAkFM+tjeoBSQSBRUKd1feXUuuekKPJ8AkL9L7NKKZ6RyhcUGEhwoWaviLV2PqnuYDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925495; c=relaxed/simple;
	bh=CtH8XQtPGXolbBZdVmqnACGN9ZTA/rgd8EyPJEQl8lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kohhohEwVvjmlK26kBjgdMQiTB9n+YeWIZlGUjf4bd5RFnDlmWFp/WerriYN9dd55X23w+HjcgAwW/MoSR+VTG+dTlPrizqeQ++ZGB//Z/bdrfq8jRzCzcEBw7S4MGQ3OHKVdIygSiK4VJwEsqatxjG1YrtOqZBo/eAgolzEP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4MZSGjr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4MZSGjr"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af925cbd73aso858059066b.1
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925491; x=1755530291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fng68D5ON4MtHXF/Xvnv7dtbGS53hmAqmZqCopjU5kA=;
        b=N4MZSGjrTHK1RyGCBMZEtLB+TkRTLLTvEuDZ75qEdazrdweMnCKR8CPiv8esZvZjmk
         4zP7hbEluUgfCcEjSg6lZoxaN8ZQxfaNKxMDQgGXw0pdDwxe3q1BGlDwNkx17JHQ3WAy
         6pm7gxigwRaDt0JAI3gcndlpQrQ7qvo64D4bHylJcFlncG5lXCQtChA2/BcDu1TqMbpt
         QqzDikoA3aBMFUIx9Wk5HKv6J0U+4/+LUZGiZAPuoZxbivzavar7MQZwQDW/pH0cqfK0
         OtJciwIOQC/mq8gPqK7x8AaIRhiEkV2AiNSWzhjmD4jzayYVaOUrysGHN6aUN8n9omGb
         i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925491; x=1755530291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fng68D5ON4MtHXF/Xvnv7dtbGS53hmAqmZqCopjU5kA=;
        b=I/fcoqfTLdV9JD58RnQUWV+ywT1l3PqtekvV02OcqjeqJSCCus6qArdGrbwZ8EnqnF
         e8Zh1G7jlzfRgD4kYaD3as+Jc4zvaURISe8ftRbJsFewb2KE3M+qHJacO4seexOgxhD/
         uTcriQz/0JlqjzQ/cz0aRGEBmWfBgnZRbLmiMkTMl54nC2Wy2j8ODcSEAVKmkwg3nIPZ
         yaUUsH8wWSCkyJS50i3vGmSTLIsxtqj0WSj08ZruBCtCdNJ/15SWNGNu9ajPZaZrgFWy
         TJqRgT+18uGC+0B6tYc+7wRj7UnStkcMHssZZdlaR+VAtyIXkBSAyFFBoNmziIp30oVt
         UpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMERBnWrpXpq0rV4sCOwXBFm0PbwPnQJu1Bt4v3SDm1oB9RQbnKH6w9lXv9A7BdWXs0KVXiob756PL9TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9qQNdcGW92K22VZCXuFzm1QiYepnsX39S10YM82HkktTSLNY
	v2IUurAPF3UPKn0vF4bFTAg4mU9RwUNtzdFiHZNS17sCtg0mpOBc9vD8qSOeslezmOw=
X-Gm-Gg: ASbGncsCQfn0YwTobHvWdS5V6CgpovcB40yrlpwICkWp+mKFxU8OZUr8LGnZG+2cA8P
	gJEUgqsPyff/i6IeyV+UJWBMq1L+lp31/BKQY4tMtGsdf8JonAMMc7St8ICi9AcRLTDEMLGcx9K
	QxMeed3stbP8Mn1Mle/a5obPQeSt4dGAfw0NmjzBO6MUMTLWM1uHd9q38yuco22MAvP+Y/rOVaN
	pKfihgKurY251ATbGi3u9weMI0Di0KTE1gQWMDouheoZC6y9g1QhwtW99U4xvdp3qj21t8+6yYq
	DeS3D+iXkeoftmIzfbE2q3n2jJw7/wui/5XgGmZrPvuTgdPV3tw4oH0/Bdn2oMm29tX68cAhOsx
	/IjuhbSVSDkuNaOrr3rwhG9LG10WEQmjZcUCwazS58O+zbBE5ImKtoOjeOs2Rhn8QsA==
X-Google-Smtp-Source: AGHT+IH258sr5DlmoIs2dXrt8URBUrKXF/WgpLPedlCY2bJF2kB5AZhyPhcJHZNSotah9gafIa5oGA==
X-Received: by 2002:a17:906:3687:b0:afa:97:55e9 with SMTP id a640c23a62f3a-afa00975734mr328441966b.36.1754925491486;
        Mon, 11 Aug 2025 08:18:11 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21ac0asm2033507666b.99.2025.08.11.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:11 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 6/6] arm64: dts: broadcom: bcm2712: Add UARTA controller node
Date: Mon, 11 Aug 2025 17:19:50 +0200
Message-ID: <c61b830b6f8f691aec9607b4707d3146bbd2ee84.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ivan T. Ivanov" <iivanov@suse.de>

On RPi5 device Bluetooth chips is connected to UARTA
port. Add Bluetooth chips and related pin definitions.

With this and firmware already provided by distributions,
at least on openSUSE Tumbleweed, this is sufficient to make
Bluetooth operational on RPi5 \o/.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 42 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 10 +++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 411b58c1dddf..04738bf281eb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -81,6 +81,11 @@ wl_on_reg: wl-on-reg {
 };
 
 &pinctrl {
+	bt_shutdown_default: bt-shutdown-default-state {
+		function = "gpio";
+		pins = "gpio29";
+	};
+
 	emmc_sd_default: emmc-sd-default-state {
 		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
 		bias-pull-up;
@@ -110,6 +115,29 @@ dat-pins {
 		};
 	};
 
+	uarta_24_default: uarta-24-default-state {
+		rts-pins {
+			function = "uart0";
+			pins = "gpio24";
+			bias-disable;
+		};
+		cts-pins {
+			function = "uart0";
+			pins = "gpio25";
+			bias-pull-up;
+		};
+		txd-pins {
+			function = "uart0";
+			pins = "gpio26";
+			bias-disable;
+		};
+		rxd-pins {
+			function = "uart0";
+			pins = "gpio27";
+			bias-pull-up;
+		};
+	};
+
 	wl_on_default: wl-on-default-state {
 		function = "gpio";
 		pins = "gpio28";
@@ -188,6 +216,20 @@ power: power {
 	};
 };
 
+/* uarta communicates with the BT module */
+&uarta {
+	uart-has-rtscts;
+	pinctrl-0 = <&uarta_24_default &bt_shutdown_default>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gio 29 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &hvs {
 	clocks = <&firmware_clocks 4>, <&firmware_clocks 16>;
 	clock-names = "core", "disp";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 871537366e96..1ed26a211ed5 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -260,6 +260,16 @@ gio: gpio@7d508500 {
 			brcm,gpio-bank-widths = <32 22>;
 		};
 
+		uarta: serial@7d50c000 {
+			compatible = "brcm,bcm7271-uart";
+			reg = <0x7d50c000 0x20>;
+			reg-names = "uart";
+			clock-frequency = <96000000>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart";
+			status = "disabled";
+		};
+
 		pinctrl_aon: pinctrl@7d510700 {
 			compatible = "brcm,bcm2712c0-aon-pinctrl";
 			reg = <0x7d510700 0x20>;
-- 
2.35.3

