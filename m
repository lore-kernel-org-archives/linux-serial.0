Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648716;
	b=XZ6gbBIcK6GB5xVNLYP2gA5czpUE+AwG7YX5+lBKHRDHbf25HYRqsxyUYUCx9O1vmTjB
	 2Xtu2xq6VZts0LSdnvcvPJtZ9Ld35trwVoOraU1ukK/+ZPrPAihFp2PfXtYaWFvFBT2zf
	 fS7i27wrfrz3p8lHY4wbZDixymwBopexXp0Mo1sdozJ0VocA8dx/BT1cxcmBfwKWmdyAE
	 thjcemOewHJ7a1zhWHfu66emhpakv3wMPl1FZG1fAyPjgKu+2mJPOiWI0Az2/e2YBmKp7
	 lQACAfiRDHgnoD9cxA03gsH9LRktx60GX6IQLDTuWBe8Og9u6EUOhtA8ylBwTO0hrdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648716;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	b=Q+9ycn70epuVztj98YhuWyhmRbH8xFbloOsfdJC1z3xjp8mPzqLsL8ECsAphe80E9gNy
	 PvvufHu4hj4nZk8FSrvKQc9L6vk8mP3UroX9HfsyUhTBBQI8xzJVGsp3TcCYqFOlSrYjG
	 YiqiFtCWcIdAacygVE9DLfIqFw9O2r9jZBCigFD3yCXtIcwsFRhNSuX+F8YNoGU4YqSx7
	 eJa9v4Qoa4rUnB53dapmqa1qEIDhXuYR6QOTxGR+DZ+MpJnLF0VBabGYH6lgReNVV9Hut
	 xRFuqkwmLRlCm5x3hA5JY2OYxjqy3KUb0ugbf1wi1rMd6sQ/TH84mhXUvq+19q7mkZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElOsybAp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB4606EEAA;
	Mon,  2 Nov 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElOsybAp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648715;
	b=c60FhZSLfJdQPfcdSArXyTt+Q13tlVdLIx0WBAyeKg+lrUV3Cl9ogfT04NSJrMna6s15
	 uCktQjLzdAMSmxOqz+os4rtu8ig9rb3oG97Kq82x5qLCD3hNRjPIRWT/i8GvCOQ8bMV5S
	 xGvBzROCZ4b/1rv55eYwnAZdWCWHfxf8biqdJ/lZIwjLs3OVeA6KolOQX3GWARw3eecjI
	 zlMhTGU+gz1TXSEmIpmNExT9q/08qW8MHhsBy8T/vkqyQ4u3BUI3FkUgyRNY9xqlyqj3j
	 pIaaLTN0VYi9+Zg7bWR8jSikFumJ3Fk3HeetNf6b0vVtPOz6s0m5meJbMzlB5aTiQjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	b=3FGRdQeBKM6YJTdcRqrGlhM6G5MPe+EOCXbq/PiW47vCAcxw1rBc+RmI+BKbJJiywQkf
	 cWqa4CNgJVi3GvtVcXNjflx2HiAua2jBTOdVlSmsT4RWj5lOtw3CXiF7/mR8Qdub2Ro9W
	 2VLfMFANqnTZyZG5JCBdrRx1t1VGaQKt3seJZxJAzag5+UksAjS+TL50lAyGHHws9nXhu
	 QHaMQpQK+JdZbRd4s0j8BoDBsjd0ybtSHVTwT5QPkI5IKwCj9QcRJPioQt73QAAa+mCyL
	 Doy7nZhC+/C2nQSK5rbLlr74SsPi8ROuCLYQnRF9gP9UEgdRJivm4z335HL7PDi6DBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F3C1B1F00A27;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648715;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ElOsybApz+l9j2Bi0vhKZSGf1bBjxGv6W6mYeIdnt8MroWkQjR3Q7ogwPhpT06Chm
	 5nZw0wGU3fNNGdHvNc46D5fGuGjAyUS33O1yhYPqXsik+jmmTgQDYhZpD0TLbd0M8o
	 W+cAOeLalsQvRUsfy6S0dGM8u/pVj9X9ph6s8PyqCvEURMvGsVMkdhw3AVadF3WM+l
	 M+wRMn8bcXq8hmGr36TdXaYidMykNvJdVoLoXfFAGhDmc0NXElxX6MxU+4H5AJcPRY
	 TyZ3Nx3Vksu1mSiwEzXUepNIhSHmKPdwyshxcRxbwSUsSz786yxlAYsbpks/BuiwR3
	 yBa+HeblqnYfg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8775146639;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:17 +0800
Subject: [PATCH RFC v3 14/17] riscv: dts: zhihe: add A210 module memory
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
Message-Id: <20261103-a210-scmi-v3-14-ee6b31580808@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=777;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=YcgMhPuDLQowVTt+MvNEeWTBEwtrbKzVnPLSZwTdXCU=;
 b=Y4lI8673ffBSGvGUvR8TW2oNRV2yJq+b13kVULUpd8094Rdj5zdOhEq52/aKiT/FxqZbiu02T
 vGoyqQWuTEKCXPpcj9O6MffWpBqvTbgdlSgRnELC/hPFixfOigKhp8P
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the A210 module memory node with a default 4 GiB range for boot
firmware to update with the detected capacity.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/zhihe/a210-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/zhihe/a210-som.dtsi b/arch/riscv/boot/dts/zhihe/a210-som.dtsi
new file mode 100644
index 000000000000..a77447e402d7
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210-som.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include "a210.dtsi"
+
+/ {
+	/* The loader replaces this reference capacity after DDR training. */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1 0x0>;
+	};
+};

-- 
2.55.0


