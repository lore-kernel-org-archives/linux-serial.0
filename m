Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DD1E47B8
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060343; cv=none; b=Grrq4axuPC6gGyx28GoMYwX03Lv68W+pSVA3Zf+NyYnBIDAfWPbdyORGsqqb215iy7qKPRKg0ZRvX10aFLOTKltcJmmuyIRSAZtRIhx/TeY1Dvpf7WJ5knwVxdbnWNl8NRjbke+INf19IRZn7hGrikX9cQ037rkpSsXh3phL560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060343; c=relaxed/simple;
	bh=2I3QYGgD+fQ78laCU7YBzXYtfRiP/TAEmsHKexsSybI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7n3oytQdTo3tfZKaqVfp6Fsruy4E9viLfIoELXkpRAMmpAkZmGWEmVJd2zObQUiar4BoPOjGjMQ1FdGoVBhxlwf/axY517u8vr4ofwpP7t3oZdH1kCdroAjrpHt+ac7HjQ4yBS4juz6yL21s6Lj5e7guoDrCGoniG+ZQUGkZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SGKaUYWX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SGKaUYWX"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso5277109a12.0
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 02:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060340; x=1731665140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYxgBdR3L0zZjTE6Q2Xo+f56VcHJlv6CSX9bi7CoE5s=;
        b=SGKaUYWX3E5Z5NKJx6rNFdmtyCME62h8Tri5XYBQh5CiXJqc0Dvy1fNz5K0aDqYpER
         6dVPwKLfrGZ1/nhQ3kwZBF5nzaF3ncTVUlcZ1JIuODR8im6cYOn6EdZtnSYu1tm/KhQt
         ho8VSEeMfhkQojum+k1XUNY8L7adg0Zd5pATXt2Yc1fg1vk+TXpDL0SB1D5Ruew1XmHE
         8R4r0oQiKTzRwnxFx3Z+7DyYbZe845f3mH9AUFSnsqYVNlQGxFZdoVC0gfCRcdZvYM9k
         YKn22grrMOnidCJ/je23Nx34z+WerDTpyg1WHNRc6oq+/XWnLlyPgZpx/8HSFPH+86U7
         TCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060340; x=1731665140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYxgBdR3L0zZjTE6Q2Xo+f56VcHJlv6CSX9bi7CoE5s=;
        b=vieqV2DCc5MRdco/44vT2aqFJarp8lCe+Y8euyxqU355e/UPkVTyumwq2UBTwsqILg
         HtDXPudVzPEs0qYeIzA/vf5h8DzAKYrt1eO4OOUZsp76RxQd5Ef3TfnskdExRDmwhGd2
         TLSQt6DyJM+Gz+3HHVhsFJSBMQumCw2mzJLrQTGAOuVk5txIR1h8/z8+lj4/7TB/g0Vz
         KDOo/orM79R/llW/iMYhAYAEplbD+BjhD4UzQEPYuIm8oJ7rhfEP/O2aGa1YIj2J5Mwd
         ZcBAs9YW2BRmcH1iT08vdQO7UeszRwjzW23K80Ox9uNSFgOuZWsbt8o1YuAuqpJrqLGq
         1KuA==
X-Forwarded-Encrypted: i=1; AJvYcCXbzAG7YMwyukrTsDa4eMZKjObG4rR6q8Vmu/W1XjCg61yYzFXw9GYBvVt2GUVW1nzp9XvzS3aQ3RJGwX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+vnarMr4n2IsnWrpkx3jyJ6u/GzyzLkQgtjwjlcaw0YyMx8z
	jcWOjSpZDd870rivaMqnFNXG/TZcF9YZKd2BzmYoZfFpP7pyoW0KSHc+fcatFJ0=
X-Google-Smtp-Source: AGHT+IE7N7pylKiTXaEOCIxixMFZUU7WhiCw4v1X0VOaK6v6PAdm72v+9Seyb/j9PC7MrQVlSHFH2A==
X-Received: by 2002:a05:6402:4021:b0:5cf:1214:8146 with SMTP id 4fb4d7f45d1cf-5cf12148226mr1044954a12.4.1731060340387;
        Fri, 08 Nov 2024 02:05:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Fri,  8 Nov 2024 12:05:12 +0200
Message-Id: <20241108100513.2814957-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable SCIF3. It is routed on the RZ SMARC Carrier II board on SER1_UART
interface.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 33b9873b225a..1be21ece131e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -9,9 +9,14 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+#include "rzg3s-smarc-switches.h"
+
 / {
 	aliases {
 		i2c0 = &i2c0;
+#if SW_CONFIG3 == SW_ON
+		serial1 = &scif3;
+#endif
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -102,6 +107,11 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
 
+	scif3_pins: scif3 {
+		pinmux = <RZG2L_PORT_PINMUX(17, 2, 7)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(17, 3, 7)>; /* TXD */
+	};
+
 	sdhi1_pins: sd1 {
 		data {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -141,6 +151,14 @@ &scif0 {
 	status = "okay";
 };
 
+#if SW_CONFIG3 == SW_ON
+&scif3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif3_pins>;
+	status = "okay";
+};
+#endif
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.39.2

