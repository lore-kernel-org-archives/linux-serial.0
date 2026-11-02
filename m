Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648712;
	b=V8DdvlwzAR7rmDJkaPc9blW0OpIYUMxyCjGedq+6JLSbYVQ3DtpURSb9qbENy4TR8WXr
	 4oAd33d5pk4/NYIW+v6XtALuI1JJXX+BDqsvpPZ3w0QPzbIcHXl3IpoCrl0bPbtmXLN90
	 /QWqDRS7A2q/pCNf1iCQ+MsH3Xg7+Fo32SF3YNzr/CHIx159Xq6s8fjaj+St7T+nWHl6o
	 P0eGQD5AaTvEIoLIIXalH3FGXa3PwmQ9GPu6T/+0TnqW1cBPannbqmR2+3tmfRnNZDOFD
	 M/k483M/iQJSjYwcTXpuqjPqDPAK+IFa2h2IceGw0f1x0JRPqXYYKQLbLlXD2pxDQ1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648712;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	b=4mBDZjNhTWYHMfzzBfXPhOnycclLyv2AJn2P1NqDlCYuLiBWh2PYC5scxhytCTYBrJGB
	 l+aypi2nkXkXcew8/5yKbDL45/TbOpUtwMByF/EJGeJdWtly7R0TbqZaMV7+HKo6S3IKN
	 6kFXhP0zxbarhH0uSkny5YoGB+uO/aC6d2uLpCvmkFICIdMvPRRUgESoWnIrox7tmoSfu
	 3Ba4vReqX1l41JrKwthJs4qPFjcg+IAidSUnjb/G87GtzHbeg9jRWVLM3OlBuz+8V/CMC
	 j3QP06CTjWD0HHcH1P8Q5BXmk1XCLJlJS3s0tlzlQWRIR+aVnoOY+mpkQIHYs3IXdKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipo59+gg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93EB606D80A;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipo59+gg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648711;
	b=nCbCdpKz8xSCrngA3Y2F2D7Vny00zp3el4jwGJFanQUUSc6b3qcBMOeOkskOJANtnGTi
	 BWeX7YyabRYAGOK28eDgzRfEUuqyXGrzHJ+p6+q3yo62rehhDUGdv+exF/sPEkzo65aq9
	 DrgaaZ830irmOG9/AqPOQVbDwu3KWOaLEfNNyyVvfekDY/CnbHV+uqjQ8lblFlaU4JLkj
	 Iv3vdcC8HWE2TRYtcy+gaoee1tHlMAjxfm1zXeB92qTkK2tS9cPFhhW7yaFhm9R5SNNjK
	 VnTKcyizPxGpmoEo2EVQefL4VPzH35DZmXL+iquyTU4sJoGtEbwJzmxUkBYJ3ICHvcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648711;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	b=WfNSS7lOhQ6kuqCmUogoEx3nYELUHCQGAQtXuH/zD6kLqRGgqMGNKG6TUzWpFNyE1JEf
	 X+6wmSSby7eSQva0Iy+3LYLh6epFausIwzxTh75TYThSd5wzDQwuEFzDBKU1TZU5fGrAW
	 /hJjbzOc9wUUodjhd94Uvhk6PXJWebr0CvOal320ppnvqPgjRGMrqydekY9LvgesxhitT
	 jX2DgDx4ZI0jQ9BpF3J7rfVjTFCui1uTb69kgnqUlYnWPxLtPe4fp+t1oMS1ouSOUHdwM
	 HzcctaHh/kIZzNiFYTZ2FbCwlExTetmuI1G5R9V0Uuh04bgs72852XVyI0jfDRfB04g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 55B8F1F00A20;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648711;
	bh=X1gs5KeCo1v5nVzDOONX/rjGPthdxfNaqSCGYiFENeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ipo59+ggcxFRtMW5bYfxQ5M74mz/GYmwgxlBwSo4vzGqKB+inZ0mrMbSRWB6+94gg
	 q2FanmVkIq0ePHFgZqd66v43NmfVl4dX1rNSDPTNQ0JOyHrmZeS4gjI4TD6Kkmc+8m
	 MrZQxgJRolgyAqUVYELGedKn/pK7/6W73B3BqnOFtWMFmO1ginY+F22M+U76/jBtnY
	 hJui9woxqQMsMngTuxtWdc0XR4C4rTwO0LjxLTyXt1nBT9pNRcqEV3YidFRrExuTDX
	 ojewSRZDzrfltFCJQ8/Hz2amuebW8gTrOnmWIgoduEETl95CPyHof8sI0RVxOy49go
	 S4HXSYzOY+UIg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D0A624660E;
	Mon,  2 Nov 2026 19:45:08 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:06 +0800
Subject: [PATCH RFC v3 03/17] riscv: add Zhihe A210 support
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
Message-Id: <20261103-a210-scmi-v3-3-ee6b31580808@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=1016;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Xvkj+SoMFEM0aCTapUCLJM3XOLxV9bGDyfr9qshYbdY=;
 b=I0TapnLVfQ9sU2mdSncHY+aBiRw1rfxabNHXOZ0jJcN3NsSMFr7CpeOk+ZPgK//QAqF6BhYuQ
 kGNPy/GvyfcDca9A7qNH3luBDY3/Raumnjxfz/13SL/GE4neHTY4Bwa
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
index cecbce0c4983..9e096feb79b9 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -91,6 +91,16 @@ config ARCH_ULTRARISC
 	  This enables support for UltraRISC SoC platform hardware,
 	  including boards based on the UR-DP1000.
 
+config ARCH_ZHIHE
+	bool "Zhihe SoCs"
+	depends on 64BIT && MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	help
+	  Enable support for the Zhihe A210 SoC.
+	  A210 has four C908V and four C920V2 RISC-V CPU cores.
+	  Supported boards include the Melon Pi V1 and V2.
+	  Say Y here to build a kernel for these boards.
+
 config ARCH_VIRT
 	bool "QEMU Virt Machine"
 	select POWER_RESET

-- 
2.55.0


