Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0563093AD
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459994; cv=none; b=FU6OSTUOGM9TZBflKImp+BvnoVrr3qFyOu5rgORpOmUpuM4usoE3F+fQt8QJj7Bb/yZ2bC/l7tOiutmBjcvHlw2XLKN30YGZ3bDJc9K1Hj5UZU1ddus93sFnBLywpdMpRgZzgOVf+PJDy+iVrCU/snlFN5Sp395c+N0dcRvz9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459994; c=relaxed/simple;
	bh=5lCeB1GcOdaoaYHi6D3PIElhAfVcfqWRdp3ECXG9b5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIGIpiqQ8LZeI25jYsTnoIB58WpwjwsALCmawVE6LcKGJ6ykrUqZxZMPZWrNcIWzJQFkDe/F1TZRRlHed59bk4wRqQ8p04Y0++b7bslT3x+GM6gp5LDpOyQUuSHU2pe5MFgYuwvwfUZhd9EPB22uau7ChpApbrcdnR1Yynioo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kULJtMnP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kULJtMnP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0c09bb78cso3669355ad.0
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459984; x=1769064784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0QPsLpzttolEq4AeXwl+YsKAr2ldWZ+dcPCydx1TA8=;
        b=kULJtMnPC79bq7irGcmv82LrLXLB84avqzwrLxGyEJbZYBp95ldKZi4uN8FITWp4ej
         9K51RyemwYzqCjynjQPnR9miqYxqZN2xL4beOaTDh/RlAPTSY3in3UhVqOZq8D5dWw2U
         mqhlePy7hfcazqTLN7pevcMa6L1lCMYrvBouY5zvZuM0Ef0WmLXbi/D4QQNYfdSYtwTP
         SR3JcgdOzl9nQVCpWoB20svYdgFK5XPX7rRny/sjdNPWxhmbrx9xpYe4JSabkQKat1a7
         tdwSFx3b6y0ANJm/SchdfNIl8Kgo+IVOkQNT7lQDghc/r/bTGK/FVVa3FXaEejEw/6tZ
         +dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459984; x=1769064784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W0QPsLpzttolEq4AeXwl+YsKAr2ldWZ+dcPCydx1TA8=;
        b=AV3WS70b7oDxSf6e2G05U4GwEv2VtReRJ8eoD10x7r6ulmDq1ko67KKr3LQPTELTB5
         JCFPrKAoySLWFHUlpxTj6EKNRTsCQRohfAS3Ga9Fs/2axVDdmKnGJvUuGkvk+mPHGmkE
         dcf372lJXOg9wqwFWyAf6V2sjK2kWYDIb4IO4ITEXid7vcNBReVkTLTtiN/rBw4amXgZ
         +0nOh2BPF4LLH7XsmykammNMXDOMLPksS0k8RwPSmJ7eUUS6BE4Ez2vTQ3qZzRSmjhvF
         UYizYEZFSGGAxvFRFxRcs/d625S2IYlRaRSdk1CCvnWF60ca4hCrVRIZvtUm4Q7rBgc1
         vr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy3XfzpiHJj2DowM19all1o/Z6ZuGY2z2Iy2p6aK3AYLB0HeyXFS3yygx9NUsA3jeXPZyY8N2BhSSxPI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+E2Pz9Q3D39PDm36FMAN+8BSnqkVg9/A0tss13ov+KE5hbPE
	V4oC5Belh0n/dv8UUqmVzXZCW9UNQaXPVhj1yg00aQke0fGsISB+A/mOB1waeYPmmdI=
X-Gm-Gg: AY/fxX73T7QgencSUd4IWsrrlytWJkfCVYbrg6lHnYvI+S3CNnaDRPyhJLyEaxvscFg
	pVwJE0CtfWHnJ17uFEVDrfnwbipyPSTOrOLLg/dqI7g5OMQ1pORb6vCiMWfGxIY61uXyTPTgIso
	Hw4km8nC5bwbJ84MS3Qh/1GoZ8jkUOmY2TTQJuiNjJ1qqos78AAeG8gHRvKNd/awt8dt3SlRJNt
	TdpyRHxhKuZKKTRP/u4+M/tuJ0GN2j3yr6ztnlQyFmg1VizDxt8qlFY79oaIiF2QaN8VOh6Puvi
	F8p02ZvwKl7ll+fNxCc2gb3bPmGnFzoEgiGWEI4yWVpqIeKm0shJSIm3VvpRxXHKjPONx0GDewk
	EqxbO/2v/eT3+FZnLX8V3y7Qjz7Y2WHQLE6YxxBSx0RHwGhTn41esLYZ0vIE9HF+S/AgY4OjSmu
	w2trYH5TAIY0Mg+jJ1d/QuLiaHo8U6RdEXBQPcoduk86R/sAp9Q5xkRM7ZWsDOLAUR
