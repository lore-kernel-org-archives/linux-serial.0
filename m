Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115430;
	b=ZQJg0fm6uTosEhHtuMkSBUudQkV7SlSOmNGRfb13u4noyyWf5YNOG1p5KV1TAFNv4hns
	 sQUGQkBTdgP7oVeCfOxj7yotCTVt7UaWHW/SC6mVv7SCPTxNqy1Rm5mzyi7pfOw/xNgK7
	 kv96SjTGcbhYVd3T+5saaGfcfPCD3GjHDc/jN1MPwxRx6brEQ8kf9W5iCc96GcQ6Xr4A1
	 BYDvNNXAeFLyPTAY73oovhrJ7Dk5Oa8Mp7CXQpGSQYR4MyMeJmGsnx3Q9qYjolofbxsEp
	 Sa/4MBK+X2iXVjutjQqZd/CeP2W/leTatERFCiJ+yhsGKgxyv5sRHAZiWyZDMEkW6Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115430;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oS++xhGGDKIKaoPqn/jR4GeC6Udugr7VmWtN0GgLuxc=;
	b=yDprVfvwEp+mazGjjohyfg2+G6dNHJHT7yNtSlp12Ek4Y82VW0/cfGhkQ2B7caXkblp8
	 T3VdmGORc8uev6zwwrkRUa8jUKE9wN+UWWGWmhYlwSUQsKhlERDBBR4OHGXLuRi//rHIg
	 L3hDby0R85jM0dYyfap5GeVnAl0TmjNv7m1IAKVRaFy0lN/5zXMFXXN2xvog4L75t67Wg
	 gv9bMoKmGq9Xu7wnfr16GkOKpAVUmxy4X15koDw2qkF3OE/kPYKqLtIUIMLEDSNtzrrW2
	 uXi9Lty6Sm4U/9AfU0rM0t9j4K/0oLEpLADASbuxT7Re8B7AzvTkxauQQJDgAvMlQTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuWvAT3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828860A2603;
	Tue, 27 Oct 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuWvAT3P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793115429;
	b=H4qZ2vUMgaP22bKWxncuZTU7U9/SIjGr/k4O0sFR4gVXTNPk8csPErFsXGtd3QnjEAZb
	 09Ehd2UeX8UrsBg4+OBlIJY6ipQcylQRp+iAyPwV+75kHpW43Fu6fwlSz1gVZk7CrukZY
	 Yeb6tTyokfLQH5AoOiyn5aA916CHcYUKZTuxq9I8oEEKWKp3EcZU2bvt7F1nERX7u47wM
	 25ULYDoWY+OFv10Yhi30SCeTAfZWZ0h5c6/JZatW8/SMI01eqOeCvKaE46TxpMSgMngKW
	 hsW5Lqiufe0HLVk+6qiZeT6gtIRR5yIQ+QtpPB22s37b4jet9/18G2HrRSIj3OClQRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=oS++xhGGDKIKaoPqn/jR4GeC6Udugr7VmWtN0GgLuxc=;
	b=TH9b9wkZenzzVNMGWFopyw3hMbB/1iEzj1F4LSKnRuIC0pWK+W7CE7Nwguu7Ob/sdwtl
	 nX3zBMERuDTb8jmUymo0ncFevWvfhYF9jzmFhOGDZSOVY4O3KWSnDig1j7OEiOgFYjeM9
	 TnWKbSanxI1CcTPFFaSbXdLKeZH4Uu0LyoOP30EAu+EBn1ciKDAx9FZLD5O1yK6wlRyBt
	 JlCWjE/um285Tbfh/6GAZ9pGRqrfceP2XEaFra0x8J8h46hkvm+QFpss99WfsKLuqppjh
	 6Rm0My/dXR0IqUHtHnBO7Qs4uj9eOhFQOiuXYqCsHhhQ8rTaRJc/XrnZ+MoSpQ8hGrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 365841F01400;
	Tue, 27 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115429;
	bh=oS++xhGGDKIKaoPqn/jR4GeC6Udugr7VmWtN0GgLuxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SuWvAT3P0MN5hxmaN5JeGG3PsAudaZj6boS02VN0HnDUVQDowA7goRvDuwmSdtA/T
	 dAdpJOdHEg5oUaHI6sel1Y81JgZfHwehFrNxGDQPCoILIn79G1mgOt2smfDd5dhVwL
	 62HNQJTYMUEFNCwDPw5M59/5OX5X/rHFqruMsFClaVoFxfiZhGQ1wJDmczu6FRkTYR
	 YYHIhKbfhy8oY5RT5yfNRS5irHTOeOB4HGVqaEk5OX2bK5wVd1K6G7Yh5rs0coPcSY
	 VvzR/Sc0O1GBsHNaRbMml/qLP0zdvl1cbPSYwdKAo9jlpnIReKwTM4JzdIGyzz0vsI
	 LWtS3i38wWFZw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF7944516B;
	Tue, 27 Oct 2026 15:37:01 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 27 Oct 2026 23:37:04 +0800
