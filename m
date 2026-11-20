Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202209;
	b=ro479s9HZTKkoUxZoe74oixwUb5NtO04o1xjY/uPKTZv986a342EfRHFKek+4eCru2Xl
	 NCC24Fdy8i+0ZbJrdcAo6PoiiUYEfE6Y3bISYzOvf1EZySL7ve28hr8yQxlUKW2BbT8PT
	 KQaykKIIj44TPlJsZhkIW/l0UOZF3yMTpqMbFTNK3LRTEcXOYLEo+U6jitHVBVTHaSjgv
	 03t7jgJsvOXHnZQ/mplJ4A4MLjw8a9qd163nH8x57LZCaUc7n5m/OFuINKkayNIKYgPEA
	 o5ZcSbe3eeoA5bdZcEKgoJLGrK/PzeW2X13R+fDY1FU4D26k/vISQbSlfBg1xAEBHag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	b=biwDhw0wnhPA9Ykx8ec/lIxh53XU8q02bgdQQ4X/5K7fVQSxggBD810Tc+lMVkfrKbED
	 TtL9/SHIoS/PTLnyl/aTxbIjtc678bcQELBBOrWkZmkgWpvZq7M0UJa8WhUlJp/jcDIup
	 hWbGRINQqO6nG7agURxrA8NEe/kl4Vmf7ArzvtHUcgRr/xEK97T/v6cX0tkq2i/jvG6/v
	 GWCgcHD4zBH3hLT/z6wtEktM+PGHpbuMGc1bYTwpU/Eo8PGfLXwOnoF4/IlIE5cSwK/JS
	 91U22FCUFyeVQ+BnP0WWJOruA6AIwwmAB74FUnd4LWUeCOhKTNDXx/bbS0Tx1xgWo2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev5lagJj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDB606C9A3;
	Fri, 20 Nov 2026 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev5lagJj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202208;
	b=i4N1LTcb0Zjz+2rTcs8wzmWWBWdGXW3WA1ou0kFzXNz3dzW3XyzPNV4k+U6YygGC7DzO
	 yMqFljxzDQvleuMD1xegmDiJNQ31PIzYoYq7fL7YOU1nMeRclBG5zYYuiUDdKotq4uWHJ
	 aBZPhjKQzYcxwwMSsJW6hkBz9P3t3zS8MQWwoX0LHYtIK5XxqORfHVGcT5uIV5tJN4ufh
	 A9bqH4INxfbvpb2jB/ORwuRvAAVcqnRpQJB+hoy58O2Q10OjeLJPZ0/ax+aiMzldaXDrH
	 vnZppfIskwAXqWOTxnXILXDBc//o2F8JTK83tYebMi38ckMpvsufNVBohrud/JsMDqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	b=uNzLItBEfrb7zzq06Pz2gQDUTP7Cf+yRP6VOOuqLBnjGatJvrcwueAD9h/1QmyhumorU
	 4qXhFBf0uHdwuQnGfKsMf9u+byaNMLPjo5wI8Mi1YXF5wALdN15YyVawItxH8/FN4YVNF
	 zLaVWSGdi3h4reqoMRB53jAxngmXQc279DnlhHwuF5aTPclQzGiREUegXgwIeTx20JZkH
	 mhs0WBuCtS5ohOh/BQhjEdM1o3eUUoLkUKdo4eoIgCO2hZkBFbGF8kGDn/uEVF3BHMkGU
	 GM/GTroX6+zs12V0bNxwFZA0+ILqCJrtjeHhXa7joyPxjia4vMjVLgGengy1xsrW2SA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3BF271F000EC;
	Fri, 20 Nov 2026 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202208;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ev5lagJjP1mSmMJJMeNNEgieM02MDFwe7g6gtY48Cj3jIqHjwbwtDJZCpo18Jq4Jd
	 6RfoS/QoNQy4DaLZx1446+nZxqQ52P7TuKuXY0/jsXJ7dpLS7fPpTY1I+Cqwr+3y2t
	 y404sQXhSnhShFiRvwoMIFBBBprDtcm6X44oS2Vj4CB2rg9HQA0SEuc5PmPWXlCRp/
	 ncwK7uDloNRthEPaSJgveYT4tIFY+ci88l3tJUqsTYYCL8LdxBvkdjm4IUZO7UGqfJ
	 xh7hKKchaoL1dWZUv6I4OM2wWrpl51dVRM8vus/YAE6M4iVo036YBxSXzq/7rAQRN/
	 S53+DmqPKFdnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3468F4B9E2;
	Fri, 20 Nov 2026 19:16:25 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:57 +0800
Subject: [PATCH v4 11/13] riscv: dts: zhihe: add Melon Pi V1 and V2
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
Message-Id: <20261121-a210-scmi-v4-11-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=3373;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=oY4cd1y5LBziUvIW+aG4iF3iEAIqMm4nbEZQYJakX5E=;
 b=gn/suiTUY9VFZyUUPY3C+ZJyWKFpk4Niqut9ZzeA6M2KsE8p95iEy8inH5IwQZJoiHnnRQZ9R
 0jQTuaek65zCfvaU6aqBL97gR5C3iURXdcyiQ8qw7jCaRX6oIJCylts
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add Melon Pi V1 and V2 with the UART4 console on GPIO2_0 and GPIO2_1.
Use serial aliases to preserve physical UART numbering.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/zhihe/Makefile                 |  2 +
 arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi | 55 ++++++++++++++++++++++
 arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts      |  9 ++++
 arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts      |  9 ++++
 5 files changed, 76 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 69d8751fb17c..445edde8f107 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -12,3 +12,4 @@ subdir-y += spacemit
 subdir-y += starfive
 subdir-y += tenstorrent
 subdir-y += thead
+subdir-y += zhihe
diff --git a/arch/riscv/boot/dts/zhihe/Makefile b/arch/riscv/boot/dts/zhihe/Makefile
new file mode 100644
index 000000000000..553102091d4f
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ZHIHE) += a210-melonpi-v1.dtb a210-melonpi-v2.dtb
diff --git a/arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi b/arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi
new file mode 100644
index 000000000000..52015f6de5f8
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include "a210-som.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+};
+
+&peri2_padctrl {
+	status = "okay";
+
+	uart4_pins: uart4-0 {
+		rx-pins {
+			pins = "GPIO2_1";
+			function = "uart4";
+			bias-disable;
+			drive-strength = <1>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		tx-pins {
+			pins = "GPIO2_0";
+			function = "uart4";
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&uart4 {
+	pinctrl-0 = <&uart4_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts b/arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts
new file mode 100644
index 000000000000..a88e9b949c4a
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+#include "a210-melonpi-common.dtsi"
+
+/ {
+	compatible = "zhihe,a210-melonpi-v1", "zhihe,a210-som", "zhihe,a210";
+	model = "Melon Pi V1";
+};
diff --git a/arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts b/arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts
new file mode 100644
index 000000000000..71752471c5fb
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+#include "a210-melonpi-common.dtsi"
+
+/ {
+	compatible = "zhihe,a210-melonpi-v2", "zhihe,a210-som", "zhihe,a210";
+	model = "Melon Pi V2";
+};

-- 
2.55.0


