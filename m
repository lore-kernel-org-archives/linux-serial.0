Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6F369217
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892021; cv=none; b=g/cOJZBrcNT2eabyDgeWEX8kKlTxYMQ25BWVB9YSiLxZKa28iiaG7oF6LvVIiORb2cokG8+bjUaufVsic8bjsMbbzUIhcjiTu24mjnrlPdq566fW//dFPscadppPyLlH7jgCxkhP7dECO/7rTqqimRN7RjbUHieLU5ikroRpGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892021; c=relaxed/simple;
	bh=SWtgk3actb41mMKlJF1tMZCCUTgeUvVgO8N077NFFiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSVWubdSFIem8sWyQAqyAOXOAgCaVVNLIF2JJNBCWIiPYnq3PDLfvdw7Zavyolq2fd6HB9rGY5T727lxbuGpkyLRtayH4iYSI3h/VsSik35oe77pvlifxNiyDYnx4TKhUitlopPhwdqMmbJRjWX9NAmklm8YmVe4eVxmWvC+7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XeVt/2aB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XeVt/2aB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso1773902a12.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892018; x=1766496818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUW1fhKJDbOe4HKSh/QeNnUAlu3BR5pVkgdl5b0ZaBI=;
        b=XeVt/2aBDZG/WZmTHGoX/LG6pjN+Lhxgd8xIM/D72yUsw8AMf7DB63zDzrFObu51zr
         ViOwMOoUQM80bjadjDMZ8+5uU4GKBQt73R3C6eYtmVfJjEkIMf4jJFmbR6JadFM8ZCn1
         z3JX7QI1u9YoFist3dGeNbV+JDWOX+BOPyWYkh+diftPTP1lzOGfXC2XHrMXMMGwV9Sn
         NmMbSirW+Q599hTHuiNR9l2PTk8x4x4eQJcBf4fgo67NtgqKBp/PvBX+awPaeTQXUfN9
         O3KcFYNnL09iNdF4u0eVKTCY1zhcMjZo/J+ZGaQpwtSCw8qDT1vHduyVlJqRLmkkbmSR
         Qupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892018; x=1766496818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUW1fhKJDbOe4HKSh/QeNnUAlu3BR5pVkgdl5b0ZaBI=;
        b=TNXu1a5E1f1/AyBvqS37X7W1DUR0mQ58Uj5l9yCyHD584+ykPNGYUSJqd/NVixVYZU
         zc8w1w+/BdYlCB33uVheWjXlNLQM2FFGVFKg/IA7jcD5U2estXHNE+zkQ4mT3KL2EKPN
         EoSOqJWhcujoN5VGHGD50RzPdb0apgpEFgaV/rPSZa02r2navRSX+8RM1zayXwvXLf8F
         jbQ8YFafbednNbmCogHQJb1BHVu34204qWYtJdpxz8itY37foJkRltaAAZQDlqnHJLqF
         O9YgGdjhShjTXIOdkT4Kd4ahdhgOu7Pd0yC9j7AoEk1sB5hMn7czxKR4+HFnf5cpt7Pr
         R+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUjws7JUQlEseEVa0ccGct9RkjjPkxwRCfxHMwYbkGohJ7kr+drO8oXs3W+2VMZrTlFmZEm7WtQWRucCHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7d32ke7fMhiWShy7/hLtNX/+sfn+uxJ4tA081zIHlSH85n4lm
	5fWZRR6Gdn6B91tP7+ZbcUpD/iqw2gl5RFQqzbx8jpRcFKzUTpV3lt9W+gWpSXoJwdg=
X-Gm-Gg: AY/fxX6/wzLbxAuWZb6qI0RntH4qoskD9etyvOjF5LV+cJatq/0/9awzk+/Kh812d4r
	+mG3khZo2LSBsxbcGsvJ7WSvD6UKB4pCopLJZckzICs0VVZhvARZMlcL05kePphQcEDmtF1HM/E
	9jSsauw+kn6fT2G5682StO0abGpHKGYEmKgDhYoIutqI0s2L8hv45P0hUbeKsWABLmauCHVvUqQ
	pNTpQA+aFdRJC4WjV4y9losqYwtFD/P60mFdu81CLAbbY97sjfpuLziAaOoKB08eRnaS0X7ym/T
	Eu14h2VzrStuld/CalZgTta/wQNKD9u1l9kpZS08qrpcTg56irKgDUhz06lQDVmCmOueO1SPU3R
	GLbGdjmtueC5PIFCORR9x4Sz5yLcS1Q7hV/vFgSahXKKhUVvmjUwvTmNbIK8mxk7+P4RpSijuAE
	ePqiTribyFlGenhZPlTH6VScTI9cwOINo=
X-Google-Smtp-Source: AGHT+IET9GhiW4RGL3w1Cy73SGb3pcHepT5GGV/njIgZC7quLxJZByYdERwcXy6lYO6BkLM3PBzhsQ==
X-Received: by 2002:a17:902:e84c:b0:2a0:971b:151 with SMTP id d9443c01a7336-2a0971b059bmr130452205ad.2.1765892017756;
        Tue, 16 Dec 2025 05:33:37 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:33:37 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:28 +0800
Subject: [PATCH 4/8] dt-bindings: interrupt-controller: add SpacemiT K3
 IMSIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-4-a0d256c9dc92@riscstar.com>
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

Add compatible string for SpacemiT K3 IMSIC.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
index c23b5c09fdb90baccece03708f4a381084b22049..152eff7335dd8457bf01d02497b7080f2a02ab65 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -47,6 +47,7 @@ properties:
   compatible:
     items:
       - enum:
+          - spacemit,k3-imsics
           - qemu,imsics
       - const: riscv,imsics
 

-- 
2.43.0

