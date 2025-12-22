Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3342D8DB1
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408903; cv=none; b=U/dQyLzgLAS8h4Kz7Rc2e47KMGVSXPP/cKY1DJzcXPCoZNDSHGWoxUz5kXblCMuyaDZKxNxBHken76M/lO1p7jCRbjYH0B0XMwtxYFAmRcJkqGdrEHWEJLohiRsAk2qSg1NUKdsNfXnsidhBTESw3lJjQ6Tb+id5ECNAw9uuF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408903; c=relaxed/simple;
	bh=OLOZwUl6RH4OmkxuM+Ler0k2wtMUEu+h/L5lwnAAfbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxGSZnlQ9j5po8IQbB6ODQMrtnDFfe/bAJUa/iJkpICezk4YpOs/yjPMDMvSdSO5mcEKzE6zTNC+e4uVs9zoGWf3b0D4Bdq/N484NlwYZGvZqrD7XOaWUEQHv5j1GDHD0LcFflMmb5s1jlmV8lNPNv6ujChlOpZpNFRQgv0AnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=sS6kQp8d; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="sS6kQp8d"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so3343395a91.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408902; x=1767013702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swb/fWVKIa6s7pXnfz0NuUC/cpCMSK9KRmfqsMJyLx0=;
        b=sS6kQp8dEtXMp3KUhoyy39XhntfiVgORe3paX3r2+RSxTf334+4AuAEVxwMqLeuUMb
         nlGA+kZh++/kAy3ggI06xxz7ZPfJmeR0yOD5y/2YbFwcrcLZgFXm4IkMjSVHpIQ9n5W9
         zgLIrSrghNnTXZW+uHMTJQ0jy7s2tsY7pC4MKyuDDF2n220KxaG8CPHwsxElVs8mOaEd
         c9MjzVzDTmFKjw7mwpkbDFp+nYrApyRFIrpD5crbrm5oWZg2PkXn54r+GCvFfGYxJ9rs
         LMjM2GSlGdi1XXEhdrWFN3pdy8Sd2qkRROoC4SscqLLiJSjORPbzch3F4GNON475Uf90
         TKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408902; x=1767013702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swb/fWVKIa6s7pXnfz0NuUC/cpCMSK9KRmfqsMJyLx0=;
        b=i265e6Tewcp2KTESOMnmnI0jM2/Ax3+vxK6xnhzLQmC+NIFKg2s2chmRQIMQxJ07ZI
         mU6PU/SRLalmHVRPdqjQL82PFqywBWUptBy3MseOGH7PFPUQwufl4h6T3gcT2Y1yY8al
         kUN12LgpVwQ6MUvqqQWKV36TgnICqKvdxGyp6nr9MBhcvco9oEAPnrdbgU+Apm5AUwqz
         S4D6f68ijB4iqiWVRQ845IU9e6/CPncdwSJbfAaxokuMfkgdI+TwWVJVweQs0lOJuShj
         UVv3akW8NfMa3v1Jk/eWpJO8HbSfmMdjfrw2yiyI5n317uX0tzp/zuv6jzi0IGlzvHGa
         9Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCWH2AH2Jwee2aHv58TGz2jAD+yu3yVQzCQWzk1xwpN/YM/hOxZ7dxSA8+44yTTDaLa/6KsJIfUOVVaWrro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9O68oNHIioM6gXkLK4sTMXvZYnj2oom6b24CAzHggeiMh+Mtv
	IEUtEIlsbBfTdTl16X/UcKb/quq/HWc34i3zgFXyrFIrJIOu92xh3N8+7ifYQB/Yqx8=
X-Gm-Gg: AY/fxX500sT+s35dNQPnH8rICo2rmDSA+2jHnZuyJkSvFwi9/6TCNRc+YnZW8ckVeYm
	qwNf4PjRSBitDlvNbDhBH6noapOgBsS9I03kCZoCS/pMP035a28z1ww1IA9ZOHlJdfpnpLhzQb+
	G1lO5aNbcqR2sCb4MiTBhxWDQs2cg+9yibARXV8fdjNwVAnJtkKGYwod//aaCzB3AT2+ZYeklzX
	HuJPYfLESULx1bkF2UTpJZbgKQUlqDD4aPkv2YFkyqFXC+Pi0GWriLcVMnbqa9loaNOGTEtvnS4
	qoqPhexipiiMAQOoeJSKdJw6Xat09tgxgCAnP5UnqI54faHwpSkYvrbVt+DxsjOdwx7FUDFmIsr
	cMvL4UvEwMCCBH3A40Dy6ivVqZHJhJuQ2dzGRmpVv8gNoA7E2ajPvdvxQ17B5k6kYsC3OVtAGel
	v0RgUZzeudWbvqiOjkDsL5Mx8E5O/rEtM=
X-Google-Smtp-Source: AGHT+IHPPRy520yxXn5W0jP09IBKvbx9Ua51s8et6DIA6qmS0TPddDUVvXFSM5IqYjM5F1HB2SrU4Q==
X-Received: by 2002:a17:90b:564e:b0:349:3fe8:170d with SMTP id 98e67ed59e1d1-34e9212a48amr7542919a91.3.1766408901569;
        Mon, 22 Dec 2025 05:08:21 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:08:21 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:21 +0800
Subject: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension
 description
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
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

Add description for the Supm extension. Supm indicates support for pointer
masking in user mode. Supm is mandatory for RVA23S64.

The Supm extension is ratified in commit d70011dde6c2 ("Update to ratified
state") of riscv-j-extension.

Supm depends on either Smnpm or Ssnpm, so add a schema check to enforce
this dependency.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: New patch.
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 1066b7e65dab89704dbac449db4aa5605c95b9d3..4997f533b2c0defad88fd59413a6885b5b9e109a 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -267,6 +267,12 @@ properties:
             ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
             ("Updated to ratified state.")
 
+        - const: supm
+          description: |
+            The standard Supm extension for pointer masking support in user
+            mode as ratified at commit d70011dde6c2 ("Update to ratified state")
+            of riscv-j-extension.
+
         - const: svade
           description: |
             The standard Svade supervisor-level extension for SW-managed PTE A/D
@@ -892,6 +898,16 @@ properties:
                 const: shvstvecd
             - contains:
                 const: ssstateen
+      # Supm depends on either Smnpm or Ssnpm
+      - if:
+          contains:
+            const: supm
+        then:
+          anyOf:
+            - contains:
+                const: smnpm
+            - contains:
+                const: ssnpm
       # Zcb depends on Zca
       - if:
           contains:

-- 
2.43.0

