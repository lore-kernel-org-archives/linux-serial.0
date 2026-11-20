Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202200;
	b=ILIqY15/ph/AqQrtE3w4BZAIsaBSE0BPzGXr7it31FB1zfyg90T5YpkIU134BMlnIAV0
	 Rq8O2Yiuwmep/25Bd0sGi8r636Z+RXbdWOuPjo0OqbhoMDMb1jBLteGvsvUtBqM3JYmdJ
	 xx7NQGdSMK51zKkOOw+D1UaqLgw//NO83iQKLRcNDatNEb1mTGdRltFrzCIJa6SUKkWh9
	 sGJq6fGOGkpsmWzZ6cn/EC6O8mfeMzhjVZ0qnFaPh0aMy5DQkEn2dTxcP5ZY88izRzkug
	 xZfUrXMSY+rqhlVWHpGOWahSbwufUrlc43XqqG1i147NWNraZmvPrTnvE95C1sB6yfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	b=4c0ShvX8gK9NKJLmTE9rH4s2EhEVuw5sQ8+/1T1ntFiWtsXz77XL9Bn26QcDb2+Pf2ca
	 0qPtEaulokTZpNwNvEKX1fmmeMML6Lx8Q1BgryVNro5jTxwEVAN8N6SHQeJsJ/FLXXJ9T
	 yKX7iS81Y2E37RY5ca1eHFiUuwEXzklHHvY9onaqCyTqFN7BHujQnM0S86qV4vK0uaxkW
	 /myxBmzC7JdtF+b+/Kk7ni4MbT63TCqDzYURAZ3kOwb5zGDwqo5XagbJJvcG8xQd8kgqh
	 P0Ec9Nz/jAOpbcIujdV9se9ODXNYQu39P0HtK62ZNXqncvI6IYDFq+5te3AhMuoPsRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYThZ1a4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFD60A2606;
	Fri, 20 Nov 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYThZ1a4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202199;
	b=xMdV4tPxKGLlN4M4JzxNVRvWUoj7lJOKZUPklW9UdnevdbyJSdF7KYWkIyUS7DfXiupL
	 VTOjrvzX8p+HntD33yOI2//ks3CkyqgxcCo+0I/7+GzMT90AcwER/Dnn1pNml3wRRqD2J
	 5jh9RsRrkEtDiE4+gfxB36qAAOAEo9WP5QRex+6a2AQZqd3J5zOmnre7O1bs0cbUwV50S
	 cVpW1okQOosHZpjUAwM0ch4hURHv6msJUJ+hOpBzpqrimpRAdXITuAoGQlChccWITMoTO
	 2poeEDJ86QP6lOyhrAkhXHmVEG803m6P7chTM7h3JwO28NEvlId9daFrRuIjUUWO6pQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	b=QKNdG/ZG5SBYRCZ+rkIm565YCmZPVC7js6ycsW2Jgv1e+5arSuZX0ehdvZ/OxpT8N8rR
	 yyZJ36khfHfUbQvHKp5Una/tttJ14IXi30Y5Cnu42e/TVJRDI/bwQeMppGfdoR2mx6NAn
	 eNkDLL+hsMu+kiw52qRrCf7UJKQ53YrDJsZ0OSYHlQsuUKX/4t/lCjarTZKo9eNoGgkN3
	 TU2i7rV9p25SkX5lV4S0qP53u7VNGDAtoWrk+WsT1WfZGsPXbiGTYpgK9Dqy7RU8QMKDU
	 G7syU9D4WPkHevuD5SFvWx2STauStnPE17pHKPF+X7EJ0EvUwUrTqBb9ZtVRmky8oig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0D201F000EE;
	Fri, 20 Nov 2026 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202199;
	bh=VoO5psaD9DFnzn5bc1zZcOjZ9Zx/iOn4te5QyeYQEoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HYThZ1a4hOsvvs+Tm7y5zXG0JNKf3bpbTlhg4Aiyip0tZ75SZYc2RsIwucIhNLyFE
	 qZdpdlXHsja3+O+JitKRL40rKrHimL5UY+k/z7QGRZkGsplC6jAnk0JjApD0IsT7nz
	 iknPYLMEdoNhd457fnq5xHQG3GEEiGcWGU0xaxsvjdvC6O7RW7YA9ZLAZ1why+ds94
	 v1QZihaHuPJmZuLr06RLdAC6augh7dsKXCN4A7bs6amGNPimrks1q6aat8TfFbOYSY
	 wW1Unx7KnhElAYeKQ4zyjXa3/a0wSZRbmNuZIuk3UQb0U7lAKlyJ6zPSJlhB6Xsi2k
	 95mdnI4HVwhSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A405B4B9CE;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:52 +0800
Subject: [PATCH v4 06/13] dt-bindings: timer: add Zhihe A210 CLINT
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
Message-Id: <20261121-a210-scmi-v4-6-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=860;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=xDW3mj4crTCYIjLMrm7hiotLvXuQDaJfNmGBDmcpw/Y=;
 b=ITBUMLFXVAn/LcCfHEiId92uBWlW/+hUYxiLBH+Nd0AXOKYmT7nGjh7oKSsVxvXEKQMhLFEH9
 VTz6tspsrugBjsPXew0KSTSRceYGa87N9F0L2edOzfzWv1JPwEOM17y
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the A210 CLINT compatible with the thead,c900-clint fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d53f52e80d88..6480c8dacf6b 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -55,6 +55,7 @@ properties:
               - sophgo,sg2000-clint
               - sophgo,sg2002-clint
               - thead,th1520-clint
+              - zhihe,a210-clint
           - const: thead,c900-clint
       - items:
           - const: sifive,clint0

-- 
2.55.0


