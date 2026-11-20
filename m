Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202206;
	b=JD3y7WynXPAqFXZ7Hhd7o6nBhmQhw8DuPyuUMkdn3yDTOsr2AMW/qO9KhDs6x1xc7ojD
	 C1BSkRSk0D6jBr3usUXaj35jpyRXtAF/UOUlwjzJj20EjDZcn6wi9JGEFpENuzNN+blqL
	 wS8VllBFzVMrJVDmHFMbdrFG5RbEWiz/Rv3QeUDnXjEJxcvELgsvod87CF+tQH3YEwLmA
	 XtNOxQx/YZeOVepaiV/yzS7G37dEXNpJvOBor0W9KT7jTA2L2L88AOTByVE61PHMHBbKy
	 WmczcNcH/q/IoTHfoV1sf4cLme0okiaptPMzDSvrWdwu9cPRAZIcBRjQ4PGKeM8O3NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202206;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rmfx7QYlhFdbxH6abqp7/AYToCj2a0IViMkw7PBXQf8=;
	b=qo9ufA1zIj9HHZ34/ZV+oSkt4QZfEB3ac2Rky/7O+RVmuv0XgKDv4btYE9ltmpemyxql
	 SEuwu9RgTepCdYCWyLzzoJ0HC2MSDmfk+eRnImFFoIZzTfXJPrOke2qkIMwR49VH5Opeo
	 E19QbTEDxAtK/xHBi3eOoZpaocOwErrpR2rmqHJb0gvX4IQFQbn3My4PO6y8XRdQD2MHU
	 iLUEQACUrWjne6CvcVGIVM3nLYzkSpTtW2aopzLALh7uIyiw672IWO4/JP8PW2z+9euIm
	 ldebZm+XHa9kACBTloWgpXifdTtEnHLeS+1jppdpIaajJ82a6dk0sk4jIZvmb4l6F7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYZsV0fW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14260A382C;
	Fri, 20 Nov 2026 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYZsV0fW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202206;
	b=PhlnVrpf2kscLzzQHrvmWwQxn83b2xJN1Ws0eqotUcA/PUBpnY3yGUk2EPtsJtQVIGNA
	 By/smh4PzPj0s470lTr42JUkRrgx2hId20U67EaX9Abxyvx1sj/MPnQPvPvgmXgS5+auj
	 IjTy0dBDKt1YDENTdUIDQSQy9QitIZ2h9Y1GsNZqeyURv5pmhNcKyCjf+onrLO13c9AAb
	 lvDtVaf/Yd6gqjqZXGgDKgx/NRx2SP8veQfxBmNlNDbih5uyFNG4h9HLleSm1Y4rIMQ4n
	 As+dQ7hygPXcCbS6UsZm2zgpxvGkPUHeSoZGStYieC2GCKjEuA4prRX+pUOuA/fy7MA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202206;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Rmfx7QYlhFdbxH6abqp7/AYToCj2a0IViMkw7PBXQf8=;
	b=Xon/8I5Ra3nPP77rdUL18kxBVztZsgtOWXm1gL4RTWQD+8SM38XMSgRyFCerTMtJ7VC6
	 X0bFsyGukHcDbfL8fNXoLmJ5cq2H5cMsl/uvi6NZW8/c9JPpeKnKMZGVLsEGbVNUQ2lPj
	 2bCPaBQ4on1+Vpy9sNE/M5s9uMOQWik4i0S4ohHVV/VoZ7FtLcSkl25Jv2EsNCAEFoYaD
	 wCr+UpS2NWQblVIePS+oo1EBPOJ0Nkz9jkkQmUYmxbQVQIY1qhwy/XTgb+8NCTJglQ+X8
	 zBvxL646cJYuLxyz0swSH0PeaoPqLFumVc+TZSaMNQYxyagHnSws/XmHymHUucaTFMw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 75CC21F000C0;
	Fri, 20 Nov 2026 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202206;
	bh=Rmfx7QYlhFdbxH6abqp7/AYToCj2a0IViMkw7PBXQf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mYZsV0fWRhqtpbLApICegaowqoFEa0EbQmUOBHgOmsRhooD5KkgjhegtheuYLmjCV
	 BFH2b8ZjH9oIGmdyAyCdNWYe3OVmY9CdGqMeQj8MsVPHjxAOhHImESg2YxDUUCmXau
	 Fgf6+1sP0c+siUsYOrxVBREBV4hJjMwHM8kVEMUn4fcZl21b3FBgsJc7H+SW4ZuoOd
	 NOSH6ouVD2FEa3TuRjElfa20G/+KQO+gT4K86Hezbaf0e+tYrilh3y9AoL/Pb1680Q
	 OwMdd/MjZ/1aysoDXsNf7kkkyjtqaLH9DsqbCfiE15VmcfjRmbCMt0yhtQvo9fwPOD
	 Rit0XYqTsrm7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BDED54B9D2;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:53 +0800
Subject: [PATCH v4 07/13] dt-bindings: serial: snps-dw-apb-uart: add Zhihe
 A210 UART
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
Message-Id: <20261121-a210-scmi-v4-7-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=1465;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=QLjwbL73GqPkQVnItJ73UGwGElc2NGvSKMH+o+6GPQk=;
 b=mvx9J3mV6IzcJmdPW+I0FhhSHOkmb5FqNp/FEIQMzB2AVPcuaZH8yoCfQNW8cEwOf8Ln1Pnuo
 mE9cgoKzdq3A/dpppN09Ibufz89fAH1Qpr2DbaAh9GxqdZTI2hsQuB9
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

The Zhihe A210 UARTs have separate APB and serial clock domain resets.
Add an SoC-specific compatible that, like the StarFive JH7110 one,
allows both resets.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..a46a87e100bf 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -29,7 +29,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: starfive,jh7110-uart
+            enum:
+              - starfive,jh7110-uart
+              - zhihe,a210-uart
     then:
       properties:
         resets:
@@ -43,6 +45,7 @@ allOf:
               enum:
                 - starfive,jh7110-uart
                 - syna,sl2610-uart
+                - zhihe,a210-uart
     then:
       properties:
         resets:
@@ -92,6 +95,7 @@ properties:
               - syna,sl2610-uart
               - ti,tda54-uart
               - ultrarisc,dp1000-uart
+              - zhihe,a210-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 

-- 
2.55.0


