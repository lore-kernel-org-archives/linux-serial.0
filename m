Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115429;
	b=O/ozJbrzf21L5bRbG11n5yvrgJ46brP9ZFobU3Zgpz2Q+5eMS/kdwSXvD5LkWj4kkgVy
	 nAGw6VWerxvk8ufxccRGcf1HUJkBjOXdaWgfQMSgi4VND/5qu28AfXOaLdVvoFFNqdm6Z
	 fRc7u6ltaq1Dj9OHe2Jby/TayyZ9aolJwCjZMytj804S93nRT3VvYuSODzS4UKbKtfOUi
	 piOXo1kd1dwYK0AOsmZkP2i1LfS8KkL+MUPiUKfGbbGoukGjdb1nY2slBmKJWegnUyoVl
	 p2eKPC5h0E7b7Ot/Cp2qT2oDYcPoV/uWcOox0MZnDDiSQI0cr+w7FB31qeExKa1dUQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1zaehfOEpJIBB309vW4ZfiHlvl8pXwnDzU4ZiFmfjLs=;
	b=XPV/DujFgvpAJYt8hFdiqCRAVspicO2dTIG/X/nLGw5TFvN9V0Bv3cAHcUc3rKtD/K0E
	 rL3snXWloRO6INXQFsfkbyRclDfA1goKjbnzJ6Sh2oEysvBolKoEsqSbQgGIWveQvJN0j
	 fw3vRTbn4feeHAIYZIaQB/tDMa2dk5TQGNcaXyyER8kNdnNBdT5ffLHqwupuqJfojnbwK
	 JMgYjRGzI9ggtibCKpIKNaaUJeYoNlnZYIswlxen6+jpZCL5UgtOYdutVb65/WiCCgFU2
	 cPoiT2yvMqZGdKTTiMA+hjfTVHjUiLRoqBUatugUSqexGAKFqWus2BdHj0lYevxJS1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzgxugg6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20160A2601;
	Tue, 27 Oct 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzgxugg6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115428;
	b=PhJfo9UrLkTsWJ3CPLRsgXkHwArtNunPxUJzQnwSJEknuRfuJTJmEROmceA/dCADUpH0
	 pQ00jRSF3ozronkMV6Jsxk6/Z1HLuWoz/TifdHj/BMTEUE21TheUmPxkST+Twk7D5SPmN
	 7+gnAUwDYgJ78Yn0K0tYxj52KSiqysU3Sv8fZ7D7aHhiU7sEGwinVQb/sojYZt2Agl4Ds
	 9xxZt45RM/BARErYZJ5LkjoHoT2aC4cUuf/KJtTpDhwIusH+RmM5w065VX/o4lEdHPfyL
	 2abj8AJL5uws9OC9nIQfPmWkgs8bJbPCRAxiQhAxVRsu1vYVv7J56va6t8+wz8kQ3hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115428;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1zaehfOEpJIBB309vW4ZfiHlvl8pXwnDzU4ZiFmfjLs=;
	b=gqFiMA994Ngr5KgD8D01lzmV5w7IaLHpMDGJK1QoIGlzhiXy1z17SLrB4D6wqNzm0htP
	 yuQ7GTuTVwlm2OFJ7GwaR0Rap+JyTMhO8k/zhMWNzvpbVz9JQ/yZfK5kE7AVlP1DSqMRe
	 6xpQ1LfV5hkX0rqDldEHi2ViLRPRB6DQ7i5lQd3l2uGj8nMTeS7qyDUSVDShO0ZEPaWbt
	 rGxP7Pa8wQY83qQQKqRlMI6Vvb0eP4Z6iEas9D/dD1/luX1ATCtKywILmru+Jqp3ogvn0
	 CE7Ru5UAFSrebNU1pFcZFT6gezKcVdSru1Ey4+g/F9j5TssfLBDRG8M1YXqY4SyVlsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8F5E01F031E7;
	Tue, 27 Oct 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115428;
	bh=1zaehfOEpJIBB309vW4ZfiHlvl8pXwnDzU4ZiFmfjLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Qzgxugg6Yi2n5p5cv1o5MFs5+QwZdFYNQsvGEeSMlILyYKi8y3iii7l+HzG5EaaNy
	 ctVOj+u25rVekWnHu00IYukiwdK4njy1v4l3+wBRzOs7s0WCOZAXH4lLLjXBEqTvpU
	 Kqydrdh7SDpH7CeaV3cxNZ6p9zUI/93iDLJw54c0y1EJnvArxGTdBf4WxkFPaR0IDR
	 rM4OBGiFrgXA8jrnyn/z80bd5kkmnyiJ1KmWcxHAqOb4xP0XFkP+AsSWAHa6Ws0o3Y
	 GnpcP3o4wgCl35hTdQdp2ez0DFwZgqIAVnMTA63dfubzBlB1ncwJtqqhh0oIQ3ir8x
	 VLsxDVazKW+0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9563845163;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:02 +0800
