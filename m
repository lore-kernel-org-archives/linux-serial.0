Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220132BE7DC
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408827; cv=none; b=e/2rAXS42ElJmEfN0DaKwvDYkulPunRSgoMbF/dkPKGSWuXyMj+6L0Xa71d7J2ToAc9+3XM2F2gIxRSw5Czgc4mdevFaRlTvzn3ZGzvmfOHS7Ae9snOFX2Mi9xBny3o3iwVZ92tV6w881bAK9Ye5ZDHxUiGlXz8EqLNzvC6VoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408827; c=relaxed/simple;
	bh=NeEncG39DCyrTFRCfu6Y0tdsxFc/enlLbR5vGWFwB2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlcgM3d0Md0vbafzZ4Sta5rBEFbJpLFwrc1senSlBovl7bIJJHziPlpFlQm4S93VWRqxYQZKt9jo+E2/QlL3AU9pmTp42u4Dk4QjW5tVSv+Qh00JUNJGb9aATYTNkpUJ2bkdPV8Ut8WcVEt30QBT86woeKzZMedWaI4+VOte3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Jri1Fn48; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Jri1Fn48"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so4191566b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408825; x=1767013625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjWQje/nveRZYVRefE1HPRIex4imNRc+7jk18aMfa5I=;
        b=Jri1Fn48vqm3huPmFAl3NwDVrn01wjQwqOUL7Zdc+uKrne8esq9yVVtnSpmeqxtqyR
         lrSFNtkYFwU34rTLWucyMhXutuvA1YCOtasB4ygA/AdmDVk5iZsPE9Zr8hvk67EQ9GsC
         pDHkA/aN0WFA/npFikuOoboXt15xBN3yITj46qGjbSmF3oTUnLPEAs9Ig9NGG7OeP1xa
         TWJ7hN2sM8IX3bfrKb2nId+8QzUXpvuTJLjn5Iw6H8lhgHPPuHSewylI0Gc0qs7zM/Pk
         O1RUsFe4+bVHX8CK3eB4Bw8iUypT2H4oKQvdgrW2rp2ColcQjQw9YW2OLHRmrxvUIlP8
         fzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408825; x=1767013625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WjWQje/nveRZYVRefE1HPRIex4imNRc+7jk18aMfa5I=;
        b=ojeg9uNlfBQAEOLNeupqE4VCojn2e1yzdwgQQ8XYWM1VOYrKB09sGmcVL28X6tudKi
         VqGr4KCGYuaEjga/Ez9z6z6ECxXHMqduAdrxlJZmvWUcrQ5sEXVKOfsTqpuQQXNb5fqw
         h+K86Et30EPxDuq8KkRE3aC0bBRhWTxcJK3N/I2/+VJq86F9/PeEJxCTz0wOlvjOIh2u
         zRcsbhpg+6I3vAEr5tLI+K0TuOACLGStneyr9Ml722Nudkl86oC0a9TKeLujLU9Xgu20
         ARxjMyk91IOTbmDHuZubJdVGRw7d/lT+LXPeCOc/3uQ0AMlauvAm66wZ4pt+OuQgGvM3
         xMEA==
X-Forwarded-Encrypted: i=1; AJvYcCXYfpOzaEGlSQT60x8OIjP0SJd2zH2wBgMY0gsPYhlz0dZzQh7BskOhU3B4RUZix/nKeG7Hf21aWQ1gKxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGNnMx2ELTQPjgQ1jh9T2HIUTGljZZPBRn79HLd/5Z22QgrMb
	J9fiX1/l3CMM6/FzeFB1MUaS8ljjw5jtnl5nvZghmsgzjBOSruzFsM8TRlCpSJQHFOw=
X-Gm-Gg: AY/fxX6xWTtR/WQvmR5wEIDL7oDbjxhvcGVrZjoHKVI2rT9hrIoQRpMPG4irXKlKDON
	jEHYRj/Fa8a9WNQ38kmCEmnyGX9BelTife84i8HXeXhwdAh7oO99DPdJDaaLoi6Rb8+w4DnoA12
	dXHfpmL9fEe8MjZtIGzdSzxUcZ+8IndqGdzdSQknbgyH77RB/nLAK6/uQKh/aW1+t1VcTxQ7NPU
	wd+uXhbXkplKDRP05CoNQBr7qPTh4i/6eAiRbFHbkt5BXps8MO8ihySeB9y4w5/4t2AJBbyQ/TT
	tpVfMHqDpH0zWCHEGQ3c2QsgaYj22F5AF6ZoMsj9VBOHp9hOw6JsV8teFEsBbHMjf5TIVitHadI
	X3Xw2EfNPJ/Fhb0US5DVAvP8rELN1of3G3wVgeVW62dUFOf3j00PCYrQAuBNZYdgRpGGFOLt6OM
	VM9+8UspX/PvGZE9lZbAj9fVI6BZwPRQc=
X-Google-Smtp-Source: AGHT+IEj6B/u6xigsQCz/iBhHquF+WSZt9ninqdaMIjKJZ5tbUeL4Vlu+cYsAEqQxRTbHzVXks71pA==
X-Received: by 2002:a05:6a20:918c:b0:334:a681:389c with SMTP id adf61e73a8af0-376a81e2a6dmr9033482637.15.1766408825385;
        Mon, 22 Dec 2025 05:07:05 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:07:05 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:14 +0800
Subject: [PATCH v2 04/13] dt-bindings: interrupt-controller: add SpacemiT
 K3 IMSIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-4-3af3f3cd0f8a@riscstar.com>
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

Add compatible string for SpacemiT K3 IMSIC.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
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

