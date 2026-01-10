Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53828275844
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022358; cv=none; b=ZtjcFJSh948LvBs7MR1gg5SJV4BfyJy7TRF098OpQ34ccSUaGgo5gZasxV5kD3uBMV02rl0rmPfXgQ9vBZ4iacqvqjN1Xoxu6lfk68t6owjdSQ5r7F2foK6nHzyQoxHhlctjZwnQXR0a5nUv58GxB0cdfUf4Uckwu8p/pojFDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022358; c=relaxed/simple;
	bh=/lTsWfEUag9M5I+SthtjmfrBk3zdILT7ZryxekX5KgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgxNiDqE5gmPRDfdcJpTq/XZaOPfkHdVOwLzE6TlR5K1eJTgh5PXz5xIsEC07uMTsdGgDF4wM7qdMn9oOrqV+wWBkER1INLisHe7ThfjH2ffB7OWPG7V3gwRICnaAW+nLEdjv0lQ/l22VdfDRYi+Oi4MqzbN4P4hw9mn+oiJsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=o0Pjyq04; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="o0Pjyq04"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f0f875bc5so41261715ad.3
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022356; x=1768627156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEt3VwPXqyMp/tcJZWmY7ZYQbqO9BpVvWujfwQFiGY8=;
        b=o0Pjyq045kT2LrT9bv2XZvPloPDpyQpv0YWkY6en8StgNdpnULlsn48oq2Fl/qOm7h
         W/RGYyjQDaAZ7/GngWyDm9RVR34ojlNsYKRCuSwY+Hfbrooo+BsRVEApBED9r4c5AcJq
         bcQnA6pf/Dw1VvlPqyaZIrmNBxraQKAr552vyp2R4/Du2GuqcuyToewsDKGf2wYT8kp4
         CmJ9rSFmmoi8Jwx/AC7iT41RyWF8NhCOLu/vqMOprC4HUtZlize/4PUmFgyZIdI+SqDE
         7c/M7bmoUcsdWOgqkvSZsgfqVoROfdr05x1C170KKoekJXqD3NVMsOxA6shnyWeezEec
         Zwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022356; x=1768627156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DEt3VwPXqyMp/tcJZWmY7ZYQbqO9BpVvWujfwQFiGY8=;
        b=mvAjvvLY2OLOKRIKk20+O3xsRNecz+1WaMrXPacpJrdUKXDtPr1PkBTErFjA4hArUI
         0BaMF+8fueD0S2Zc2Whqj25vpGfl4xuXL8XpvyRDZg/TpQjlN/mYjKwyIJnoIZFp8mm7
         TlOQvsEj1D4bEL02EnmjmYonVUX609+IiVIuk2CyevIhHDl41U5vrxUnG0kvQqza0yP3
         bOJ/1NktqkTme8gTVsG4BtZe+F6bmC68cq2fhAOiZkVD1fSGCb+ukwzhukOgJxDQdaIe
         Hr9a4CByyzBG2qUQiU0My5y2s2If8LQbJEwSXH24hf52hCktCP/MUZJIJRte709anqbz
         q37A==
X-Forwarded-Encrypted: i=1; AJvYcCUEirFaDqIhxZpNyMMZplxY4l1/ELk8GQjSwNkJsSjezp4VWn2Ow6zU49XYI0WEG8Jmvxv60nH2wp++aw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdU/auz+XheHCg2bomaBIX2k/0TLiBrJ/d1gRtDyan0w1DSet
	ry7e56S6TgQYSa4yTRCXtozTAB7hiQMWRdCoJq69rQ1K/vyXqPUQhF/WYU5K2rnxRYU=
X-Gm-Gg: AY/fxX6pfsolrLuNEZwxM5VCFwuDLmOfmShd9kuLhNO70j/5mKJ2nbaU+AdmZhdwlxO
	4Arjh/6+lwRWZAIIQCDl2SuGj9uTXK0n8YGBJZqcglSrw8Gq4geFFtbblEklFEgp1SY+en2ZCGD
	j6w/Cpe7vjGCRRBgI/HpRdrTIp6lxKsPtVWEEL7hQCTdpx6un5KJy0HLeKDimMXzsRL+8oQo72o
	+iZrCEqUEs/N2bKTlfctqeAqhDc3+f9T+bz9ZSi4wjD2Cljzo/GcCBHtuGte8/XCmhWwtdu9ofT
	HjayS+uJLFsQu3U8WbUVUm8g/KzHpNBNQtNeb5OlQ7WYCN7TMDleB4L9BgGrnyj8zgzwWhEz2rT
	teW9qCziSFFKL7E10QDYg2UqeXDe0RAOq1DdaU3FLXAEXXubJ5VF2ys9nFwxFsGmoYjctHw92MN
	JncO82E10SOlQtrm0PxmU7wGtwMQ3XoiWFRZnXikwawEDWptjdTAjopQ==
X-Google-Smtp-Source: AGHT+IFAUkJBe5NUVBgMgG0885O2cnfFnOaJYFiVEjS7bJDb2MRQEGYB6WLZDNiAx0QS3ppLLiX9Hg==
X-Received: by 2002:a17:902:e943:b0:2a1:243:94a5 with SMTP id d9443c01a7336-2a3ee4fec29mr116348805ad.47.1768022356567;
        Fri, 09 Jan 2026 21:19:16 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:19:16 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:14 +0800
Subject: [PATCH v4 02/11] dt-bindings: timer: add SpacemiT K3 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-2-d492f3a30ffa@riscstar.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Add compatible string for SpacemiT K3 CLINT.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: Add Conor's Acked-by.
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 0d3b8dc362ba..3bab40500df9 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -33,6 +33,7 @@ properties:
               - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540
               - spacemit,k1-clint       # SpacemiT K1
+              - spacemit,k3-clint       # SpacemiT K3
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.43.0

