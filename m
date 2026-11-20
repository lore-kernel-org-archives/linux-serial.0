Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202195;
	b=x+NUKbL39omL9Wp0KJmmxs9FAUd0ES8Vf3UWjRTuimaGx/jaMM/E7PNduBSNT8svJSAh
	 KMFbsU848N0gDvKcJ1p49XVYjINkPV4tVjuA/pSRO8Ct4LtFObPKSgtHPCzuihP4UWSZi
	 bHhZtwTgutSJRvazHuzYqxcUzCGsa5DiUjPdPvRE/5Rlvlq3XlGqhYmrDVb3C3/iANnLr
	 +yitFEyaZXBMrOFkIaiLHVD36NLG7+WyJXI3QhyhEh1DcVFRcBkQ2HVcBAuHw1U1/Ir6w
	 MkiLw8NAeIxIF/RjiHcm9oPZMa1XPFS1oAvkgOPNpB/Nwwjf7aH5c8BfksUUbXJaidQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202195;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L8S/WNv20+oRCfncRZ/tZDNWMqkqP07ca+Q4m2HbqFQ=;
	b=Ybprodsbsl72tixAHIDxPhvvTLDXd9RCTaWrC2jrrzveJMfSDIuH+wr04LXIQhK/62TU
	 B3bhHfhI50jXcxzmphzkEj3fo+rkuqSd1mCgvMxvwA515c9qyPPXTDElz1OBPrE3lbIEB
	 lccd4O/1NTvYTTu3xtcDhHuZ9N63mH4f2r56UISi5D2Ou97+hsCx81tumrcZKS4SMnoXZ
	 ujbLUI8pYtzQpwy0w2iBWpDEE5VoHtfd01hJvnHjYy4nt0+ep5PiM4n1czGBO/40tSa+I
	 uWt8dXo09I77aBeJ11L7gxqPkDTfX4tA/Xit1O+OOV8imb99z0eL4YYn40Wuxwb998A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrUen82G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8560A380C;
	Fri, 20 Nov 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrUen82G
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202194;
	b=ipDqiHUMTR/rI4CYfg8N/mWtbKwaqwH+Txzgsu8ibxRnfaXY8FaBFtpjx8lbg9FIgC5r
	 pXxiA5/6z++R5Kjt9RkBaWfBrfNOVT2BeGJQn94NPQfHbTZeotST4MUnNZnslpcTDFZVs
	 5ECJGLB0IQx1Loec5AIxJvNwAlBEBv0dzuprJ+WK5Nv1gazH0kHMmlXgaZS7H28ICdNXq
	 bH3ryJNCOTvQqsrQJnR0ZLPcgLc6EwYiihzHwF5uHugce/UzKiftVILyqIXLiIQs0g+GI
	 5WKwj1Sb/9Mr3PtVR3pEuCNcS6MaagscYbHSIyyyKwvNlwhdgJlnJd7TCUdc2ffd9hQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202194;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L8S/WNv20+oRCfncRZ/tZDNWMqkqP07ca+Q4m2HbqFQ=;
	b=rXeAkijKv/Wbx0ntRsufPG6essokPorc+rdzHrZ3ZMWd2LF+NuU3RqGY7OFMyT7Js3Ab
	 foj58YqgsGo3elvx4/YSjE5O0ZTCMVEqOVvZALMfc9wN3BMDL67vDZkVXkZyN244ZDcYG
	 hwDwghbbtHW2tBQSvX7lCT0Mm1eZhXGWmblURr3TsWCC7RD5XgZj6Q8YbiZJQPEwpH5Sf
	 f9htgfdl2vEvguea6uvM1/vCC77k+nM24VBaglNO1YvVnFD7kfIJtLVPHn4rTh53Nr89d
	 Y8zaV1oMhvsM5CRbMNubuNyiOu+LrxAenKhjZxVuxa5KC+B/GMEJWrYlaecRFnRY5fg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A41F51F000CF;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202194;
	bh=L8S/WNv20+oRCfncRZ/tZDNWMqkqP07ca+Q4m2HbqFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KrUen82GrpaDH6DqOG690NaG2JwwzdNDeTPcATJqEF/fRzZE3DJXYgVg0kFacJ8IQ
	 h+fEP9171+xiQcIg/GmDCDnZxHoH3DuPo/dglCC0h3JKl0FNfVTFeKoqj3uf0zZ49b
	 BxsbaWu+yyyvw9nZqrT/zub8iX7x8Z0ftiq7645+3HRgXEopbbQta3ChZ81I/c5IPQ
	 rmdUjD16vR+qy4NwMQfSSP6jdAwwiAgytlU1Nmza43W1n+t32oBY3+48K32AMPx172
	 mqCh047+9wdBBhYVko9n3oqxiS5qVh350wdK79RBGhtPimIGd+qtZ3VUyqcc1O1nwF
	 prLjb5waJLQQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CDFE4B9BE;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:48 +0800
