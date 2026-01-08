Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DE465F65
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875262; cv=none; b=rr9zLLSfoQcuhe6Vook3mXB6XoM6AFNWM2bjOIta3UOvlk6mm/0c36QQ8hWFqQWyKxMtPM89TYUdwOavGctXCUTcT4ltIBy0Tx93BqGsWBJeeT4eEYX1DugX1OlUnaqMiU+bLZBWFR6qxQDWZ9wfWr8YcJfdmA1QCMmkwZNBd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875262; c=relaxed/simple;
	bh=bv9dzoM+qQXP0CaPNIJAe0gHl9Bs1Sb05T0zGPjfK/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHJenAAgLGguQ8bjWMI52fCGLBOghC0TGixhvzb0yeNV82ZyylBN5sZFyHFH8g1xcHntrWTJR1BQM/SkMm9RU2e38DM1C+PxC5quveIN9HLGS1uC0fxGoAr8yq2I6kg6oblbQcl9wqBknJhWO1SRl1tIVw8+oQFtwlNo8/ajGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=u5CAiVRa; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="u5CAiVRa"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81db1530173so18317b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875259; x=1768480059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSlCL63bjlWI7Lu3zwai0kdDlIJMrGyFIXeM2/6yxPg=;
        b=u5CAiVRau9oiXaKliRSTVDdoifngezTNqIFhNdz8ujuOmKCFsCzKQu6s0hJMyaBiwS
         reiRU7wrIMoF4zTCdlwyrw0xaV1RU77EYzh31z09Mus2Vc1PLuEZP2GWIbl14HeJpuuJ
         kkCcwOoTCRpZe6WDfOBUZNh14S2k199yciH8Il2/jNOmJu0wNRep66RwzDvqhjD11TFS
         v1SM6X2FIvBT310zs5EOEOlbCnjsRq2CNrXLAtWaJfFuTPBtOVKbdjedMvIDky0u9rUV
         SD/z7m5bV0ALb+ekMuOEeL0nVQc1FB5RlmYhhV9RrS5nuD9PowHHe3dg5hCJfz88lrOq
         nXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875259; x=1768480059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSlCL63bjlWI7Lu3zwai0kdDlIJMrGyFIXeM2/6yxPg=;
        b=pW/62Sn0IluMHobLT/f88h56aPnsVQRgKXAtXGP8NdyxIhr8h4ew02qvVLrfXh+ZiN
         4xXoDSvC9nGuhmgAbZrqUIfNfK5SlqmsOxrgyAuqupbfxHTuRiCXip36Tq8DwVRt0x51
         PFY9ESSUTGZA+lc/2BA8VQS87hxBxIKY/qbVuEZacwYPnt5+UaK8bT3FFg3I3ctSYboq
         vyGOuQfzmmUzoNjXofZXUDrUgPrDDXJVvYsJ24i4hZjhpu4aMLqOGhPR1h3dFNL2uWpU
         vn2E5hFbAO5ceK9TkyYQ6Z/1mhfH1e5bIUM7YV/ofHdLJuoYKzB+ZWIz0f0QrscN6u+u
         0nCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCS8eKLKDaViBtScrZB8mr9HQx26L8wDCFvzgHwvvMc71EGUVF57utgCDRp2idTB1urLZllpcG/xHHGMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr55sGC9rx9fcyOoDbNvYnNQvqAHe/3JFQX4a3emMzueT5Jgl4
	t72NiwBYP30uUzzoXLzVw0HLvi0nyz8HbI7kUyQFEUyZ9UW8Pr92dhVSI4a0lMQwsDY=
