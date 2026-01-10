Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B59279DC3
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022392; cv=none; b=juInbI97hGMuY6u+p+XmG5VaW8njqs54+VKoDV/RpOAx0oA/adepEH/BHpQs10Bj2ttdksDm0jxLk481doZ85b7zz0vBqPUhMarYWgoB+stu/ReJMWhaEYJWnZ+E5ZIfI4douNaOl3Xrok32k2gOLc7OnW/yUO7+A1YpUqRA/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022392; c=relaxed/simple;
	bh=S1jisF6ftVT3rCNF0GDuik15Q/hcWo5k5Yu1I9kYLtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcQwam4h4h0vKiY53WnMZdVLXp/GVNvCd2pm7jwCrF5PQBNToqHRfPFqp/0OvRaYcEEI2Z7m3vOZjOZRZN+cMAMyAWV/rRjcjkxy0o20yTvq1GOGdVoRjvVgapQpqQHZh/FpR+2jQokl0n9l925pSb32FGJthA4IPEHYsiBRJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vlYMKlSv; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vlYMKlSv"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso2973660a12.2
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022389; x=1768627189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmyABXvs1SN8VuCBpy/0tab2Fs0I2RX3eOqS1zJrtK4=;
        b=vlYMKlSvOZcq80+1cnMlX4Kh6DKcjduIgnWUoM75f4PNWCtPjvA/uh43NJVzJPuhzX
         x90gahPJf2k9j79U43ifsc8r6FJxCF07F1kRRavVJuwQEMVqZYb86tOGeKJSs224BH6q
         kW3bTHsg+XJkAMAoEJSdmwQh0lc3OR8NJUalY/D00/mei6yZLmpptkxDKh+oNUQOAwL7
         08GblrV4P3zPI3YufiRZFu/gAYhQ+3N5HQ8b91VoOdTDHcBwooV2ucfZ2JK9+2Nbw1ln
         DzzFIO4McEHdSJxsTyKXAWzw5EN7I0nX+kdICT+Pvjq0kA4JF/hhNBqrVAFG0334qj2Y
         OxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022389; x=1768627189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmyABXvs1SN8VuCBpy/0tab2Fs0I2RX3eOqS1zJrtK4=;
        b=u0XMaXjHFLVLbDsH4YERjfaaTG8IcwNzdnwa3y7L2QfkRgUzc04zySAu1ZdALe4I1T
         mXgh7oQWoO0W5samWjtgm3ARazjamorUjzEZP0SvYxj/Y0CSSayNp5L6BmBqTkG8eC5W
         eVagK6kvvFjyrwYkeKT7bH1GffgV6CH8LdTtTTsQusi6dXC8SpK34Y2tbqMu0+2ig31g
         Bf7YCxsTSq5oR66Blw90hU5bzF0a8gBFFXdMrDstWNtc2fO0a1Nu1EA+nxy5UWZ5Ec7D
         tMQAEgT2FYNuvcY/twAwW8lflQjAULUk4g9mhf6KD+F+bqYJVfA0oaYlViTgDHky9inT
         xVQw==
X-Forwarded-Encrypted: i=1; AJvYcCXVvAilnqyPs+MoQBWc12jngl33faK4qokF7rM/3d8+N2pty237rA+qB2hUkXw5vRRzgTc+0JcIKKLCdwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6WKu0Tv7qWdh7MekLW/4j6EiRe/bLK+gJeVTmkkJ6FdTWnZu
	S64lSxklEzx2stP9Uy8+p9v4ZxLY1czzXs2H0a39So7NWkGKLlQsh0/JYQ7Tns4HOq8=
X-Gm-Gg: AY/fxX7vb888sXBzIKcJtCscLdwcfG4CqAM18VScjQv+qk+fc7tZPcG16UJxERsunw0
	DD+Ggvl5Djo4fJl5RsPsNak+PndInIXwdIZrxgXELlt3p01S7HyuHIIo8B7Uzj8CWFcUPJ/c5XS
	2oCg+evGxsKUgAC0Bn6IrlO4kN/CSCMEzCr/b5g02QeW7eVhRRfXwpXTq/Dvbl7EmEuTWJh+qPe
	j6nZpzdhTgOfdy03uVqwLB2jNhZYR2jh1PgWi0y9SmGN+/VHi8kz5uaXt3wJCr6K8tHfblRtNF2
	N/vl5180cm3cx9bMaQj8QJKxS+OHLD2YEGOQ1zWU14LOFcTE3d2DGQeHqSDXfHgCu2DtHo/MRCm
	bsJgTWSSXICcb3m5alqdpbC2q2fc80g99XryH4uVQpu+UbTK1UWivJ7kfWaRYseqn/OsoZTeGzs
	p6mFJm7UV/+3VDrVMWJzaZdtcSRm0R9sYL09sqUqPrWjR7sRjai4Z92SmlRIRbcq7R
X-Google-Smtp-Source: AGHT+IEPPeIUWgsSKZBo27LQFfXmf78KQe8uU+5vPpaDED03FOdBQAsZNe/tyTQTcMQjGVrGxwlkJg==
X-Received: by 2002:a17:902:cf06:b0:2a3:e7aa:dd6e with SMTP id d9443c01a7336-2a3ee48ac0fmr115216775ad.38.1768022389213;
        Fri, 09 Jan 2026 21:19:49 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:19:48 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:17 +0800
Subject: [PATCH v4 05/11] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-5-d492f3a30ffa@riscstar.com>
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

Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
which is a 2.5-inch single-board computer.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: Adjust maintainers list in alphabetic order.
    Declare spacemit,k3-pico-itx as an enum, which can save future
     code change when adding new boards.
v3: No change.
v2: Use one-blank-space between name and email address.
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 9c49482002f7..b958b94a924d 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -7,6 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SpacemiT SoC-based boards
 
 maintainers:
+  - Guodong Xu <guodong@riscstar.com>
   - Yangyu Chen <cyy@cyyself.name>
   - Yixun Lan <dlan@gentoo.org>
 
@@ -26,6 +27,10 @@ properties:
               - xunlong,orangepi-r2s
               - xunlong,orangepi-rv2
           - const: spacemit,k1
+      - items:
+          - enum:
+              - spacemit,k3-pico-itx
+          - const: spacemit,k3
 
 additionalProperties: true
 

-- 
2.43.0

