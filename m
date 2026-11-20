Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202203;
	b=caEAYFycVc24Vmk9LZsFE2A/hpFAhIOMJyecFb4YiZLkSW57irDGHm/rnF7dcbebkPVt
	 4bz1OUBVmJxF59njHbsz9uWdF2WiAysjiQadb6w1DNwXA+6uzcm1sICuQuiqV3vCtXjtj
	 iXyet1uguUnv+RemDhgZsCA7iRk4/c6oLtobA0igKFnGyRS2FEcUcZh3TzO+mCgSDUt6e
	 Ac9r+wMyrQkubrhNaavLWN2/e+ylENY4TbQqpbZq9R16UgOpIFg7OLdRx8NDm7G7N+SEa
	 /fTxKREnqe1zxjbr9bjmu9PrGXJvTV/38w2h940id6evXxYs84Co/0Phc6YIvEFzi0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202203;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=O3an+/q3JaFkFvnjOlTdpdXG9frcgBLFrKEyJdxf5OE=;
	b=OQkcMI/j74yCb7zFl7Vwf+HMkOa9/cMupyb3ApeztQqJ2F1WpxeRopNx8CO64UEm/931
	 oc1wgapRbR4Jg6thHwOkXgkrishIMDZZ9r5kA2/aAr+byJhlpNDzRaEgAXcRS7feKpazx
	 XnMHtUJWDfGbYH/1u75boOonUaIOGIhLWlY572dX0ub3Rc88GQHiiXM/fdryAP/eaAKf6
	 mgG0JoYVeJELhCFaonDE1Ub/alPeSHc4adVH2nwSI2fBvEIySQByntEnT9rADgsVvO5L0
	 ttA+vAFXPj/XeZFlESVuCK2ILNpxVj0pnjBdFL59TmtFghxOoBNYT7JqzTKGjIUug7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNpOCbH5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7460A381E;
	Fri, 20 Nov 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNpOCbH5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202203;
	b=sdH2sNFagpKz3+yCeGJvMaRdwm5E0hAVFgltqji8tCSJsc4oB1p1/M9/uSdrwU1PPUOh
	 khVgYMICNFapfskfAgM5+LM3U0Bnf+3ECJbeL+OH/rLglQybRdW/WOZhHajAHT4R9nPnT
	 RbX/kpJwSU/WdU4cPGKpkt1GhH2JqT58r+g596IMXZ/qT5x/TjMd+uXHCr0Z3MLpTKQ+u
	 fiCsJxAIZscyx7TfYZFnLpajp1eIkEaNksugds64NI5ITB6itq9MH4riWFV1yAxS7P4Br
	 ayrp3qPqfuNNfTfjdqfYvuSiTvt2IHhiovZdkK+1xsV9jLITNva8aJF9Ht1/f7lndmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202203;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=O3an+/q3JaFkFvnjOlTdpdXG9frcgBLFrKEyJdxf5OE=;
	b=Zjp93Gv44i69Uvz8LkuFgnKO3ZJI0iPDYoqgP+1rFhLPcCE6gUEjUQY/K8DV5/kCmSnp
	 wfGrU9VTim9ZnMAItEh9nBabypfMBcgpbbudU6lU5ipcKxlpz3/b/RhUpuf+TnO3t3/Nu
	 huO76xT0+VC/E9wBt52hHFOHAQ8LXCglL1kCAt0fbUUfKdLIxSrDhhPHmEnFu/ZP6z9UH
	 vEo6Fky3XHR5cB0J59wPhfHPXhfEWsmavUyEMbEqCJeFwsoGfNDJMBfGYh/LZxFl4Xu4x
	 rQHzQkf/IdLoGMTuyx6g81ErEpzUy/dqTvlPL64en056VzdYcOa8khidzWm4yDiFmLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF3791F000D8;
	Fri, 20 Nov 2026 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202203;
	bh=O3an+/q3JaFkFvnjOlTdpdXG9frcgBLFrKEyJdxf5OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WNpOCbH5XqOdMbARcU85bkWY1aIGtmjgIBB16zB4arMwB02QV+D327gJcVusOLpu5
	 zAJSw52r6jdc+oAghgJokaOlwjDj2Cq9VNnU3O+cI0FgSyA0KLLROYWVjzuX9e80ja
	 kgqT4Py0akeZ4tZmMqSl1cWB3ePcCMI/VS+cClkXRqMjjBonoffXuOPHV82/ClFZh5
	 FhtbsYtkpzhMeCyBm1Y0pbaSXh9zFW/Jx+k7HaOEUtc/0IXLjXNaCKTLYZ9KjPFUEV
	 YkHG34zcZqf4O+2SFFaoC360sEhqRE/9QZKoFF3a3u6dzumG/2QaG3pACdl6Iaaj/D
	 4+5aeQ3mebkhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87AED4B9CA;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:51 +0800
Subject: [PATCH v4 05/13] dt-bindings: riscv: add Melon Pi V1 and V2
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
Message-Id: <20261121-a210-scmi-v4-5-4a795a0a9fc9@iscas.ac.cn>
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
 Han Gao <gaohan@iscas.ac.cn>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=1374;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=on0k3/ROjA851j7Dksi+n9Xdm06/pOAfayb1Q0RsTuY=;
 b=PP5nWJ3gOvrjZtkB+LPtY0eHwTGyaaIIuDAiwuVFqZwdxmCsWEqEHb149VJc/Tad1Cfi/BiST
 JdzHQ2HJ789BkuWUYUrUI8UGhtzk8gecqy3H3RKS0flrCKxQC/n07TJ
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/riscv/zhihe.yaml | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/zhihe.yaml b/Documentation/devicetree/bindings/riscv/zhihe.yaml
new file mode 100644
index 000000000000..aa778275ab5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/zhihe.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/zhihe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zhihe SoC-based boards
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


