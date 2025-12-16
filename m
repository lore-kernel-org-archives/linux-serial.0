Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24103BE549
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892058; cv=none; b=YAniy+y2TaNqTnkBIg5UTx1QmznHhB7UVDPVkoiFMafZDTftfMRQWKG+4ERsl3Qw9H5s9m5K0lK7QYyH5ywcglOwaoncYd1MzMqBtGk1GK2ins5hcbDck1uzMjYITSbPn6MGkwO5FMrCQEHsQV4jbE5l5z3NLt49BQ3fRtcHKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892058; c=relaxed/simple;
	bh=nYqDa0MT2EF7ddsZiIeHAdn1cpNK+emDKQZ73kLQ9w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWQIat4WVyMkBKKfkHaZK2NxLvPPZUKFpLcdaTuuXR6oD2KydyPaObpdGv96oyrLTxxFqvIqZbOBg/deEXQCRIXq2MeT+nY3Hr1KDS/CuliM1VEJZ/sylvaqw3WmgZBRYaw4z8S3pPHKXXguKveXpECNzyu8KKyExZ/gSQ1r+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FoDsoDhV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FoDsoDhV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0834769f0so32890825ad.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892056; x=1766496856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qQ3eHhisvmtOWqdlBLmEdp33CsXRSkulBff6gjbNnc=;
        b=FoDsoDhVZGx/hYCp3yjh4OlSoix0clzT5512NHJs3thvD0wVAjtKbI+mLyP37feCf9
         A8cP8AMKe5c8ZmRXfMIsFhESoJUDWk3l9u+8Cs7EOV64CH5CCTgc9iIcdgl1yj1gYqsz
         pvKZLZT9hegSGTkJXeaKi6z/v3wFoTKRJana4DyeY8biKAxWaXGXcrB1HO13Pp6+wvFT
         sHHywUWJcIY4rwAQWGHbEqgc8N+ZFlZmZ853QOu39lFmVv80I+dfHVq9a7cH1jq3dsbr
         v8LQD04D9uG5Oo5aONtrauydWHwISSWBNNpeqk/Nw1dsuqcjqLphqwaFZGDMCsBX/d4+
         7DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892056; x=1766496856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qQ3eHhisvmtOWqdlBLmEdp33CsXRSkulBff6gjbNnc=;
        b=Uln+39f1znh+Nde6/Jd4XDpErGqPoRblYuYvd9fqVGDXux+JSXtoMNx+bf8fVgLrkk
         PedpyL+cAnPLd9ae8MMDdiSNsbwIiO3NnQ2e0B7XiD6ZQ8MlHFkkNhgLN6EK9+NQf+5D
         IvTXPTuSXjTmAUfFUd1OAjr3XIQRawsNkD0O/up0FdV5gnoej1tZPxW0m/Mxsz+um1d6
         cJOdPQ4rAcyBMtlwwOnFUmnIgBbBjf0VYFff3s3aodgkhw9RjRPpnYDxKzgd2SjvO2uP
         A7J5K2PO2n2eQWEMqJOD2Wmkk/vX4hCxLZ3SpvFIT9ebnnBNM1Qmh1WQlFShskjgFumV
         7X3A==
X-Forwarded-Encrypted: i=1; AJvYcCXCuuRZR6n0nwDnCiOXlgjZ38AFCnXbIuO4ccIFcARWDareTwTZUx4RQ483ZOsi1ux8h+bbwxHh+MHz74U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk06fG6HMxFvkC7l6/l768y1DcZV7k/5+4X/3l7yZ4jkHLZSj1
	W9+ZAw6TSO7xmJyk+46ZfAnKeCHfcM4cmRndiicemsYSVTcp0nNXRY44YbOS4LsmO/0=
X-Gm-Gg: AY/fxX71csBGNdiQtahlGbCTBkNiNS/9GvR8uXb6e+KnaPPewujVAas8tBh3UpJ/918
	5oIC6EGYjE1/oCPT3F1cCLTXcXEh1smRlu5+Ygh0By5fdniO8JGNc2Xpiou5SZlSSc/y1BHLjfJ
	LyMRjSjZBzsxpXMUZUktLYetHW1vZPqPS0AvDzT0GTq4KWT68pCsyZGz5Gck8ddpL24jillc4/c
	YzXeLa5ag2RhXXkWwGdTB8xVmdnIxxYNCX30F96PKO8ctHnxSAtGJggK0g6YHSMHX6I0ehC40Zs
	IIkU7WJSONdzsEYVWnUEREwyxf7sflf7gjqE6lvtqce6C2aBEtvy6Idnpjivl1QpRNWtz7/HaIl
	rM3IXwpwP2Glo0NPTvSH3X9eZhpYMAz8aXnwnFDQ9c0rlYZHdHiJR8TTWABzU0ocmtIq3Qu+ks8
	GfmtumyDIAY3sWI8piuBYgyMBEP7LHGWhSAmj4+IKdtQ==
