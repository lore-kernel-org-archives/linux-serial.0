Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5130E0FC
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022420; cv=none; b=QcpjbW2rVmGPC9Fxj0ZyWiaXh+G8TcvBcByaWysILk0rMvnPnM+l5S6pg6rd3G1UdgZ8bZVlMZefunrvs9smRF2FOltDg5Vpx3IoqZnElJqKNoKwGIbJfLd/KjM1EspQyJs5GncbskQ/kCGAU1QbSPwr+t9mUI4mtDgIfjC51jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022420; c=relaxed/simple;
	bh=80EhE/OitNlYB1B+6VQ3QGxBv250UUMYzSB2ImKLAxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuSXcHpuk+B7r0DKtzxah/oN5ZWEloSXRPIqhTQkLxm18LFAaL38SQjosjcbbS+luTjkzxR8kf1ay8Sw5sNtykXbjrQdaRuknXdZuqupykt229q7FAH8/K302VhXp1AxawIB5lsoNCUYNsB0zJe2FA9Ww4PaZdPZA5tUnbgiI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hQfEaxDa; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hQfEaxDa"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso35870515ad.1
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022418; x=1768627218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zN0jIJOhzutug7gLJze8M0eK2qEZ0NMWNu3NtKdrP8=;
        b=hQfEaxDaWH4cbCjU0cdptinb0nvrfGRsfWUiI579alHT1tg6MA568huKhMC73/E1ek
         i562v/L1odyWOQpi17tNHBAurIaZmdzvTeRXtli26Cm7FrKaDrdCbrBkyZGT14lUehzs
         EBQfbNth6JvtqqhVxW8PeZE3BUCpG8X5jvCnt/WCP7BVBoNr8OplEWvqFzp6J8jxeReZ
         3X+A8LICjagXCdazpzB9lvlUhgYpT5dYdWjatkHMWcl+yMwk/+saDByM25EnSelIsyyi
         saE1pQTwaGYNsHnnHZR1w2z7w0xNJVi3xn4hp2beN0Tz00s4PnqgqAPD/1okd/ZH983x
         v62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022418; x=1768627218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5zN0jIJOhzutug7gLJze8M0eK2qEZ0NMWNu3NtKdrP8=;
        b=Kt2oxTCTI/Vk8oq/pe/6BKMBKhChgPAocMaw9fMClQlKpbmhoMf14+OjMuAq39TCv+
         lXgkG4mr62hOLxtqH7koK/8eg7g0z1THGXkOGM1sbejR6pYLuj0jm9yRGBs2kOqPriMZ
         lWG3lm1BjLXQExBpfXSPfZC3Px65lrM1daFblO11Dkfp/2s9WXabftSfroQIdBoU2cex
         rtf0571q15P0FH/iYejHdOsGhxuXiQBaEg1WWNMjV6sez5z/s89kMGeeesCHAmkS9dLP
         O0RGnC84lx5sIt5tOE1C3JY7HvHPKSAePHMpTidTjCPXBEKceN0U1zQrlUDTWXPJKZnv
         ZVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCAG6IL09aX6pkWf+ykEMzfAQSOBxrWkZqon/KzEJkKildTXPdnCxVBr4birIqNqfrH19UafVwQXb8iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/CDMyFBcn5TRdMz2L2G3ipSBczOLVNIzigkIWWCb2/Mu117y
	LdRJjIN0fsEEElZnEuI79vwtqnPXjBa7ReyuLKLqlF3bpTn0kq+uzWa3vbE1HNrUyhA=
X-Gm-Gg: AY/fxX7jT8xH8t0AO+3IVAdUfKALgVaHlphmeKCtaN2DkyEmElBxm9hE78VNz+pBYW3
	wao4cLpVVt58tZC36FXmxvfkkzGWOnVMFMQIK2ocV5Pxm8dfj7dzvKkudzxyT2rwS8jQSMVc3Lm
	QPk+76UP4ZYzTVA+S8j8yU+Gv50SuQidSBDjhdnFN6gUKxd3xfc1iLwXBF9O3XIyG62pG0P1z0C
	YNMTN+6LMhXwB8yutUGboRCIEfpYZ9dOlcL2DcHA1zPsiz009KwBDBmhAr+tXMcV/voDK/0BZsh
	DbonuafOD37M59NyUVYq1eJ1clTfBx1gWOf5E936KeQ8MtYF3XdKX7orPMt3ied6WxCGR+PP2PB
	5Fl7yryI9y0tc1Ew1m1DwUxcpYrEWfAGKFl57Y/pvzfOUgYuGyrxpuoVDoCoMkqUlX2JP4JYNUU
	QC3NWWyh1fFd+qjS4UUMkXE2N819H6HDCuDs33PYBL+URlNMQ4C8r+SQ==
X-Google-Smtp-Source: AGHT+IG/YASZ5bP0G4QlJrDOO/Py+JE5tERCJ+CHN75BwBTQicN0ixi/wKAyrG96pxluUrT44Q9eFg==
X-Received: by 2002:a17:903:124d:b0:2a0:be68:9457 with SMTP id d9443c01a7336-2a3ee4902d6mr98631605ad.44.1768022418148;
        Fri, 09 Jan 2026 21:20:18 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:20:17 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:20 +0800
Subject: [PATCH v4 08/11] dt-bindings: riscv: Add Ssccptr, Sscounterenw,
 Sstvala, Sstvecd, Ssu64xl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-8-d492f3a30ffa@riscstar.com>
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
v4: No change.
v3: No change.
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 345624326e9f..900270e8d22e 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -161,12 +161,26 @@ properties:
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
@@ -179,6 +193,24 @@ properties:
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

