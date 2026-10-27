Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115425;
	b=rp0P4fvWBijvgeW0nOjbLBRXm3l7qrA5Vjoj1hHi4tOoHAeMwTBHhhgVpDAlbsQFeGvh
	 AOR1r4ibyhgeRMkIKhAKmFL+7PPhQoPWd/D58FeIHdgsYi59j4XvMgJC1SypLbsMI82xK
	 /04jSEaiZOsw1d0daqFjtxybf1sKxDWcG4+PVqHTt6LJ/y5/gxFdE4oL0qSonbSdvUcls
	 jGn4bSlQ4pftQjVruTEhPA6sLjyMdRgnuTQXLIpjkv2hg1Or7lpa3+Vs1O9hWX5wbivzm
	 7pmkQy8bDsC6q6UU8fiu20i5vobLUA02U16Ka9Zm5pNYNcpKBaumA4+CzY6Ma203iWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115425;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8zdkSy4S9d8mahCstou+MAd3++gCJOCaSRrb4UBEAWU=;
	b=RYmRrSbdc42w36etL4rRQxQv3rw0TpB7XRH2EUr+jAJVTrxfZP7cOjgMSiNtIrheB3Tp
	 jtkd/k14ishWVQmTU71wAOf1kCUdeujGRQSoh6odrYa1ITdgh4A6jCwybKYe1oE39p8bf
	 LvjavjNTSDiqaxIiCdyFk/WcRaHX9magZJb/z9o049OOfs3rEVFGQjn34Xkfg0taNwQ/d
	 OVgA7LH5F1ATsisBeDJYEyToDiwv2i+YtUgjsHZKVvTS2ewgF8rYImwFEIRP673qbC/ld
	 jBZSildjc64PaiXn5QpTzcbb3Fph/XkQqm9e1gRDoFXrh6CoFrLxhhHhFxw2dbHSVUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebo1EUcv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114C60A262C;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebo1EUcv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115425;
	b=TPw/y8wrt3+iMCglB7apz0HDy0WfBDGowvcrnJmUjecm2xv3pNrFaZM6a0D2hXADkz14
	 AlgIA3+D8D3f7iB0u2jKaDGZENOhzZ7tx9TqqZn/MesZXSZKndDG1oX1xTdjkMPwZnCE7
	 kVARXbXbF6n/6DZJrARDsmBzgJtNd01LRoTy5Y6UglD/pP6ltIlpKGGJD5iY5b+iAA7S0
	 X8c5N26M9JmkuaKIR8184B3rWMg8n2HnQgC0vv6hQpppTWdD6DnDM1nRNzkrBsRYwZkgp
	 gGSjmJI4kS1UAkqCGj1VelktOVPRYkiV/vfqVgezUboXWGSrfzUQwXdY31f1EvhsKaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115425;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8zdkSy4S9d8mahCstou+MAd3++gCJOCaSRrb4UBEAWU=;
	b=dK+31QxFP1lBZfAHRbsBImu/6kBph/QURVqKxC0hlkrrQMHse4y8StP1dVGJKPeSMgAh
	 MYt6ESU1y3UYFJwJkilpt+dS90ZjlnpJrjE6Ta1MTuAwxMsyc9QYPDPgpYRR8h6QBjm+M
	 7nJUWx844KBxWSAXdqCvzhsNnNfZVSs6QrVLGuOEnJ28Es7oNRdOqnwxuXW7WwLIOc4Qf
	 a4LzBa5HsAmxJJAJRErTwcxc1TpSq5WXUlLW2RH7KxyD2IvbAqCARQfeXTAbl94jlnN54
	 idCxbu+VBUvFF96rrGrBAKABec3UK3yBWjz1zWtfxPcia8CKBwCl5IQHFS6/VQbdx7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B4BE51F031E9;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115425;
	bh=8zdkSy4S9d8mahCstou+MAd3++gCJOCaSRrb4UBEAWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ebo1EUcvfmzZ/mY9wwKc+oCbv/uFVd19Xq1vXyakOrs2McvmVbVg775+BFIbFfvIn
	 2hV1XlxRanuWs0RVw3jDfQzuTU+yPfW2zVanSV/PlWcWDeTUVL3YV04/jQ5tW1eggT
	 W7RDU6tyeT8mqJuQchZdDnXtZLPvs1j4lnoVYlbUjj1P9QdO+TDTa3yM5xqP7qmae3
	 C7z/zutZPTLc0drDxwh7gjiHd9DEyKt6/PsrNtImOVtCT8IQx+qdnE1xGPGnGfzxIz
	 /7XjliBBJqOBKwvbPL6DAgfztXeuuzOSlLSgweHnWsF4m8TrG/adYTblbbOetGEIv5
	 7UE3i3SWiGE9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A68145143;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:36:54 +0800
Subject: [PATCH RFC 03/18] riscv: add Zhihe A210 support
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
Message-Id: <20261027-a210-scmi-v1-3-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=1013;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=4BCg+toIRbmSQPVtgy4Q0XzWNjGrXKkDc5R8if2Rdc4=;
 b=1pDamW3QTPBKSSKzzRENwqiqMqVJhpTprOuArsGVVA8UErhZhB2MrFaIMX07VrlWigcyFgZL1
 WpehrKhtBPgC++sF6Kq8JbHl8+KDOE37eNlO24T6In/83R1aQLkLfpV
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add the ARCH_ZHIHE option for the Zhihe A210 SoC.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/Kconfig.socs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c4983..b9863ebd88c7 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -91,6 +91,16 @@ config ARCH_ULTRARISC
 	  This enables support for UltraRISC SoC platform hardware,
 	  including boards based on the UR-DP1000.
 
+config ARCH_ZHIHE
+	bool "ZhiHe SoCs"
+	depends on 64BIT && MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	help
+	  Enable support for the Zhihe A210 SoC.
+	  A210 has four C908 and four C920 RISC-V CPU cores.
+	  Supported boards include the Melon Pi V1 and V2.
+	  Say Y here to build a kernel for these boards.
+
 config ARCH_VIRT
 	bool "QEMU Virt Machine"
 	select POWER_RESET

-- 
2.55.0


