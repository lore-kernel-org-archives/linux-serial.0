Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202208;
	b=m+FZh6/qftZ373d75WmOfWNUoCWo3X+kWltSgpy4VVRCjl1XFOzvwcjlFAgG473duKg3
	 fF4XHsZSgUlsfkl3clLVUikt+WMq0drczZ1WRqK2BhqkGg2xrHVCpNbX7vN9KaNiPotSH
	 1Ojl2judmqQm1eOGT9Re7q7yrY3Us5vBOC2TCdr1HeEb7/UeisrM3ZKv795agYmMjMNqK
	 WTNMVFWRbooHV+b9tf2HrC6Jya2PkUYIJrb55ThkaHWNbCv/DVuyM+RC8r32PkiFV+NF8
	 Kvq2GtL+wB6f8gFIwjc6hkGGHKpAixf123FyG5UHxiPNk1biMCLcIAIJbTrf7KtW3dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202208;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	b=glUllhsCnow68ait+JrAK8BhE/rC1Ti9TogPwvAhL2iKhhzs8q4cDTWF2pxzuhJWpIrU
	 XQ6rUKIXMS8t/sUYsa3CE22yLlK96KnRI90FYQRfetjHo2wQTn7bQl7k07GOmXpBuUsrB
	 6OTFlzKdKHUD8tEF/4t1V03g3R8ujYg6tIXdgm63LtynFZ08sEnQf78SJLjpsFSLu4Loq
	 /CkIs9QiqlgUQBRmsa3tx4LlPVOQB9HsB6vmp16lznJ0OewqQAfH//89qTBiCHDIGgKhu
	 zAr4b/iq8X6qCfiYWEphsrOEeBN56nGszjJDxUMB2Z5kDL8fKZMgnTN7pjBpDTtwx1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFA6fJlM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A1606C9AA;
	Fri, 20 Nov 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFA6fJlM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202208;
	b=MqVWBHyHz4ms4L5SFV6mtWg9qH6iAW5Jf8Pj1wRaqe/hDv/uBca2te/LdUhSh3SeBJaR
	 nAW0ESeAevW1TIySDr9pMupi59LM6WXa513cSTJGeRLFU0fQMK9Lt9usXbQAVsXlWPwrq
	 N/cSrb3J3ARKcJTLjjNqlMRKTE212hDr4NIhVQ8PL4N7datt5JpIQxbfZk83HQn94ucOj
	 ZKROWiaj3o92nMpm1ZLyeZtz98J6FN9MO3lILWXR21gFXKOraIr4n/oI6xbebumtnbC+Z
	 dwIw4CrXc7myq14A415cxc023cCZGs4XUSOn1iFGa6h7X6/dk4n/cdktO22C6whHw9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	b=J4XtsRvpt89YDUUWHnG/WGhOE/Qv3ej6CimV/nKT1orukEJL81xVC2u0v82JRHjrDv++
	 xI7FG+FNoyfaiTqv+njXH66Jq0Oib3BV4nJ0UaUSYSPWJUlVnc7th26AtWHioycOIy++y
	 mp/TNH3RMaFwRMWxBh5sESMFhp92ztkE8Cpz9bSf5+GITeKA5TLxLSQslYiJ5nqdK4V1H
	 Jx6EOQ2Ohkhu/RCAlXc32lAzWn/hoa5mPLDoF2lwkrU9HGy57Sirr6nQ5KxW3XxrnIKRU
	 XbhgGElH+zpA8oOzm0E1FfHnZp/tGSLC4G3UQcTQqcv3V2YcVN5nhhEbdq+YrXB2Utw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 401B41F000EF;
	Fri, 20 Nov 2026 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202208;
	bh=aCo6XwDUGKHrJrZqVvT8fOWO5dQALu2JDMEOxosLhT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TFA6fJlMFAAfF9TA/dOebPzqcynjxyWEg6hYUZzP3E8miRzlhr8cY+ig5ZrptzS4N
	 dVReXSuF5BTU3b66lS2BuQnqrLLRQ97cl6PMRFu497ZKVx6BABfap74u861iCVl9Jw
	 8lyfKth0+n5VJsItJASfbpqDqDjSyFlpB6NHsMVXCYb4tQuh9AAu6TjoOXkmmYBPyP
	 zeL09BwDdggfGxbk35FZvlZX9ddYDq9DGceGJmh9+AUeVXKc6kVsdoWr+jLclRKiGz
	 XyrQnhlQmefM/q2YfLEGIFwnX0EfAe3mySQdCzxYM5tb8bRBoC+yIfDxFtOhxNPPC3
	 0JFrcBIV2MEGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 558414B9E6;
	Fri, 20 Nov 2026 19:16:25 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:58 +0800
Subject: [PATCH v4 12/13] riscv: defconfig: enable A210 support
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
Message-Id: <20261121-a210-scmi-v4-12-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=2125;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=gbFp8UQIqmjgXxLfsth1MuBUL/I680UNXyToqmM6t9o=;
 b=mztsFAtYNvn27nSpR5w/p1fX6NaXvdoK5Y3VgHR13kbszgNHYcjKTv8C2HL+5NAwjHxDZ33Sm
 fpkr+FzExhvBl/3Ge5dgxmvFibTRDBpk/WilSpKD/X/YeF5fwn+3qFH
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


