Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599152;
	b=ue4t+sfEdiMm4/5nIHKCPC7TNdkjvWD+UiHoc78yqQWZacQh6mn/1Wwa8eYfzEQEatC0
	 w5qu2i3XxBGCEWRDwucPIyvy8qp9LWIe3Iz5TRh7NxVQSA4phMSEM2zZgG28ALFvWrEzP
	 QpXK6W/kr1rzjiCjNnFCDz/v27niiADZRH8nERVZIE+4nb7EIbnvAfpX77U3RTrxEOWr7
	 whUmF0y4U1rQszW+ghpNwNeFUOEE57r+vEn8iI+wrXYErj9d1OplixQI4hxCtmpDh5whH
	 YmWjuk8Td2RF2/G4SQ1Jyj/9+01jrReOdVbE5fYBhxHs9RmEO6nwkvPigWScnmu8geQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599152;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	b=LP8skPJsZ3yJs87bSvIhUDZXj1MvPk3iMlQPqCq01pLuPEJRmYBOz0S/FEyu/SByst2N
	 UPTFWAGnPZVn335z9VFRCLhiSUR16gpxuBgXm7EVJ1I/00TzfEO34SlRDvsK9YnHqsHY5
	 Ydxme1P1rNlLCDfzDk9g7N5KVePeZL1IhoyyXKzZal5MbFauEw8hnUu0WB/eUgtnUFMIU
	 UgTU9YCs/3snppITmWABEuYWYaN+1IxfDSUpnMTjUmVT6TNtgWCBhQU33SRx7Yy3ICrZB
	 a41zRb5mPS63MZ4SnABdsCAYbnTR5ISi8XsuJoXJ3Gzpwl88rMmW7NYRwQrLn3HETnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bP3BNGy2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD460A3813;
	Wed, 21 Oct 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bP3BNGy2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599151;
	b=rCUN74Vjr4dW44uKKp3d/16gTm090GSATIFMF1mnt/PLJEarNNy11K3CZVnr2PPpJ+og
	 VQgMArjk7hheiu1v4QzWYoxPgsoJzWihcIA6qkb9VLLeLjsd3xjSgKC/nucob1Sriiqcf
	 8TvIp4GNnIsifzoyt8hgAHIhXitcJk4hPS60ccR/RgLDv9uA/a/GwYRzLjvL34JzzVhOm
	 IFWhuCXlIUbb3Zl9bbOcBpriJzg+hkWClzLlneg4PJF2VVY/j/h4yA9lUICbcuCWb7Plt
	 360RI1rl5Chl1TjSED8hUj461hJfWW86OhRKl3+F51hBtMpmx5uaT33ALW1K5lS+ZUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599151;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	b=kYFP9ONJrbf8ihxQbsM/8zOkQonJkxpUmAqzTjxkuS7/fPlH3xNDcMZF0uEa4V2ci4B8
	 90tBNVSxdDTK2Jzdo76PqkycgupaFxDBVgZRWDnm7/i3ZAqFBrQdZpqytHjyWOWXz6WNs
	 h0XU+DPBJsizQxlDRo3jYsw/anjK/VSjzjh+PnCRWlilQ6otje3Ejjg5svzm+k3UXrGHE
	 v6KTUchvq79YiE7zgjYULmeJAh32JX6HJ3kVAEX4wej7g6WEgVp+AGylE1WYOZ/a57wJp
	 XJ+6lJp2Vp4CkZg78uRWsa+bN0Cs1pkO8NVSwY/vwmg8549qCdZER2D3zkAIbW37tYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3447F1F0157D;
	Wed, 21 Oct 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599151;
	bh=9OhtDeWco/qHepZsdYaoSDfBdVEmkEvICiVjHgzAKVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bP3BNGy2K2xKyWUlYpBmDlHYuaRrkrTa7UmSDRnj2IP6SHyiNuTnTj4mHZUF7EQou
	 wR7JSqXWQ/Dzt+QRGjOSKLIS+EyHrkZ0eSMfCpikg8sRD8TfYUbNbhvaoteXPI8k0M
	 SqvztJ7C29Jr9JAUk4/zO8lVvFu7b4q2f/sy2os9t5Z0okLNzUhBNDnAvxPpuCUFek
	 +mh+zjcLPirhi6V4SlHSORacsxxyHUK87dPKIH9TTeIR4AxTZnsnuxdQ/pvdwyEDge
	 sYUgrvrPcwyuXGpqi7u5dPaV3+rt9mB3HQ4XFkJ5ObV/xw0JSOAbwv3lXSBg5SrZ93
	 tMTKRjPz+T5KQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 250A8433AF;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:02 +0800
Subject: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=808;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=7Cwg4wq5+C6jKGQLPpMc9LwBD2h7LAV97O69wvTBPj8=;
 b=EF4whsGfJl4BJ74dJFmiD0OLdXtnmpjaJdIa5SjqcpJ1E5QnilqIGFxGptEjeUZVlzPmMEbVw
 ox/BKH2IxLdDM2nkeGE4jgZCgSye/1RSrtxMlFnb3A+fVMODRy/G6Ux
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 pinctrl compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 81747bb53056..cbecabd8e307 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -48,6 +48,7 @@ properties:
       - rockchip,rk3528-pinctrl
       - rockchip,rk3562-pinctrl
       - rockchip,rk3568-pinctrl
+      - rockchip,rk3572-pinctrl
       - rockchip,rk3576-pinctrl
       - rockchip,rk3588-pinctrl
       - rockchip,rv1103b-pinctrl

-- 
2.34.1


