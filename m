Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A01A9F8C
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022430; cv=none; b=KNEzgNzQwYQLCG8u5tfIDsjDoeeIof3PMVOOgFSNnRCAWT2Bc8OEI4SUWK4t7/ypQdkeqfNsxAMLhPGgm1x6GJzzfpF/mHhiXcJu7t8p+0cR+NSpTQHH3eUbKuxh5Nh9s5Zt5bwwEj7rPj58gZcBCb38fUYXBHW1gzGN489chd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022430; c=relaxed/simple;
	bh=oaK5l+uadB/1UtTh6X35C4GVaTS/guc95RdMu2I299c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/4h7rT4NhFIFZMCjuldSGVogvYj2YzNW6amomfrgqEjEtOOMAhA+/NbyMlQ004LxjbYOHB4Ggs+Q4LzIZD0aU+qIlSHjTtdAWZWhOtCUBlHv5PxY3L24M14ioAWzjeGIfQ9mWFIJ9r/5uDUGXCi58rG2upDe/HcrWGvImyup74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pJOi6adM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pJOi6adM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so1546984a12.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022429; x=1768627229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnKLaktx0YitXAvKONWboruSzuMArssppl0GK0vv2ZI=;
        b=pJOi6adMLnqmhKJnzOuRamDxuDmTr1Wkkkqe/7bNt++9Ura1J9/Hw1KfBxSxRIqYBY
         OZxu1v0R0j1bqP8ZcjCn9OuE2y9gU3BwlxnhiqoSdp++JB7EX0Vm576YUhuU5GShAxSU
         +fAgLKemOGR6+qbHwLcIokRX06chXdohc0/XgqFDVWqxr/ApUc8XOxGLYLF3UmwcZk95
         GK4cltOqVPATSXw5j7blcMKiij3VmFk5ohMAEP82M0tgfEkyVorwIEhDrI87tU5umrHf
         GGfDe8Xrc7H1tSTQbV4Q7+TplNN24oq26oqgc/uMkFveaF1nqc1hzxHaIbPxuq85NDY+
         mJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022429; x=1768627229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnKLaktx0YitXAvKONWboruSzuMArssppl0GK0vv2ZI=;
        b=nr9ILfHuStGBjAoJn5r9YLnWJlRD8p0XDBiXi4eSE/2VQqGr2MpQg3XGistKXc6wAW
         MnTrGbPEfeaxVUeXK1+LTIz7oeiR8XsmJHaPG+EhYoCJxAlrKyryXsH4vdMZH9wgbPrX
         lcoZNzcF8slRpFD9yscufD0ZCmBMf+t3uEvBeQQ+650ulNRECTMlFA/4wP8MoOpBZ6bs
         e2TcFXfartYPrq7JItMuy1jlJoH2bJWESdoxYd+8iwh8w5o4birIfUx1avoru3erNgb4
         lqOToCGtROXwz+Q3YSu5Kn28HLuc57Ey5bQPaSPxp7OC1hAGx+1ZNd5DpHgzcCb2r8l8
         wI0g==
X-Forwarded-Encrypted: i=1; AJvYcCWqlSs9+K/HtEN0VQWMM5+zsoUrTc82wCNPoDIA/7avpF4Z/106VFbr+cuB5QK5vLlbAXh/khwNCSMbtvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshIaxbA3oNwcTrjZf++vi26NDQzviPoCcMWWolQ8iabeRHfFu
	krYApLQSyorZ6nBHLh4jCYZlWHboAjV+iVlJFDKSwGJcSw8xMzq1SZHg2zlWxcne5n0=
X-Gm-Gg: AY/fxX78RAW3EgM/5wV4ei/l11VF7+StCgkcF1LYToy+fJoPHWtE2BZiD1T8aIwA1AY
	cZ6Vtz8vbITRGRNLsH2Le6I7+A4MwGmyIhWy3O0ujIH1LstzlP/uvLoQCmZg4hRYXDTPoGEfIvG
	Yyz7xazqMzwRXlZNzgD7G37CTptGiP9rBLwSTfkcGCVpbT+/AYW2zl3zarr24EiIN+S0pMA6ebc
	u6YFPuGGRuW0MpSVpCq/tFGdewbR1NJs/RmkjQYXtgdxiBTZbiBxFR2AQX2ho8zC7ftlI1P/Kxm
	gk03ACfRNyPJJXZADcJ4rZVQRpiAOZ5ThtPf10+kGzta9PnsKPNneJ3J+PxTcgHN4P4zN/nc+Mq
	X/tEvufJazJeh4ibXA68N1N5UsezJvLKkcTVEtENwJY4E2MzkcfnPX/lrS1gt820fUNayYLUczb
	pUdmM41FyA5T9zVU5FyXofemOdc5BocbsJwK7FqUmpUMgHA2fljRhNew==
