Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F643BB83C
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891998; cv=none; b=SYpw04A4u6hgh8R+XeLMfv1FGtHrMzKu/2Bf8ADTNLiS5+JCJzQEKG/MK4kIvDx/hf6BIWTTGZZjKvluAgHWKNTRYAR7D3qu0gOT6uUblI8P+KM5kx11beeFjVCvgmgdiXLtHRLOP4XbULDuOYBPBtovkNlfMHEbKepzwUvNxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891998; c=relaxed/simple;
	bh=EoM0juMOXjr6GR2unrjDT+d+btXpji6LDeK28LHuz0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKAE2CjqLhQo9PNWEVEwueQkUTd3pRqc0Q+gkBPeQmAtu8dA5zFyR3FV9tupnspnxHn0Pjs5cmBpztkLXIbJOx1G6o7iZ4x61xfSBQ55ozfT67dXsgn/865TSQORlBSXM19Os1PcEbB0N8EB01uKiJqM7RYscKENbDWz33Kdci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kRuqErbj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kRuqErbj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f1bc40b35so66570475ad.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765891996; x=1766496796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgtnPUK83eGnHHD4+3Z/OSGEDGJ36/32wtdJor/AdJU=;
        b=kRuqErbjUq1rzVSv7GtPcYMkrYen8WqrcsNGrK4H50LOwLyc0+/0jcmdQKqmYmTgxp
         KsxQ48tWaEhrbpPbDn1hmzD/AQ8vonB0+Jtvuktm48zRKx7xs/JGVcth7O+WB2l302Uh
         cUupfiQtEO0uwddcxTn01tQDv2OW6eVNLnTK12jmaI1w+swgnRQCRfs4F+LjhR2xcnGS
         WH7hCUzWekHR7J7ss0WAO3cSCBw8oB5/DIJPk+2BW0GLHr46kBEKqNjjE8Mi7tGJibF0
         WqV7DgBY+uAn3JyjuoiJQ6ug0OMkCKNMV3Kipgw0Ft4eecv+YUVuBERLca9FGvqHNhCy
         0Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891996; x=1766496796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YgtnPUK83eGnHHD4+3Z/OSGEDGJ36/32wtdJor/AdJU=;
        b=pxzurTIsLLvGe2VV46VOLDBCBbXbTJmIC9/rr/kfhZqGBqPK9YpPBPB8WnXarTscXx
         4IxF4sA5//iKeCrFR6pVJnOkFiA33TrK+aDGHE24NMgTnNQnZIlPVrI2CvJUWjL0VH9j
         h13c0d1Jx7U8KxgQ5e9YVUAgLKxZmyXFRSA0+qBEmzlZktLcib0BaECbpYX+PKFOHo5H
         CpnJYLRZleQT1pn0z4L+QRzjiGxrnHRO+izKBe6H+I6nJevTcVWM97oILSLGhkRpswfP
         NSToKCf7hqEVFWIwpK4t8Xt16IP3afUSHxg/NPVzA1dFfEyuT4fHBAuzJywlV5EpcJRW
         nAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc4bQLl2UqvAmBU+srl/y6ngO3uTUmA2byT/3TFeA/FPTEkZ9JiklMjJl9oMF/9nPGAwMmYWAL6VP0fk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDF8DhoQIM/iRj3FeavMpSInAbrzGsk1aBUEcZcPEa9CTzU6RE
	aCmX99/XVL95y3+1LfWZ01iAGrDr3pBVNo1R7ZQCmFc4Vn8zg0DUiuX00Yvi0E43bqE=
X-Gm-Gg: AY/fxX5Gqu9qKQeVSV9qrqDtNERi2khfRCGn4+0O3TEilkldbcrSPcxADAljZRS/2tY
	4EwJ58iPoHzmzQjr3gEFdxwTqsNMzs+7CKw5iYjQQ1yDvgpjEU7ih1m/kB/EQhcxq63txx+/VCw
	jVViNjGfw+4cck3vJAL+hhaFHe48/yKqImQ/8w2/AjyOmtCtzkaxICE6ZXD55EV1WNorh5Hyg3J
	BFMGFtz7hVVD/0XxTik7K92XDbNx3fKv2+ywP+j24w81bz0UnRhd5JWffYi4eF/sA22BRft3CjA
	m0N45GJpVmQ2d9+RWZ5tntvihk9Illz3UUY6LYDX6o1ibWHSKETGOl5IDdCP3p27b9YLx2hfC9/
	dLoh3W7Me3KQvTcyCrzKiknq8wCMZN4dGdhMAD66gAs9hlUrcuFAdHeWepAip31ot230k2AyEZl
	QEqvb2NzC3sYuctzUylNLkSIxRiO7CLvA=
X-Google-Smtp-Source: AGHT+IGY3Bl6L/q/ucq2o7krHMUCV6pUZcjqotL6XoN1XRPjp4aSVY3JMf/8mH7J80vFyBB1R/u+VA==
X-Received: by 2002:a17:902:cf0b:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a0c5a6cccbmr98731775ad.21.1765891996120;
        Tue, 16 Dec 2025 05:33:16 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:33:15 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:26 +0800
Subject: [PATCH 2/8] dt-bindings: timer: add SpacemiT K3 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-2-a0d256c9dc92@riscstar.com>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
In-Reply-To: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add compatible string for SpacemiT K3 CLINT.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 0d3b8dc362ba7e8d0ca6d0cea692ceddc5e1f89e..3bab40500df9bc2ba4f7d6f1bf340c8cbc06f9de 100644
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

