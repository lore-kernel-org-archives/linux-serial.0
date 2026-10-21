Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599147;
	b=aIVN+Pnl+UOFjo8ENPJIIjdXz5mQvB2HK/HRnycku5gnLX2/f/hNcNbmZkWFo+zbt0LI
	 eFwTgQ2oed2Db1Qy8aOXYPPonMPhquqUgfjMVCyFpbWHRrLESNwcji0e2ryfzB4AuDiN4
	 uVawuTLUs8reJzqFjYEkliNi66TaDof6yeWMBuxAENtlRe9zrzG5EirZo7b2DnRxZ+ttT
	 Cd68r4jX92/4QrRYDBj1XuAMSu81vy+DUDAU/xgt0e2ZFH55mU9F8KLsR70Wi8zXvbBil
	 3rsRpuZ6I06qRnQf5q94SPrE/A0rLbuXvnctMeEQx7AwLKhELroM4vKRIDpCs4APcPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599147;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	b=IeVjXgAbgpxUoJmm6v/AJE9wOOmSKLzr/Liiao418djYKFfTqo2QqUTsBG8EkhnWcmai
	 h9oP0hLnuDBlQ4I8xas64ZtuRULmdKSxFNWcy6vOM1ew/jCAfKWQG1WIDKgduRDsCy6m3
	 /rd4fr0OiAmYWottHgFQWrXUVXQo1/68KwcBsXphmpHCrQtgM2PtTVkoJXtmN8gtN+HOe
	 UbFHEhCgnn/bNkO4VdvgLkLIo8PpSdbaWGmbdJjRhNQtlW7qVsrlZDLgM6F42jmIwx1sH
	 sf1TmCLIXXaUQUoNwhCD+CQTtujnU1Pm3b4xzrTPRBk402hcusyNOiEEIzwqWWQ0lcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6c9RIWI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AC606A32D;
	Wed, 21 Oct 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6c9RIWI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599147;
	b=QnRW+pjVI+hMNnTw9osDHw1HT3dxIXgVxJwIZYP57S1B3Ex7cOSIULKpS8lEPhh4lXXn
	 ftiv39Ltu4h39L28hAHmF/s//hRBuLJ56LOanVwVkK3cYxHL0smqh6MRp9zGoBIrR116k
	 +8afuzGgwXiRJl6qW5Srvmt/aGpWc4drF6+S4chibRyfZfptKnbNrmvM+fZVSMlB3SOi7
	 tU3grvEgTliIft7dzDkXZAYrV8/NnQJnqzMHknDLnmdmADKpNIsde5oaZSBeX9x2EcWme
	 OglUh0+06ktJcmDtTRfEkbi62mRQ5nd2uk+FB3NNBRmpx13gEFxki1wQEiXVVp8+fsQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599147;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	b=SixPmX/fP/a5w+NBvUnqhnTAgOgs66whMS9P53XHT96ujHuCGIuV1PbvvNLBAbaoSEp6
	 AKkmCjbtNKv7zJ8Z1CviWcf16ILxpwX7i6+RsAX0NhoqdxWoJ3GqElCxg7eWZ6Vvj2ste
	 C3yhSy5VPAwRce5BYyHj7gXh7oDfPeT+J9gEmLrU2UrvdiXgEii60MPRBWOBcI77EvoeS
	 yPbXcrD9yfdZpvApBciFod9HCI/mMK9aEhMh+M0xPsL6jr3OrtQpF3aMyUdjxqY8sJiSt
	 QdFX1uTWEemnQaeOws1YZXJ4dtX9ffuY0fnpb18TYAhGwWpFMTx8xDjI+i+klv00SsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6D9E1F000C5;
	Wed, 21 Oct 2026 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599147;
	bh=fTncLPPGPohuW14GIbjnE8CrQrINNX7MPVns5vfiTYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=G6c9RIWIQCStjBWnM4azJqBitIGY6GjxLfuPumIkZjGLU33ddLyum7gHgjPbtnP/l
	 StK7b/B6RtF3OgniNAhzg5+JHgaU1iWjuKWGC4s7qKyrFfCusmpS870S6pk51uMeGN
	 ZBFWHPnYshqNUVxUYnY0wI181PytWpLIPsLesw/txW6wxduA5D1Q1Y9tyip1quvhC/
	 i/I3JXCwfjnZpvVBKFgg1M9qyYzL4cfihWHYpDnI342CFbFPUEEIF9lI0VQrDcjB8D
	 No+INBAa5Gx8jLSQdN+t0O7PysAbql0O/dIIqbzG4EWjApYD1k388FFsKTO4ekj001
	 qQnWYn2Fm3bgg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0A5A0433A3;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:10:59 +0800
Subject: [PATCH 02/27] dt-bindings: power: rockchip: Add RK3572 power
 domains
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
Message-Id: <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2586;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=XCHXnkhL1K3pqwpZtcnxnK6WkRaV98m9UCg4zRZwm8s=;
 b=MnXYmtt0bh6snlWCojGt8+2eWEY2VDGVIaBGezscAHOMFj3U56kvvBOcA3fufVOxsrbS2Efql
 GOt1v4997hoC5Ss8sbADnheAa9c6n1i1wCUJNZAPpb2L9gi3GrIigbO
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Define the RK3572 power-domain IDs and require the system GRF used to
check firewall status.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
 .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95de..f8afb0fabe809 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -43,6 +43,7 @@ properties:
       - rockchip,rk3528-power-controller
       - rockchip,rk3562-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3572-power-controller
       - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
@@ -57,6 +58,22 @@ properties:
   "#size-cells":
     const: 0
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: System GRF with firewall readiness status.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-power-controller
+    then:
+      required:
+        - rockchip,grf
+    else:
+      properties:
+        rockchip,grf: false
+
 required:
   - compatible
   - "#power-domain-cells"
diff --git a/include/dt-bindings/power/rockchip,rk3572-power-controller.h b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
new file mode 100644
index 0000000000000..c2316fa859df9
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3572-power-controller.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2026 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+#define __DT_BINDINGS_POWER_RK3572_POWER_CONTROLLER_H__
+
+/* VD_NPU */
+#define RK3572_PD_NPU		0
+
+/* VD_GPU */
+#define RK3572_PD_GPU		1
+
+/* VD_LOGIC */
+#define RK3572_PD_NVM0		2
+#define RK3572_PD_NVM1		3
+#define RK3572_PD_DSMC		4
+#define RK3572_PD_PHP		5
+#define RK3572_PD_AUDIO		6
+#define RK3572_PD_IMG		7
+#define RK3572_PD_VDEC		8
+#define RK3572_PD_VI		9
+#define RK3572_PD_VENC		10
+#define RK3572_PD_VO		11
+#define RK3572_PD_VOP		12
+#define RK3572_PD_VOP_PRE	13
+
+#endif

-- 
2.34.1


