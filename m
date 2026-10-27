Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115431;
	b=h78HddRIpbycQJ9Yv/Jb4gRzJoLPPNKZxJ3AtOe3hvA4uUVTXsqnEKyvDbyaqqkJCTvC
	 bOexW69DS8mY9fGIPwdx4KXPrNzaUvBYslVfuFffX4UbGb2ikx7b1GtfZtU3lo9qTtAMs
	 JD3h5HNFnrXta0nr7+VrX2J5fRb80cvAu/N+d+GCTD/ptIKYq6S98TqSQn/WG0xjgZ3GN
	 0eLVgVJMDgrmKfgM9gwDuHYhY6q+S/IpFuOi+8B5o0urmRsHMjzFgdUiQzucTnoBdRsX1
	 aLq0qwNi8nQuQ7tuLSOLIV1ArNPe9gnA+S9TLiv4irD7bXDRpIaBxSKfS2LUe5lvp1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115431;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hwTvj8kvx7kCl+NNi9DA0xJSBtLAzcLn/PCRBAcCdhw=;
	b=ptcFUUjsWu17UD0LZwz1bISUATpfGzij8/VfG3bgH/OUaOcE4EHVIgOdDjtuKE4npcxj
	 Dqus/ACe8D1wLiD7/sNISIOTlemYFTjF0DSFUVNdma2e/RWrpHLSXcW6pdtseAt6nBX3X
	 tySeI02rSr8HSvvBJ6OGDRPMC7k7bOC8eZGw7WfZ2AY8ytj4ypS/ewqjtjf1f8/T4tQwc
	 sZDgb9K0Qv4erSa9P97is/IVGC0k/zWa5MW7ODZK7oQ4SQI8NHGz+NoR7JgWnSPANO+/e
	 Hsb7mieCfmj+K+Tgti/QZYPKP9cEM2cvUX57/vGn4KloQJ/RBm1jWfa3O5R4KmW+47Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z34K4R3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC260A6F43;
	Tue, 27 Oct 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z34K4R3E
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115430;
	b=UjdZxev0JMh73idLZxrDbx6qNx4eZvvHdOcrFKJ/OYgR5I65c1Mq67zCewYy5xiT67eL
	 fZSuIdeCo38bIipizgjCVt95RJkcLLJcj4xnbN3Rp6kdbDRhftqLcFOT54vz+Q5I9uMIB
	 Fn9U44VWsFCJPLbB08oet3PzMnHyYfRS8843oSz6pdnzltKQxzegMXHSVzILZ72oYHvu0
	 Hgt62NSoDI0rDsGZZuXAZMoD4qv1dyaUDJ+Mj25/JFmNn4aJk2hGUQC4RLjQXQIcVL7cS
	 GImOEyheRa0mVFjlIBmUDEMv1uormwhL+PxtvIZ5mXqNJpLcoS3mqjdJd2TyJbJxWdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115430;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hwTvj8kvx7kCl+NNi9DA0xJSBtLAzcLn/PCRBAcCdhw=;
	b=tQMiOAg2mpNbIvjS6czjMW7d7G3hGdRXCkl2W4vy2gvJRWrG3JHahvaSAYhs+tr5R0WW
	 +o9gDjQ0Qyhbo1ikL6FISEgKOnz9g2OP8HH0KroiVWE9UuJnyqhSin59RPLuza3236L+J
	 j6Mxz4oC8R/LuUONwylz1mbR3XhU6VlRZjX4cgdu9TVw/U0ovoCR327rVqVxIgCkIm6wt
	 A5T0Rc2PulTzsaKcB3M6+WlVyOcm4DutEOf5ca1E/3wEyLHOkl2CVoxnbxepJ923fxpf1
	 /e0VFABxZFdXeDN94oaZa7hI0upWULUjfc6tM9K4oKgUm2GMHOaKBKiq2XM7pbwypaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CBF3A1F01414;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115430;
	bh=hwTvj8kvx7kCl+NNi9DA0xJSBtLAzcLn/PCRBAcCdhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z34K4R3E7KogcCvkEbENyD/hZ5iWtaER/bmrHPZLgjUCkulGF6Oihd3QTK0z+iRRn
	 S1smm1tBnr0gd56A6162lpHDzLbWcU49opxSG7cc20r2W4Z3OvK5kusosx54OpWKpy
	 IfXvQDl569AN6ckIwnBStXeXCzqgBa+935TbOKq4p8nOWXPhotQggbgGdB7WL7kVNK
	 BXSMk/ZWBPUEjaJZHzLdS/Az+No7acy/y3rYWxfrBw0WpoZgTGWx66Lgrdu4lhY2Ei
	 4c9wExsiN13hajinK2/ez6Sa9Y+z+6LffTdDJNqLfUAzuwiaYCLmB0SrjwRCwRJudN
	 UaxD154N5hkIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA2DB4517B;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:08 +0800
Subject: [PATCH RFC 17/18] riscv: defconfig: enable A210 support
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
Message-Id: <20261027-a210-scmi-v1-17-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=2441;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=eAfD142qqOegiKKXIl8oNxyczfVf35BqTLu5AYylfSc=;
 b=5rQEWh1ufuQftCFfr2HKZutyk+sL0V2JGANqtYHunqZL6pI1rX1HSHn77Bvu0YAx49muOw7j8
 niuZBUDHXRqDXNLNx4WcrC+3POrtY4mJvuQlWDhp2YA6Gl/dfD+OCN3
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Enable A210 pinctrl, mailbox and standard SCMI clock/reset drivers.

The A210 has ten UARTs, and Melon Pi numbers them through serial0..9
aliases with the console on serial4. With the default four 8250 ports,
the ports beyond serial3 fall back to other line numbers and no longer
match their aliases. Reserve ten ports.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511..b4c4aea6eabe 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_TENSTORRENT=y
 CONFIG_ARCH_THEAD=y
+CONFIG_ARCH_ZHIHE=y
 CONFIG_ARCH_ULTRARISC=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_CANAAN=y
@@ -108,6 +109,8 @@ CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
 CONFIG_PCIE_FU740=y
 CONFIG_PCIE_STARFIVE_HOST=m
+CONFIG_ARM_SCMI_PROTOCOL=y
+CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SIFIVE_CCACHE=y
@@ -119,6 +122,7 @@ CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
+CONFIG_SRAM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_VIRTIO=y
@@ -149,6 +153,8 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=10
+CONFIG_SERIAL_8250_RUNTIME_UARTS=10
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
@@ -167,6 +173,7 @@ CONFIG_SPI_PL022=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_PINCTRL_A210=y
 CONFIG_PINCTRL_TH1520=y
 CONFIG_PINCTRL_SOPHGO_CV1800B=y
 CONFIG_PINCTRL_SOPHGO_CV1812H=y
@@ -255,6 +262,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_SCMI=y
 CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_CLK_SOPHGO_SG2042_PLL=y
 CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
@@ -263,11 +271,13 @@ CONFIG_SPACEMIT_K1_CCU=y
 CONFIG_SPACEMIT_K3_CCU=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
+CONFIG_ZHIHE_A210_MBOX=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_RESET_SCMI=y
 CONFIG_PWM=y
 CONFIG_PWM_PXA=m
 CONFIG_THEAD_C900_ACLINT_SSWI=y

-- 
2.55.0


