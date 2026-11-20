Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202210;
	b=SSU1rwsMV4/G+TW+B+46JHFdWnISFuCDp4YtPrnCrM8etrwxUjfjKbA3L3edT87znaKe
	 LiGHJXIWgTdl7+PO3nA/cj8M4jR/YLHGPlCO49hhhaQFTat5re/QQS0Kw94ge5rxkjQ4U
	 szXUPYId2IxwQwht6VeUi3monJF7u/PKDdZ9zf67G3DgMulxQFvUNJO1eX+fHE0F/gi3H
	 VGXB04bW03hVuMLuaTbyINhExW20lIf7DGSXrsnFEPocqexoAwRXbCn5/XICDPpnFPMxT
	 /kEkJ0Swx6ra5IyxJJOTxitgYvvRiPGnebzoa4j7P+NLdKJYS6B0sPifz27XWQRBxZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202210;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ne2gE+0c5VVuSEJ4JgnLZoMrp02nkPPc7XwbkOsJy9U=;
	b=Uy6mrLFuuJ/EbPcRPpqvbkqD2OzB2xnVB8SZycvnohiD7f2lxSlwcZZeWfgYJVxTsAKc
	 wzkmS+IYU6AoEKzb3lbTx/VDKzsKgcLsajvl9iiaHVhWKM2qVbilxWEFLxKePwx1TkP10
	 iqKAFHbZ8Dq6lmi+0LPXAhRfYoqMDJrkPQvycysI3Ro3nu2KcCN13WqzFzM9XLq5gbsCa
	 8vOl+xHeRT9QLBq0Z8huJbVgeaBe5hDQOYHpcR7Mf8WDb0k6wIoIvA8YzBZ/cicBm9OEy
	 tzE7BbwSoC66LNQKRW487PR/HrNkaVOTkjUx3iSRcppJjwXsyz5jxGKjGRmL4FHivYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gm10O6Be;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0360A2609;
	Fri, 20 Nov 2026 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gm10O6Be
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795202209;
	b=znR2zmqO5QYpIOU4KB8rZOuJcLrEaBSWSNBbOl1fiANUM1nhAxURKH496EWrLgDAKnQ2
	 HxjKcA/vA7J+HvdN3ehEqpzYobUd9a/mOWBhRtLjmOPzxUJGTAcb+Z7K1ZYprewAK5WLQ
	 iaV8p+tZgKrYkWZf5KGz5yfsFHPQZzf3HjDk9w8RXSQ/3JPvrRxwi8oA1l2Cxt0doVyuD
	 zPaK5WruhphDFhzDY9Lfmg5Lkj7VpIxoN2YTGpm1DtqPkT5WiyQOXJzZU2bE0hPpwWuoI
	 rktMLxihEl27CN9MjdUHdwJB8UtraJMcGGTeiq2lFziNqiJiLofBju9se3owIbz+6tA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795202209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ne2gE+0c5VVuSEJ4JgnLZoMrp02nkPPc7XwbkOsJy9U=;
	b=erSoKW7i947d491R5himrvxKf3QQWrJj74BuCXr9XH34ZeghHJ8p/Slg6iTxDtZK77fi
	 Cg/zXVcqt9hKBCJKiuLvpmDKPSVnLW52o2kk7EZALtdCot+4D8b5b4jpPYvLEfJ5v7Ex4
	 Uz3vjsCrCPb7W38QN8EcbN7ZnWtJrCwmciosnDWmgB7XZD18Jqb3Ma+/259cCXVU3BPrf
	 Ckavj/cnvyFwx2XJGOFUOtauU/HqYQhcmokBfj8BpHRyjDPzyioMQJLH0/dSQc5ldPxYp
	 NzYNACL2pIczsv0oIP2vc0nDDTbp5umUcACPZ7fLjEn0tYIjcFbF40wTEIM5VAS3mkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BB0A1F000CA;
	Fri, 20 Nov 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202209;
	bh=ne2gE+0c5VVuSEJ4JgnLZoMrp02nkPPc7XwbkOsJy9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gm10O6BeOeFETn5lNu8pBVYWDsjfwU9e6ADBBXXHO1lOPmu/06Ebkgc4LdOYy+uic
	 d9aWU4Kx/beSNlFgWY64nfJsKYDCXdpNYlhrsvN/YM5XC/x00T1MJjOgQTbTqCTlwy
	 +i2PbLbQwEviulxRM2ygSWgSJmJA+VAozC9QpgdNlrl42+6H/Qh3Kb9A34XMyEg1Qw
	 JfxQq5IvA7Y4oZhziFYc0+1zTHC3JIREuULtvvrP6ltzy2NGG55YFEAXWMACcGEmaH
	 g8SFiwNZaysx6Hqtkdo1utWHF9aN8tZZkF06OlTEzNcbWvIbQX5CBBU0UxYfL/aEnu
	 kjuJjC5G84hSg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 70E704B9EA;
	Fri, 20 Nov 2026 19:16:25 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 21 Nov 2026 03:15:59 +0800
Subject: [PATCH v4 13/13] MAINTAINERS: add Zhihe A210
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
Message-Id: <20261121-a210-scmi-v4-13-4a795a0a9fc9@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202181; l=998;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=4+K9oMgmXDDNfWP3RQVazEGhA8ORba3TgR1reKRQrsA=;
 b=7xcyBtu7YBanong5vbppbomKxRSQ5askeWhUrWIhxQ49iTgHE+taiLAE4M2HbLLzGiFk62t3o
 ZuIW/KgYXZDB//lw5jViGKgh8McyJDTU0lHz8KeFABH1yAAJZAYqs+j
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add Zhiguo Zhu and Han Gao as A210 maintainers.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9..a1eb24fd742e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30928,6 +30928,18 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
+ZHIHE A210 SOC SUPPORT
+M:	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
+M:	Han Gao <gaohan@iscas.ac.cn>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
+F:	Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
+F:	Documentation/devicetree/bindings/riscv/zhihe.yaml
+F:	arch/riscv/boot/dts/zhihe/
+F:	drivers/mailbox/mailbox-a210.c
+F:	drivers/pinctrl/pinctrl-zhihe-a210.c
+
 ZONED BLOCK DEVICE (BLOCK LAYER)
 M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-block@vger.kernel.org

-- 
2.55.0


