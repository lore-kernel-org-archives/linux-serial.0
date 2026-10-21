Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599158;
	b=kD9B7h0JFKNi3nquUhVtb4ZXkZtu0DwYRJvGWpaXfTL/Wn/bYQs/FkKt0+ctHF0U7FUW
	 +9/zZaRhwzGZs3OgUb9JLvWofbg7dhtMwlFmL5lk3gGfYfUH+JrBUIxVhfGZEK6oZQqm0
	 AXKwuNIiSZsQprd2Dl77Apr3IyTa60dsDvvXNb5Mc1e/DouEgkr1VwUeCljnADGNzHmio
	 KtogHJ9c1COjQpH/2Plfjz/OLEK5Dbx0XQtWOHAqBPRzABkDU56cKOCyC6fOlsuRDnJiE
	 Y++PtSyqlu6VBuxIrkUTH/g6H90K+kBM4qygnrfULfzKvDyzHWNIw9QaB98Vt9/VUkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599158;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	b=f7rtq5CNOdtlPF4gu1zjEtDwnvHUJ3Ks66XXXmswhUWkRGOhHXQ+6Kw3Du3VhZtM4E9a
	 aOOo68xNY2rGuYI5sDaObx2At4L859cNdq01EOkiVvGMr1BYnxPO+4WKLiwsKuBCueDT5
	 rRWgojfREYMN29MljD3/6DGn2Ydoxutipcfh4u0r9r1Nni8J7l0Tur11CKtI8E9sFl2ie
	 fpnRK864FFZr4r6HOL7Z/SizJb5L6PwE5DQ7HZu+dv61uZjDivUam227XyAwmgWKD7LOb
	 MwwWEQPsFjmvZbg3JdkKxfgHI0/CI+IrqAo3aO8TaHyeeghMya5zJhOSS9wmLmdIT2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIjuhUnG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F060A4AFC;
	Wed, 21 Oct 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIjuhUnG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599158;
	b=RWuJ76wNARF1uCC9ZXpUdVbeNc8+5x2JWJ44GnGdEFXpO8usPcQq4DUuppNM3CKU6RGB
	 1IU4y88MJiyRETEhtFB7D2tmQQhUMLMPiaPxPIxkKAIa8wTqIZoX7aJXVnwv1fQRHpEYn
	 UY40hRVvM5/AQcsjtQuax6+Hw3yR39UiJie/bIBnWZpOUAv0xxYNgDYiuBeOkut5Jy1z1
	 4Hy/qL8JV4LkeuBj0EbodtSRsHnEzf73VaqALT4UgEPXIavviM3zJDkEV5kRp8mHMc4K8
	 4GYHxHqUP7jn3z2IGknoezdap6XIQiyzQCAA2aH7dFB/xtD7pCOZjeAlLgEv9KgW3gw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599158;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	b=zRfL2kdux9ES4AtZ/Ikm8Wm7A0F4ejrq2DPRfCdJ/USuuG3its+jr6CMJi5ECtRZFYAu
	 Ty4fbjTiJXkTAON5qj2oJlJtHk7zbtuKJXVj+4wHGwVN01ZY6cU0xYOT2rr/gQoMSZRHk
	 SzZzUjxCfkzX2RtDSDOsRrzvF+sluz92QaT8OV3c8+D6NysgSxVekB0oPeg2WhGTPjzqY
	 5zJ3MsmNDJuJICt4qs5OT0MZYdNRnvhcBr2+zZoPUzJ6UVpbgTqaw8JWJezexssJ8QLFj
	 xgqqLx/LrDQRIGQbkhpUYVzm1b+8WFZhLoqU7JFmZNXruE3iIP3LQdVf/vt2AFu6lwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4160A1F000CF;
	Wed, 21 Oct 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599158;
	bh=7wLxM6Jx2TxijdJOdPWYIEJcNEz65qnh7+8neQqm6rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TIjuhUnGJu7KSPXf4GoOkJRfMik9vzokF89dsKGahYFRxeE9UHMKMSHZz1lIFa4R+
	 Pa9ST5n3a2IKjXPzAOV4RmnUumUbzr/uQSRimKM/sx6mePY7VBHLB6qCpgPcipj+GS
	 bn5GOq0EjlRlXsNvwyKnfkqw6vHntA6OZmGxTmljceWDxwzYj2WWBGCKACX0H7hIRS
	 bXJuA3Zq0TNn55PFD1Pg6ogxPQ7Vq26w1fPfWlEVkzQYrdMB65CGhavTM2sSvAIjNQ
	 d7TFuJcPtfdnTV6zxB9fnEw6qBELlg1c/xMAK6/WsWv577fofri1YphAyw+yQKSBQI
	 S43qxhnnNKnlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1CB9E433AB;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:01 +0800
Subject: [PATCH 04/27] dt-bindings: mfd: syscon: Add RK3572 QoS register
 compatible
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
Message-Id: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=787;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=uFfiJe79UHoJUmZUfddULOE/yY4AM8aRwf1OA9QQsAw=;
 b=PQlvImamcct9qYzOV3A6Za7RjEIj1sPanPiyKUAgVT8qOcZLZshqI9eYCroTYs9FppadblViO
 vNmeEdVoB8IAPJdBQj2d2OT1inwdeWPYAeSge7dK06aGkCZlOaxcUEQ
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add rockchip,rk3572-qos to the syscon compatible list.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 945a168b613d..b3c96e1de74f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -118,6 +118,7 @@ properties:
               - rockchip,rk3528-qos
               - rockchip,rk3562-qos
               - rockchip,rk3568-qos
+              - rockchip,rk3572-qos
               - rockchip,rk3576-qos
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos

-- 
2.34.1