Subject: [PATCH RFC 13/18] riscv: dts: zhihe: add A210 core support
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
Message-Id: <20261027-a210-scmi-v1-13-74d58ce85bd8@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793115418; l=13008;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=RQLOLtjHxIvwJUeim1bI53l1VbR+S6hkZ7O/I75dWFE=;
 b=HnZ4tu8a9SgcvOQ8d6+Xys900xL5pZ80qqnexgVKI4/zWKJAXeLMu6zlMAKyYov2KoeZvw6ZV
 TyX3+7TGTd8BbSkmdU6meacMzlk3eB4m7C3x/0llWRWySfb/kBHtw4v
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Describe the CPU clusters, interrupt controllers and pad controllers.
Use SCMI clock and reset services through the E902 mailbox, with a
second mailbox channel for firmware notifications.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/zhihe/a210.dtsi | 458 ++++++++++++++++++++++++++++++++++++
 1 file changed, 458 insertions(+)

diff --git a/arch/riscv/boot/dts/zhihe/a210.dtsi b/arch/riscv/boot/dts/zhihe/a210.dtsi
new file mode 100644
index 000000000000..c7b623800aa7
--- /dev/null
+++ b/arch/riscv/boot/dts/zhihe/a210.dtsi
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ */
+
+#include <dt-bindings/clock/zhihe,a210-scmi.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/zhihe,a210-scmi.h>
+
+/ {
+	compatible = "zhihe,a210";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <24000000>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&c908_0>;
+				};
+
+				core1 {
+					cpu = <&c908_1>;
+				};
+
+				core2 {
+					cpu = <&c908_2>;
+				};
+
+				core3 {
+					cpu = <&c908_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&c920_4>;
+				};
+
+				core1 {
+					cpu = <&c920_5>;
+				};
+
+				core2 {
+					cpu = <&c920_6>;
+				};
+
+				core3 {
+					cpu = <&c920_7>;
+				};
+			};
+		};
+
+		c0_l2_cache: l2-cache0 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+		};
+
+		c1_l2_cache: l2-cache1 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		c908_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "thead,c908", "riscv";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <256>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c0_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c908_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "thead,c908", "riscv";
+			reg = <1>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <256>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c0_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c908_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "thead,c908", "riscv";
+			reg = <2>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <256>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c0_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c908_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "thead,c908", "riscv";
+			reg = <3>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <256>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c0_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c920_4: cpu@4 {
+			device_type = "cpu";
+			compatible = "thead,c920", "riscv";
+			reg = <4>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <65536>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c1_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c920_5: cpu@5 {
+			device_type = "cpu";
+			compatible = "thead,c920", "riscv";
+			reg = <5>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <65536>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c1_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu5_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c920_6: cpu@6 {
+			device_type = "cpu";
+			compatible = "thead,c920", "riscv";
+			reg = <6>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <65536>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c1_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu6_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		c920_7: cpu@7 {
+			device_type = "cpu";
+			compatible = "thead,c920", "riscv";
+			reg = <7>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <65536>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&c1_l2_cache>;
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "b", "v", "sscofpmf", "sstc",
+					       "svpbmt", "zba", "zbb", "zbc",
+					       "zbs", "zicbom", "zicbop",
+					       "zicboz", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu7_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&mbox_e902 0>, <&mbox_e902 1>;
+			mbox-names = "tx", "rx";
+			shmem = <&scmi_shmem>, <&scmi_notification_shmem>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <2>;
+		dma-noncoherent;
+		#size-cells = <2>;
+
+		mbox_e902: mailbox@321000 {
+			compatible = "zhihe,a210-ap-mailbox";
+			reg = <0 0x00321000 0 0x1000>,
+			      <0 0x00311000 0 0x1000>,
+			      <0 0x00320000 0 0x1000>;
+			reg-names = "interrupt", "tx", "rx";
+			interrupt-parent = <&intc>;
+			interrupts = <336 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
+		peri3_padctrl: pinctrl@542000 {
+			compatible = "zhihe,a210-peri3-pinctrl";
+			reg = <0x0 0x00542000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_PERI3_PAD>;
+			clock-names = "pclk";
+			resets = <&scmi_reset A210_RESET_PERI3_PAD>;
+
+			status = "disabled";
+		};
+
+		peri1_padctrl: pinctrl@2026000 {
+			compatible = "zhihe,a210-peri1-pinctrl";
+			reg = <0x0 0x02026000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_PERI1_PAD>;
+			clock-names = "pclk";
+
+			status = "disabled";
+		};
+
+		peri2_padctrl: pinctrl@8411000 {
+			compatible = "zhihe,a210-peri2-pinctrl";
+			reg = <0x0 0x08411000 0x0 0x1000>;
+			clocks = <&scmi_clk A210_CLK_PERI2_PAD>;
+			clock-names = "pclk";
+			resets = <&scmi_reset A210_RESET_PERI2_PAD>;
+
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@18000000 {
+			compatible = "zhihe,a210-plic", "thead,c900-plic";
+			reg = <0x0 0x18000000 0x0 0x04000000>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 0xffffffff>,
+					      <&cpu0_intc 9>,
+					      <&cpu1_intc 0xffffffff>,
+					      <&cpu1_intc 9>,
+					      <&cpu2_intc 0xffffffff>,
+					      <&cpu2_intc 9>,
+					      <&cpu3_intc 0xffffffff>,
+					      <&cpu3_intc 9>,
+					      <&cpu4_intc 0xffffffff>,
+					      <&cpu4_intc 9>,
+					      <&cpu5_intc 0xffffffff>,
+					      <&cpu5_intc 9>,
+					      <&cpu6_intc 0xffffffff>,
+					      <&cpu6_intc 9>,
+					      <&cpu7_intc 0xffffffff>,
+					      <&cpu7_intc 9>;
+			riscv,ndev = <351>;
+		};
+
+		clint0: clint@1c000000 {
+			compatible = "zhihe,a210-clint", "thead,c900-clint";
+			reg = <0x0 0x1c000000 0x0 0x0000d800>;
+			interrupts-extended = <&cpu0_intc 3>,
+					      <&cpu0_intc 7>,
+					      <&cpu1_intc 3>,
+					      <&cpu1_intc 7>,
+					      <&cpu2_intc 3>,
+					      <&cpu2_intc 7>,
+					      <&cpu3_intc 3>,
+					      <&cpu3_intc 7>,
+					      <&cpu4_intc 3>,
+					      <&cpu4_intc 7>,
+					      <&cpu5_intc 3>,
+					      <&cpu5_intc 7>,
+					      <&cpu6_intc 3>,
+					      <&cpu6_intc 7>,
+					      <&cpu7_intc 3>,
+					      <&cpu7_intc 7>;
+		};
+
+		aon_padctrl: pinctrl@30848000 {
+			compatible = "zhihe,a210-aon-pinctrl";
+			reg = <0x0 0x30848000 0x0 0x2000>;
+			clocks = <&scmi_clk A210_CLK_AON_SYS>;
+			clock-names = "pclk";
+
+			status = "disabled";
+		};
+
+		sram@30907c00 {
+			compatible = "mmio-sram";
+			reg = <0 0x30907c00 0 0x200>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x30907c00 0x200>;
+
+			scmi_shmem: scp-sram@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0 0x100>;
+			};
+
+			scmi_notification_shmem: scp-sram@100 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x100 0x100>;
+			};
+		};
+	};
+};

-- 
2.55.0


