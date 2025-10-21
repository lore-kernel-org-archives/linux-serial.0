Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDE2E7637;
	Tue, 21 Oct 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040097; cv=pass; b=OgR4ncRz4Y7/KGyRrgrC58fJTeyS6v3fwPzRzwEs6fyhbEA8rce1MTcqkWq9usIGrPAN62/rbPggYCwXzEOSKwqOIH+OsrahLdtWVWWn91vZ164xBZsCtTRmO77/5WWLQuB6ZpzqpEzbIpc0FtXfhHZh4MrPIBAdv6yUAIuPeP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040097; c=relaxed/simple;
	bh=RDVWZeAxgz1alDJPsqpgTVocpV8c0UxJ9gg4n/HME6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zx0CV7FT5/FB7vyXsNpXqXudyJV6bSd1S53PcFYZAhqwYXQvOewzWnx+tAJZR2ZTKLKRQu7v7pxx62kVrG+Z0I4sY41Hhrf1XtpkcXg4jkFRMg2Bs9QxJG95aegAfgPhzv/kQpps7IlM5pDGI1LzWG61bvS62wTBhUMb5ia90Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=GbWDWsfv; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="GbWDWsfv"
ARC-Seal: i=1; a=rsa-sha256; t=1761039961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P/EFRnhemYf+Fm4Fglh30csavqYDo3TiJIUspKpafk3m6JyEEwBsgr9GVwFY7bFBR1jcOabPfgvV/LRUo6w6SpQ+m8Ir/kjxdksG8MZ3Mju/PG85sEz4zla3OJjxTvo9CDiKuOzI6WfRNZw4fc2V7e89jc0AoYMySCpcaJCVGrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hqiQC5ayX+JN5fxtyr14jM4MC4pfQMFMI0LCqJastRo=; 
	b=RPAtb8tKgaFEM41mD4ke34oWrQd3M3dmwM9rwpD7aHn2DChJKgy+JNiOr1/NhrGkGJkTid+0g8E50pUfsJTD2bLIIQOey2COm586NCM26UPiAvgdrA+h/CaW+zl13wvuatm3L4GnEIoVBXFp5L7y1VvtG+NHCxMVsy+PNK2YUxM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039961;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=hqiQC5ayX+JN5fxtyr14jM4MC4pfQMFMI0LCqJastRo=;
	b=GbWDWsfv6Ftb35C/7s4NJ9NiGsB9nLl1TWrAfOeICsiQA4qR1qjnGPnJGQNvUY7n
	I8ehy4ufUCQFQ1SGVLZ+dxuuE05B3cpIV7poLCkszO8JRxaa2fQBpwZkOctA9hDAMCk
	wspT+yJiO10mwtMJdAFGWZij8NyIGPeroAFnFgEY=
Received: by mx.zohomail.com with SMTPS id 1761039959167749.4138204173319;
	Tue, 21 Oct 2025 02:45:59 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:46 +0800
Subject: [PATCH v3 11/13] riscv: dts: Add initial Anlogic DR1V90 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-11-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@outlook.com>, 
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=4796;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=RDVWZeAxgz1alDJPsqpgTVocpV8c0UxJ9gg4n/HME6s=;
 b=2DvHOsMqdF+wdj5Cz+HgdyjhVfgbbd4sID/wYYDvXeI4GxcnrBDmQF3VrnJanLFjClkIPhteZ
 lBrt1aD6kxFDEC3imTux8KP9x5HoCMuyomffiSaxHQRjoFf08wMF/P9
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi | 100 ++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/riscv/boot/dts/anlogic/dr1v90.dtsi b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..a5d0765ade3231ece0afbe8835d95cd918a44ad9
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
@@ -0,0 +1,100 @@
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
+		aclint_mswi: interrupt-controller@68031000 {
+			compatible = "anlogic,dr1v90-aclint-mswi", "nuclei,ux900-aclint-mswi";
+			reg = <0x0 0x68031000 0x0 0x4000>;
+			interrupts-extended = <&cpu0_intc 3>;
+		};
+
+		aclint_mtimer: timer@68035000 {
+			compatible = "anlogic,dr1v90-aclint-mtimer", "nuclei,ux900-aclint-mtimer";
+			reg = <0x0 0x68035000 0x0 0x8000>;
+			reg-names = "mtimecmp";
+			interrupts-extended = <&cpu0_intc 7>;
+		};
+
+		aclint_sswi: interrupt-controller@6803d000 {
+			compatible = "anlogic,dr1v90-aclint-sswi", "nuclei,ux900-aclint-sswi";
+			reg = <0x0 0x6803d000 0x0 0x3000>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 1>;
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
2.51.1

