Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A22D8DC2
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408852; cv=none; b=HSRIxe3AqzQ6YPZH5iUq0FfCr9MToeY2DIq8S1TeuF3YRrCJlYLt5VS04VnCvRcouRTEso2Db4pIoc45vW+a4vU6s9GEEu3k5TPcGjsDxB9QBAGHgUOblXjxaEzUukhbYZPrmY9Onl5NEbrPrg8kZFRz8tcMXaNsLdWOL8VN+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408852; c=relaxed/simple;
	bh=8O+KmyR+Z+W71V2Q1jG+1NmAb+LSz0CgxIiQwpSEyZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wwvik0URYs/HuRyJJkqMnXDbrUg3omcVp8JDJ2rr+n+ZlUlLsXQWNd8cxZQjAzLDwKnEZYL45Vm89YS3Pb+/fpYMNDTR83H9fWat+o7zTXlB/aRUu9F6+hnxrXo1UWk9OrXiKlVoVD9MTBoLSi7e23VCvZ5DUmE4Vj0uOLIoLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=qZmJbBkw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="qZmJbBkw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c21417781so3807862a91.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408849; x=1767013649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0hBCIJJ8EmxKyYJQRfDJ40fTqpg3Aav6dbr97Zk4ps=;
        b=qZmJbBkwc8qEmJjPPWdN4VRLicpGRBdXh8gLbse5pO8HQ6Qjpyz/RAB12kUMdP12hI
         YCsAXjIxI0gEicqpBpzXCoc0Yi9s/9p/U9oUnyKA3hF9w4QnsOZ8eA1wv/8B2ZAch25d
         i33nER4d/bqHrS7bxyENY77ROC//QhAlrYP7GeL389u+/dleNJOSuK+C3bnpKSq+ip7B
         1EC9LqO1epAOa0+cGZQw4kpERgafr+d5+cguKDNY0xLEGIwJYW+V+Ioava7PdgEsGJQE
         yzRNCc29DhDfmD3nhMhPxonPkTOAURV6awLVEGj/gPL2f2bZLoUs6ibQXa4bqg+aJjsQ
         smWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408849; x=1767013649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0hBCIJJ8EmxKyYJQRfDJ40fTqpg3Aav6dbr97Zk4ps=;
        b=iDqJtZby0WSxyIZ5tc+G0hExnzGxRHGdi9qPiSsen37O5BGpNpKBMTUCJg1D1npUiJ
         9KpcL0u/p61+qc/kYrj2e+zK2cYrxjxZRkysotd6oJ+9dzB3s1mmpZsUhjhzhOyKUA9h
         hZEMR8jYHKxjKzonxEEnWBa9TpA0RGWtkYCAhLVDGzcnFFSbskahUyd2ZzAlO5emLAFR
         KYisMlgo+gAxleW0VYLqmXdIp6i3IXaAjuqevug/7vdexw1+KWwbl3mDj2tRTzJdLZVB
         GziGvsjrkB9vSkdvwil8EiIJiEiLcBeVG01x8HipT85xwsDQmeqMHDG/47xjyLpoXh0I
         MFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2LTwsxKHjIKft2ISACFLjJf90cLR3qJfhf6R72GqJFVPNN3Z6eHqcCX/j505anLU6/rAXStLC9lQL+Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLIj0FGyg5Uo1TD8qKD/aIol1CS9YJ3RKLy/Uf805jyHN0fvg
	4maBrilr/sS19DbFoMc9pMDZoJwRqPDeUDZoLW3z4aY9pppKQ7AqVMwqGM3n9MWqSRg=
X-Gm-Gg: AY/fxX6xdGRWldgGYR6p8AIMAsLlFk/TTMZ0iaGePsnSjAlgO6GHctrd8jMVCBKwr1Y
	8w+QaxRH57kARcahb/riHUwGI/W35Bmkx6yv3RJXJ+goyHINifCme8+LtiOhSXrpDtqp0oqCcmS
	E4hKJ/ptweWc2/slLkZZFdOLGSI8uisl/DQ5BIkGO/YRuHqUFJYMO10L96sLnfl4HQkJw/MitRW
	0cwXTGtf5LH+ht2LM+2Isa+5H2URvul+dOS9VmQh7k2+Wkoq2i9459mVEHXrPROoqluWLciPrch
	Xe92T6iTAtAOg7bm5MqIE77NTxgSJ5msCZzgQQZ66U1M97U/FadlGwAAJ5bf5TM+uNrJ/ayELQ+
	tBSDxj+rYrKl43FN5vqKhCpMKfRjzEQX6SzywidhqThZsDk/ML/a4yWfvCc07HNZi6C8WUhzCq1
	dxW9NWPQcSkjb2iMsZSHOApZc+h7ild7k=
X-Google-Smtp-Source: AGHT+IH/ef6qJxgLISPyQdVV9ykkGamL2Gr7XNJ9wshLQVPd+I8d+rSgyrotTljXgKb8jsc3m2BCnA==
X-Received: by 2002:a17:90b:3f90:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-34e92130102mr9913256a91.14.1766408848875;
        Mon, 22 Dec 2025 05:07:28 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:07:28 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:16 +0800
Subject: [PATCH v2 06/13] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-6-3af3f3cd0f8a@riscstar.com>
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

Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
which is a 2.5-inch single-board computer.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Use one-blank-space between name and email address.
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 9c49482002f768cd0cc59be6db02659a43fa31ce..fe62971c9d1f4a7470eabc0e84e8a747f84baf0d 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -9,6 +9,7 @@ title: SpacemiT SoC-based boards
 maintainers:
   - Yangyu Chen <cyy@cyyself.name>
   - Yixun Lan <dlan@gentoo.org>
+  - Guodong Xu <guodong@riscstar.com>
 
 description:
   SpacemiT SoC-based boards
@@ -26,6 +27,9 @@ properties:
               - xunlong,orangepi-r2s
               - xunlong,orangepi-rv2
           - const: spacemit,k1
+      - items:
+          - const: spacemit,k3-pico-itx
+          - const: spacemit,k3
 
 additionalProperties: true
 

-- 
2.43.0

