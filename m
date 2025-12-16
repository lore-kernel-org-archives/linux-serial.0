Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35D34E264
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892048; cv=none; b=hgiXWn1t2H221QKpFRDcF6ndfQQYw2SCF0oCUc9mZrvAR6KwscVs9PUejrNezcPMS8Yt3/7/dy+l7dpCD9AUby9L3NHX2+ROU6owwbp8rkNQtv349fd22adSzIMBcCHOnJJugHkRoDg3yJIT9614W0IcMpmXgOO8FCV0KOQ0qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892048; c=relaxed/simple;
	bh=WXHiNOHxNEkVgGMjQZWeXB9DxbyMRjTpNm9zjjrOvhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clzl57cocgvBzbtNwvDxg+S/+Cefy3G7rxvBySRwIKLUe8pJvoZ/bt+EcORbOez3RTrJSX9555wbcsw9SkU1vMeQbTEaRA7lvDk/PN12UGvmDJqHZrbJE2xOHfn1Ky6Ln0ZKk1Y8S8ISc9cez68D9ueRgPYGkIv8QAA5WkECRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JCq18g9t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JCq18g9t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0c09bb78cso17125085ad.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892045; x=1766496845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7y/C6MB7UDZ9brxunSfG6djbfKn9Ck4w/Hk2KhvHZ4=;
        b=JCq18g9tSCJ0DMYvZmxKjm7oAF1MiPtjNhD1SYtADyVA8hOsA81MZklGVC7jLF/9Gx
         fUeuNudbmVMExEra6AY8ym3rYRhKKLA7vCnyYEOwpbpFyVVXN7UiksguGQkyIR/EGTRH
         OtYy9V2tO37UFSj5PlDljzRXOkKjdwJ3EeXXDxR5dTLb9He9SAL2l59H0hyX5WQq5qx5
         Qp9ldV/eVDvySJh1mzy9Hqkn1blk3/9oatPsMX/2hNShI5d3ukI0tIAURWCCv9yvLVzq
         K7cp6tDsUbvwTeha3cg/FMxE7Zvf+K7iLgwc25q3N/MnHOiWWdeCj/4rjLIxBGRBMyk3
         5+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892045; x=1766496845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7y/C6MB7UDZ9brxunSfG6djbfKn9Ck4w/Hk2KhvHZ4=;
        b=hcRVj7iikCRI1H6tIamfQuUtVj/LLo5QvEwkg3IUrg6m/rMqX6kETLXiJ3/e/HQDoy
         eezumVwRPtmQruyw9uLH5uRcY3XdWXe1X90+7VGyJn6llXmG0unuasMZ2uUUr0l3YbCt
         Jo4O3/0vMcnq7/r4DwQPl+rELW40cAfRd1HLDMLX1snNX7nliwCSzg2GnclQODRCuCvR
         5CuYXiph3Bm4Q/+Kh+K7Hk58lnW9x4//eW/WD3ZsclXBfUZ+xEBBwojRNlxGpWqMSXoR
         yDYY9BDhuOBlPHDSHFOoGhQix9x5PUQasUjny+r8XOqtz0AiHW0/ndeLaqULQ7f03fBs
         dUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrGxk7HmpLRURhJsX8rEX6YPyltDDWOufnFxv9Giu+OROfLPzd1tl4EZPsRfbdRb4oUIqo4ifw51ngBYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLFC5ERCUUngoHSkyzJzVYxfv8iAOpMNe8QTSrKDJE7d/yo1y
	H8KKTz6WWLWUe510ENoDgg3bt9htjBiYZunsNTOQ0iy9G4ZIgEX0s30G+WKx1gr5VEE=
X-Gm-Gg: AY/fxX71TVNODrABIszOdHztTwb5IEuKFFC3t0QSe3qdpcO4vKFSl7SWEJ26wFAWGC9
	t8haQGwkD3d/vuXXHbpI4+IBxkl6/LSIZmea6iIuPw9j8jLntg7gLmdC/+6dKoeH46Pf8rP7T/X
	NgOvo7sj9La7ikQJTUqzO/nQGLCjsL+apkuZZMXRRA+WC3mSHs+6Ya+ebIzejbnYWwTzmVvFubA
	iQSSP2MVCQzjIdIpYcMU2yXB4+iZHWWf93TPZnQiorDTiOp0+pbArz+q5R6JHg2I5P2L33NhKKQ
	2PInwSBilgl0f0ZW2ABLxWJ2wAw1lQol07XZ6mUsNwKGEmzszlUNiv6h+ybnUWLlbLBCicCQeni
	tp2TiYUMp9Ek620xZ1wspg42RAHP1YF/bOXu3fnjFCAiwr66nipkqm6s2xiqSI2uRLnTpuizbDc
	HtGZFXeMVrAT9bbdq8kv+Mo8J4mqdfWho=
X-Google-Smtp-Source: AGHT+IGlJuIYFFX4Kf4ETwvpERoBwiGUxzh2gcBhl1n1hPyzmW7Qi4XuHbuLS3V/KKQPD4rNe3NC7g==
X-Received: by 2002:a17:903:1a0e:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2a0c92ea624mr100750335ad.7.1765892044589;
        Tue, 16 Dec 2025 05:34:04 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:34:00 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:30 +0800
Subject: [PATCH 6/8] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-6-a0d256c9dc92@riscstar.com>
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

Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
which is a 2.5-inch single-board computer.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 9c49482002f768cd0cc59be6db02659a43fa31ce..003b0bc1539b621e39172a0565dfea1274cbc8b8 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -8,7 +8,8 @@ title: SpacemiT SoC-based boards
 
 maintainers:
   - Yangyu Chen <cyy@cyyself.name>
-  - Yixun Lan <dlan@gentoo.org>
+  - Yixun Lan   <dlan@gentoo.org>
+  - Guodong Xu  <guodong@riscstar.com>
 
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

