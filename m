Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648724;
	b=P5xKSFpGqiU7GqlstxKf458UNhvvUG4CF17Ni6ujd++64XYPnFY9ORzynuJzm9roWYaY
	 QijdIB6Z2OJKEa4cZa2FQUvIdLsl3furbGSPNoZJzmuXQc+61DZ6GaiqtDfdl8UqYxU1J
	 Xj2HaGGkzecQzqzTYzzpT5pz16tyjUJYerjok4B5qipLY6xeRUSwiuGM0f2VlwggP+G/C
	 9vjaGOf2lo0Ggrcn8hr/126HFdyc0dfNWbRuiJob/z8VnHFlayDKGwvgY3qb7X71pRuQh
	 d1+rCDyee3J66MMSTfBkbW7+OZVto4sc0ORXmVwipW57BrQ1ZsdYj+vVz7Z2HkYFqkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648724;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	b=PgtYT2L2jbNlpR+H0sSc6zh/agHBjwl4c2ajgjoYU9iXHYvPW4yFyAAROHKivzIaWzV0
	 /lb5Bx47lMYjfQQQIhz9UitxAm0OcAcP/pg5LRoo/Hck0iJaVxi3DTW++vrZMwHlez55o
	 urEGj7AcTnYHPsH3f/hrxTmUgiqFiNnI1xBlezLGT8BbP4dx51U4kxRmm4ihZV5UJKn0e
	 I4E8vxyh1kRjyj/DIVt7gBX0JgQb7aHYvmgBt9l2u8zo8+cD1+CQsapO3JJXe4WMlsA32
	 PB3+zoTIhGChZrrMiL/wTUF6NTVagf6hr/GDqpEH2fS8L6Eqa3GZkoooVXoCEAp6tiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZutfjvTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121F6085099;
	Mon,  2 Nov 2026 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZutfjvTW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648724;
	b=yWcmbEounmY9uf64v9G7aVZ31gcsDY07i/6mPm6qumkRig8ZfmrEcerEgKpVbCKC/TYX
	 EkbBTcQGY4e9UE+xLTZm59QFx6UNioatBpXk91/ryYpi9Ap0d/0W4yjvL+k3IlQdQ9psW
	 mNfaJSqKBjwJX6/tR+lcl4t85v4X0vJ4hSvF+QmpErjbHMcKc1mS4jATiYj0UeT0ocToB
	 jCUcO32NyNly52J0vLlj3eI72TnJBkGs/oIjtmsWwInzUPr10Fr69p0lWe2LIiw1Y4FP4
	 XoJ/KWBXC1ZnkmG6e1OXPYagNejWDsQ++gBZsOV2TVe7gpQH8Yx0LfnLRwdpgMABz3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648724;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	b=MteQcWtSHajKSdjAKRep6PIMxlkuppafRWa2ehywROohs3dID7SAN3BGi565cOvuYN0L
	 R3a/wJwGsAu8o3axQNNZ7J5xpwIHFlOlF8TaKTfi2FxIeMjI2M6Wq7f7sKRyELVtphgeM
	 YXDEF7NiCnjrgfV8lQtJFp5THK2M13NhiHchjDpFoWfzr3nWxsJmYNlGzQX85JDJja/rL
	 SuM1fSSrUnv24EcPzQWYiq2V58I2rKkmt4JlYmUU09rqvRepJ6+83l/NstY3OBYVgUEzF
	 K+l1KBwvNkhLm6sFjAALiGCl5Up3oal6IiOfvLFiu33dOCPOKYMQi1JQr3nyTDKw6JA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E33651F0180C;
	Mon,  2 Nov 2026 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648723;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZutfjvTWEPO1jGYl550spBI5fhcN1W+0bk0lJ718Xoss0uKIU853700AMNV/tHRQr
	 m80mjBTO+YGoDHNCBUK3V2Ia44Hiig9dmbIJsrNCgMS6QLUHbvZG1bKCKguv3du8MC
	 a2/D6nXCyn90NYZX/csgtKtVu2PCYk4vwx7UkG/UgN1lv3bzh183tZIIfxDcU8Dsnl
	 1gfTCZ/chQ0A61Zi63dNkfsIFw8Uy7aHI043rI1TDVzoJ5k4P7hul1guYexSYrOUNj
	 zZ+57iLPpjPRNfZsB+Mpi1JeVHXtPgsha4SoM5KhIhRjR9mytWoDODXgViJksb12Bc
	 AfjLvB6xEuRuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A62FA46641;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:19 +0800
Subject: [PATCH RFC v3 16/17] riscv: defconfig: enable A210 support
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
Message-Id: <20261103-a210-scmi-v3-16-ee6b31580808@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=2125;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=gbFp8UQIqmjgXxLfsth1MuBUL/I680UNXyToqmM6t9o=;
 b=Dh1vBF2bkMeI2CYu4RYDr5VU3Y4Lzwcq1wHwve5KVlRm15AJiGEerFvfdmFnAHx8jRLA7J3Xf
 rGIOiX5jaYICn9CAwkrVPMCQ0Pg4LKJ4MVDn2113pKtBU9UIQ8xi3dN
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Enable the A210 pinctrl and mailbox drivers, SCMI and the SCMI clock
driver. The SCMI mailbox transport and reset driver follow SCMI by
default.

The A210 has 10 UARTs. With the default of 4, UARTs beyond the 4th
don't get a fixed ttyS index and end up in whatever slot is free. Set
SERIAL_8250_NR_UARTS and SERIAL_8250_RUNTIME_UARTS to 10 to keep the
index stable.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511..e9275be22e8c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_TENSTORRENT=y
 CONFIG_ARCH_THEAD=y
 CONFIG_ARCH_ULTRARISC=y
+CONFIG_ARCH_ZHIHE=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_CANAAN=y
 CONFIG_SMP=y
@@ -111,6 +112,7 @@ CONFIG_PCIE_STARFIVE_HOST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SIFIVE_CCACHE=y
+CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -149,6 +151,8 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=10
+CONFIG_SERIAL_8250_RUNTIME_UARTS=10
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
@@ -168,6 +172,7 @@ CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_PINCTRL_TH1520=y
+CONFIG_PINCTRL_ZHIHE_A210=y
 CONFIG_PINCTRL_SOPHGO_CV1800B=y
 CONFIG_PINCTRL_SOPHGO_CV1812H=y
 CONFIG_PINCTRL_SOPHGO_SG2000=y
@@ -255,6 +260,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_SCMI=y
 CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_CLK_SOPHGO_SG2042_PLL=y
 CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
@@ -262,6 +268,7 @@ CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
 CONFIG_SPACEMIT_K1_CCU=y
 CONFIG_SPACEMIT_K3_CCU=y
 CONFIG_SUN8I_DE2_CCU=m
+CONFIG_ZHIHE_A210_MBOX=y
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y

-- 
2.55.0


