Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AD2D7DE7
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408893; cv=none; b=mFowlK5ohrwOPwsRbHUNO+oo+I08wKrO2YBdUuXS9fIXBTTLz3W7k9b6AXBfdltQqV6MqXLK+WRkSoAieVnJFp3AFED7gCnWd3wHKjnvM0hFYUrbo3roIsJOFiAcIjLfJxBjuWhew4mogxs+2hyewUf+Z+1yv/9S/TnXd2zg0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408893; c=relaxed/simple;
	bh=8a6U2IsZOg73IWgIfo21uFSscDQAarI5QbcUFlV13lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLu/ZPcvp7wNkG9TOIApLb4Ox4KNxF7QpMSBxyQr99BSDYBkqC1WwU8v9yNTpO0onnIQKYDggsxRkcoVbcq552DppUx8qw5nXeo09a4T2GrznYNJoCx50vrQuerZEniezeumRwSFx+aCmjMuskIq+IMdmIxKSXu6UspdKzKJ6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=uXcMMrla; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="uXcMMrla"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so4192910b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408891; x=1767013691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UGeHuXe1WkpRh7lAuv6WjtJBbiZ85uUpTEhyAT5GGU=;
        b=uXcMMrlaDYjzpjDyrq3DVvj7n/I/F8TMgCZPnDKyn9mwXrhpXfrRxN7OIaK7s9LQAE
         /ON8yydQBTOrsxcjHysAQz1TjPHxUTJju0ZxwUQ5AicneY29PLvlNKPM4P+Xd0+/SbXb
         oS+kW918FlU67xPIlV3buVVjhb4hyLM83EqdOJsLywZuWmKgeBWwTFV9339q9HfQrOA8
         B8B0LNSKRtygqxxxq3qi/dz8BBSkm+AyJhfiM0JR4HCL6iCWoBvXN2FSFe4GrZhlq9PH
         k/X9wilj2FH/J2c8lgZ2lZb4twEe8iayI4ytgJ7C9+dwZkmzOCas1sPXoGw+DVzrrLXl
         2tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408891; x=1767013691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4UGeHuXe1WkpRh7lAuv6WjtJBbiZ85uUpTEhyAT5GGU=;
        b=btxYqvZ5xWnpIabjaKQOw2WnYH3k0isBfvkfdQN26OYl2C+lg0EQrhidm2MjiHSsMa
         yR4kBOKlL8JZckRXF4INSevUwn5wnEfhcFoLI3zIXF85TDel+/IcVe4bqaov21GbEZS5
         j/b4rkj56cxKRIBYNHx52u0ruSdZ9/nt6fB9pxPXT6YvxuY7EHcWHTO0DhT16vsfxoUS
         6Ku6M0znI0JbQ1YJMw2JpalFGv8YEUJHBx/WmKBWM+GaQVpKUH++ooHEO78jTd/CENhX
         gVUjK4nSQbHahmsXtN1DfxWYLnyY3E0vDF7fT3TfNCfqXt3uafx07tVgYg0kvY+VtOAK
         ljEg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrxv4bYH3MiJbrYp3zCE4dV+grBhzPMamMqRqCxrtkSGRibEneIfLTVDNe/D8ZPiGrIpB6DZnfqdjNJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELIqSK/ef1j3vmlg/GiSrcSm4Et9IS1Sz8UzPcvIg/5pkj+T2
	bgPc6QzRnLHFjMgeEh7kClElC8Efwd6PuhRBA/ySE6GXPTiAWkmeVCjtzMvAFMwozWsSiaf7de8
	EWqo8XeY=
X-Gm-Gg: AY/fxX6NcwY9JDrr7/4j7tNG1Tmx/aYtAqDfMbvHpXxpJ7BzBLIRH7lD8h1JHl2QowJ
	l5zIh6zoW9IdTvxk0lK9vDZcCK7H3GbwUQOPAmEZ2haKBT2nzXZdWEP42PgbR5lGIyScGowcIP9
	dosuJkIS+/BHm9obXfTaeaffWjwl+EZq7MOM4WITplMLtutG2W2MoHDWXXzy3fyxBauHwFwTXAp
	Ie3TWgfsmIY+D7RUy09NDyZws5cxYpkEKhVAX6Rgonc+aVUoJmblFRJTZ3Ciw4lsyT3hvQGb3F/
	lASqYak/Za+r7gwXwm7SiDyKJH4CT/uTpWoTXUhUWS1kedT4BXoXQeLt2wEHg0oaJcw42z1+zR4
	BIqPmIpEswDXWsRSlzbUMVd/8SoBhY9sng3v3ZtoWwwGij5cLYrq0vAwYnEmHOONvy8M0V/+uA2
	sS3GsUTMC3UgOmZHP+5dTEg1h9nZwmbYQ=
X-Google-Smtp-Source: AGHT+IHHPuN3hCtZKFz2kz+Wvy3Izr0+e/klWfBzpYbVvra66xOr1F8o2wRbCo2GQASyMyGdljfeaw==
X-Received: by 2002:a05:6a20:3ca2:b0:363:e4d7:2c34 with SMTP id adf61e73a8af0-376aa8f384dmr10273525637.57.1766408891406;
        Mon, 22 Dec 2025 05:08:11 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:08:11 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:20 +0800
Subject: [PATCH v2 10/13] dt-bindings: riscv: Add Sha and its comprised
 extensions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-10-3af3f3cd0f8a@riscstar.com>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
In-Reply-To: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
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
X-Mailer: b4 0.14.2

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

Add schema checks to enforce that Sha implies the presence of all its
comprised extensions.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ed7a88c0ab3b7dc7ad4a4d2fd300d6fb33ef050c..1066b7e65dab89704dbac449db4aa5605c95b9d3 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,57 @@ properties:
             version of the privileged ISA specification.
 
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
@@ -186,6 +237,12 @@ properties:
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
@@ -813,6 +870,28 @@ properties:
                 const: zbb
             - contains:
                 const: zbs
+      # sha comprises the following extensions
+      - if:
+          contains:
+            const: sha
+        then:
+          allOf:
+            - contains:
+                const: h
+            - contains:
+                const: shcounterenw
+            - contains:
+                const: shgatpa
+            - contains:
+                const: shtvala
+            - contains:
+                const: shvsatpa
+            - contains:
+                const: shvstvala
+            - contains:
+                const: shvstvecd
+            - contains:
+                const: ssstateen
       # Zcb depends on Zca
       - if:
           contains:

-- 
2.43.0

