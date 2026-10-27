Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115430;
	b=CRsKJNlNKf+NKTjGBCIywmGlLQ3uxweUwXHLrBUfVK3AfaEUa9QAS/msBktr6uQ9jvXL
	 p0zY8N71PQB2tmOH1llZJPV6Olfblnd5UrbkA1SbMe7F1QRgbnoVdou493FZU6k8INMGY
	 W3vGomLI9VdJM6onKUZSL2G3gY+ZQYTkJKGb5uJK8BKkpthJLS3h8LnJyShAD4Q8QnDaD
	 ZMjytc9STseFIYsqJERUTrALn0T3kPHjK1mKXwYgir9+RfUFqpuLHv9Q0Ot7//GgGwXbU
	 +bbtX5ba8sgjk12ZRw8WUcYYROq9tAbg5oqUxu+sMuaiJZAtMyLqyvPJMrXZ3KdfS3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115430;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=+p3cu7D5opnUF2UdppBUge9QydMQLoSHZJ9keRNgKhk=;
	b=bb6QT2owNK2YkPA2HGxesuz3iwy9T3ixULHzca/ZS57li4pRYFSXG6PmbmrfqaChuZ7L
	 jL7sWwdSFCG/G1Yi3T63SZIAa01XUbl6Dno8fRWtO43Jy9zZ1mJGqQeb5eePUWcRjBnSS
	 ZWRipAiGlTF0H2h3mO4MunU2xctXvMEhkDmnmd8Cov78Ias/HgPVBNrcj//8uP7iRjvYZ
	 sfDqEIoCrZ+MR0Fn9jTp5D9fSrAyPrbvYXxv5/7EymSzl34PVFdyBYdLplpGWXsiDq4Qn
	 MuoRuPSmGXJITUrp+4bwQ+mF5tFrzqXii17hwIF548WW7W/Y7hDtTZNNNoSgjiT4dHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm8OtCnY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F560A5BE1;
	Tue, 27 Oct 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm8OtCnY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115430;
	b=2Gi64QNKS9uYfhGhH7W/V6x0PVbi1HpWjb98NsKJT++GL9p2p+5ojYjfwd+yVhZS0dpE
	 moZSJmOBdI4BIuC39cbui6UZDpVsc4Jr5bPRGRWz9f0l1vw4+nwDVT23ltPAlHb4szRaX
	 EoGVevlqo6DMNyzrivZuY1+qSRxlnJPyP+zoUQtql4rah0AGGm65RCRwfolLMYmXHZYBW
	 2ZkbVFidzxGu1amZ+a/g8R5NGltBJQT8Ersoje5aHYvhL1QsCJ9THjtC78qlyCbkjLhYO
	 Dzzb/vgw7bmxm4LAB2zfCOg9JhC4yCCSGb6Tqgccf3JlSMxMxKcp+Lhzpsc0wgPinDA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115430;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=+p3cu7D5opnUF2UdppBUge9QydMQLoSHZJ9keRNgKhk=;
	b=jodnIeYxmlxvrG3xe+4iFPXnqyHJevRjb/xErBthTFjxJpV8plHjHQ3lpVSDdibCtDBr
	 49ewUCK3ER9WDcYSd9m/EHQ7SUl0CZM/7nBX6g394z49qZb8tk1ToPHkXRL2exxYcSFsc
	 q1AZEZkpncYRswLznbdRpPUUZY7zXwm1zAqKU1BzE9GkgNKMC/k+v0v0/EUnCYE324pwT
	 EWOUaRDm8xPhlTtyzP57n2EhyRhBgp4MwrVpYsQUEUcG+cxzxkFqW7gNaCfi1wBb2PK4v
	 HrNJh3MBbtIth7Me6PB/V9tyzyXHloqhCY715s+cfLHTDdWrikJfc3eXhUUab1jfM7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CFA11F01401;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115430;
	bh=+p3cu7D5opnUF2UdppBUge9QydMQLoSHZJ9keRNgKhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jm8OtCnYUxOG3KyVcEDIxeW83TNSPyH7jeMQ/GbKBwqlkiv6EYxO8HtdjQG8d4GA6
	 4L0hsxzhEnKZlQva8G47mbF+IJDhB4ar3cm20d4RiXCVU4FIqTc4DdlDf5TJqPxK4k
	 Y3pKv6GvlnFVL9e2dly8y4RT7em/CS9WjIYax4uSiZqAMNSUmF1OIsq/iutbWDUlPY
	 P2fCzmOSYLN4Rz4LsiuCYAx2BgLfuvJQqzcQ2w3Ef+XXdMHfp6UbJTQARu3NXwmC3Y
	 EsAMbPV/USM9cei0x5zba9rtPF2rr/AxCoUwvAX5ijVwrw70j/D98mXfHfdDdyBC4u
	 3s/sMOERry2Hg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B9FB14516F;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:05 +0800