X-Google-Smtp-Source: AGHT+IEeOBOd3s5RHNSYePxmYi+3w5U0r2lvSZOjKCgBznCRlzMR+LVjww93EvvVn9vTLNkucmTX5A==
X-Received: by 2002:a17:903:4b27:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-29f2435b8d6mr145169125ad.47.1765892056026;
        Tue, 16 Dec 2025 05:34:16 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:34:15 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:31 +0800
Subject: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
In-Reply-To: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
Add nodes of uarts, timer and interrupt-controllers.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 529 +++++++++++++++++++++++++++++++++++
 1 file changed, 529 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..cb27b790716fdd6dc2bc89c28dd2588a596a5af9
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SpacemiT K3";
+	compatible = "spacemit,k3";
+
+	aliases {
+		serial0 = &uart0;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <24000000>;
+
+		cpu_0: cpu@0 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache0>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_1: cpu@1 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <1>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache0>;
+			mmu-type = "riscv,sv39";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_2: cpu@2 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <2>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache0>;
+			mmu-type = "riscv,sv39";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_3: cpu@3 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <3>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache0>;
+			mmu-type = "riscv,sv39";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_4: cpu@4 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <4>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache1>;
+			mmu-type = "riscv,sv39";
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_5: cpu@5 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <5>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache1>;
+			mmu-type = "riscv,sv39";
+
+			cpu5_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_6: cpu@6 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <6>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache1>;
+			mmu-type = "riscv,sv39";
+
+			cpu6_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu_7: cpu@7 {
+			compatible = "spacemit,x100", "riscv";
+			device_type = "cpu";
+			reg = <7>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
+					       "smaia", "smstateen", "ssaia", "sscofpmf",
+					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
+					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
+					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicond", "zicsr", "zifencei",
+					       "zihintntl", "zihintpause", "zihpm", "zimop",
+					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
+					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
+					       "zvknc", "zvkned", "zvkng", "zvknha",
+					       "zvknhb", "zvks", "zvksc", "zvksed",
+					       "zvksg", "zvksh", "zvkt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <256>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache1>;
+			mmu-type = "riscv,sv39";
+
+			cpu7_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		l2_cache0: cache-controller-0 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <4194304>;
+			cache-sets = <4096>;
+			cache-unified;
+		};
+
+		l2_cache1: cache-controller-1 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <4194304>;
+			cache-sets = <4096>;
+			cache-unified;
+		};
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
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&saplic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+		ranges;
+
+		uart0: serial@d4017000 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017000 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <42 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart2: serial@d4017100 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017100 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart3: serial@d4017200 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017200 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart4: serial@d4017300 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017300 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart5: serial@d4017400 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017400 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart6: serial@d4017500 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017500 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart7: serial@d4017600 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017600 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <49 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart8: serial@d4017700 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017700 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <50 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart9: serial@d4017800 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd4017800 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart10: serial@d401f000 {
+			compatible = "spacemit,k3-uart", "intel,xscale-uart";
+			reg = <0x0 0xd401f000 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <14700000>;
+			interrupts = <281 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		simsic: interrupt-controller@e0400000 {
+			compatible = "spacemit,k3-imsics","riscv,imsics";
+			reg = <0x0 0xe0400000 0x0 0x00200000>;
+			interrupt-controller;
+			#interrupt-cells = <0>;
+			msi-controller;
+			#msi-cells = <0>;
+			interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
+					      <&cpu2_intc 9>, <&cpu3_intc 9>,
+					      <&cpu4_intc 9>, <&cpu5_intc 9>,
+					      <&cpu6_intc 9>, <&cpu7_intc 9>;
+			riscv,num-ids = <511>;
+			riscv,num-guest-ids = <511>;
+			riscv,hart-index-bits = <4>;
+			riscv,guest-index-bits = <6>;
+		};
+
+		saplic: interrupt-controller@e0804000 {
+			compatible = "spacemit,k3-aplic", "riscv,aplic";
+			reg = <0x0 0xe0804000 0x0 0x4000>;
+			msi-parent = <&simsic>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			riscv,num-sources = <512>;
+		};
+
+		clint: timer@e081c000 {
+			compatible = "spacemit,k3-clint", "sifive,clint0";
+			reg = <0x0 0xe081c000 0x0 0x0004000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>,
+					      <&cpu5_intc 3>, <&cpu5_intc 7>,
+					      <&cpu6_intc 3>, <&cpu6_intc 7>,
+					      <&cpu7_intc 3>, <&cpu7_intc 7>;
+		};
+	};
+};

-- 
2.43.0

