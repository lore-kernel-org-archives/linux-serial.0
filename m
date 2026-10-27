Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115426;
	b=US4ZE2GA1ZJrfEmA2PFGb+/UVsuLRQrhyeas5G5+vgA9KVNKj465MnLX5kz4wmSaey3x
	 Pb/q+zvsrWKs7+B4DXAp0uS9YBbKJgT1eVcXh5kIpObemnWjyZUpz8HYauaHSk5WTHstd
	 G4vzoxwYl7tVlZFj1sW/WMnbBJGJ3GlMqb3rQ2mHcudGFLas0fHZI5xrYM+0UiBMYv6+U
	 zH1V45L3/cHN9346Q9EgUinUlk1/RZO7411beqkfrIYT/ayLMp5df86H/h6cuUzFLU6lW
	 de4H1pWDDJBk0ganhpBiqfx5diDXwmcV4D1kz77S+jE5Rbwhoq3FhrrljLH4r2TGKnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115426;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=QShVkM2LJ8JPti4P3lg9N2gtK9rDsPbvy7dUhJpdWr4=;
	b=GLJw9xeMmVZgmgkG0dQwyQ9hOGul2hGyZqwFVx0P4EJ7zULShngxGN4oV8vFKqqi6Gsf
	 XjN4rL2r2V/LEaNw6W9AaHDkfghai/b2BL4c2B6JZ2QwvwAdF3+Jfsser/YGTdIIaYziV
	 U5ICeE7zv6i77Zj9Fcpra5XFIYKvkOSfdwbjyzVugT3zENNJb+SlEJe8N1+GfcvdOKK84
	 7PwfjWXnRpsUjynmqhDsL/Tgn5GMw4/A6WhUWOLD28ZWJN8YzS5CfZ4Nt+5Wk+Imi4scq
	 4KPzQDP/J8Jghn4tVLJyKM13c65rnvBslaInqcVM3pObRFKL9TyM0Ut0tk3cHZDzsjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8IO6Onz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006960A3810;
	Tue, 27 Oct 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8IO6Onz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115426;
	b=gGAz2b/ClVxpgQWPMd9PIgRPDw81mQcAUiRgSOIP0RbdgEonvbjJLjiEmlakpLNW7DlL
	 W2wO99R/gB8i5IqGSQ3XlYMM0cPrmownof0LpRbXvrCy0Y/zcl5cVfwi9iAM/FMXodjPk
	 DzJAR0Q8zOlrrBw7VHisJOl9YileN9QGe3uRh9DQNEYQ5ReTidvZEe07pqn/Hh6ZinsMq
	 Xp6wGFhRquchDX4Ba9m9PFjIUZ38f59DGBQmOQD8mUD6/TkRU/MIInDZxbFmOR4ctZVO1
	 clQiVxRwLi+Hhqrcyos/wo10zSKMTCn+PvxCTzAs9fAhEkSfT6lrOMPa12lcLWbAhkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115426;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=QShVkM2LJ8JPti4P3lg9N2gtK9rDsPbvy7dUhJpdWr4=;
	b=iBTZy573CmuOZw4k+Y89Nru7N0Rm41VKbyLyZY/xfNwYpvP7BTeaNg9T51pT/aEP0825
	 XS0HF8OnKNae7sL7OM3t2Rc/ZNpscE0otfQW8e6Ug1BBmkWcdh13q2zkHtPEmAnQ/SUN7
	 Qd3B0Edxq64mqNmj8kiSyB2WFhGO7PU8LJX3h41o3lXiS3VkV9zobbnDVO6/7pmNuINt/
	 iYXMXYg0VCUVpeRV3wDjiAixALL+qPF6/+LVl+VLWQiiXo9kDDslF/nNEz423+MQUgEqD
	 o8xozq787cL0U6nh7lK3ri7NdFrQdPK5dB/KdM/Sr0KpvcYOoINJM9ZAryizkZZwtMA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C65431F031F3;
	Tue, 27 Oct 2026 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115426;
	bh=QShVkM2LJ8JPti4P3lg9N2gtK9rDsPbvy7dUhJpdWr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h8IO6Onz8MkhKPU1CNdCpKvpe1gwIeLZln9hTTOr8nOUB5oQcYyfoe53aaKNT4CV6
	 QA76zIbh/UjqMbprsn5TzxWzbhJf3B4n3chIbaKatgkFfRgXyl1HJezr+10nNf+xdN
	 TU+TWH3vvfrNTcLbhLAlgHLP35C+tY1sOkWLyKehXvU7bSxnCGfeiiS7G9XEomYqCS
	 Ic7bGBQFBh45Dd2u98jeeLuAUH0d6oAV0PgPRrckAM05yqtq4TBrzDnlf/AtdG3W7j
	 dZcEHGm6faeLuqAxLIABBVQy7Qp7WgQXwooDDRBa0mmjQbhzjgH9SNUVfmXxFn8X4I
	 1CuKufpAiqg2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7E8BB4515B;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:00 +0800
Subject: [PATCH RFC 09/18] dt-bindings: riscv: add Melon Pi V1 and V2
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
Message-Id: <20261027-a210-scmi-v1-9-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
In-Reply-To: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
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
 linux-serial@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=1321;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=h9FV4C+Ue58b+AWtFVeYgWLXZsICp/RdVjsM7aslrBo=;
 b=CXMz2z2iXxjnfF4FICVgZ85JK65I0vMGVNWQqfbZmKmsQaO1DIkvh/uwxjNNP/AuYvBX24AVt
 yUGdlNRrycCBPvwSK75BIYWUSxqlnEQbIurdbFbtLdojF82lIY8jxF1
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add bindings for Melon Pi V1 and V2 with the A210 module. V3 uses the
same board compatible as V2.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/riscv/zhihe.yaml | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/zhihe.yaml b/Documentation/devicetree/bindings/riscv/zhihe.yaml
new file mode 100644
index 000000000000..92ac0a99a687
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/zhihe.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/zhihe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZhiHe SoC-based boards
+
+maintainers:
+  - Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Melon Pi V1 and V2 with the A210 SODIMM module
+        items:
+          - enum:
+              - zhihe,a210-melonpi-v1
+              - zhihe,a210-melonpi-v2
+          - const: zhihe,a210-som
+          - const: zhihe,a210
+
+additionalProperties: true
+
+...

-- 
2.55.0


