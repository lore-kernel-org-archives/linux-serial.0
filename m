Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792599162;
	b=z3d09rwzVG485tKmvelN5188KPf4LyFLpRIvLxew9Y6ltX28PxH4d31p+2a55ltMwIJl
	 Gx2PRrdlGVdGOGNHQSygfZNrmYKAkapP4YBThhfA9ZeiUXxutWyiZABSHbQRZDpmkdJeP
	 YYbqnKW6lVc/QmUniQ4aUIUCLw+8EJVaaIu4fgCVJDDfWPv10B9Cl87Z3FAycJ5buFXRh
	 bN7DPiEkFyfpNLlnfFLIxF7RXUUv8doUwD430c6F/+S7mirV4y00VoHLwEGrKKThqQMTY
	 iJhdJ8f/RKWnimYcNrj5G9hR9bzdzkSNGGezwZC1DrFPu6VMEHdDMSohdsvifBzIrEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599162;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	b=0K5zibxGu5yuS9vO9aqSkSpRfei1uW6fWXwkXlU83oVj3Qo90H3eRlcDavX6QT92pwII
	 OViuyD5RUAGROl+05ngPGWGRbAnhar7H2Kmz0ra9FKEIl2wqQgCubjeLZVXSaoAERYeTe
	 DOpUmP68X63ak7bbGG+ua4jT9SBR5uDur1kczBuFsH6/K3ZjvxbMBjGUZL4w8A6GbLm5/
	 hvjcm5mTkoxBx+I70el4D6WglJro0KXoFd6QP9SMjvk7WZaY9QO3TaPZTKFQsAhrnQjrI
	 YHT37s6OJS+09RIgAQu6xFXPRled+UKSKjCVfZSU9EdLl0nlj9kyBKkXcemZLon2A4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S0/pHd6L";
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24052606B6D6;
	Wed, 21 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0/pHd6L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599161;
	b=msNNkdK9l8BXqUAYx+aPSFHZg8TA5968H+LcKnyMqSN/cunNwpf7jiy2AoXg50wyuMJP
	 b1ok1kL4ikLrz89lXge2Kd10jcs4N5rJ6cXctGvi/ZjJ6DJQzf7a1aWP4/xEWos/D/wGz
	 NUuma6nuEyJOsGB0vrvE1ZeSOzYwGVYLHhKIBTywETc8HryY7w7gp/eMcq+mh0Tc/psm1
	 kNDFx42FfwfH8e1D5GWge89sXqOUtsQABzsYV8AafMCMZBlIsF7hzWTOk5OMST6u4avBK
	 t+tSLy/eu//7+nw0GQj64Mhhwubc5t+EYSUOKHp4snPMZm6J8vPjfWpJiSR3y5Hvelw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	b=ZC07pfC0NScJ7LmI8OrLYVmvZ2OAOzSnt0Lb5NVoroL75v9pE+7WPvU8krU+zmZyMx7V
	 W1F2kT5uawS+FP23lF6TuwRVotbsLmjWJ9zOLsc7BwV2rcS7hcyL48LMFglVJUVk1Ein3
	 J9E7p4WdgCTUhwAKfucifpgofOSulaVoRhV6suKZNsIJuM1aBOptcaJLp/tCMTTgvrxH9
	 UEUSILOmDk+/wSK68GV6Sdp9tUxT8krF+zoNMPDjXam1PXMJd3RnkZ+n51hnzW67vfKIO
	 TfbhCowhfoXmcvvKHkQCN5ScuF5LRrFtAHkAh1RGxwK2hWktBVqf9JyU5hHUj1hPhsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4616A1F000D3;
	Wed, 21 Oct 2026 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599161;
	bh=1LyLY75raFOWC8g1ja1YF1K6rlijG5R5FhPw46PdyQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=S0/pHd6LQFhhAiaaYoUlhn7+qfFJuwD5FLVCDl1QzU8cfoQHWkJeKGhfqXx7Al73D
	 YeR8o7k0sqSj8f07AEz0xNcGtvkaTKukulhLeTMuGl58muk4YxtkOvuBO48VeqDy4g
	 KnC0ct37qUB+rknjI5l2cg+CaIZIK14NBq5xvCxxXlbB7aR0KcqHalU38HsOEjQLMK
	 RNNS5SeFhQyrowAtNty8SGHZGHFLkMLDUTULRH7tEGRwPUzdvXFopdRirJ0vw8d/WI
	 1P9IzlPZbe+bc7w1ej/D930oaDbBJGijQcKiedLmVucDxrABQyck5IcVvO05OGSApU
	 bvFNxViY/hN3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 909D8433E2;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:14 +0800
Subject: [PATCH 17/27] thermal: rockchip: Add RK3572 support
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-add-board-ok3572-c-v1-17-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1769;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=bsK0j/Qm4dk7H1oLoynYDwdzYp8Fxzpx4vhiNIJc70k=;
 b=zSifOOwVDgw+1IA6DzQ0rBwBBT12H+BJr7PpG/+IJVMwXpPRo1f/M3ZA9vr1XX6ULo4oCUoWO
 htWNcBJy35GB6shfe9XoMRDAnZ4oeBNwoMvR1t00Hfl/yQBkGRA3ggI
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Support all five RK3572 thermal sensor channels.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/thermal/rockchip_thermal.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 08891608baa6..745aad53beba 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1303,6 +1303,31 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3572_tsadc_data = {
+	/* center, gpu_npu, ddr, little_core, big_core */
+	.chn_offset = 0,
+	.chn_num = 5,
+	.grf_required = false,
+	.tshut_mode = TSHUT_MODE_GPIO,
+	.tshut_polarity = TSHUT_LOW_ACTIVE,
+	.tshut_temp = 95000,
+	.initialize = rk_tsadcv8_initialize,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv4_tshut_mode,
+	.get_trim_code = rk_tsadcv2_get_trim_code,
+	.trim_slope = 923,
+	.table = {
+		.id = rk3588_code_table,
+		.length = ARRAY_SIZE(rk3588_code_table),
+		.data_mask = TSADCV4_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
 	/* top, big_core, little_core, ddr, npu, gpu */
 	.chn_offset = 0,
@@ -1388,6 +1413,9 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.data = (void *)&rk3568_tsadc_data,
 	},
 	{
+		.compatible = "rockchip,rk3572-tsadc",
+		.data = &rk3572_tsadc_data,
+	}, {
 		.compatible = "rockchip,rk3576-tsadc",
 		.data = (void *)&rk3576_tsadc_data,
 	},

-- 
2.34.1


