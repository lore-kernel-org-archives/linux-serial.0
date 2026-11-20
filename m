Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202205;
	b=bNMFYLS1hwpIxbjUVvIA1MS6tutnAdIDgsjFQr31rqDstsSKZ8aNC38p334/+dZMwXH3
	 8OvTDuOnE4xqOs9RK53i74nQNaM8qJzCZtV/uBPvcxxcweAyLORic6xoY8p7Qv83/2Kzy
	 Mw/r1C4dnDyzuOcqYCoMHFf6HurZApjkJEkcCLC8JW2ifGUZzQoAwCZ9wsI7wEKWVWiB9
	 nXYYVrSMVXKqlDJnXdvmIy+3DLu4SSdjLExcK0Y1Inlchwid+F7FsfWZ9jJ7Y8WnxRzU5
	 NRPp/uzf6zl1NEVlTKYfdWTRTvmBDhL77/1Jc/WoqQR1yOPVo9BerE6R5++k2TQvl3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202205;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vuLX4aqv2NwWnayVJvuaUsysVyU5Yw4azjI1P5BNB+M=;
	b=ZHzrzaeEyDy9z1EgxkIhzd2TSseS2j1KvlYLSlictz1oUQDLAMl5ltpvzaD2a0BrJYUB
	 av/aHPbG+KosOz/g/ob1ZTeAH0vCL+rYUQdNk3VQfOlUqXqhBpnQW35BBoqONsjxqdASz
	 1PnVUZfRROn/Jm94Z5u/O62chkyqaJj83K5L+XEdZI1ncPqz30PHcULKnddIKdUcZ4+Lh
	 bt2A5AjTIe3HDgG4aDmDlP9QbwOAcHAhnqMAJzwh1sWFfAb98fH2O9/Qs6YQhoIq8s/w7
	 KNamKjAjYzOKU81dT++h12BfDJ4xk7mMDuxEWUn/KAymm2NwhXLkPNQxlCcKr4QLpMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcOUpOTp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF160A3802;
	Fri, 20 Nov 2026 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcOUpOTp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202205;
	b=Z8Aa/2CTnUwAXuTtfDGm9ZJ9OW0XvKPMzJe6kZZd1vJmXc8OzCl8j+Luh6gn6JorNvI9
	 jqCNZ4dSjYkqqDMueqfdorOoyFYQRtUKspX4LSJJI9x0McztajsezrFPAWwygovUiuShO
	 o7nA5+8Sg0Fl22q2+CEyFOp6+jci09aTAzTzwvWTxAKi60n3euRm2ZNtNWDY2HHXLjQcQ
	 uNBfAHpg5FVe6oeTsyCbcuk0jEwKj8z/JlQIY0dgyV/RlBWNak9TGrct2eyKL0j1Adao5
	 Ub6Sb6Ox564JD1XhnkmVgon7Pko0qQ4fKb3zff2dke98bkYLHG63QnSeuGlncFIoV4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202205;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vuLX4aqv2NwWnayVJvuaUsysVyU5Yw4azjI1P5BNB+M=;
	b=NQNc3P1R54utQsufB5mhCkONdB2aJiBZot12cfXpY2I4glTYQNDqIT8YDrS9bN0cJKDy
	 ef0OXQZZ3o+mf0VRgDAW+dtpofwqCA2eIsZf9saY+rIxe2V1Nq82Do803y5bOST0p4pzn
	 6IR2LYlgpD/D6/bfCGxWdWJH4xCMbivnyRcbfkzFvhhy4Qxs8SR53s3LghOKoUvvFuQR+
	 S2at2IrHNh9jk9G/wzOWqkSuWjw0LiaHO/lW0Nwwu2uUrXNFdEfKFo7WuyhJNCb6YI0aU
	 5nbl7uoNZ9k6Fb8Hos+dQtlB+wIrH2NtaG0ct3Y4gCxIo5u2auNwEf1SVbeWWpRL65w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F23AF1F00A03;
	Fri, 20 Nov 2026 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202205;
	bh=vuLX4aqv2NwWnayVJvuaUsysVyU5Yw4azjI1P5BNB+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OcOUpOTpXi+0aRbd7qpr914z9sBnAB3+qgmMNVNiuAoaiCTWrWPdKLnYwkKfPijI3
	 JZ8m6pbQ+GI1mfu2uZ6QMHdrrYG/OJRmbBqxxtCjiKYB56SqKh1q2u4zqhhrmg5Fyo
	 HS0D2nwc1InRqjt8CdEC4cLYCqmMMC3pV0ulpfKb/17GH56O1iX2+p7wxbPojGt7CZ
	 P4v5tIm8MZAQUExd4iErPKZeAeWOFOCsp4jrvxVvZONLnCGxGD4MH01Rn7TG1hVAK7
	 fPB2y42nfkFaZ218Yc0NAqtGC+BiiHrQ7WRR5Hb3hydhwjVK4DnyTWpzygvL+ld+ux
	 gRhqVeHEFtuMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F26424B9DA;
	Fri, 20 Nov 2026 19:16:24 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:55 +0800
Subject: [PATCH v4 09/13] riscv: dts: zhihe: add A210 UARTs
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
Message-Id: <20261121-a210-scmi-v4-9-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=6182;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=B6tm2OM7jOdMucw1zXohh3+kCm1z/YVGQ/Bj++2MOGQ=;
 b=KWBCjhAsuHQloEOkwOWCWYFkGWeNr7GpUolpsfipMR6L4yL6NmDd0uOfd2mrVr7aysPz1ktcA
 cto02UPVO3lC929xmB+/Sm9t6zYmC0ppBst1FV/01pTqSuxZlJyO0hT
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
 arch/riscv/boot/dts/zhihe/a210.dtsi | 160 ++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/riscv/boot/dts/zhihe/a210.dtsi b/arch/riscv/boot/dts/zhihe/a210.dtsi
index 6d85d94f0af1..caa3005830ca 100644
--- a/arch/riscv/boot/dts/zhihe/a210.dtsi
+++ b/arch/riscv/boot/dts/zhihe/a210.dtsi
@@ -353,6 +353,70 @@ mbox_e902: mailbox@320000 {
 			#mbox-cells = <1>;
 		};
 
+		uart0: serial@2014000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x02014000 0x0 0x1000>;
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
@@ -363,6 +427,102 @@ peri1_padctrl: pinctrl@2026000 {
 			status = "disabled";
 		};
 
+		uart4: serial@8401000 {
+			compatible = "zhihe,a210-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x08401000 0x0 0x1000>;
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
+
+			status = "disabled";
+		};
+
 		peri2_padctrl: pinctrl@8411000 {
 			compatible = "zhihe,a210-peri2-pinctrl";
 			reg = <0x0 0x08411000 0x0 0x1000>;

-- 
2.55.0


