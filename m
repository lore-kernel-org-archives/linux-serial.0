Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115429;
	b=KAhyKchQroZ6mVmNQGz4JzQ/9XRmBLLAGkZIfAnn+zXxlYoNTRk4JAnYCVgltkIM0RzM
	 AJEk5FoAMsXz4bZ6BY/jrNHL+H1HE2STnpqni6NB+cU2PNcwenGlqsA2HMsb5Co2Q02DP
	 KTVRjJTHEGPZhhoWjL9l4cvsNfSDcTNS+kDPvJpVYKfJ5Qc/eMdz0nkYl0Z60hTUbQepG
	 5UlOPCNCWlixhL9WkAyp9+NF4bTdpWtohxjnK5Zqdr+7Rj8Z1GjHwWBDfs4eMMuPMN+op
	 AWookC7J2+t6rA7B0D4eXvmPtlJtMPJiDb5Kw1atWSD9euNrzq/N/oh21Bs/8s5cw8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	b=4+rGOaGzOeITb5DSj4iX72PndmzOeaGYifOEoV0Q49H+kTqWRziSK0jQDE4kaAq/Gj+L
	 yEjljRjktfD5XS9kRO6d2urUcqNLLPS0zoPlHZNTDWWQsLvEa4ZCIDEmen5kM/VYFBtb4
	 eQEVOZdm4xT8f/c38aNNrXMDpKgh+ggPUKRj9wBoB76OSL5IpDOkhKidv9xDfHvz1Ylv1
	 zoSwdd4khxjOzABriq9oD9cq4dPfjpIY+KZWnnTUibWE9oA69q2z8QpufqLJKV/hBZTKC
	 tK1UokCUiMKc9pG6Fq5hmIq8tusX4E6xQSwlerWDA/BsNgpotZlWkmO/HmmAN4iNeAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K5/jYBOM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126660A383A;
	Tue, 27 Oct 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5/jYBOM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115429;
	b=WwP3l3zFIke3eIhqzf06II2bPE+MSD5JIoTKwNnIWXAJFDKaU/d+mjQq9VS6VxPU2H9P
	 fR1qPAo1DFp6eNy/lF2RhooigvtxheVl4aUef138j3RbAjABEKpYFXIMwfqmklWupfVIG
	 c9bckL6z3GkuPaa3E71fem8gljz3t6wao4Sl+MPzGsID59XhWathywLQno3WcvdyofKlM
	 UrTN+b/t2ge2X0CZa6qtPqv0y73F6WVw3NqpGOiwboAXfu3lZhAfSS/s9/i4lGDz2r3Ge
	 Wg1ypj89FRKL07wAffd2nE+hnn0vpZK3Tt7s3q3ZL7AUxgaBl4jI3ewSA2dM8W6aKiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	b=kdcZbdN77xYGgp+RI102ad2eN8JpPpOxLsYZm5LMv9B0AceV735HynuGGFsT0nAbqwZy
	 7DVNiIF+gl6cnvQEyDzt9/w8piGqmsr6pw85QgSyxfX4TfIlc+neQXd+ODjQzZkf6EWOV
	 M/GRNQOshCeIBttzgtPT1LHFfNMgXtSn3BQ/SdF1Sl7eZnRQGiKXN7eolKvVKeqrDoGft
	 btiDZzfTI2ySM/pCRmPN7inHpHBTKlHbaAYqIRQvucL3GMBPUtqS82CH9L/A/QLcFRVbQ
	 Cv/l26cWAOkBerBzh45vISnnjUgmY/DUa3J18soQiQhGAuq68dSFVabk6iiUJnMWJlw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 735A91F01408;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115429;
	bh=Q5sP7zJDVKsg8tL+CekeKmX0pZ6GZsu9tbiTl6q7uqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K5/jYBOMynzC0NNf3smd+hYP3hXm2F+kTFN4AncaIQO/qXU6AWaWoAL3SLXFMYuZU
	 B1NALvBBakgDIUTbmHik9ZeR8QHN/onpb4mRe25CW150pkCnOc/KTplHItzsVL4096
	 TkFr9yOB5xBWGlftJSSSenW4Y84gAWLrmf0iJGl963O5CSvZdhEXSDwbNAnl0fEOba
	 xY8gripuaPsO9JxT0QWTkYwEEd2aMt8Sz0BKmymGmN0bklDO9kuUqIcEFBOKNglfTN
	 lp8uQAvbndrDy2mjzdeL9WEiJ9MPgQY4P2TMT66cVjoMmy8Xa9I8dT+a6Y1bGZPs46
	 zjU5MLRwwFgcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CF6A445177;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:07 +0800
Subject: [PATCH RFC 16/18] riscv: dts: zhihe: add Melon Pi V1 and V2
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
Message-Id: <20261027-a210-scmi-v1-16-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=3373;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=oY4cd1y5LBziUvIW+aG4iF3iEAIqMm4nbEZQYJakX5E=;
 b=4tiMJ27dq3Tmofw0aIhQnF/GFOKjJZclGrfTcCcOZ7U4KV5DotcDPjRSTf9e99e1z17caZh2u
 WaAJAiTV8wjAkN0lTpG1Wndpa3NLV+shRaP/Yd7Q0QoCnNHHmrDzrmg
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


