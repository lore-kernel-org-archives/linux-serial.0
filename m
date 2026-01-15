Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FE2288D5
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459946; cv=none; b=YL7YcgFfAOiOX0aNRSdF1t9kD0kiHSCWRhESPw5FTMQcZ6KM60L3LDSyX/IYzOMBF/a5v37pVkxKWEZAGaaBuQJaqmxUN+YzYsNwnORaLXPJKZMFbPcrDvcs13cwpPMjrz6lFYwqyBTv9oIbrf5qS8NjmaYOnIcrwrQTOudzoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459946; c=relaxed/simple;
	bh=PbW1Vj0QGf/yy5Fg9JXBDXLV0q15HSZaWzIB4j92DR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8PfONmCa1XzZsRMTaMxNUjO1vRWJMN/l0HI8JmEOxv81Eig8q2F7vG3y8JLkehk6CdCbqlcg1Um2Wm3ZqWleNdiD3Un8siDstTDRd+xOGAuDPKbK0y/l2DOv5W+hjqkiN6sfC0nUzHHg6EpVBEtDbkAKyitfWBBW0pc2UKwj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Nh5J7tYJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Nh5J7tYJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so4948485ad.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459941; x=1769064741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYYXZRYIOku7Vb4B3mqsPICr98BDRNcpwBcyivdVSks=;
        b=Nh5J7tYJuaO4DpnZG+YULAx87/d4247jIY5QKiIAt+mlxd31jZ5w0TrcbSqSDbviRx
         dE506z6R45B07KeAaEBYcHc/3xn/ljXtZJVpWoSOE6v2t/nya2680LLkMnB20VGgBeMS
         biz6dQSZzbqFVQ3HqjrUzSoDnNE3o91zf5WeZtNkFigt2LbpM1XLVgZvtb6RioOvyhAL
         YkJS1sPE22BP8Zdy52q5GOE4UJJw5pUmj2Ka3T7GFUD2K2osL9Yq3lOakJpA7/Eb7m7W
         eCYZFo//wIO7aoWRAyERhkzBIuEaLrAEIaiM1+zlhwmtNA5VnWVoFCty9camQSZFvt3V
         3PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459941; x=1769064741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYYXZRYIOku7Vb4B3mqsPICr98BDRNcpwBcyivdVSks=;
        b=Fnxw2nBCt3RzanIi13VUUJZxmUhBwcO0qy2pBJSMGJa8kxwFq4QF8u2aNWO9UKwU8g
         yLzBwF5vI5GpEebUmxzKvzb5yaEZve36MntD+4uGC7Ds4GFxK7nliT4IsKSp+U5z9nTR
         8pTaC/02FWrkJZ2AsNeMN1mBTQx9DDl6p3XPfdVkgMxXyE6witB18XisQL5nkFK0RslE
         8fq6NxTcK8dUOtZfXWsKuMaEIuzfJnH+gyyMsgW42AccMwazrsKiVATFBk/sJstIiA6F
         5aiLGaDlmBddJWw7tffubB9UZR7H6OuBcrSWdSOG7afqRUw7M1Am2F/bukpKJh5Zpqsp
         unwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/v5/+ZoVNRORk3l+5k2k/SnG5YglvMW5GTXSwqCxkzEVCWOJ1PSEy1q/pLxiheNyapRZMcBPjujHR18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBILwO+0AmLTmu15FKjunrvN9RvGq6hqR/gIVmcUmxv3nHJih
	VnSX5Gqw+37f/ugbr0inRbbvtsy0S2l7Z1HqrHMskgXJy2ZcDymczcndhC25dIUJcEU=
X-Gm-Gg: AY/fxX6WAyZKwJDv4U+Fb/PKePvmifi45fEQbKoI2Zu4504ORouvd/6+ahWKrMfR3Qd
	uKkizpZv9MV88ChoP8oemcEiZvUyXMONR9GTk5suTc0uSuW1OHdQHxVt/ucZZ/vgof9b27kNTbd
	gp39u/dnKT9nej+G9xm5KKPVMzIM/x6W/o3qKF1u5JnUJ//baoCBakE4BB89KxTZT1U1fcJIQ0F
	vDLBWgE6SmsbTiLrRmSY11thIY3JwuefnbVn758mFpsvSWOAh1F+onv/j/3SfUFbY4dylwUDE8E
	WrE90a9O2LAyW8mcQRH6D5X3IQCFn4aqJaseCfI1PASYHjvkEyiZW4HqhOnPdZcOKd64O7p1Ler
	8qt0SNHXZYcX2+LVmBc//xz2943BdtJ4G4RinvOnVXys8PlKXqMXAOgwlB3ESMZEP69b0pPdmHj
	xDv8XQe2EfusUqEIFRbAneGZRqdbzPVc9+mHK7Ff5Lacz7apTNcX3SoQ==
X-Received: by 2002:a17:902:e551:b0:29f:29ae:8733 with SMTP id d9443c01a7336-2a59bc6819fmr46124625ad.53.1768459941521;
        Wed, 14 Jan 2026 22:52:21 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:21 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:41 +0800
Subject: [PATCH v5 2/7] dt-bindings: timer: add SpacemiT K3 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-2-6990ac9f4308@riscstar.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Add compatible string for SpacemiT K3 CLINT.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change.
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

