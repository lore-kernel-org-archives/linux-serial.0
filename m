Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115423;
	b=HMb6k7DH4ghyDxpJm1+CopA+bsA8zf11ALXPLw46WSm+Gjvm46Ks5/QRD2yNYSho8S+q
	 yl+Y6S7gJRoMf+TKBNfWnRdYemBCvDhtg418sY2mGuQNWiDr1s7KupWKdgppL9+f4U5QB
	 1+mZU2Q+sdfz4qs4nKl/bLwwFctZ7hcb7/eA6jDnZyENuYWmQ/Neb48cCJDrt3u+9E293
	 xrYPt5HOCRGFnYpbRTzC66qF98k4NFQreGN6wx/kuo4JTK6hLi8rr/4LJTrVj6iyPlQCV
	 17zhMYq/tfUv6njgJhG80VnFUDytyU44FuqM49vNZhmLjY6Pe5WkA6OsLsIJXN+Tx2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115423;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rx6gaFO7DjpVw2ov3SN1A7Kr5RzF+G9b8UuLcJzdg4g=;
	b=ltfThdnyhu625+TWe7/WC0OCsZRnTH3Wq3xO03VkyFQMFo5cQUuBRQeQAq4XrBc1r0dE
	 kh1jj6tUmbiaIEqTraoYsv6n2Un/naVqymGFmG02FGRp8RYHzYbdoSIu2d+7U5/0sPPqC
	 ObMMeeY8mTI5f0SVdWpZry2YkKoqGYiTnIjazDw5QIBREbg6jiOffI8Gf8urByWE4y6tN
	 a4bWqISxux3CRxDPQf8t56NhYFLPTz4pydKPvAWns44zlf12HtA7TDCGhcVT+/yScC4d2
	 MQfsfspfIVZN7U/fAA4dlekgLg2tLzxYmeTxjgge6zXv986GXoryOcpPdj+qiDsi2Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLZVTF4J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF67606A339;
	Tue, 27 Oct 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLZVTF4J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115423;
	b=yAQxO5zIB0t7VCG69u7DoJg/krDJ3y1rv2WImdmQ2VZmGiBMqUU2wYWndutcVk/6WB5j
	 r5Y3VbWc2cPzILDavUepcX7iZ4IYru3GOU4GkVeTQFm7Y057ldFdq85fheT4xZ0vvEZfe
	 BL3R7qE1SsIWR5kvoqh739g1PDXQ6/ZopOF7ebHJ84WizOVQHOviUNgDeMLnXOuI1QD1p
	 H/x+v48qGfU1aBF0sipshMeuehufZKPBHGhKgyKjQe+HV3tl1T4jE8HXRGUdPiC9H57sO
	 bR8K6QuF63KRW8UBIFDbslUd5i/xlRkeBBp1ZVjSW4FAIcd22zGPPdaqbngF6Or/0lw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115423;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rx6gaFO7DjpVw2ov3SN1A7Kr5RzF+G9b8UuLcJzdg4g=;
	b=AMVXzDQqk9Bl6uNxAeJEF9KqvQO5WI8DAJ03NdQkeLn8w0okwhIggQ91iq+Gpl4qDgZq
	 uR7VID316FEu3M3SY/JbqlfC/4t6avSQBskjBTo1hE22SjOojxc8PbfTGgb6YZs7UUz3h
	 NfjMWcNZB9rhklNinySQnaDssrIYp0JoA392A3/FcXe0CYrD8x9YvJiNBpIqKrFBP+ORi
	 OFyjaE/dz8Cwu8FDKttiahKgXFB/7k78XzaMR/HDy2XCEP/rxCt7GnLvjO7/n9JvCoQCJ
	 8gE9sg8+GgUNCXQ3BOUbWg4aVpRqID4aYP7XV35zt+/9XfomAvox4I+a2fPosdx48DA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF4A61F031EB;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115423;
	bh=rx6gaFO7DjpVw2ov3SN1A7Kr5RzF+G9b8UuLcJzdg4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cLZVTF4JiJOSzdeW2Co6ljjW7O8vWT8wiBDZMROr3xnrH+cqTa3WPD7ocML1JNx8g
	 Xtu2WXwErx5iecLPQnSR4orDmqbylfs3Rhc/jXibMgogNQ2AHrZ5Uh4WHLv7YbitAi
	 qYS/0FA5qtEEPGaAzU0WgBz0HI32U2rSbn8MR0yXGTRyQozgyiRjg5By1rBPErOP0j
	 x/leOqbTndr+Uz/RV7V7yUZRxg3MiT3kMgHccn2HT2LDIg8WBo+pwhp4PsFYeCzJMK
	 Tv+2xgCQPdEIYxbqYvVXEVbJtmj+asjDeCi7gJcdiHe6dkFXQ92qiz+p64Wv8zs6Xe
	 gjEdiNEzywbkw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4668745147;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:36:55 +0800
