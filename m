Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970223ABA1
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022348; cv=none; b=O/i3Prh8Ml+Vs2PgOpUzUZ9KLUEkO/eiff+F7f3FNe5zry+4XA162mutoryajgYkRgaNQeGfbJRQSQK5xnLaUKGpJ0HYEwruiHpYJ6Oi/fE4m+/rxgtSfCdbHAJx904nScGVsq86pMdNj18NWRnx3xKaMayv3sEkjQ7UXHT5OZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022348; c=relaxed/simple;
	bh=2L6MNmGY38hVdp9Ijc+okVTe3kqDNq0YpAih/UfxNDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTkOQxuVtVg7aK9RslefQuN3Sted7XTOl/Ga1gx5kYlWZKLZVRniyawPUHqHXkNB8UriJ1rQAnd2nJoyH1iZp9W8Bd1uDaOUFHIJoCNf/447P7i1YqUpjEUnJ0fJRVQR/vPJd3Xk6YI/mUp850WFuApwB0tQSl5seU4ixTWMbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=q6UvC2cO; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="q6UvC2cO"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f2676bb21so43937445ad.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022346; x=1768627146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vZa4MSAEGd4aC/jK6JBtGhuF7IGt0ZyoCs3KPie1Vc=;
        b=q6UvC2cOrSAnDOq+s+jUxpdGCQ2cyU+UlCa3XE3LSUcjS9vJHaDDOWe2uJpLTDHM8z
         PpyvlQiMPrZr98079NwsMOOLjwMX+UWWraPkd3iQw1uYR4CUiQmDPzvYWDBAm8cdTP/G
         dEdqd3c7Dkhuif8p4yvBoS73BI3lue8wxldDIMpBLII6T+22m3tU7X0slXNjQG+08Sjf
         uEqiNspWEMAxvZoXJ/fzCYHzN0JTKQkpNkXLbaSWNFToEkg1AlJEnlHD4Tadarbxuh7+
         Yyrii0nXjHTIDiJHDb7pIOqBX2efM5lCwRtshVqTV5rimmKHqjB0ZH4kuZOrtwwnFhYT
         3HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022346; x=1768627146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vZa4MSAEGd4aC/jK6JBtGhuF7IGt0ZyoCs3KPie1Vc=;
        b=lbZaBQie5CWrklmJhAAwohKTqvcxCJxXVMSsGlZsSzSbSOUAt6l6C53DeVxVF4Yftp
         R1wAwqPyw52KfcZESNKIWYFLbSwU+M0tU/gdGkqgNstrSdsJMbTCkad+e8nxdzyZcDVV
         +M55iu740Iesb8KtwJYA9EPLz86r00GDgaGtiUaVEIirAM3sUDwlpZe805CEWbqfn9vM
         HIGqYwIif9GotY9rVCZL8RIAxJdLA5+ZdR6f7XnnBS66uUdOrHg2Tsc3VQ87fVPcdVon
         Sa14VpwF4lPStV0J45qSeHqrrEld/8YehJCvjPH5kiC6FsrrKerL9lydDvRxakDmfvcH
         ZKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkqmQX8vBR9ePaJfA7YbnoU6sc7iEWAOIk01U/SCf4x22owgueWyDEaL+ZO8GJSYc3GsWzOhqUeIWfvOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8UdVS+BUf/Fsg4XoOJyExdKg5UStf43CuEN90QllCgMZdBei
	DAQVRJsNzhS2w72nB/fK05j0wS5RbLSOQ/ktO3yd1n1aawU2Po8Nde2nytCFZ+ShfJ0=
X-Gm-Gg: AY/fxX6tV5DjAYTBSerRzN6QNU9hB9MQOvY6yRazZHDsbnqvND5E1iT9kquwaCUGu0n
	sbR7lEd3e9dqjrdbxyyR1QlsU9rcYOW7y23DwoXqxBTsL2sAl/l2S+BCDR/PGeLJT4xT/jBOmpW
	sPl+hmALSEztxMARJ5e/97+BXHVk0lYeI+DU5B8tL69DJUqG4WK6Mxu3kIJXOeAgGIVpS4GWd5p
	sIPynUjyRLK2AfwipJLm+tgleH5EmJEY50i+53tJRUiYyqa0fvKbcAvoXQALnER6Tgx2QF5q7Jq
	K2U9lNu5hJw1MPYZdORjuCWnJAJx1dFy09Wln0O2/bZfEkbQKv1OyFAVGzDOGtiuNAi0Bq6oI3j
	3h7hNd/BT8AXWlMytCI7FamSuHOmSgr1IZdDgqQEc96zQGQoDbkUNRBU8rZjl6OePsb+i/+g/xJ
	TQQ+V5epbkSliI8br2trTh0geUy4WGbSlFxKcBST2oqJ3MmDIGZrY9PA==
X-Google-Smtp-Source: AGHT+IHbWq9DQ8nx6uG9JGFLdiLuMqyccmdPD516zDG77XGC4jrI6E+jtKCvRSSwQ6vvWdUH3x05HQ==
X-Received: by 2002:a17:902:e549:b0:2a0:be59:10cc with SMTP id d9443c01a7336-2a3ee491b7emr114403405ad.32.1768022346020;
        Fri, 09 Jan 2026 21:19:06 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:19:05 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:13 +0800
Subject: [PATCH v4 01/11] dt-bindings: riscv: add SpacemiT X100 CPU
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-1-d492f3a30ffa@riscstar.com>
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
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: b4 0.14.3

Add compatible string for the SpacemiT X100 core. [1]

The X100 is a 64-bit RVA23-compliant RISC-V core from SpacemiT. X100
supports the RISC-V vector and hypervisor extensions and all mandatory
extersions as required by the RVA23U64 and RVA23S64 profiles, per the
definition in 'RVA23 Profile, Version 1.0'. [2]

From a microarchieture viewpoint, the X100 features a 4-issue
out-of-order pipeline.

X100 is used in SpacemiT K3 SoC.

Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]
Link: https://docs.riscv.org/reference/profiles/rva23/_attachments/rva23-profile.pdf [2]
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: Added Acked-by from Krzysztof.
v2: Fixed alphanumeric sorting of compatible strings, put x100 before x60,
     as per Krzysztof's feedback.
    Added reviewed-by from Yixun and Heinrich.
    Updated the commit message to provide more information about X100.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d733c0bd534f..5feeb2203050 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -61,6 +61,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x100
               - spacemit,x60
               - thead,c906
               - thead,c908

-- 
2.43.0

