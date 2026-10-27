Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115431;
	b=eh6fC1c8GY9eEJ90HjHCMCR0AUJgdMmi5rvxdh0/jtyf742X8hbm6ERtseJ9F7zk5qbE
	 C8WW+DpLPCCFwx3FDQ1CQcRfi4PJT2WsW/ZBc4QfCkTVmulMiROJHJqYdwkolw2X2FN1t
	 i3Riy+Um8yLxsS/egiepdlPrPwf1LdDeMBGte3jehtkR43QANctW5MUWe640D+1ODNkeB
	 eV7C5j41c/XORTGoTuaWxpw09xRmezJ0edHey13CKlVJNz4j8NdwjfiUhxmiG9KVMfjJ2
	 3rO+Z8dpqgya1BXbpNcubchWhHhnt0zzivH9bbCTK0SR7oS+XdgBlj3XToo6Sbk/Ogg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115431;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ka16RtxltIRx5Rtry+ZSPQw2tbg0Um/nvv7x+nHVP3o=;
	b=KEl7J7Tv2gc8bU/dD/L8jXG53HaBA6Ng99U01nDDNimmyIXYVpqN/k5Lz5hKtx/NgIEp
	 HpyNIqEiqqCFdG/Z4ZzPD2SrJwnaqkEHiVnnFPHwjLIWy2SpnHM+kAbQlNPAcZ9hUDMPG
	 xz3SmDWRB8dvw/WJAShS8OKmXnDsaDLkLnSZ0RArtUamvk/X57mihOjOHXY7EEC8RGkIe
	 C2BHABJ42/XMKEQTMFanQnbvlS4exMklHd3pdXJpM2qQ9ecTHOrVP/0bPXpVE4LfMH7lt
	 3qBy/IETkAZcjpcesdMnj1KVUY91DfXPOJg7AZlfT1ipUYga44r7J71cT9qwzTUw0Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4hKSU5p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37860A6F5E;
	Tue, 27 Oct 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4hKSU5p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115431;
	b=IivH1YwwnWKnpSu+QOkHTIF0gEoniE2CEsW+XzRdDOXQtfOPVPrgxTOL8TbgLkSEfTSC
	 3nDX0Sk9aSyVtkIp8Y17DLERB/pkxF7mKfeVVljerBNfS69vFzvIIJZwrsJYAmRbAQUu6
	 Gy64yjGzzpcOVFlCUpzXJB3WDzBHus5q0dxVrIqvmAlQyxyOiiMdT9U6vKFwscEnXZDxF
	 gH9T3gn05NEk/c6Lkt/I7JR+YEaVLpgxzGW21D67RcANuc1GSgMaLN6B66YYvbG/cEKZ2
	 VvrcSNgpE186Lyavs20hW65xtNuR/HiWfnTua883JksASNFXVN3xA334zFUyeXJoLAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115431;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ka16RtxltIRx5Rtry+ZSPQw2tbg0Um/nvv7x+nHVP3o=;
	b=a+ZOHdpwEE9wr6kxP1A+Qiuf/qnMZsZaS4mltsJDXmnRjV8UMo3/0l/F0FK9yMcfb9nR
	 u78HqOK7abl7Ctb9U8nxh4Or2FJZsGpWsqYVbZY6oZIFmkB5rXRiBF/Vpq87G6hH43hHc
	 k1tP4nbwD5KXTi44hI6A1QaHuPy+hPIaD7CnMrCobLu0UdmDxw4uRz440P0VzKQGg+NiI
	 rqqgMhtmmNlX0/UdZJUBa4hwxhx+sfDeKd0MHKbbsKAGg+qFl9fXpK/a1QAT9wu6Xj8Ok
	 2TKJmVcGzm0rYQQR1Qj06JK8FYl11jNxx9nClvkciquQmod+Nlq9TxyFBDhCtRPaJAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D929E1F01403;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115431;
	bh=ka16RtxltIRx5Rtry+ZSPQw2tbg0Um/nvv7x+nHVP3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Q4hKSU5psxvu4j8Ft5i6LxP2TwHJxAhscCmL09slZuxuNve5zpGrusAt3cflSWLir
	 pW7RExAI+N15JgLKbWM6090qaBul2WjlSzBnnf6yZ8u8/KSbdCb3m26lW8l4t1XitS
	 WrJ+3A25VjUnF9/7pCs98A41yRj+S6TcjR7PTtg4dONgPKCHIrcPmrr8ISg7lll+yd
	 BuSOjYNbGXr+jhvX3CEVMCNSsHWZcBCGzrq0dUYqvYuGSilIWBUgMzevGMNWH2IkeR
	 Pj5xTA6FMLBbL+9GUQX3guaD8mOBNAKoVX24y7S2z7c4gYrtZQidsLzdzlnralJyq1
	 DeFI5SJwBqxjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E4DC44517F;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:09 +0800
Subject: [PATCH RFC 18/18] MAINTAINERS: add Zhihe A210
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
Message-Id: <20261027-a210-scmi-v1-18-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=1092;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=9GPu+epF9k6rbtMyhWOkYOw3QLfgzPBWR9Pa4XSugC0=;
 b=twemv20JvRO3q7e0BGCA9T65+jEJVu6g0Ry4ZA2BPrly/26TlC1+5GJSO/aU+teCnFSSRuYNe
 KVuP8gy4gpHDuomclAAmrVgddoUnIbZ7elGvQwZxfnMUtuYvBhL3sS3
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
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..c6cdd9bb0864 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30115,6 +30115,20 @@ L:	linux-kernel@vger.kernel.org
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
+F:	drivers/pinctrl/pinctrl-a210.c
+F:	include/dt-bindings/clock/zhihe,a210-scmi.h
+F:	include/dt-bindings/reset/zhihe,a210-scmi.h
+
 ZONED BLOCK DEVICE (BLOCK LAYER)
 M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-block@vger.kernel.org

-- 
2.55.0