Subject: [PATCH RFC 11/18] dt-bindings: firmware: add A210 SCMI clock and
 reset IDs
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
Message-Id: <20261027-a210-scmi-v1-11-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=1905;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=cHyzHGe6C3hGqmqu+74Uf23AwBzHigG0TJ40txxDzZQ=;
 b=E380Dv6zaJZQluLlzXLNBYuGUXD5AMN+wkU/OKBHqGlcCbNfmOk1GGvnTFt5OQcKfn489dj4/
 mo0jkwjU3KRDRTt+HmLpg7mYFznHabr2FUPq+S9y1Hrz1BHN2dwZ8Iu
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Define the SCMI clock and reset IDs for the A210 UARTs, pad controllers
and AON I2C1. Each UART has separate serial and APB reset lines, so
they get separate reset IDs, numbered like the matching clocks.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 include/dt-bindings/clock/zhihe,a210-scmi.h | 15 +++++++++++++++
 include/dt-bindings/reset/zhihe,a210-scmi.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/dt-bindings/clock/zhihe,a210-scmi.h b/include/dt-bindings/clock/zhihe,a210-scmi.h
new file mode 100644
index 000000000000..b8f6441ac650
--- /dev/null
+++ b/include/dt-bindings/clock/zhihe,a210-scmi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_CLOCK_ZHIHE_A210_SCMI_H_
+#define _DT_BINDINGS_CLOCK_ZHIHE_A210_SCMI_H_
+
+/* SCMI clock IDs; existing entries must not be renumbered. */
+#define A210_CLK_UART_SCLK(n) (n)
+#define A210_CLK_UART_PCLK(n) (10 + (n))
+#define A210_CLK_PERI1_PAD 20
+#define A210_CLK_PERI2_PAD 21
+#define A210_CLK_PERI3_PAD 22
+#define A210_CLK_AON_SYS 23
+#define A210_CLK_AON_I2C1_IC 24
+#define A210_CLK_AON_I2C1_PCLK 25
+
+#endif
diff --git a/include/dt-bindings/reset/zhihe,a210-scmi.h b/include/dt-bindings/reset/zhihe,a210-scmi.h
new file mode 100644
index 000000000000..53e108c15407
--- /dev/null
+++ b/include/dt-bindings/reset/zhihe,a210-scmi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_RESET_ZHIHE_A210_SCMI_H_
+#define _DT_BINDINGS_RESET_ZHIHE_A210_SCMI_H_
+
+/* SCMI reset IDs; existing entries must not be renumbered. */
+#define A210_RESET_UART_SRST(n) (n)
+#define A210_RESET_UART_PRST(n) (10 + (n))
+#define A210_RESET_PERI1_PAD 20
+#define A210_RESET_PERI2_PAD 21
+#define A210_RESET_PERI3_PAD 22
+#define A210_RESET_AON_I2C1 23
+
+#endif

-- 
2.55.0


