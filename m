Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202212;
	b=zRsQv509AGHQUCkjVfBpdGtdLab8v0tOEVFPgoMhE2ePmNcFll0nIen2eJItx6cLSt73
	 YvR+xrC3FPUuWndXBHp3w5HklN7Z7I53N8lWpKg+YFohlgpJa69naUwRFHXN9ltszu3L2
	 j2RZgqIap6e/NU9GUd3QctC7BdO7Ps9FwAHU9C9//R3HfG7YUoykPPv2smXoklmJKYf8c
	 nMpArcRFFkTVndCkkpGH5QYwupGApdj9wf6aEjd9TShjubtTgY36tOhvi8vh+AdhV103U
	 wJgpmUlmn/kwq3PwouTkxZ7u0DD5BXdNr+cHLlA7ugzRiSf1ZK4xZ9XCt0AUiKVSvPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202212;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	b=WJ7Huu9zY0HAnvU62CbLBR5neJryIR7hGGytAcGaYlyyqgBNet1ix1mbOLP6MEaSG7rP
	 rY4nwDJSMVs0dspXvj3jIw9DQvx10N9xi0jL1PqJiT/JTb1sNihytfZYUSoz6+uthrxsu
	 kdxWb0xWuIm+B82pDcRzFhAJPt1l6mAgsVNnHIKsPbgvWArHdJctGEuqgRbXuLNJuxp1s
	 0yxZQ0m6ItPkcuiX6yPqrGg8XK8MIxWztgrXbbetpcBTojyzooQkprlrYMdTVJwn7Q6w9
	 qGIPgCbltokQivz2YNlCbtf5/DbuMg+lYfayxWKJzlKQlncszrQn6u/o4BrHGzvxBgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n0uumM/2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE0606A33A;
	Fri, 20 Nov 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0uumM/2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202212;
	b=AgRYJMmErCe6+Ok1nc5BNJp+x4FQ9GHPTTIX8koQDH78gjk8ZQLZFiKdVprzN6fS+FZa
	 BrAlcdatF6Q7Ee7y5Ww+uaDVUbLsdgMz9hc0skispk8gyMF/lye1jfLF31GSioqSv+LUO
	 qqz0U2JUELR6QLUtDuGzwVT2kEwQ6PISW2tVrQsdByNdCMbtbzKl3dyXJYFjM7lF4yKhU
	 xJbq2/8VaUlwIvPAiKRDcnDPEuISw3uQWHwMWIbLFnE/q0wXZl8WklwQcEhAGTD/D3saP
	 Hy4nRhxRa+T8KE1AjdWY0eceg++T4ahfANUAYeWl/3qMLkDTFMKPUMnKdwNLhVgoY5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202212;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	b=l4q/EoQRxKqsSb6q2PgUqjITNfImUPaX/FvI7iqhDoMTGjLV2pi7RJC8/yzHyY4uz34a
	 NuPeuEP66ehkhUGmZiGAgOrlMk4bqvwTgquSv0/YBphZV4jsi86mfy6EcnU+SZltlxpXr
	 sxxq/eEccTxe/Z+lxYsKVgnEzOp00UUt/iz0sP96W+KpATyVnIo8rSE/QG9a8gqv3w10b
	 Zu7lJ/wRNwfCuLRpCD9SpcuvJyHmMz1+5DRIHb4jDUdRHP4WlSM4/qa2TONT+omslbXT3
	 VWHaCb9T9sFD+ki2oSlCyGGkM8R0ePFg5nQjPAJPPSzJ2RdB2pqcT0fr+yCTVp1RijA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 051871F000CF;
	Fri, 20 Nov 2026 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202212;
	bh=E+Sl1Gk0Izp8iNjXVvH7BXDYK1wVBrrJEHxdo0B8yl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=n0uumM/2f4e4WX1djaV+kb2DrCvFpm+emAAWizF8ndmVmuoWb/9pCKG8n/IZQMrlK
	 VdLMAsADCCKWNH6QVr6RQrGVvhNCuujeMW6JCdgNmZ/8tB9nI4QAh7kbQds50hSfLu
	 kyCrwh6ZUbK78P6stMznbax8v8TwYBpY5c2oTxG0H2vDfvBJH0u9ATk550xAsJmjUP
	 uZDdJ4VtDgBIxKcBAnHbl646V53TQ4O76ZQYbiRSRneLQgI+htYdH/NnbPPk1QnXB4
	 rV4M5HAN9ek1sXSPU8Ip0Nbn1eb7qI2q46vNaAP/4ZKRjej2RLLOFuGDJ4FmeRsM8M
	 +Z1C9FKMqQ29g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 189954B9DE;
	Fri, 20 Nov 2026 19:16:25 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:56 +0800
Subject: [PATCH v4 10/13] riscv: dts: zhihe: add A210 module memory
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
Message-Id: <20261121-a210-scmi-v4-10-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=777;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=YcgMhPuDLQowVTt+MvNEeWTBEwtrbKzVnPLSZwTdXCU=;
 b=UCyyELTjinwGxSiobkxFax1VS8/WmZZD+1yWwZXAf4WG0exoNvFai7aW2vn3dGB7NugVpqKtB
 VP/INK+1K3wBjMg+f42Z0GgT06wejuMZZI4nPHk+b1FCe6Zckc1FVnH
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the A210 module memory node with a default 4 GiB range for boot
firmware to update with the detected capacity.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/zhihe/a210-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/zhihe/a210-som.dtsi b/arch/riscv/boot/dts/zhihe/a210-som.dtsi
new file mode 100644
index 000000000000..a77447e402d7
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210-som.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include "a210.dtsi"
+
+/ {
+	/* The loader replaces this reference capacity after DDR training. */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1 0x0>;
+	};
+};

-- 
2.55.0


