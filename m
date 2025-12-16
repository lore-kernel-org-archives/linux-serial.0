Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D573363C74
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892009; cv=none; b=nXG1LKrdzcU+wWihxBitFrXFRHBHLXSLE7qWdvsm15Wx7hffCLKzgoaVz39JcxnzDJJdd2mghKjZWsX3jMhiWasaE8hI7tduIEqxviOQYsJhJajzL374vYfpkrujE6v9/k/3tADJV4X4RRETZveqTSvYJXOumGbgfvPKhzpH0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892009; c=relaxed/simple;
	bh=bEvkKfpGvLRG5xChRyMfGRM8paMP5NXrDcBPWFsx3Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCuZWSCkc5J3SYNqwE1AZxfcd+C86rk8mthOYb9enxapwtMBHdFcCek0e6CFBeix2btSVYioFeZeTpdVqJ/HVBZb9ImK2ryfRNVFLeE2k8reRSG96UBj1irZMZWJL3BO3MzUoxefgVBqcrLuE0DmDl+wFoyGkIC0L1CWJqSZkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1r6wOLeB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1r6wOLeB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0bb2f093aso28316995ad.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892007; x=1766496807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rs9VW0IfWPzrbiE9L+0r4Qf5TkuQRPp65nyjMqVUyYo=;
        b=1r6wOLeBe5yysMuQcx/NlvRvIMB/dehGUb/amrciCFtdrxB6yHl8Cof+7bKm6X/7TM
         z1XZFh7/yBbE2jUk6TA2MMuFHS0XDpP7m3Xmf0fUOdcaLN/evWvQwzPaF6NowWGkSb+4
         SXsp8hzmt75iF95wf4IQtxIgrb7Oe+eJmzrnwgI45GvCNGaU0922RM84On87L7Eu3Z0K
         fwUItlrepnrXOl1mMAkKdCtcIVLBvebgvoQ1cy4BzxCqpFDBkaXbltB0jE3yju9Gn6Ie
         lCcJIDFGpPi/M7fAWeWgFk3/bUEWikMiIS5EORtmcaf5Ns161faYhQUDxNhhcq44MFyU
         LI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892007; x=1766496807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rs9VW0IfWPzrbiE9L+0r4Qf5TkuQRPp65nyjMqVUyYo=;
        b=jGuPlQ5nVR08LZ+3C0z8HyOo+O42AKjiYxKks8+BYkprqrHK7sCzBeeQVUHuurX1fi
         RSBRx1Yvn5c0q53wX2psbQVYsBXApiu9OtOFBW11/9ne0XiQMInoNL/yfjPjB+zJMIK+
         sU95TLX/kACHBmw9TlOpAM62/mStgu0EGZj7lGdF5BS/eLk8JtQu/mHhSR2CM42mvibx
         qmEZ7uU4oUTNt7bDMVs1y1wf/UeJFjp75fhCb8a098S/d0b4mRFY5ryBHjSgnnP9QzDc
         oVnsfa41llEPirOltNBjVDJB6HYg0zLxROASq2v8agRidUPN0/QjWAVSx1SHERFBXjox
         Kl4g==
X-Forwarded-Encrypted: i=1; AJvYcCXVwVH91zzSXJcsc1ScXonTqYtsaoBL1/ZAAZOosNkUU/1BzbQIB9yK/ZrvrJh6CbWklrU1NuaW3T+Jzz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQIaGyqEJENwu/XPL74o+NwooeQjs2FtQnSFFOIRfDSmxDqDL
	vFCQdKzv0vSoz9YJolJ5ZEU00bpuS8ZhvfZxchSHH//4eT39k2bRJUYIJdUvFDJxfTI=
X-Gm-Gg: AY/fxX7w0bZxy7I7N5H0ad/AcVPhY5jIRh15usisYBNmf0N4S2BwqhOrLeO7b9y+CBo
	CeNtGLxNKkdf3WAJoFD0+qCJUyxtwNRvIlZDu8zNV8nMpzSLNTz3PwElNDf8eFPtqFjNGDyFLDn
	uFmSIbbU3VhJjC45DnMfb9bs5ijssl80BZnn1q4jtudks/XMIq1lqr7L8InEIfFwxyxvFJN+V5p
	cb4J/+fxY/2fJ9gv8TByj0KmKGoorzZUxohRKLvVLAgRQZ5lUieXrMA4J8x8clnxQ4W7nWZV4/L
	7Zhhb2k7p5sYt2Ci7ebMvZxZwpJgZbVtQPgRVkpTsd4jqIQBkZLjv5n0rdzXSkDI0Gb7Q/9PdzD
	4wZLLiHM0DPLoW3ibFMLBo4ldF0WUFWwkmOqUSv87oM4qIOtjxXfh3impPfUu2MdZe3bFchJNgZ
	qtfpcIlhxHpbohWHnREeDLYiBwZXkAaDg=
X-Google-Smtp-Source: AGHT+IHYO6VckBIE/NKNbVNQkjVqL/H4F2phLWFUlelSLlWr6JEkHmBJoAON7Tz83USpUb8q2a1UVA==
X-Received: by 2002:a17:902:f686:b0:2a0:abba:a2f4 with SMTP id d9443c01a7336-2a0abbaa7aamr118026675ad.2.1765892007376;
        Tue, 16 Dec 2025 05:33:27 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:33:27 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:27 +0800
Subject: [PATCH 3/8] dt-bindings: interrupt-controller: add SpacemiT K3
 APLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-3-a0d256c9dc92@riscstar.com>
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

Add compatible string for SpacemiT K3 APLIC.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
index bef00521d5dacc002d24c50843ebe6380a7d5524..0718071444d29fbfa36283fc9666e8cecd6f77e7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -28,6 +28,7 @@ properties:
     items:
       - enum:
           - qemu,aplic
+          - spacemit,k3-aplic
       - const: riscv,aplic
 
   reg:

-- 
2.43.0

