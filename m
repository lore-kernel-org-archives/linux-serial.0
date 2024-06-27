Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD0199233;
	Thu, 27 Jun 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502403; cv=none; b=YSHPkbVDMbLY3JnHx/VMi98Ei/i1Tr8CaIipTSRN8uPcb47kC8TleCSjW9PTWGlXdIJR/ETll5Q0GRHTlWP7WZtBS4Qy9FQu+mA3UItgJPnWqMZwXtBhOEI/1q2yfSo4aXsoINqQAOu0nX5ff0S8bNT36XGFVrPA0FJB7hVa6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502403; c=relaxed/simple;
	bh=z3fLiCJSdRgubps9W4RLfSbnpXl1zvy0tSgQVmdR+Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeWwKjNvv6M+Tix3Y2KdhPfwOEov4NDCL2cBOYpY15sS/xGHfF4nvBJcucOUZjEM6P5j4djlP6IRm86VfUPBSpXr6uE3AnR60M3QbmhGwIu9qkemC0kDh9TNhQTnZBhpBl/XZV6bbXA5muBYh4zETXG8hxq0rIPudMZIcmY93RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:22 +0000
Subject: [PATCH v2 08/10] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13783; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=84b45fPNb/ONvNlA2uWSp8nduFgNul1nN8A4r4JM+qE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYX2whu8Wm+n1z858O/xksgm1qXxkMNKx2YRv
 gx95VAWd1uJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F9l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RxXD/4lS3DHNPzxRtLwWd
 OOgqzGbJ1CG7x/L/bW7uZ3C4vFDpu+1ULpzY1thn2ELC1QAuA8E/yT2dMuFTRbcS19/uMqf5mni
 8YWGbx/In4B6el8piUGY/nIFgFeHB+tqcXZ1XJdhqXYz+Mxl3QKjof0+72ZlWjdalJm6teTrczQ
 fe2Jj1OJgpQGqhJCTFpyyF5k+PvBxPN1/UMXOSAwryxnoZyKxGKaA6MZqIaGSakYihCSRYvLKD+
 Es1yEh9Wkn/bqrOGMKOcO+XO+AxGfeT9C3lsdiBtFSRUzjFqm/eNKRkPCBkPsJzbkW5WAiVjVwr
 Elx19N2BePpLSurCekA3RuCppso/UQ7VfW4xEQ+Z1p8+fioDCa/K/EEdDJrnpc8lWdNIG+Gt6Bi
 pazeI8Q//hom7TdXYP8NtF1QoCbcmcwch+RHvwe+ShBe/UC6yT8/Un9EO/ltA15W63uvq75X68B
 3ThqCzgyJdaBss456uNL/aKGph6cZj7+Qo0MjaPXLxSFCm8KWj5N4BmZASmBHLT+bvSBMZzy92F
 fZXjSpbo9wsGYKA7ARv5S6eqFsj5SlFm1LRMAkgtSK/n120cKNIa3psF/xQo5lbyyMdCRv/l01N
 pc+WfkpJVEh84vjFF6KekMk0CHCVbJ3C9D64HClgAeb7t42oJtWvuFxFXR4jd1VSlf0w==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].

Key features:
- 4 cores per cluster, 2 clusters on chip
- UART IP is Intel XScale UART

Some key considerations:
- ISA string is inferred from vendor documentation[2]
- Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
- No coherent DMA on this board
    Inferred by taking vendor ethernet and MMC drivers to the mainline
    kernel. Without dma-noncoherent in soc node, the driver fails.
- No cache nodes now
    The parameters from vendor dts are likely to be wrong. It has 512
    sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
    When the size of the cache line is 64B, it is a directly mapped
    cache rather than a set-associative cache, the latter is commonly
    used. Thus, I didn't use the parameters from vendor dts.

Currently only support booting into console with only uart, other
features will be added soon later.

[1] https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet
[2] https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb
[3] https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 378 +++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
new file mode 100644
index 0000000000000..a46149b0b9ff8
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SpacemiT K1";
+	compatible = "spacemit,k1";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <24000000>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_0>;
+				};
+				core1 {
+					cpu = <&cpu_1>;
+				};
+				core2 {
+					cpu = <&cpu_2>;
+				};
+				core3 {
+					cpu = <&cpu_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_4>;
+				};
+				core1 {
+					cpu = <&cpu_5>;
+				};
+				core2 {
+					cpu = <&cpu_6>;
+				};
+				core3 {
+					cpu = <&cpu_7>;
+				};
+			};
+		};
+
+		cpu_0: cpu@0 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_1: cpu@1 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <1>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_2: cpu@2 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <2>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_3: cpu@3 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <3>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_4: cpu@4 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <4>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_5: cpu@5 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <5>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu5_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_6: cpu@6 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <6>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu6_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_7: cpu@7 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <7>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu7_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+		ranges;
+
+		plic: interrupt-controller@e0000000 {
+			compatible = "spacemit,k1-plic", "riscv,plic0";
+			reg = <0x0 0xe0000000 0x0 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>,
+					      <&cpu4_intc 11>, <&cpu4_intc 9>,
+					      <&cpu5_intc 11>, <&cpu5_intc 9>,
+					      <&cpu6_intc 11>, <&cpu6_intc 9>,
+					      <&cpu7_intc 11>, <&cpu7_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			riscv,ndev = <159>;
+		};
+
+		clint: timer@e4000000 {
+			compatible = "spacemit,k1-clint", "sifive,clint0";
+			reg = <0x0 0xe4000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>,
+					      <&cpu5_intc 3>, <&cpu5_intc 7>,
+					      <&cpu6_intc 3>, <&cpu6_intc 7>,
+					      <&cpu7_intc 3>, <&cpu7_intc 7>;
+		};
+
+		uart0: serial@d4017000 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017000 0x0 0x100>;
+			interrupts = <42>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		/* note: uart1 skipped */
+
+		uart2: uart@d4017100 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017100 0x0 0x100>;
+			interrupts = <44>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: uart@d4017200 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017200 0x0 0x100>;
+			interrupts = <45>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart4: uart@d4017300 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017300 0x0 0x100>;
+			interrupts = <46>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart5: uart@d4017400 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017400 0x0 0x100>;
+			interrupts = <47>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart6: uart@d4017500 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017500 0x0 0x100>;
+			interrupts = <48>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart7: uart@d4017600 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017600 0x0 0x100>;
+			interrupts = <49>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart8: uart@d4017700 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017700 0x0 0x100>;
+			interrupts = <50>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart9: uart@d4017800 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017800 0x0 0x100>;
+			interrupts = <51>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.45.2

