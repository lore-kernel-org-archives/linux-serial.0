Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535983D3315
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875217; cv=none; b=DpmjHcQe4BQn/7dFGpm9X3d7jmQHb/hvHo/SIub2ept6PnhQQl6vPOEOAxOb+lTc4Z3a7av4pI4Q2lqQT1CQKUBrMcH1LDuCg7xOpwO5bCYYLAhUiWecsLGWbJ27IdaPc+kcixeKR0Til9krIYLKEdlwyYnp6aoQJ6uQCm3BSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875217; c=relaxed/simple;
	bh=K37CDQVk1qKhIlEnznd2RkcI254RHjk8sgFKmzbozCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbJ9v4+DsJoUMW+We3DrRL2qqjbwxNjesL4nCxVwC60OoEgfGbCcyfLwNuYXIB2cGYSFmm1XmC+wfIRDu4Mx3A9U9q71I1Ig6DcnqQ4r/VSUXKu5egHFQ83/cvqdUqcGO2fTl3ssZWZIttcyCcp1/dL2Dpz0mffCMNla9Rg9Y+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tJ1Y8BMW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tJ1Y8BMW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2307058b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875212; x=1768480012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Uu81D54FMEFR1KBiicj40Orv/JnpYImdvG8u4ALBqk=;
        b=tJ1Y8BMWmTeZXSIQHNRsiO86Df87gXV3W3fIBUjSMbjxxIR3v5MGJBcKVFXe5Y21Ev
         qyxHoOyJY+lDx8J2xUgT2q8bm8fJa0AiSuNBGvccLcKhA56976tHDCisWEDm0a+VKl42
         m3y7yH14eS98BWV+aRXN+n7jeb0szkNfFzqnHe70LFPGNTRVo07SV9UXYRk2lNxqFBAd
         eKC6KIqBMq6stpZpoysMWTWwuJKL+k3Vb/8Cnw4+SxxiDLGK4jKPUcgU826a9XO1lV09
         Ufwv0ZymAKT7zwfHKOrxHFtsu+hCJ14YsycxSyJAQ6GSRgI056xT1WPEXTgFHkTza53X
         9ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875212; x=1768480012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Uu81D54FMEFR1KBiicj40Orv/JnpYImdvG8u4ALBqk=;
        b=MlI0DucewktWsGoEqDOgKAK6WQCDKh2YRAOFuhOU5pA2trdRTAKUy7q3O+pPCiqDDz
         8Pn4uzz2GOIofmjo+WL+blrBjZALUyaJs6DJ3VFEFecapLw7QYEjPeizEI+9Lo1e81K6
         2/qwrtYzpw5G86n9LnVAbXqYaMGuH9CiH5PHCWoi2TVIU6BsONuE48QrmW65yJ3B/uTm
         kCmjtdOuy6tfCiT2DLZuOV9BoX01IFfrYJGU/DZYJp8NdLOxcydEX0KAOEfBhohwLsEo
         0TX+FbVkmY7rQPb9JXE2zztha33hYzy+Tv3YDCwdjEp0fW4IdJPRM/qUQhiOrXl/TEy2
         jG8g==
X-Forwarded-Encrypted: i=1; AJvYcCXvq/e/rRLBeKFYaGeAT0k670j/PD6Ik6LgL6xGOUxXsBElncZlSTtg5Y4KHT3KTXynwBhCA3ny1fBYLN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAO2P5NDuYjc8Lg4NK5HVP1XmSY87O0nK3+uYnuHk9uBe5d6MW
	Le03iZRjZ/VoaNYKpydDzvDUMoj+ICCH5oQsHgcPvWUOFjQ+6zFgbp5AyBWzcMtMb1E=
X-Gm-Gg: AY/fxX4cDyDbg3utAkO01LXbm8RrMmdjezdwULPCP/lo1xtiKA0CZqcHrs8x0Dk29RI
	NWsadDx97llA5FpJlNtDWGi7QgHm1OJl4JD0H59t7JVj5bHATyej7woiYWP5gHubQNSQ/uf1lkZ
	qC7l6HKLrQ/jK96pGFAKP3x8zRyXh1qM2EpyrGdblAd0GKn1A5DdjI1l2MOGFdfBQRyuK+xFOCM
	fwDKE4sbUcYG3TZm4BzvvwZT7+PIYxVNLirR7xx8Zi5CIPEUtGBytBRuc1hlHQO0Uc8UWsrwgRD
	T6PvfOERI0CHbln5RWOQO//umvHTAu+ChKIDXQCu76VQ/I6upibya5L1Fu5TZdFHJAcBCuD7VHL
	CD6nIfXyI3YV5qmt362BNjdqVxXdnVIVG2hPhWSENbOl1nzymHHydeDGP0ILForBJPf3I2YQmL/
	ngwXUMeZu5wPSfUg9UpJetlZUKbhAdJC4=
X-Google-Smtp-Source: AGHT+IGjXfsog98K9N9BmFt/146sG4w5oYOSz5QSQHD2sWVG91brHPM0hOS0kYWXqTMiNVr9IiT+oA==
X-Received: by 2002:a05:6a00:3003:b0:7e8:450c:61c3 with SMTP id d2e1a72fcca58-81b80ac5a0cmr5573634b3a.51.1767875212553;
        Thu, 08 Jan 2026 04:26:52 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:26:52 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:25:55 +0800
Subject: [PATCH v3 04/11] dt-bindings: interrupt-controller: add SpacemiT
 K3 IMSIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-4-ed99eb4c3ad3@riscstar.com>
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
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add compatible string for SpacemiT K3 IMSIC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: Add Acked-by from Krzysztof.
v2: Fix the order to keep things alphabetically.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
index c23b5c09fdb90baccece03708f4a381084b22049..feec122bddde1f82cbd29b8f3597d6af1a16cb23 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -48,6 +48,7 @@ properties:
     items:
       - enum:
           - qemu,imsics
+          - spacemit,k3-imsics
       - const: riscv,imsics
 
   reg:

-- 
2.43.0