X-Received: by 2002:a17:903:2341:b0:2a1:3ad6:fab3 with SMTP id d9443c01a7336-2a700978ecbmr18482855ad.1.1768459984404;
        Wed, 14 Jan 2026 22:53:04 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:53:04 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:45 +0800
Subject: [PATCH v5 6/7] riscv: dts: spacemit: add initial support for K3
 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-6-6990ac9f4308@riscstar.com>
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
In-Reply-To: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.3

SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
Add nodes of uarts, timer and interrupt-controllers. Also add M-mode
APLIC (maplic) and IMSIC (mimsic) nodes to represent the hardware
topology and ready for potential firmware usage.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: Update the copyright year to 2026.
    Set M-mode maplic and mimsic status to "reserved".
    Update the commit message per Yixun's suggestion.
    In maplic node, use riscv,delegation to match kernel binding. OpenSBI
     accepts both delegate and delegation, but the binding documents only
     riscv,delegation.
v4: Fix missing blank space after commas in compatible string.
    Add m-mode imsic and aplic node.
    Reorder properties in simsic, saplic, mimsic, and maplic nodes
     to match DTS coding style.
v3: Remove "supm" from the riscv,isa-extensions list.
v2: Remove aliases from k3.dtsi, they should be in board DTS.
    Updated riscv,isa-extensions with new extensions from the extensions.yaml.
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 590 +++++++++++++++++++++++++++++++++++
 1 file changed, 590 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
new file mode 100644
index 000000000000..53425badfea9
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2026 Guodong Xu <guodong@riscstar.com>
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
+					       "sha", "shcounterenw", "shgatpa", "shtvala",
+					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
+					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
+					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
+					       "sstvala", "sstvecd", "ssu64xl", "svade",
+					       "svinval", "svnapot", "svpbmt", "za64rs",
+					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
+					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
+					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
+					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
+					       "zicond", "zicsr", "zifencei", "zihintntl",
+					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
+					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
+					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
+					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
+					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
+
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
+
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
+
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
+
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
+
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
+
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
+
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
+
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
+
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
+
+			status = "disabled";
+		};
+
+		simsic: interrupt-controller@e0400000 {
+			compatible = "spacemit,k3-imsics", "riscv,imsics";
+			reg = <0x0 0xe0400000 0x0 0x200000>;
+			#interrupt-cells = <0>;
+			#msi-cells = <0>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
+					      <&cpu2_intc 9>, <&cpu3_intc 9>,
+					      <&cpu4_intc 9>, <&cpu5_intc 9>,
+					      <&cpu6_intc 9>, <&cpu7_intc 9>;
+			msi-controller;
+			riscv,guest-index-bits = <6>;
+			riscv,hart-index-bits = <4>;
+			riscv,num-guest-ids = <511>;
+			riscv,num-ids = <511>;
+		};
+
+		saplic: interrupt-controller@e0804000 {
+			compatible = "spacemit,k3-aplic", "riscv,aplic";
+			reg = <0x0 0xe0804000 0x0 0x4000>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			msi-parent = <&simsic>;
+			riscv,num-sources = <512>;
+		};
+
+		clint: timer@e081c000 {
+			compatible = "spacemit,k3-clint", "sifive,clint0";
+			reg = <0x0 0xe081c000 0x0 0x4000>;
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
+		mimsic: interrupt-controller@f1000000 {
+			compatible = "spacemit,k3-imsics", "riscv,imsics";
+			reg = <0x0 0xf1000000 0x0 0x10000>;
+			#interrupt-cells = <0>;
+			#msi-cells = <0>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu1_intc 11>,
+					      <&cpu2_intc 11>, <&cpu3_intc 11>,
+					      <&cpu4_intc 11>, <&cpu5_intc 11>,
+					      <&cpu6_intc 11>, <&cpu7_intc 11>;
+			msi-controller;
+			riscv,guest-index-bits = <6>;
+			riscv,hart-index-bits = <4>;
+			riscv,num-guest-ids = <511>;
+			riscv,num-ids = <511>;
+
+			status = "reserved";
+		};
+
+		maplic: interrupt-controller@f1800000 {
+			compatible = "spacemit,k3-aplic", "riscv,aplic";
+			reg = <0x0 0xf1800000 0x0 0x4000>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			msi-parent = <&mimsic>;
+			riscv,children = <&saplic>;
+			riscv,delegation = <&saplic 1 512>;
+			riscv,num-sources = <512>;
+
+			status = "reserved";
+		};
+	};
+};

-- 
2.43.0