Subject: [PATCH RFC 14/18] riscv: dts: zhihe: add A210 UARTs
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
Message-Id: <20261027-a210-scmi-v1-14-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=6132;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=rRW4ylMF29ir1IYBIWF90YJ6C63CtXasTioTY26aDbI=;
 b=1orY14EtxCG4UhYuWnQ834lieUC3qIb9xnmL3IQSnQDQFuyeI0SpvadwpLUUAs6OSIQjFUlVA
 wXcEkKSq3ZYB5dx+qUkxDO/Qz15DPQZaTrPQiVPtERk3SDHK+C+QGWO
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Describe the ten DW APB UARTs with SCMI clocks and their separate APB
and serial resets.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/zhihe/a210.dtsi | 161 ++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/arch/riscv/boot/dts/zhihe/a210.dtsi b/arch/riscv/boot/dts/zhihe/a210.dtsi
index c7b623800aa7..a23f59394659 100644
--- a/arch/riscv/boot/dts/zhihe/a210.dtsi
+++ b/arch/riscv/boot/dts/zhihe/a210.dtsi
@@ -363,11 +363,172 @@ peri3_padctrl: pinctrl@542000 {
 			status = "disabled";
 		};
 
+		uart0: serial@2014000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x02014000 0x0 0x400>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(0)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(0)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <321 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(0)>,
+				 <&scmi_reset A210_RESET_UART_SRST(0)>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@2015000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x02015000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(1)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(1)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <322 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(1)>,
+				 <&scmi_reset A210_RESET_UART_SRST(1)>;
+
+			status = "disabled";
+		};
+
+		uart2: serial@2016000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x02016000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(2)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(2)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <323 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(2)>,
+				 <&scmi_reset A210_RESET_UART_SRST(2)>;
+
+			status = "disabled";
+		};
+
+		uart3: serial@2017000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x02017000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(3)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(3)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <324 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(3)>,
+				 <&scmi_reset A210_RESET_UART_SRST(3)>;
+
+			status = "disabled";
+		};
+
 		peri1_padctrl: pinctrl@2026000 {
 			compatible = "zhihe,a210-peri1-pinctrl";
 			reg = <0x0 0x02026000 0x0 0x1000>;
 			clocks = <&scmi_clk A210_CLK_PERI1_PAD>;
 			clock-names = "pclk";
+			resets = <&scmi_reset A210_RESET_PERI1_PAD>;
+
+			status = "disabled";
+		};
+
+		uart4: serial@8401000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08401000 0x0 0x400>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(4)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(4)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <325 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(4)>,
+				 <&scmi_reset A210_RESET_UART_SRST(4)>;
+
+			status = "disabled";
+		};
+
+		uart5: serial@8402000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08402000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(5)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(5)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <326 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(5)>,
+				 <&scmi_reset A210_RESET_UART_SRST(5)>;
+
+			status = "disabled";
+		};
+
+		uart6: serial@8403000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08403000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(6)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(6)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <327 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(6)>,
+				 <&scmi_reset A210_RESET_UART_SRST(6)>;
+
+			status = "disabled";
+		};
+
+		uart7: serial@8404000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08404000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(7)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(7)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <328 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(7)>,
+				 <&scmi_reset A210_RESET_UART_SRST(7)>;
+
+			status = "disabled";
+		};
+
+		uart8: serial@8405000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08405000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(8)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(8)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <329 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(8)>,
+				 <&scmi_reset A210_RESET_UART_SRST(8)>;
+
+			status = "disabled";
+		};
+
+		uart9: serial@8406000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08406000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_UART_SCLK(9)>,
+				 <&scmi_clk A210_CLK_UART_PCLK(9)>;
+			clock-names = "baudclk", "apb_pclk";
+			interrupt-parent = <&intc>;
+			interrupts = <330 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			resets = <&scmi_reset A210_RESET_UART_PRST(9)>,
+				 <&scmi_reset A210_RESET_UART_SRST(9)>;
 
 			status = "disabled";
 		};

-- 
2.55.0


