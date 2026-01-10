Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE130E0F6
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022441; cv=none; b=huc2IzM55TJDKIsLiqeMvcEztBbEMll8q5rNvy8Npv1gZeOAlXRtcvtbJuLDH4OqxlJlWCYBHUFYxyxtaRWKNyQSO/zTSzcEL7eJAb+97Lm/Dvin/yg62E3nJOlTfiOUmrqKMcN8c/d8RV19lx3vfbUfkr91he1oYIi7UfnpTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022441; c=relaxed/simple;
	bh=gUPoN3Sspp+t6VA4+L2c+gg+nhvFaxxJLk8z+08/Eik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVx5UYqZj+QkAuhdFm9yukI5QW1lfMwsmju2X6KCxHzzUMQ5boDJGKm8qMbGJ4sKxSrDeag4GoscEKK+32Kj5wQKcl0VLBeaRqlr5crJpumXExQBVc6+4rmOvb4UJetPZww0D+r3acbY5yUy1J6e34DYMFIYNmvmWo6oqVJAb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rusFqxxR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rusFqxxR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso35871395ad.1
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022439; x=1768627239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN8PVqzzAZZHRjxdINCBCNKySb3WeVOzy7dnQm8uUnI=;
        b=rusFqxxRtG7aiEPDQMVV4bn1RjINPEYznHZWLiw/p+Mij5Wr71swU+X4QcZLMhfLEM
         hyCmAQhuQhH3QLfamOaEs/2/ixSEqkv/jEV3zGB+Kou0LGcD1kG7CVToTKdhx1bcyRpx
         CJqVCqO5vEFDclX71CZ1rCy5VmfRjC46Mb+VaR5RVhbIhfQ4eqCEGKTT7PNugrzDHYYq
         drF3akkTH4BuCeTOGjI7yIKOe2Sy9qS70Tj4YquQV97hnL9tj4h0bY6WRjrFnyQITyYa
         kvlsQsxJExF3kJqUJIyVQACdHpLXeG5IrC0g0McT0L6Z7lrMLJ9xyBWoBN0axBbhrW7a
         mgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022439; x=1768627239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wN8PVqzzAZZHRjxdINCBCNKySb3WeVOzy7dnQm8uUnI=;
        b=StyEm6+VNxlezruLLel21x9J8FV7daC3ltgavY0hDNxHI49Lpi68O68ZNEezqjLvS+
         3+cL5OrOCq5/gBM5Fqn2Nn0altKtFAij4mFGivAw6tWKqTQo4xG5GgutTdiQgHsDKHX8
         cOGk0Mot5sE9L1lfoROWQ84/XTd2PSdHYLC9qMpD6TJ2Gov+vGAgz4ARpgly9UM66NXD
         RBq4qG/PleSA16aWpeikZ/YUZOhEjuPDe78tZoi+RuxXHxNMjS8PANBPU1rm54j8Nx96
         2ru5rY6qc1jAcJOptENCrifOQr7XkGWj7JUVxKsZdmWoBNkvrzu+7PICsxzB1cHmlBsU
         w4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuK/fUCIe8PvYa9CirJJoTCqvU/PLn2VhNJD6rTAlMTxqcpeORMSgAjZfA01/dPXbm78fkDaZ8oozoODk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbEHSYCDhGIOwo5EO9bBJGJAMormns833qXwVjEGsKCgTG26S
	kSZpCc3Pqtvtj3/Co9raOBxLmeoCG4AK/hDI9LsFOMpM+WG3NGlvOI/v9qBH30sTzN0=
X-Gm-Gg: AY/fxX6yL2uxxiqnP2tvS8hraOdACMgse44iT5L6ahWCHN/9LaIX6wJ9j7hqEzAlpxy
	IfHwIoaHRzmXuSx3pDzNONUKJRYO03xyktEgoVGzziIGJ9R0JQrgfW9Beu79ql2tISSnPqS4fm4
	ViQZFHHUj4gemsdPAdJVFcXMy3DZtmeNBMOGPVcCXn+vRgdiAlE+WgBLBi1REbblIuxSzGJ6dnM
	o/XDpYnM0Lnn/iebcbqsAmsEywPi/uHm+Wl62Bw+ViSnb7OWT2dGB6WL4oVWHA0hGG3+Iv6ceLL
	qYu59mHV53r2G3B64b9iKJ29Aut3KaExYEUvqSGX/eOv6TBc8+ZVWsoKQnb3xE9kjAR/60usHD2
	VzV+5iIyc1WecVMnnLDK7dWOK2TdkKtvmaNl8ZlWnaGAizqgHfodJfhY0Hrtpi0t/qXde7/l4Be
	qUL7EAb/kAUJgrjMUNdZpEJftcu6HZMwEeoik0EQh3p66GeHbfRsx5fQ==
X-Google-Smtp-Source: AGHT+IGZtSmMwR6cKIPymm7XZZ9fkMJA6J3bFnj8XPrkJ3tLZRy9i+zl/jYj9RHZFiRlyHqgY3b88A==
X-Received: by 2002:a17:903:2341:b0:2a0:c1ed:c8c2 with SMTP id d9443c01a7336-2a3ee4b4497mr98060915ad.55.1768022439138;
        Fri, 09 Jan 2026 21:20:39 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:20:38 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:22 +0800
Subject: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
In-Reply-To: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
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
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.3

SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
Add nodes of uarts, timer and interrupt-controllers.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
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
index 000000000000..a815f85cf5a6
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -0,0 +1,590 @@
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
+			status = "disabled";
+		};
+
+		maplic: interrupt-controller@f1800000 {
+			compatible = "spacemit,k3-aplic", "riscv,aplic";
+			reg = <0x0 0xf1800000 0x0 0x4000>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			msi-parent = <&mimsic>;
+			riscv,children = <&saplic>;
+			riscv,delegate = <&saplic 1 512>;
+			riscv,num-sources = <512>;
+
+			status = "disabled";
+		};
+	};
+};

-- 
2.43.0

