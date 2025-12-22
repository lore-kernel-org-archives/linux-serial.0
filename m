Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC22D7D2A
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408862; cv=none; b=PqwmwRdA7RgI6JNFAjK75/GTSdHHZGNQ8P4Q7mSelJwgzVD/KPAEOTQdCCI3nsbBIuuqTbjnNpBWQFXif/ZcaJ3bwKkEP+NK75cnNTe1/afr7qpwU0w/V2XxqjMvmEarKEsum6krWTg1HVuYQ512PupqJ9+Vaj65SI9SX8kQHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408862; c=relaxed/simple;
	bh=5SA3J65WlN60QjZ8eAnYw9T14G42qcDvprvwz4v2MDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAWoh5NtWis/EavYqWj9FnF/6zUwF+sDdM6ilCFGfHbt1LrFbSfuWb+ZTQgQLcDdD+XaKfdvt8jsLHydoKINrwgBm6sUqwuOKlVUasUaXmMlFQljfVIoPg1iVkyJaaPidoUT16L6gmxE86sYXPDkOGA51tX30klCYQM5cQPnMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DskmzHSF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DskmzHSF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso3332513a91.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408859; x=1767013659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGQTfjuLcO04tKg5qOE8aVGf71IAU9Gz/ZUJidQ1+vM=;
        b=DskmzHSFT9AQPHHcpNw9CtIsEnD6WBmCzxi75Tqc8A0R2siOsgtW+ru2BmiA2jT5na
         bKOrJUCkmRGGUh1JdBomwCh64Ra1nbG4gR4qz/sBKYLHdI7DyPvjemoCSB/vfN5lfITP
         /CXvCxENz4qRhM7XtC3NsCCymFq7vHVV5yVNbROWN+H7oR7mfcW5FNYd0OUbrmMbVkVm
         zh/NbpYctFLGNgmhpJIQSEltvSutV/wWGXn3LG/N8oT5ToRfnJVTYvwrxq3/om/GtQwg
         Bsk8LLaJceley48cTKJ7qyYX1IxMrrowiCJqXDniWfQmR4ekCgRoz+lxRcM5MQc2/YHT
         AUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408859; x=1767013659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGQTfjuLcO04tKg5qOE8aVGf71IAU9Gz/ZUJidQ1+vM=;
        b=nsqhcT56rHBxeZ5wES7MQn/JOLpe3zHNYZlN0n3lOBa07MEFHj0Opnis4lLbQId/MD
         UJy89HLX+/3BU3sDoVNScAxkdMIIpSVTH+FU+FhC16EI8inzS0e7PEGihtLwKh9uyzjh
         8L1STTHmZxIFFvWh3j7cQWgu9hPWHYcBMcUmixEvP1/8x5py12olIOHkosBUXCC4DZUW
         x9BkKKRHcnZM0duqnDLNsMykckNIaV6djuiurUYmBsXba7oIbOqU9uKIGiHacpS9F5DA
         PK0IK2plthXV0jUnQgApfSHbrjw4SxwBanRS5+opYJ2vDU03nFmLKX8whKFud8jwyQjZ
         Vpqw==
X-Forwarded-Encrypted: i=1; AJvYcCX9M+nTMwi0qynltNK0bLrhLVWJtMh5VGuTr1HYplwWCkWpdnp6JDGK2GmVw8rQw+9/0CCibqAI4mgYDVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONkQFP0A/4ExUGNzNmfGWP74bre6S9D9PVSGoulFJ6Mu5oR83
	/NHywFsrgaQwMw+0XO7gHmob+40z7HBfc4iKMAs1XDaA6Kky7gXxKodgRZoDikWLS8w=
X-Gm-Gg: AY/fxX7Mkth5Doc/gIEDOBAxSDFyrL67zw+hQtB9bWPxD1ohfyyfeONdOQUuRHBYBmb
	xoeyrHZm4/0jl3Ega7gHewx7MVUsFzUmlUttNWGu4pYg2nlC2xe7Se58+D5obfMN3semtcTqZz5
	hEwoLto82syw24Fxi4lgqyfASFVvzmiyzRbVPmaF7szEMy3Gmexm2tSVK0cWGb/0D1IE6EqoSX/
	YHCYfuL4npiL7/8aal3PyNyREpa9XGmobracBVWR9nDRRxCQ9c+2lq5SRRVxFlkAdpvVdCqsjkA
	ZkD4TaApaI+d5eyJoTnGBikB6KwCs6+Rx77bUh4PD5fqj1t2dM7+6eqvwQmEbVjdqeBatw9O7r8
	Fr3IRaAbCIC8Kc+eY3z4Wc+NhR4/dEEPOUr0G8HopiO9oOkRdKSCvDxVMZeXG5umJbrXUHXJWJS
	9vkJ4CwtPLz5TVE51lR7y4mdXGPoCYPxA=
X-Google-Smtp-Source: AGHT+IH9e82inTfTfBy9JIkcZ+jC/BVvaACK9Mh7FCCtZMLW3mXb8WEQ8z1KSPITq0+87R6HI/oygg==
X-Received: by 2002:a17:90b:1dc6:b0:343:b610:901c with SMTP id 98e67ed59e1d1-34e921bb683mr10198388a91.26.1766408859410;
        Mon, 22 Dec 2025 05:07:39 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:07:39 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:17 +0800
Subject: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
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

Add description of the single-letter "B" extennsion for Bit Manipulation.
B is mandatory for RVA23U64.

The B extension is ratified in the 20240411 version of the unprivileged
ISA specification. According to the ratified spec, "the B standard
extension comprises instructions provided by the Zba, Zbb, and Zbs
extensions.

Hence add a schema check rule to enforce that B implies Zba, Zbb and Zbs.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e7662693f1257f910a6e129 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -109,6 +109,13 @@ properties:
             The standard C extension for compressed instructions, as ratified in
             the 20191213 version of the unprivileged ISA specification.
 
+        - const: b
+          description:
+            The standard B extension for bit manipulation instructions, as
+            ratified in the 20240411 version of the unprivileged ISA
+            specification. The B standard extension comprises instructions
+            provided by the Zba, Zbb, and Zbs extensions.
+
         - const: v
           description:
             The standard V extension for vector operations, as ratified
@@ -735,6 +742,18 @@ properties:
         then:
           contains:
             const: f
+      # b comprises the following extensions
+      - if:
+          contains:
+            const: b
+        then:
+          allOf:
+            - contains:
+                const: zba
+            - contains:
+                const: zbb
+            - contains:
+                const: zbs
       # Zcb depends on Zca
       - if:
           contains:

-- 
2.43.0

