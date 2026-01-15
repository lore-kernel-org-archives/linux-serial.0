Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960130E0C0
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459969; cv=none; b=Xb5yM1E72Sm+7UlUcIyH5jq/FrfYWhpIVhNBxqQZvJbEdGnvM1KI1A26G+5mLeoZNVrQhf7I1ogq9si7G3Uak4p/pDk9e7XYdCfHynqeAlhDTMGT+7gb4InAN08208QoYVGwjr31Cm5dcLwGazaWES+58Ka079422GSFOpT2M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459969; c=relaxed/simple;
	bh=7GsKL/0cK9MpJKy0wiy9gpBRnMF//wYNkY0xTML1hsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbDfoEgvFlPhjUxsMLtvB21i9gFiRCYfJtai3ox+r2LjdEvzPcbScopAWXG79ySG1SW8U9XTfjANizKSN2TRCUj0jzgLEIOt1FVlUysSgu/Qms3fA5aHs/kOdoXGzsssc2SDWNyoMWGpEp7iNWsOfqQKQAs2wF/pR6SU6yjtO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mnaiWYFR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mnaiWYFR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0833b5aeeso5924795ad.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459963; x=1769064763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBO7qrwPmz8yCkOE9w4XOKMChGOOJNh4q0wHZ0CHZEQ=;
        b=mnaiWYFR5AWzZiaV7YcEpIiPtKAhnIq06lIfd3s3RQBUXoxZH2pq65ZOIMp/WSuOfD
         BPydhPBK2Lj3+sM2cOdnLLX3mZcgIMrmX+UuL8SZQDY9yGP74N2e7KPgDnN6QD+hNWQg
         Y+8WOTbsCfp51bGR1NhFEJ4fGMP258Jd4lq5k6nw9xTxlaf2LzCLq47Md3UfGKvB7kVm
         NS3fVAnpOfjHw7MJ36sAZTwTWgv7yIZPiTJ/UfPjB7CEatNKCiz+oiltpWBxhuw1o4qq
         B/R7TP0ZMfafuYgxCXOIgT2S9bm971DO3RLBxGPH5Ss7LxjyeA61PEqgj26TK9R1pXVm
         6cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459963; x=1769064763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nBO7qrwPmz8yCkOE9w4XOKMChGOOJNh4q0wHZ0CHZEQ=;
        b=eyVQkJYLyw5jayXX2mK3ybBfdlnkcRWiusZZ10TGt9FqptvsW8/ruurnD6m99Tr1Tj
         k5k6oBcgzTxspp56I8tY5qsk2pwHfLcSzDZKZe/kOhlTBmugHNqZ3NStpKSgNGZ/iSok
         pIMNhkjF1Dsjw9hICf4hv8LGvFB/wNszwVCS3Q9BR7h65BTJKO14TP+y/cAZkiBMY2Mn
         tdfElO6jSdHTZGMmtlYDiFVf1JoTgOCjzK4uTkw7pXGQW8fsTl/yO5NP4BzDaBjUM/vM
         ge1s8h8v19DXq4GAG21GXqz7LdzTBrBeJ0p0wV7cXyu2mS41u+cTUa3gbKYIUIXQfeRu
         K9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVfNpEhA9Ot4S9hpw/mTBU5Yg6vXk8hAw2N4VKA89XjOcfk1c/SwN8cH0Bt1mWV2rXuShRRStl/McGi4r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuczivFCyi8x/2//Gzhez4mdL6D6dMjmIEf1ntEcvd/qsKnmEO
	yK7hqgXhhW1Irhva9DMM6mOIGqHeplvuVTA2BC6jizxkHxJPcMdPuta73kmP5qWKiCQ=
X-Gm-Gg: AY/fxX72zI5G5uL1SQ1PUTsBtrFTTa/9hl/pMhwapi/kveR8UAr9LCB2/VUFhwo9xOV
	ECc7fSqSAmZkNaCXncbEMpLiBgi6dwNRaZ2ikyWuvX2foDD0/5efrJBbchDXS7EHZlq2lCzz/jC
	oraSzJmdmxUvT10NR4/Nrd7Cnxc46PrfzkxpTWRIIXPt7eVHGqsFRJOY/2VYK3JySGP6AGWXgMp
	kHnDY1k/viTtOncM+REtIQFsrcgn5k7VH+COM96oqd+6Uh9ZNrENOtdlgPdgYInz8Tf1KfMiut5
	WUKBfixv2OdyCrDgSs1KkWsTc/tW8HeKOF2P4fVhBqVNDz+tU5wmPPmasOCdYHXamQMO/w+dcZg
	YonOiS2xIGIEvrm1OqcmKIffR7i+FX2OQnrQVIGruoJ0sagj9JXDPJlNG8ShvxUcJ/WT7iccTqZ
	zq7zNYbUByxYhwVOgTIE0ggiqne2MPcbuv4QJiZMM5lGn0G91Sv5QduY/uO9GCMwc3
X-Received: by 2002:a17:902:cf04:b0:2a0:dd66:d813 with SMTP id d9443c01a7336-2a599e5f8bamr55517385ad.55.1768459963033;
        Wed, 14 Jan 2026 22:52:43 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:42 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:43 +0800
Subject: [PATCH v5 4/7] dt-bindings: interrupt-controller: add SpacemiT K3
 IMSIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-4-6990ac9f4308@riscstar.com>
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
In-Reply-To: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

Add compatible string for SpacemiT K3 IMSIC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change.
v4: No change.
v3: Add Acked-by from Krzysztof.
v2: Fix the order to keep things alphabetically.
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
index c23b5c09fdb9..feec122bddde 100644
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

