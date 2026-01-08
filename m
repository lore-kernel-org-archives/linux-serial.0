Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25271425485
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875237; cv=none; b=ITFY9m/FEPMBaLLbppyEWEDjEwgQDd4aK3RvvSnCLlcPHJwif03KRMPNCg65LZiGugOeBe0imG6V3Tr4HJfuVMQ2lj6+IGapti2Qn0yc5gtGlA8iSf4qT8afQ/WOtp3Sb5iwo8HRJLraq8q+u9NxQko5TH1r2SU+SGun/2D/jJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875237; c=relaxed/simple;
	bh=JNc8LtlSqbUM1gYtb1AiNOnq7DSnYAfiDqB4gjysnbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LboGM81mzVCweZrODQRhz/zPnsjls8OBhbvAl9EdpqW4sKyvvM3RpTp3I6xBZWgbUBIGRKCVy6MawhiQykzKmuYbhd5SIJViKSnPY+1MlrhX3qRtLVOpz96u5Bsiuo0L4bW9OSuBbZTZv8SZfyui+g1OtByk1084aqLgOF5raVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=F6giAJOr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="F6giAJOr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2973203b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875235; x=1768480035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQRNhZyBrryZ4W75vN/HbLrPnH9UQ6pAq5yFj98AFr8=;
        b=F6giAJOrD8SEr5WoFCyZ/0TCE6d4bbNrYtbsQzXXEMmRpchQw7rXMmsb3MIKmba4P2
         LNvgKhxjq9p+cHcsuGL1yLf7JmBSNYrNj3kL69F19Gru4aJF1xmWAtcogvRWuMOLY+QS
         LSu3Nv8h3Oefr137bSqY16iXnCwNbAxw2EUPpNekPHU1jWhYLLtSKqq5/hSscWEJLE2t
         qDfTbZKqE4zZF9Grlsh8mCjNXXR+SMtzpXSjhAzjwN6LH/jpehT1H1xRBaMH8L1EBUwi
         9JqJbGOAFjRDpKNzO8gg083dqQymNuKLE5HDXCrB082Kqpnb1ArDK7KwY0tJqyG5BXSb
         uQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875235; x=1768480035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQRNhZyBrryZ4W75vN/HbLrPnH9UQ6pAq5yFj98AFr8=;
        b=pJCjF9fYcWMDXpQtEiKHgX4SUEVArwx8vfWuN8l4jM1N5pXTJmoZ5B0oY8IVyEVEcR
         UsAd8lEHI9T8odinygf8Z7uddd0gyzVVBwHxTrUCEn/Z+8cGWY69Mo2n+aU22aXdKWhV
         oH+smEBT+cEOu+23VLlFkF9i4Nppa5L6y8e769N08254INEyke5nU9tdOzgxwi243WYF
         dVs8OzxR72lqWrSg6xdh6oWGonvkjsoWjpz5ZgnNXe+rFuOsxMAWKqsoOO2gbKdN1lhW
         FMREt6aiAyit0913X0qL6iYUAH2Ev3kKP36rl9XXcww0/HNCjRp/PDE0u7zZJiWiL7ab
         FOvg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+5Rt4seVnG94X4FHeFkXr2AzO9yPZ3AIOpIC8D5qgoLSggZ5b6/gobhg4rNQ0U6QiG8RbcgltajJTJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOzjAJFIL5WAZI9d2Cqrj2lvhmcqGnuhmitoBos2ZZOBsS+oC
	8RNOoYlgMj3rqB/LqtPC4jPQNFOwEPGACBEBwxYIC5WQIGJGLMQskFGvCDGcpcNijoI=
X-Gm-Gg: AY/fxX7wrCtKyJxS4uGF6/v0qXtYBbZO5Aj0HKLAj/ly7gjS54S9ZwVf+PObXuiH1f6
	mY26pYUQolpMDYqeOcFAcv8Q2Cf9aR2kzHRb01h+GXr4MLcq1KAtC1h8rDuJwFg1YiasZptjfCk
	n1cBbTufU//RAH5jWAfcfEbjUVw6X4tWQg93xrtpg+uBfvKgGb33HsDz5Y7029+7sFdIzolVa4r
	tcapJPWu1/9z3pW1adRmbZNndjhIMiqs068DVOKKx2fUiybbUwzLtS3HO1q0AjAGY7qo9aUpWOt
	OzuVZIki7f761ktNAvd7sBRF+hQ+A7VdUqzIhN5pj18HLR8zhfTz8C7kXzo0zA6OGvrTUp1wlwa
	v/5pu0fx23HiU2cb+NIYRPrEnzYaitH83LcorBGFWBjeUh7otVzqwbfBo1jUjAWseVV4etxqLsC
	w9oV7xql5I+/+uAYrzDgBAKX9E7PURVUk=
X-Google-Smtp-Source: AGHT+IFRYciZVmuwXxqgs2+z9bm/vSux/mZP8+GYdPklVFiskGwlhaojZKgF/mVDfvC0CzsE/D+StA==
X-Received: by 2002:a05:6a00:1d12:b0:7ff:c51d:7e0 with SMTP id d2e1a72fcca58-81b7d3584f2mr5778224b3a.3.1767875235211;
        Thu, 08 Jan 2026 04:27:15 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:27:14 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:25:57 +0800
Subject: [PATCH v3 06/11] dt-bindings: riscv: Add B ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-6-ed99eb4c3ad3@riscstar.com>
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

Add description of the single-letter B extennsion for Bit Manipulation.
B is mandatory for RVA23U64.

The B extension is ratified in the 20240411 version of the unprivileged
ISA specification. According to the ratified spec, the B standard
extension comprises instructions provided by the Zba, Zbb, and Zbs
extensions.

Add two-way dependency check to enforce that B implies Zba/Zbb/Zbs; and
when Zba/Zbb/Zbs (all of them) are specified, then B must be added too.

The reason why B/Zba/Zbb/Zbs must coexist at the same time is that
unlike other single-letter extensions, B was ratified (Apr/2024) much
later than its component extensions Zba/Zbb/Zbs (Jun/2021).

When "b" is specified, zba/zbb/zbs must also be present to ensure
backward compatibility with existing software and kernels that only
look for the explicit component strings.

When all three components zba/zbb/zbs are specified, "b" should also be
present. Making "b" mandatory when all three components are present.

Existing devicetrees with zba/zbb/zbs but without "b" will generate
warnings that can be fixed in follow-up patches.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: Update the commit message to explain the retionale why B and
     Zba/Zbb/Zbs should all exist in DT.
v2: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 5bab356addc848abf8240991ff525c619b9fc0dc..e026b366c8f5dbe7d6988d3ed374183c165de35a 100644
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
@@ -749,6 +756,30 @@ properties:
         then:
           contains:
             const: f
+      # B comprises Zba, Zbb, and Zbs
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
+      # Zba, Zbb, Zbs together require B
+      - if:
+          allOf:
+            - contains:
+                const: zba
+            - contains:
+                const: zbb
+            - contains:
+                const: zbs
+        then:
+          contains:
+            const: b
       # Zcb depends on Zca
       - if:
           contains:

-- 
2.43.0

