Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648714;
	b=wtC2eyFG9vC8Gl3fQ7dZUsV9H04/rWkUhrTObj8geV6MsKOrXjkANpjL45Rj2pTHfFnq
	 +H8M3aH+Nl+ft73tuWIQY5lf2YdT8C7eTxW080WyqCS36TiyznfmU423mdWpM6Xz0yO8i
	 5NigjD9upLQiEPsvent7Lc7WSAYvDGFBmMDolRoVwv2qZ+A3b24HI4RjipEU6KCT+1to/
	 NCCLWvJ+PFVnpF9tnIw2+sRkKAzlqHOnGYemgaFzBKqy1kg/avCGbi3bWuHGQuWB26bvj
	 YcTV/9DUj4cAl6JvdCwmRKMImUUFIJ7x4bU7nslsxB3ztOTmcXZoTElZMPp/0lJRndA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648714;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VMZZaYjxAsNk+aIsMMw7wg9+anqipnDz8dl+A17D+zw=;
	b=m/l6gp6RgJVpi6AlNc8hU1TR0STeIWljgeulyooz/cdYeBNUo3b/ZfxMjCbz+E+sjfiA
	 vr78pwFid/rewe3B8cVdDRPEAxKUnbyeYrBp4kFBA9q+QrUCxLCIp9v1s0GYsNe1TEhjF
	 7wTLTINmc2ktIvbhoh+0dNUJ4ZCSqnNuPbUaHSgzfAqyZlQInniXkKVVaTivO/9BdFEGR
	 Uq/fPeR/WVxpXirOuFVpq72IIQ/egRO3XzmyJYLCLFLXieLr1HESNO3u6PNl1uXuWm69z
	 kl2IuzzXDD7A6Zcn4W/LGb0Ixai3/Z7I4svVB/Sme5Ylocuolv2V5E8Q+H9vruQNdbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWxt7RJR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939B606A327;
	Mon,  2 Nov 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWxt7RJR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648713;
	b=FtS+ZscDcPTK7+GQqaKYhIU1n8vHpNR+05JgRf4Atri2inuyvavYCwD+GU+DMkd0ET4l
	 TtwG6tFKi+wFJRiTZQ3jPLx7Lo//0dnxd6x2KVxftTM/zf+6dBBmvxj+GWord6LG6lv91
	 mzJ1E5fppWs+RWX5+x5jogVgXZNqzL8tQisXzJERG4FCXYYYjWUILRz3OM9FkiOaxHn2c
	 OIuL5ft3KO/dj8AT21S37VDCa0xH2eePqVDAXxtjz2cfdFeR/kKxd5GIfVz3dr5nds9+e
	 /AnI/6Z3eL3c7lmconAAlpS9XA7Pqhfq8MyI+MOI0F5xY90pWX4Eg9Oxzyaw1IrHPCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648713;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VMZZaYjxAsNk+aIsMMw7wg9+anqipnDz8dl+A17D+zw=;
	b=zYGEyIV8kqanvXyAIIbj+EvVl47tHsTWbky5BjmDaRgAbcVfPpHkSCaEzBHvC6nylDY3
	 6yac3Q5d+Rh+aHBeDG0tK4L6Uy4p6Rcb4KUjWuaVplr40i2W6KLOZyGmkujs1DtYZ+RzV
	 fX83YnuFWgCKnkf4z3Jj5cT/ZPSV6rTqTFWQspihbaC2v+XGJGyYuszCkdXAgjd2rALTH
	 A7AblFGAlmi7OHr0sqLE/KLSTBhVo9RpcdJGch407Bp/dOHweUErgNJ+fc2LMCDM9O6qH
	 vcwlgSZYLOHyWKSdvkotiyGdDksgrTHHxlseNw21yqo2FpH0ipE1Xjv9pbwENxICyQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4218E1F00AD9;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648713;
	bh=VMZZaYjxAsNk+aIsMMw7wg9+anqipnDz8dl+A17D+zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BWxt7RJR5Cjo6U1odBa6mLZ38YxBnIEWYC1RYGHLXPDkpcplakOhlBlTmkM/X2NXO
	 wNRiZ8tW6qPKa2NzWMdeNOALg7qRHBw70hmvnF2Om8E+jBzZGGvC0mf9phJnuWSZbb
	 ATfwyKIpx0zWR5ekycRq5ydh0ptarSLU6xUCtKP73sunGbYBWGUdCyUHW3NKCgN3u0
	 R1YhtiluzR/+BtT24wBSpFV/xPFSwnCS8zrqup12dAi6XegRzUUsdmWXygHhA3UGKx
	 BFfd+iBzhHIVnQ7bct2CimX443b7106eDauaRFo/YyUonhVmzgRu6s4zPW7EClWkAK
	 bNhQZm7XTNjMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 286DD46621;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:11 +0800
Subject: [PATCH RFC v3 08/17] dt-bindings: interrupt-controller: add Zhihe
 A210 PLIC
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-a210-scmi-v3-8-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
In-Reply-To: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=1014;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=AEoDt8k53w5dy3iSBlDwYkPfz+bxGBpVIveGLfYHoNA=;
 b=7RILR+3lREaOAzh0obueWAuK4utvjEs/cnspNsTORZ6cXjK2zvh0wLtr52zyIicT8GL+6gVjp
 8Ie9jpeCMeUAh+7QR1AO8ZIjRc9U4P6FAN3B3LqdmGYiKd61C7/P6sA
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add the A210 PLIC compatible with the thead,c900-plic fallback.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cde4bb691897..fd5b61db3f5f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -80,6 +80,7 @@ properties:
               - sophgo,sg2042-plic
               - sophgo,sg2044-plic
               - thead,th1520-plic
+              - zhihe,a210-plic
           - const: thead,c900-plic
       - items:
           - const: ultrarisc,dp1000-plic

-- 
2.55.0