Subject: [PATCH RFC 04/18] dt-bindings: mailbox: add the A210 AP to E902
 doorbell
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
Message-Id: <20261027-a210-scmi-v1-4-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=3071;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Aa03o52/q7r5yl/oQj7tvURMaxh2zbyMjEEfFVs/Mx0=;
 b=9x5MRu5wx8RqE0wf2ApXCODP19BTZv0c73fMy5djuOOqlLT+r+AZHvIggIAKsqbM2e6z5K8ZF
 dzXeFbZybVjD7bIKfS+XUJrF4bXbLFldE77YjSDtNMqOr8tgvu5mgUl
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Describe the AP doorbell and optional endpoint clocks. Firmware may keep
the clocks enabled before the SCMI transport is available. An optional
E902 to AP data bank identifies a second, receive-only notification
channel sharing the doorbell interrupt.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../bindings/mailbox/zhihe,a210-ap-mailbox.yaml    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
new file mode 100644
index 000000000000..4541750223eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/zhihe,a210-ap-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zhihe A210 application processor to E902 doorbell
+
+maintainers:
+  - Han Gao <gaohan@iscas.ac.cn>
+
+description: |
+  The A210 exposes a bidirectional notification channel between the
+  application processors and E902 firmware. Payloads and transaction
+  completion are managed by the client using shared memory. The firmware
+  initializes the remote endpoint before the application processor binds.
+  When firmware manages the endpoint clocks and keeps them running, omit
+  clocks and clock-names to avoid a dependency on services using this mailbox.
+
+properties:
+  compatible:
+    const: zhihe,a210-ap-mailbox
+  reg:
+    minItems: 2
+    items:
+      - description: Application processor interrupt status and control
+      - description: Remote E902 notification channel
+      - description:
+          E902 to application processor channel data, which identifies the
+          channel that raised the shared interrupt
+  reg-names:
+    minItems: 2
+    items:
+      - const: interrupt
+      - const: tx
+      - const: rx
+  interrupts:
+    maxItems: 1
+  clocks:
+    items:
+      - description: Application processor mailbox clock
+      - description: E902 mailbox clock
+  clock-names:
+    items:
+      - const: local
+      - const: remote
+  '#mbox-cells':
+    const: 1
+    description: |
+      Channel index. Channel 0 carries requests to E902 and their completion.
+      Channel 1 receives E902 notifications and requires the rx region.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+dependentRequired:
+  clocks: [clock-names]
+  clock-names: [clocks]
+
+examples:
+  - |
+    mailbox@321000 {
+        compatible = "zhihe,a210-ap-mailbox";
+        reg = <0x321000 0x1000>, <0x311000 0x1000>, <0x320000 0x1000>;
+        reg-names = "interrupt", "tx", "rx";
+        clocks = <&clk 0>, <&clk 1>;
+        clock-names = "local", "remote";
+        #mbox-cells = <1>;
+        interrupts = <336 4>;
+    };

-- 
2.55.0


