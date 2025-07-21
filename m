Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C42E03E6;
	Mon, 21 Jul 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113130; cv=pass; b=UxqpHnEdFIr/6NInh43lgkM055Oe2murjb4i7exi/arVJMhTFqvQ4iA1o1AA/9A983LPiGj0jL8E7UxXcOCCYyoT/2LFlJgQ7aW33vEJF1RpH47V3du7B9azVe9PrMYS7zYCKJkWXvzx1Qw0kpu/kxutmiymllcP5/fIW2yXCKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113130; c=relaxed/simple;
	bh=+EFABcFWlLIRqin+/kMYM/pMww5J+sGA43GWCpn0qnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mda1VyETDJ9NIIJ3mfA+UNqoS2iAfADA7CrYA75v7wLK451zZaxD1zzQzNejvVbhraee2J1CQ4POpYqw/ieyipmqR2dAcopWEQBqo8qUYwfVUiUiJNhvKYFJ/VrgkBzQI9kMGE47SIelPl6idO3kVX9I1K/ZbDwkxyJm+D8sByw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=InnBnQOp; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="InnBnQOp"
ARC-Seal: i=1; a=rsa-sha256; t=1753113107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MMxXBx9vMjhNm9618SJbd+bvoj0qAWNBaf6I1hdm53xc46i0qqN9eQIc13xs75t+53us32gepdGbt/KN8o0DKb0P5TW0mqv52h3y0skTUgVjronFTR4grplGmibLjsVVU9k5cyD93YJqhc2xbEDO4BK2Fib6uoX5UvoOo9vDMQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z0Qp3/izL0TY+gD3T8jeqDLAQGqMdDazcJY4P4vPPw4=; 
	b=j1+hqsdH5QK+Vq2t76ulbjrTm885R4+nswoeoneNI8dbrK0z+m3Zm8IOizEK+dxWAtAmxHYQ1d8/N2qn7cmGqpeLAkO9wB4Uty99eGzi2G7hWHIt+7mrXjRUgk9XdT75niHIELRZaB0FefRJCGFqi15cQV1E0rcVZfcHOhDj1gQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113107;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=z0Qp3/izL0TY+gD3T8jeqDLAQGqMdDazcJY4P4vPPw4=;
	b=InnBnQOpzVDUeOPoqFEPZra92raBfL0WxUin+VJO7PE6D0VVwJesEnFbtnoUDX4b
	qpngp0U5h3qhkF7tOyP7Ojeuf0My7xbKwTUj+cm2gMP/6kXWhStfbd1L/Sks6mstgwR
	g/4KLOdEgg+gtwf6yW0W24vZ9BVFHAnAOrvKgbAw=
Received: by mx.zohomail.com with SMTPS id 1753113105602598.6931403939552;
	Mon, 21 Jul 2025 08:51:45 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:14 +0800
Subject: [PATCH RFC 08/10] riscv: dts: Add initial Anlogic DR1V90 SoC
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-8-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=4459;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=+EFABcFWlLIRqin+/kMYM/pMww5J+sGA43GWCpn0qnw=;
 b=JPYOvB0MuwSMHITDJwm54eaor40UxEHbk+iMY+ckuwpB7HhQ0hPaBpwHFTO8WWCJMDNi9uyZA
 sHHn3R50myBB1v9eypzmwSiPqV8G74iPyDjOuvNEK7PlEqzaswbnNzv
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

DR1V90 is a FPSoC from Anlogic, which features a RISC-V core as the PS
part and 94,464 LUTs for the PL part.

The PS part integrates a Nuclei UX900 RISC-V core with 32KB L1 icache
and 32KB L1 dcache. It also provides two "snps,dw-apb-uart" compatible
UART controllers.

Currently, a "no4lvl" bootarg is required to force the kernel to use
3-level paging for successful boot. The DR1V90 hangs if SATP is set to
4/5-level paging modes during early boot, as detected in
set_satp_mode().

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
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/riscv/boot/dts/anlogic/dr1v90.dtsi b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e1e3f6b72e56abce5a35e6d7571c91a64b0fecff
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/dr1v90.dtsi
@@ -0,0 +1,86 @@
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
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zba", "zbb", "zbc",
+					       "zbkc", "zbs", "zicntr", "zicsr", "zifencei",
+					       "zihintpause", "zihpm";
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <256>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
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
+		clint: timer@68030000 {
+			compatible = "anlogic,dr1v90-clint", "sifive,clint0";
+			reg = <0x0 0x68030000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		plic: interrupt-controller@6c000000 {
+			compatible = "anlogic,dr1v90-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0x6c000000 0x0 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			riscv,ndev = <150>;
+		};
+
+		uart0: serial@f8400000 {
+			compatible = "anlogic,dr1v90-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xf8400000 0x0 0x1000>;
+			interrupts = <71>;
+			clock-frequency = <50000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@f8401000 {
+			compatible = "anlogic,dr1v90-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xf8401000 0x0 0x1000>;
+			interrupts = <72>;
+			clock-frequency = <50000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.50.1

