Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115432;
	b=ThnqJRowTiTxxw3yrmRlmuvqpe63C+3DSOwtZCaiTtUHxnulHeAEKPe57O4ChE3tCiXj
	 bE8/Cy9mjypMWVZcYRxShvcCo8I19AkZhAQjGG2Dm05YCIsIKCaAwIYWUitMiJ/IIClEj
	 7ysdpHCh2YMVVSRPhTM9ooUhN5UlTokVxPGRaT9JKKP6wHqOBJOM7vNPqZKBDMxbYfkU/
	 dx4BUuLk99lUcv6Kmh4wvb2tb9wruW/6xUKpVhXIoCpbJE1c0Y0IcSmuhV7DzAfQHVU53
	 CTAKQTgvtoEc7FbuIHO13N1lWrCD42GQxUHfgkOyaOTlNzlWqnrMnIDqHpFhphzeq4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115432;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1GwL5y6pZZCkHBo5MnJZ2tlozrS8EqxeZLmokyx75kw=;
	b=PGnPMaqOEuvfzbDVvIbrAZYE0f5K+FWpi8F2rYVtFUaJq/9lYWEjlD7kgF8AdI15H8Xq
	 dN0LFZjh3lZTTu0ZCqBeoXXsBx1MLEjENLeLiXB5XSuPzaDQDfPlrV70gUy7b7+lwgm+2
	 6t5qx30kbsxrzfv3xaKglAvwT4DTj34kbE6lggLb/lMauFZcBXi2cHJd1JJX5zqVRByZe
	 M+m6X8CVGjNpWDGr/legRZtDmXTiFdKvmJKJWWj9Y+rGa4uO/5jWom2Pwhc4ZVkBModWx
	 962fiou/zy7BiCj4rUomRmUEHH1ngbGVtwTYPowzj+L5R4WtEHNWDNBto46iep9nNfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320F606A336;
	Tue, 27 Oct 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115426;
	b=BBS2tIqSjmyIwBRuWHQE1cYWGqLEl0Osu8WVFoSWs2dqeGt2g+ZUJplZ8Woof/61wfio
	 oAcg1fNt9XRL3zMopt8/Qel72VIXlIeuubW8Lp3Qt1i9Gqbk+xe5clpAFkIcrEoWNPxj2
	 dxKvPYr0Aukm0UO4TPIwbcsxppls06mcEIbPbDrlUT0VysA0yyyMjAmB7LBbyHNQIXzD+
	 jwWY+xN+XZGjfznbQ+t8jklZ7DBh0jZ3MOnddhUmRxJtahyCb9jys5QoDN6j91c77KS8V
	 HHB7ouSZge513NBBqVgyJkzj19vKRFI5TboK62Yt4RXof3ei1vsagwRnchmQdUV3asg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115426;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1GwL5y6pZZCkHBo5MnJZ2tlozrS8EqxeZLmokyx75kw=;
	b=v47VXK/JoV39HLkcBfYcbD1yo/yZu3dsjxNgirQfOYr7DFp7CM4J0e86WA5nHb+y50C7
	 WVnOmevhtqPb1yLICC6I+B/pUAl4fQrXjVSFozgGILWnLRpywlt+/n6jjn5+zMIMp2fMK
	 Oe8FzTOn3V5ei/HHyeIWr1KqZLhx+imNTVhiC3jgwGcNmUJTiyf7xOUhA0cgCChbzjwhQ
	 O/MJ+j0tEGFSfLKvPtvgT6Yho1pOGAMyiDTut6CD4WdEfmZMtZs9Px7E9HnJDSsVnCbcs
	 MfE0NIBq3iEOFmv6jtXHQ6/3TLmDL6JRAbS5Oiu6tIkxwseAq1K91gTU/gpg63vkX6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 956DB1F031ED;
	Tue, 27 Oct 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115426;
	bh=1GwL5y6pZZCkHBo5MnJZ2tlozrS8EqxeZLmokyx75kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MAb5k3Ch0mWJuqij+yi+hLQ2rH5Ot/ZU/Dc4wQ7onulmYa3Q/4L+5XXSfIRwbW5s7
	 eyW2+AD7hGgi/GiKLgK5va0umqPA+oCxUCcZaGfscqe7RKAHeT/wLTQYSccZq8cWQ0
	 l05XEzHV8Lhqfx6b31ApRD/EoLbEAIe+eMPf57jJTMDGaPB/T6qTwa/pPsnpwZNLXQ
	 HoNp9e44xdiDpQHmMGJREhdNb7uNmMYVBpA1+Th6QYEsUxliOsrFYjlEYcFWjcIWCX
	 BbtNDyIoDC3kEJ6Ptv55KPgheY5P8tpMgUv6xTlbBiR95ZIfBcKz0fw+GtGurmJ+aL
	 4npNhP9ubVrhg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A2A5545167;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:03 +0800
Subject: [PATCH RFC 12/18] dt-bindings: serial: snps-dw-apb-uart: add Zhihe
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
Message-Id: <20261027-a210-scmi-v1-12-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=1210;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=SLTCxGfOMWDsBEnctOnjAIrPrBSK3SM6xa1q6aUn5UQ=;
 b=pHSCXWZq/KwHKORkAXodw+iJClxqRIbBMs4NSU6eLbiOA6IWjOz2JXifAacM+YD2NVyP+LfG6
 r0YjR2TJ5tzCjUlkx5FeJU+LBxZKuR+RBQ8Oy1baIjFKDdqcetSGHa2
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

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..907f8dab2c4f 100644
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
@@ -81,6 +83,7 @@ properties:
               - starfive,jh7100-uart
               - starfive,jh7110-uart
               - ultrarisc,dp1000-uart
+              - zhihe,a210-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 

-- 
2.55.0