X-Google-Smtp-Source: AGHT+IHLx1wPTjXjzAS2eGdh9903fjAPi7RCiCtnZZLH7PsVuIyVqtFb3O/Bml6wg2iKJ9agI1qtCA==
X-Received: by 2002:a17:902:dacf:b0:299:bda7:ae45 with SMTP id d9443c01a7336-2a3e39edf19mr141059685ad.25.1768022428644;
        Fri, 09 Jan 2026 21:20:28 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:20:28 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:21 +0800
Subject: [PATCH v4 09/11] dt-bindings: riscv: Add Sha and its comprised
 extensions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-9-d492f3a30ffa@riscstar.com>
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

Add descriptions for the Sha extension and the seven extensions it
comprises: Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
and Ssstateen.

Sha is ratified in the RVA23 Profiles Version 1.0 (commit 0273f3c921b6
"rva23/rvb23 ratified") as a new profile-defined extension that captures
the full set of features that are mandated to be supported along with
the H extension.

Extensions Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
and Ssstateen are ratified in the RISC-V Profiles Version 1.0 (commit
b1d806605f87 "Updated to ratified state").

The requirement status for Sha and its comprised extension in RISC-V
Profiles are:
 - Sha: Mandatory in RVA23S64
 - H: Optional in RVA22S64; Mandatory in RVA23S64
 - Shcounterenw: Optional in RVA22S64; Mandatory in RVA23S64
 - Shgatpa: Optional in RVA22S64; Mandatory in RVA23S64
 - Shtvala: Optional in RVA22S64; Mandatory in RVA23S64
 - Shvsatpa: Optional in RVA22S64; Mandatory in RVA23S64
 - Shvstvala: Optional in RVA22S64; Mandatory in RVA23S64
 - Shvstvecd: Optional in RVA22S64; Mandatory in RVA23S64
 - Ssstateen: Optional in RVA22S64; Mandatory in RVA23S64

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: Drop dependency check for Sha. Both Sha and the extensions it
     implies are allowed to co-exist in DT.
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 900270e8d22e..41cb4aeb2667 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -129,6 +129,57 @@ properties:
             Document Version 20211203.
 
         # multi-letter extensions, sorted alphanumerically
+        - const: sha
+          description: |
+            The standard Sha extension for augmented hypervisor extension as
+            ratified in RVA23 Profiles Version 1.0, with commit 0273f3c921b6
+            ("rva23/rvb23 ratified").
+
+            Sha captures the full set of features that are mandated to be
+            supported along with the H extension. Sha comprises the following
+            extensions: H, Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala,
+            Shvstvecd, and Ssstateen.
+
+        - const: shcounterenw
+          description: |
+            The standard Shcounterenw extension for support writable enables
+            in hcounteren for any supported counter, as ratified in RISC-V
+            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
+            ratified state.")
+
+        - const: shgatpa
+          description: |
+            The standard Shgatpa extension indicates that for each supported
+            virtual memory scheme SvNN supported in satp, the corresponding
+            hgatp SvNNx4 mode must be supported. The hgatp mode Bare must
+            also be supported. It is ratified in RISC-V Profiles Version 1.0,
+            with commit b1d806605f87 ("Updated to ratified state.")
+
+        - const: shtvala
+          description: |
+            The standard Shtvala extension for htval be written with the
+            faulting guest physical address in all circumstances permitted by
+            the ISA. It is ratified in RISC-V Profiles Version 1.0, with
+            commit b1d806605f87 ("Updated to ratified state.")
+
+        - const: shvsatpa
+          description: |
+            The standard Shvsatpa extension for vsatp supporting all translation
+            modes supported in satp, as ratified in RISC-V Profiles Version 1.0,
+            with commit b1d806605f87 ("Updated to ratified state.")
+
+        - const: shvstvala
+          description: |
+            The standard Shvstvala extension for vstval provides all needed
+            values as ratified in RISC-V Profiles Version 1.0, with commit
+            b1d806605f87 ("Updated to ratified state.")
+
+        - const: shvstvecd
+          description: |
+            The standard Shvstvecd extension for vstvec supporting Direct mode,
+            as ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
+            ("Updated to ratified state.")
+
         - const: smaia
           description: |
             The standard Smaia supervisor-level extension for the advanced
@@ -187,6 +238,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssstateen
+          description: |
+            The standard Ssstateen extension for supervisor-mode view of the
+            state-enable extension, as ratified in RISC-V Profiles Version 1.0,
+            with commit b1d806605f87 ("Updated to ratified state.")
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as

-- 
2.43.0