Subject: [PATCH v4 02/13] dt-bindings: mailbox: add Zhihe A210 AP to E902
 mailbox
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
Message-Id: <20261121-a210-scmi-v4-2-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
In-Reply-To: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
 Inochi Amaoto <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Yao Zi <me@ziyao.cc>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=3069;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=1bSlRTbJH+ic/kKX/KZWwqkpU0t/w8ZHzrQrtqPAxps=;
 b=lzwwljT4hoF98KpvO2sq3Fyj8Vf7qxTxshhSDPyuOHsAGcOO1hNb+Wf7HawbD7NeTAYJHaTya
 zVGvZdrptnMDttoQ9FmeGzixU8kHAViO2ozxRWHUI5nr0f2WG1y9zMf
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The Zhihe A210 has an E902 management core next to its application
processors. Each side owns a mailbox block and rings the other side by
writing to its slice of the other side's mailbox.

The application processors ring E902 through their slice of the E902
mailbox. E902 rings back through the application processor mailbox and
writes INFO0 or INFO1 there to say which of its two doorbells it rang.
The doorbells carry no data, and clients such as SCMI keep their
messages in shared memory.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../bindings/mailbox/zhihe,a210-ap-mailbox.yaml    | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
new file mode 100644
index 000000000000..7d7ab1c550a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/zhihe,a210-ap-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zhihe A210 application processor to E902 mailbox
+
+maintainers:
+  - Han Gao <gaohan@iscas.ac.cn>
+
+description: |
+  The A210 application processors and the E902 always-on core each own a
+  mailbox. A core raises an interrupt on the other side by writing the
+  generate register of the other core's mailbox, and can leave a value in one
+  of the INFO registers there to identify the request. The application
+  processor side therefore needs its own mailbox, which holds the INFO
+  registers written by E902 and the interrupt status, clear and mask
+  registers, and the slice of the E902 mailbox assigned to it.
+
+  The E902 firmware keeps both mailboxes clocked and out of reset. Their
+  clocks and resets are not controlled from the application processors.
+
+properties:
+  compatible:
+    const: zhihe,a210-ap-mailbox
+
+  reg:
+    items:
+      - description: Application processor mailbox
+      - description: Application processor slice of the E902 mailbox
+
+  reg-names:
+    items:
+      - const: local
+      - const: remote
+
+  interrupts:
+    maxItems: 1
+
+  '#mbox-cells':
+    const: 1
+    description:
+      Doorbell index, 0 or 1. E902 writes INFO0 or INFO1 of the application
+      processor mailbox to tell which doorbell it rings. Only doorbell 0 can
+      also be rung by the application processor.
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mailbox@320000 {
+        compatible = "zhihe,a210-ap-mailbox";
+        reg = <0x320000 0x2000>, <0x311000 0x1000>;
+        reg-names = "local", "remote";
+        interrupts = <336 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };

-- 
2.55.0


