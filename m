Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648724;
	b=sIHfcaE2EJg50aQKc5yA327owk0QZpX5G2oogznzOPVYW827sdFK+NFYD40iz3D+Zmga
	 I1du96qtHkja4hC0peB2RE/NRv9003+3o239Jpj1+cScvrcP5Y2BTI6PJyevspMWnP3zc
	 2q9dZl8t/dUQCIP6OWOoj48jVX108QKSfROemSOEq7vpjQ/He26HcHGs70Om5JDfDFEWD
	 WvoOUeJ0OZzpbnSsoIWg0IRnQ5Bha12H6WoiDXNwtpYTaQ/fSc1tOZb4dIaFXqLdKQhLn
	 IuyNe4tJSE9S2gW75FC1pgXTxA6/047w+8hlR+AuDQD4cxayt5i0+CJaefo1uWKkHoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648724;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xDviUrSMqV9Z+mot6jCFHNu1hNqv1bylSy05f5qWmgw=;
	b=sRqj07r5EaPZgrk8hemh84AkDbxYHrMzYiqPysnZROijBUhz2trUhltI6Meel2q13Vjt
	 /Pl614h+M+/0OrR+eSwdFMqebjQzABFE1a2ZTLCOX8DXCqMYsHAvWcxB17i77eh/XQY4r
	 OMKzlwxRKhiwlNtX/vUu9TfWEK3tpmXNz+/6A3ssijZGm6VW5I7oMkO4Q6cMLQo+ZPL0u
	 OgFo3CunUxUauwgX4o7z5CYsRFuUo2yuXWim7j7K6dHlHffdZuArUw6bwqlaA7mPALtgR
	 XYespGYZMaRPYZt2BJFGFwoBx4qQxjkQO1d4p9Cd8mLjQ2WDd0xqD3wqQDX5VWj7ljw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbbHgxWW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777860850AA;
	Mon,  2 Nov 2026 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbbHgxWW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648724;
	b=fly8MnMLxQkj7QnhtcTqGnn1JCAqPUcXhYE7+HiQ7wGpOwaRFshkyfplcRGFU5/H9iQh
	 yNUSSJx6QudD3BKgUMoxWVhb4yBgiXeHv8Nd7Z9yCyad/xu+gYfTydHGAwHauMuhArnoU
	 nBXk/jGIUXREvPS9Av3WcsObXrtQ7/wO9ODzBuG99ef/5QqMLG9abZwF5AczyFJnMulWL
	 vBbBDCdBet81IcpWVDUVNybzR0qA5KrupXMzVRNurMSPSs1jrqW9buToORqeBL+eM8Et0
	 wvNaTd89/T/0WqYlQBsK+rFIQR1YaCGR2RAcn4vGEgpKMtXkAQzOVpYFZ+4gNnkj7Yg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648724;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xDviUrSMqV9Z+mot6jCFHNu1hNqv1bylSy05f5qWmgw=;
	b=MKqNiY5nM22mJ9GI3JuZrOsqYNakqrhtpUJNFXC66/LJUPwNjex6iSzh8Ur9ZQ3bHYi3
	 n/9iBQFGp9eP9NkNfA7xG6KRvNQDrluObqPb7/dG4Dn1pe9oGzzCY3m2Y7bNZ0cGi9o/3
	 W9w1OpBji2en3NcllwuOAYlYIoiMnKYbIc4Gn5xLx8prNVFS+VeufgqiFsbvPNgEVHLEh
	 C3GeIvnGF/xuplgz2TlIPxzfWjRi/86OUaHkNI728Pief+rJelY7io7YlEVB8RnZR5VKo
	 NsO1V9iehdq2u7knew2dYy6HygDuVOtVU317gkGPVyLRk2zvqSS8BH14yZzRxb0plTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 655C51F00A1D;
	Mon,  2 Nov 2026 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648724;
	bh=xDviUrSMqV9Z+mot6jCFHNu1hNqv1bylSy05f5qWmgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MbbHgxWW2YJEnOlOf10TwB62Gzg84RjY6W0IkpARovW8PSsh+XZ/MicGtGaKHhnxN
	 0DxY2xHonBHwTSuv+lMoBst3PJM6edBbG0sYbcQb5pRjCXSYOc6G0ucpvId8KHOEKL
	 pG1TRaYZu38mRJtGyIlno37FlnqB73audAjmRq5+Oo5QV4gGN1obi8bb11Ak2QnCFc
	 hav1rFuhhu1q5axxdkey4mbQS5ODEGZxt2a06p4TSxx8HrnirH8ElU/+44gV7uBWW5
	 vzd4Oaib630dckPKiPZTK/fU6hCEYHTv0thmOK/9HCW7TDp+r42DBnl+AXtSNCalFa
	 wgHKdA+bfjPjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B618246645;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:20 +0800
Subject: [PATCH RFC v3 17/17] MAINTAINERS: add Zhihe A210
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
Message-Id: <20261103-a210-scmi-v3-17-ee6b31580808@iscas.ac.cn>
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
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=998;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=8rAYBDf7gj4NVAnJH29mjOJ+nEym4unk8d8Kkoausq0=;
 b=6TtP6/NuwZRzu3va09O8e8UnA3pvPHGh9UPTGAq0Dmo7rbWDjdpRffzRpEhXpozRYgIMWLU6S
 zn1EkLvVW2CC6itThiOaOSkDpscWcGEVnsphO87jn/Tou5u0i4hWASF
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add Zhiguo Zhu and Han Gao as A210 maintainers.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..64ed305d9bce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30860,6 +30860,18 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
+ZHIHE A210 SOC SUPPORT
+M:	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
+M:	Han Gao <gaohan@iscas.ac.cn>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
+F:	Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
+F:	Documentation/devicetree/bindings/riscv/zhihe.yaml
+F:	arch/riscv/boot/dts/zhihe/
+F:	drivers/mailbox/mailbox-a210.c
+F:	drivers/pinctrl/pinctrl-zhihe-a210.c
+
 ZONED BLOCK DEVICE (BLOCK LAYER)
 M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-block@vger.kernel.org

-- 
2.55.0


