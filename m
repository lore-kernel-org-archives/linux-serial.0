Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E614A62B;
	Mon, 22 Sep 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545891; cv=pass; b=ODuKlSyS4R5zLkJFbFOkbqAqDDT2lUKQ4scOfmcLb+1lXy75//AXQgi2dmSJoz6vPFjg7mLYA8T6rabwr7gozISYvRhX7Ve2TwG/jHJNzRn9qz1FBaHOrLTf1laplP5R1WnamEDruTLJTd+4uqW5osgXRfIffT/eJc8RNUMwJTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545891; c=relaxed/simple;
	bh=o3xPffNeLJgv5ADUab3GzsiV/FS81PqR65Q3s6SrFes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbKl67I/KPpID0fhYgCAXaujxMu2vcYIGWzaY7kRk0bsVAkX1sqf3AMDfJn9Rpu64dxtvRMCbJz+DjMObT4aVNkcIU74EVO4KQrrPqPTc4q6r/Ox9iue7+zVGXL+UtDLxkCMwlPj54RfQNOndQWMXH+j3p72tDbyoxDQ5jRs3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=dljjHfmo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="dljjHfmo"
ARC-Seal: i=1; a=rsa-sha256; t=1758545866; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dDvpJIN8h+D65wzpZ0ciiCLRQVRUskzV2YsOryeO5imWU3/EhH4BpqoMjQzJpECcUSCOXG1/qKYV+mn6sdC6K4WsBerzuGCerATNGLPvTc9CSVJEOpKyNZosYk9ANZxmFKncCJPtmPnot+giyzi64QVhePEAfSwDC4iSqF3pUzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545866; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=reoWwfW4E3+2fgyj2vTDgycGJza5VWCmd2+i408FNi4=; 
	b=Lip1/UNGrgBLsg+CEeJblf5y/WQxwyIj+KYAsvOef8OHu++Aeh9vPrgfTYkvNZRqfuGDYRtHEx9NPBgJnrwe90C3vYTVHzG1Mdgu1vhLwuz/wLSyjToyHSFVA56S8mGdrO/tUmbQvuX8Yk0VWAKEorFucwuOYxMiqZg96mhKJSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545866;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=reoWwfW4E3+2fgyj2vTDgycGJza5VWCmd2+i408FNi4=;
	b=dljjHfmoXQZcUEoGqYGlLPf8c4fG1g3GJbAagy1IYUN8qeW8nUW417u2RUGrtQxq
	lZwxfX7O8SPv6dyGjLB0wMKvpbHReAoNf+nslLoiexOtW/FO5Wpy0dXTCW2lT4XjUfE
	z1HNjv5xwux+Xp7Rq55BusBZB1MUoHWMN8pdQnWA=
Received: by mx.zohomail.com with SMTPS id 1758545864300967.1977091027373;
	Mon, 22 Sep 2025 05:57:44 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:38 +0800
Subject: [PATCH v2 08/11] riscv: dts: Add initial Anlogic DR1V90 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-8-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=4207;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=o3xPffNeLJgv5ADUab3GzsiV/FS81PqR65Q3s6SrFes=;
 b=h3jPJytm+0Sdr+E0xi5MpwMUj3CEHjb6YBSNdWeZBqYInzKb5Mkz3j4fSFB7HjO2DsurzAExl
 oUaAd0D6HSACcXb8a7Dq65wGSKif2cR5dIte2jQJIMBp519WQHe8hFi
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

DR1V90 is a FPSoC from Anlogic, which features a RISC-V core as the PS
part and 94,464 LUTs for the PL part.

The PS part integrates a Nuclei UX900 RISC-V core with 32KB L1 icache
and 32KB L1 dcache. It also provides two "snps,dw-apb-uart" compatible
UART controllers.

Some basic information of the processor can be obtained by running a
simple application from nuclei-sdk [1]:

-----Nuclei RISC-V CPU Configuration Information-----
         MARCHID: 0xc900
          MIMPID: 0x20300
             ISA: RV64 A B C D F I M P S U
            MCFG: TEE ECC ECLIC PLIC PPI ILM DLM ICACHE DCACHE IREGION No-Safety-Mechanism DLEN=VLEN/2
             ILM: 256 KB has-ecc
             DLM: 256 KB has-ecc
          ICACHE: 32 KB(set=256,way=2,lsize=64,ecc=1)
          DCACHE: 32 KB(set=256,way=2,lsize=64,ecc=1)
             TLB: MainTLB(set=32,way=2,entry=1,ecc=1) ITLB(entry=8) DTLB(entry=8)
         IREGION: 0x68000000 128 MB
                  Unit        Size        Address
                  INFO        64KB        0x68000000
                  DEBUG       64KB        0x68010000
                  ECLIC       64KB        0x68020000
                  TIMER       64KB        0x68030000
                  PLIC        64MB        0x6c000000
     INFO-Detail:
                  mpasize : 0
             PPI: 0xf8000000 128 MB
-----End of Nuclei CPU INFO-----

Link: https://github.com/Nuclei-Software/nuclei-sdk/blob/master/application/baremetal/cpuinfo/main.c [1]
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/riscv/boot/dts/anlogic/dr1v90.dtsi b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..f9f8754ceb5247d3ca25e6a65b3f915916ba6173
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Anlogic DR1V90";
+	compatible = "anlogic,dr1v90";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <800000000>;
+
+		cpu@0 {
+			compatible = "nuclei,ux900", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <256>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			reg = <0>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zba", "zbb", "zbc",
+					       "zbkc", "zbs", "zicntr", "zicsr", "zifencei",
+					       "zihintpause", "zihpm";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clint: timer@68031000 {
+			compatible = "anlogic,dr1v90-clint", "sifive,clint0";
+			reg = <0x0 0x68031000 0x0 0xc000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		plic: interrupt-controller@6c000000 {
+			compatible = "anlogic,dr1v90-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0x6c000000 0x0 0x4000000>;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			riscv,ndev = <150>;
+		};
+
+		uart0: serial@f8400000 {
+			compatible = "anlogic,dr1v90-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xf8400000 0x0 0x1000>;
+			clock-frequency = <50000000>;
+			interrupts = <71>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@f8401000 {
+			compatible = "anlogic,dr1v90-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xf8401000 0x0 0x1000>;
+			clock-frequency = <50000000>;
+			interrupts = <72>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.51.0

