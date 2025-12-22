Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFB2E62C0
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408882; cv=none; b=uQTZlj6aCEPA/XAeqETbH10jbl4zD/e22WRvn8mUu/H2R8JaH1P6Zd80zxoRAro2wFcFiLzgB2VdsH8Mjx3WGghcelcxd8tWRulmizfSmhJaWe7PB4kaU5SXxNjQHBFf+hxXBBXFMycDKnlXpgo2MO4+o//kuzFxdO3ePiphFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408882; c=relaxed/simple;
	bh=K89WJDNQZlTb3RIHeGjyXPAyA1oKMNnY/ZPdlLDcRPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2tbzxm2OgSaJG4Ph5/2JaP7IfeWCnhPfwXTdrPiKM2yKCyQ1W/5kFSJC82Ag4dBzBWA8fvSfzEkObxbtQp5Q7IA8hPAm3gRwsB4HO2HT9Z8/zDTbYF9MO+uQj+HkrNiZTPomCpd/vU3A9cBceQAaZMVa7QP2q0UNW60eSBUfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DNJi14LN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DNJi14LN"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so4773236b3a.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408880; x=1767013680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkOHhVohKsGIoIuLcaXjm92Us2r7m97EVQ3rEIH1/FI=;
        b=DNJi14LN1/M2nylWwFmZOt12gpj8YB2E/O5s1uF3q0VdFwJHm6b2SktWaA7ycQbpHS
         f6tutfdI/ilfoCF6QyKAHNj6169LtYoBGyNffHXZBH5KUhR3BcbzLITzP2BLaAw5ALf2
         u3aRh4pR1gACL0Oc61mWc1JeqjQJ8p1JTmITtLWJJboiaChiGycgSayx4bB74lV9TVwa
         wzuq88wAa2ldglftkPuGbao2cEkTj5Y03nZZetCYc8nTvuIyjkqscWjIj4kQMOqP1Cwr
         S169xHu8+AurIUxbpOdrI/M+uC2XfkfX+fdymM/hFBkH1rf51zq5yvcRiZEgSGpRXpOT
         Vg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408880; x=1767013680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkOHhVohKsGIoIuLcaXjm92Us2r7m97EVQ3rEIH1/FI=;
        b=EFYVkylW32uqsHYyBB9kLEJ0GiC2ylBz2J3/42iqf+ADX8kWNVo8oQWwqKc5bup3Io
         rk2s3y41zyZAmT3PLZnlbKdpI6hmq3+xjlx0wxCH/hArq3LqZqCf6ChYJ37Acjxww2KM
         YD2koryD6AjGvJpNzzBF2uC9uXEcOeBXtDgKd3+IaMfLSynMdY4wV5LzMZBKgMH4rNDC
         QHKozCANd7FpLWgnZCIT3T1KNmGkwiX4lMSF+SiuN28bSKzJ4NQJoHxzaI1+T6Q1Drw7
         aysUpJ4DXArbaE1bJIcLSIGfxOETDwkX1eBjLZVLzJU5e/WJhEk/K66+8t0XJsNOv0xI
         9ezw==
X-Forwarded-Encrypted: i=1; AJvYcCW7tF+O0V1LB9+W9ODMfKCf0O8rBYoTaH+AxG3yyfF7x5lO5PR4UgXgF9Agu1Ii1E3YODpnwPL8QVoqi9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgipY7mC+kpLz1+gFl7rHZLdOwjii8PONTTF9LV/ZC60v311Lb
	DbJZeEgbxD23QyeCFDoe6Cs4tHFXs/dFMgCsfJcTgpuRd22TcE0GXV8r5Vj6kFBxO+4=
X-Gm-Gg: AY/fxX6YLzvxYqBsg99PE0Fe26s7s0W81SGMH4SeZ+Zg2MgOlkp0uCC1JHNcINLnlBm
	7qbdsB3GCtaWOEf+26WQdtj2Aua2FhDnrFNt4OouvjqbVLEG2GtWegUWa+jR3u/RrxjcPgBGRMs
	PmCJdN5JP/HuXhdIoEcsJX0Q9MUgxr0PNBAqI7cSit/knGcH0myePOmVJWvhfUWnEcY0f9Jkr+O
	rTR6Jp5RokHz/H1GZFGSa107FRJ6mgQTuOSt+fQQ8ouTCsQFSXtt4rtwm3W2QTq0ARnXc+itYOR
	1Md8YHMCMOKOalEJRqLFyiAJrveazyH286kvtuI3x3kNce65uSAGN/ZL5mTcr/YkAmB7yCjczUp
	+8XBahM500b5vQnEYt+Jkh3vNkQI3C7i72GS/1kNSf8vfsCiKfKscBYeRXdLcxiSp9sMuPIduQz
	vMyMhmfwjqTVlfRuGEBNBSQhqFDU6oQMw=
X-Google-Smtp-Source: AGHT+IEVVJo9wYrbvjovvz34oXELviGUYat3B+h9KiQImiYaXL0x/LFxPhkuEtVr9NEz35uNWiLhaQ==
X-Received: by 2002:a05:6a20:9189:b0:366:14ac:e1d9 with SMTP id adf61e73a8af0-376aaff470amr10935543637.63.1766408880374;
        Mon, 22 Dec 2025 05:08:00 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:08:00 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:19 +0800
Subject: [PATCH v2 09/13] dt-bindings: riscv: Add Ssccptr, Sscounterenw,
 Sstvala, Sstvecd, Ssu64xl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-9-3af3f3cd0f8a@riscstar.com>
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
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a6b9d7e3edf86ecfb117ba72e295ef097bdc9831..ed7a88c0ab3b7dc7ad4a4d2fd300d6fb33ef050c 100644
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

