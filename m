Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115424;
	b=GDFWSvLDNWY2g5NzZizBjWeDvoQD6zxU3qn1c/bPgsYRZ4N1uRbowsUSgp7vF+qkFrQP
	 YVJ1KemamewW8L/bsD3cYEVK15x1dh4jwfHv7OnNZucZCM52Arj1QL3r8ruPzO6JCP3Tk
	 ZUL2xk2YyDSF1ohoocr5RT0i/Uv0E4k8PHXK0PwR5pK/hwPQKz4E+4Puu2tVgsrU1mEwi
	 OP6qwzEI4LnEKP+1mhHEPLDmjmiq7hecugcDOryu2aG69G6qxX7iVd3cRd37g/02SwIrI
	 BZbUck3p+/+Tqhuwkt0l4niEb5NwCctEfHZETf+xZSz1hfqMAoITQhxzQI2TTBIjXhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115424;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/KGaSHBvvoWL+O7MCZ6oZvrEvuXG4eqoQUwd3V+4yyM=;
	b=2DXZJuBEkriukKdzAFxMmfxhtk95m7wWApLlKO9WUkna1Dk2wadQeDdrczOwh11uCYpp
	 1gXPHjkA2NQGpFPS/C+51F3ANul6KGU8GJcOBvpb0EXOqf+YclyHWLJzDsMx04wnhwTnl
	 fx/KNmhFN/TKPV1hg57veRRHACvYanEe9oDP6h56O1tK3W2HNGKzc2Fqu2LLPIJj8/A8O
	 MB2i5pXfPgjm8VnQPPPGtMXcwJx75jUUpIsXju8vSc5dLluiqUorh4jx/NNn/pEv02ClS
	 UbXIMbCgFTuDG7S5KOcnI3VQOphFxCwPKgOZikIJ3gpPRTIRR6OzzgpFQiSkTRA00YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJCqHpSs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEA606A33A;
	Tue, 27 Oct 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJCqHpSs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115423;
	b=gH8mfoPn3xH9A8r7KsysK4G/1vkGBTB8XVJy+N3Xv3asFinAhXgijs6VNMojjJzEjd9L
	 0cHNcfmXDqiIwSYXhnZhEjtVBOcfrQR5rYFNvDuSEJ8+tcdiTUWgGcx033x60F17kKmSg
	 Gb5/LKqE7A0eSVmTPfl0T0m9Ra8XEZ6wUJfqQSBFx6HW7/7rtkunEvvqqzeBvPD3YDBhd
	 gu44xPVpifv5fRRACMa3Q+leoCKVJuPlwlbJBmdNWbTIX1ABu0UOgxHRnII6weq3IPOCR
	 dlZYCujFgjG8EnmjV12ocFCwhzrr9MPD13P2hwDa79mP/ugYcub696+0gbDvcPyifYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115423;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/KGaSHBvvoWL+O7MCZ6oZvrEvuXG4eqoQUwd3V+4yyM=;
	b=M7TZbhgXivtmPzB83HT9gI0BxfsV0XeCMRIq9ptYZjcBGMdZ5g1TN497YtR/GwV+KC7x
	 WzEnCfGCAP/VHIHwDAHkq/oSdkHeUXXVuypMdGewTIDCJoUPQTXHloz1WkJZGfgKkAYDG
	 FxGVpgJFbu+QdY1gk/4qaaoBHi3+vjwN8ryrMGx50AC9RCp+iRSWME5GmUiSbClGJ8sbh
	 15BDUIPo6Fp53VP7MBU8KOoH+QqMnKAVg1VHEfHBhwgsZsH8rwGI7lLsXtG8evDYA3tox
	 loFlzjXdLDqUcemjRAG9h1IVP3uJHu4+0Sp9Suau558yBKEfUfYVuKRJVAc4WZa4zQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B4B791F031E5;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115423;
	bh=/KGaSHBvvoWL+O7MCZ6oZvrEvuXG4eqoQUwd3V+4yyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LJCqHpSsnpOhGArAJQTiuSh2EZrC68VWzQM9h4CnC0wnl3dHwZ5NA2enhN6Z9Njqf
	 hHK3kPZaIn3nc9YhrmXpNtMJ1d43AFBJllgYPrwKcf1/BviaLO7UNNvYlWc+dRLclu
	 IKkEBXmeqtEgxLdxI/ZGTWlcCt4WYm7+lUjjEAPgmSY79siFjPhZN2Qc9xracONMqx
	 cwT6/pqAzZRMfxHpdtL7LVLB6BVu73D0zvkR+7iavkhMgcqX9nRHPNzeLT3ZCS8fzl
	 35paNMmzT3zM28pj49izIHAZpeDO4t8OTBNJriTxOHIIBxyY4uGRtxGgEyOX92ycY6
	 f6WeP0j2AhSrw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 25AD04512E;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:36:52 +0800
Subject: [PATCH RFC 01/18] firmware: arm_scmi: Allow SCMI transports on
 RISC-V
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
Message-Id: <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
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
 bh=TVSlaTkcQWucNuQbo9clD2EYvUNJXp80mxvivBUzLmI=;
 b=XVlpQR8bfbMMFzGIxQobo08oDZ+aFzeIFawIuzSgfBEgu6kQPqeL3bnZJwtQ/pcZFfd7koJGL
 2y8kDDbLI/rAA1wM1EraHXBsLVhI55nKGexS5Wvdgb5NUB3SVppZ1Oj
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Mailbox and shared-memory SCMI transports do not require ARM execution.
Allow RISC-V platforms to use the existing SCMI core and protocol drivers;
architecture-specific transports retain their own dependencies.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/firmware/arm_scmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 783c24a20e29..1cfe2b572d18 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -3,7 +3,7 @@ menu "ARM System Control and Management Interface Protocol"
 
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
-	depends on ARM || ARM64 || COMPILE_TEST
+	depends on ARM || ARM64 || RISCV || COMPILE_TEST
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are

-- 
2.55.0


