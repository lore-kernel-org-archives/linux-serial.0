Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599160;
	b=lvGoHtMA5Z4l49RGIEy/66cw/Kt3IdNO3QTsIX4HBNFIoSbGvGeV1M1Nsnbthw7gbYUJ
	 XBsMnuvw8J3nitNVWBg+qcu20FRZku1mVY9jtTam22zuJIqrPfiD7399Q70crhsVDhFVf
	 w3XBWmynr1aZCFVxTCdwVrawFHXtpsRFH89PGqx3z1+0nQnMV8JGTgGv9EqGr4b95snWx
	 Iwp5crhX++ib7b7cjewpRpZ4f3pHjxRACU60JdFzgR3xfQItlFCtGyWMdjhddUjAyMc1w
	 tu3gsvdBIusya96/u/vCQXn0F0pbA4+1HNX0TEBBlGuKO//+nDDY5J5KMzg7vDHhcKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599160;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	b=cELk/+DNGINcwnLLa6VgyTbZ43UV83e+hWpiYKALLp5+ibRuevlSTCvSyx7PprEa2qDx
	 svJKN4PUGbJyx13/Q+MqHkFpHPxQ5hYRJx4jATcneBhD6XEvVj86+kWpyzkP+c8mtvhlx
	 73L5WMUi62YkIuEnmxdd8/HMGa2UFC26zmUZv2BYBq5DNu48f/hLSN+EPTTZ/Fr2fk5vm
	 RXLG+uDbOI0gz3NvdaLMklyBmIRWbpJEjp1od1XsWgC+YzoO0rWrX77gfmfYwtAqy6S3v
	 A89ZOLvTNXz48C9T4cdjpnyRvXPU/eiDOq4l0wb105vfTb1WxEJxU97iwaDjkN4TfxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqsqFBzA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C57606A561;
	Wed, 21 Oct 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqsqFBzA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599160;
	b=aJB1CcR4YihJLiFRofoXk9pW+ph9v3Xdq1U2CSvTm0Wlym9+rS85SXBgs3mq1R/L0oVm
	 UBIn10IsjgbLWiH2iOD5XB+eP8ceRLNEQTjCC/Olzt0INulgg2h8Kc8JHzJlHRYPaW7Wn
	 jni6rg2qmZbwUdMW0i6Auhw0HxQW7JrLpPtvIkY5NSwQX1wNiB0Y2ZCML040A6mLxOEr1
	 DGZZiikIuaqNIm1wox1znb3xwpv8vVyATrxCpjjENxR2FauchoCq1Ivr6ZxmHFSQ2fYFl
	 tKaDAzXFg1030hhPt2ffhJdX9xF0tZFjma/Y5Mf1lsHPqqoLMfL/ISc4WSohv3j3LFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599160;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	b=MuardiJz008pmTT9nOTAvIGgw1P/2C//QjaavsW+V/8auqmjmTgoSqo95kaZvWKeF+8R
	 NimQKatomgHmoAgf4uBy9Uysgoxm6ldo4/MwgyOHFtUdhhLfffjqrpn+75jz5edu1EbPh
	 OaQkLZe+DiV1TWkN+7u3kZp3U7xp2zcAtYJApATj+0vWC7fBIHq5EYFOJXEGXnz7U9bjN
	 e+TpZQJj1bFfrJPq7HGb7xPsQtbfORDaATnYPPzab99qAjLCTFfbKkrs5h2Mm7VRvu73b
	 7EAcnXxHiwO9g8VfvWFSOYqnRnxtpsovejwyhhUJaqWQxqaKAMxfoAQu36IczxgPf+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C76D71F0157E;
	Wed, 21 Oct 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599160;
	bh=HkfHwPyLmt0lyg8sxRRrXUSzNOY48bkzXVEumriQRkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SqsqFBzAis7J7y3fEe4JqIduRBFOdaL4XymU0zAU4MJ98oGCM1PZBOM/7N8divLV+
	 DfQSGn4mfI8qLhtbPiAe5cX3Nea4mhIMsTKx+ueVgumbFMsdOvSJd2kYRlLI8O9m/3
	 wQOgh4Vt37/lwvhc6mh5TsnVVFMaT68qBomakIhQ0QwokEfLollAQIXOoboqahtCWK
	 InR4TluPtYfzP1EeA/mCCqx9Qfthjo8IwiWadoNZYMM4LW+SS7jv0v5Y9ronazn9Xi
	 md99vjqCyeGDVudU7P81a7oPo0UDpFQ5cl1y1o36c59XkAnW/ysu+NHSyE/ugN8M2f
	 gmVDhmDhhRU4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 64558433CD;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:09 +0800
Subject: [PATCH 12/27] dt-bindings: serial: snps-dw-apb-uart: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=863;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=D1FXViPVwujIOTT9x4HkdtazDzg/Nd0v50dhD62lfCw=;
 b=bXyhxcCQAaxGkzUkidwaNd9WBOseIQ1bn1C/gLwHjeftMUjLXEIu+l0mtI8wNJbpQezhprCb9
 eiCgnJoV0jgBq1kJsV9P1ps6h5idPRU5RDnkGRCmnonnKH3T6X+xldJ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 UART compatible using the Synopsys fallback.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..4567f8e76c9f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -70,6 +70,7 @@ properties:
               - rockchip,rk3528-uart
               - rockchip,rk3562-uart
               - rockchip,rk3568-uart
+              - rockchip,rk3572-uart
               - rockchip,rk3576-uart
               - rockchip,rk3588-uart
               - rockchip,rv1103b-uart

-- 
2.34.1