X-Gm-Gg: AY/fxX49tODdE4a39yOTBUE5MBU2T16duq6lWxyS0oY8JeFOuETqN+6FYKV5RSn9WBB
	sshMeXwOZVT3+jKnq9So/XuCShEvP4noiWvlhAQ4l4tXwgFCrInZ7dhY7J04sE2Qb+1Tx2yjUuP
	wj/yxDgCTFgDAzTbwTLX1kRXu4RpIwoBZwI+plaX9fn635m+MEvQAlbopDD+GNfFQLLhETT8Szl
	NP7/lZgf82uuov1ijwCpbB3LI/2BfMx5GMdd6ejcxvi14X2eoD7HEukyVIVcLINwDcd5vBz2VDO
	vm7mNrNSiCWCeKBZvCJztqFwKBIMi+jVA4NjQGlgN3YzDMjGnfqIfIjYzewPbOwk078ZXVZFm0K
	WoFct9Z5uGtbO+w+NlVCT7oE0PNfPxSf+TWu9ARHTQwH10dYD6YReS/hXpa3h21K/KowO05pQ2S
	D3t9Y7k0NZhyj0wG26tVkgATFMd1g44IjwhquPVjocgw==
X-Google-Smtp-Source: AGHT+IFkYm2SREYy+7WJ7uAuLhJAJVWSuC3ES+DlILkoTqpUr0EQ9J4ASyAuPfOv5z6+UGv+JulmOw==
X-Received: by 2002:a05:6a20:3ca1:b0:366:58cc:b74b with SMTP id adf61e73a8af0-3898f91d2c1mr6221633637.21.1767875258815;
        Thu, 08 Jan 2026 04:27:38 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:27:38 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:25:59 +0800
Subject: [PATCH v3 08/11] dt-bindings: riscv: Add Ssccptr, Sscounterenw,
 Sstvala, Sstvecd, Ssu64xl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-8-ed99eb4c3ad3@riscstar.com>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
In-Reply-To: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
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

Add descriptions for five new extensions: Ssccptr, Sscounterenw, Sstvala,
Sstvecd, and Ssu64xl. These extensions are ratified in RISC-V Profiles
Version 1.0 (commit b1d806605f87 "Updated to ratified state.").

They are introduced as new extension names for existing features and
regulate implementation details for RISC-V Profile compliance. According
to RISC-V Profiles Version 1.0 and RVA23 Profiles Version 1.0, their
requirement status are:

 - Ssccptr: Mandatory in RVA20S64, RVA22S64, RVA23S64
 - Sscounterenw: Mandatory in RVA22S64, RVA23S64
 - Sstvala: Mandatory in RVA20S64, RVA22S64, RVA23S64
 - Sstvecd: Mandatory in RVA20S64, RVA22S64, RVA23S64
 - Ssu64xl: Optional in RVA20S64, RVA22S64; Mandatory in RVA23S64

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ee2cdd3856b91a5bbf486e8a2da0986269e82a2b..78b75ab0a473b60508f72fc30d4809a797a2c40a 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -160,12 +160,26 @@ properties:
             behavioural changes to interrupts as frozen at commit ccbddab
             ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: ssccptr
+          description: |
+            The standard Ssccptr extension for main memory (cacheability and
+            coherence) hardware page-table reads, as ratified in RISC-V
+            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
+            ratified state.")
+
         - const: sscofpmf
           description: |
             The standard Sscofpmf supervisor-level extension for count overflow
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: sscounterenw
+          description: |
+            The standard Sscounterenw extension for support writable enables
+            in scounteren for any supported counter, as ratified in RISC-V
+            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
+            ratified state.")
+
         - const: ssnpm
           description: |
             The standard Ssnpm extension for next-mode pointer masking as
@@ -178,6 +192,24 @@ properties:
             ratified at commit 3f9ed34 ("Add ability to manually trigger
             workflow. (#2)") of riscv-time-compare.
 
+        - const: sstvala
+          description: |
+            The standard Sstvala extension for stval provides all needed values
+            as ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
+            ("Updated to ratified state.")
+
+        - const: sstvecd
+          description: |
+            The standard Sstvecd extension for stvec supports Direct mode as
+            ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
+            ("Updated to ratified state.")
+
+        - const: ssu64xl
+          description: |
+            The standard Ssu64xl extension for UXLEN=64 must be supported, as
+            ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
+            ("Updated to ratified state.")
+
         - const: svade
           description: |
             The standard Svade supervisor-level extension for SW-managed PTE A/D

-- 
2.43.0

