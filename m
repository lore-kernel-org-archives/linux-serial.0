Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1D30BB86
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459938; cv=none; b=r7T2nYGsNBhWJS3HAZXh+U4I1C6MhY12leCQe6azKapyMHNekKv+CdenTf/dIHMzJLbNlMywoG4cpSZdwKZweqQbTqLneTgHqSeKaOQqimdMk/+YvHbyQp14wlAvQfDk6Xazkm2CwIFFIPe1ESUmssLZY2hXQRZP19fFWt2GIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459938; c=relaxed/simple;
	bh=ndCk7OisaRpWQIEmEK6Y89WQLECntbmXGUxlUurEFAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsXhqrdchGqu1aoudV789TizdMkR8gURbNhoO+Rzy+zzgQPrPmpWBKkhwQYDWBHR/1dy0fE60G3sCekjiKQxIH7vxJxlaNyAurVP94aC6wQXdnZ1WMQpHrPSS0dSKFaCoC0zCAj+FqOPBt4JENIKuR4jxJxLc9ByaAa91r43zRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=RNZkb49g; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="RNZkb49g"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c20ee83dso4712105ad.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459933; x=1769064733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBZ/ScCVDVjRB+myzZeML8bLD+7O2F+m5AwnN8MdY5M=;
        b=RNZkb49gVEqYSVE1PjPeiEET4uWZ0zNPbHDh2xpcu4FbMAqzjghhdG6gUs/sl1TegS
         9hPNXkdwD+xNiz2aHmJn7EUwJtqgX/SpgOOZmVya8F9CGIM0cFnVbyVI6N8GSAs03/8A
         lvjMAicOqUmJHZSc/RgMIJN+aYmt6I5UQ4ox6sFlRGi9f/3hdfkZ/WXkPE8EwOk8JEiP
         RZzBSZcbcfv+3SPRfLIeUWrx8yKv0+xeFHRka6f+6JhPHl/1blmY29SYXG/GTq9iBEw6
         uC0pksC8e913/CvZMuNR8nIfb4CY3RhcPN3K1yJBQIlZzVdwg/OjzLQsGe1VyPAJXX2z
         awOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459933; x=1769064733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBZ/ScCVDVjRB+myzZeML8bLD+7O2F+m5AwnN8MdY5M=;
        b=nEFKsbjVz/aMSAy9fn/0otzr9eHeWi6xBnqT2HtsRUfwIBYTJaBX+w+2f2OejREdMR
         PA5N6buuLFa2DKjxbLzlMwMgTgoodQn4GynydDYKdiLignp7lBaKon+GgyWhvfG5lcs6
         Jvp9SL2YFyP5Tzw8hRqNU7bOuDkxQhcOT8SmOewFQ4hO1vq8V3+7twoo9+QDUJVHjKCB
         IHu6qvT6IS8Mq28r/OELSb/pMKgvMqU3+fFj5+5gLhG58ViAUO2vCpZyHtLecnuLxHue
         3UwGS7I766wCrCEIPHXciLgMnKUPYhmR5iSLYW0nsWryEi5GEyKRbgI5bvkivHiSQJrE
         8JzA==
X-Forwarded-Encrypted: i=1; AJvYcCXF9/+7+/zyqy630OuqNEA+R33VaPwDUtGECQzAgmXWO4xmVnWLdfgoAolPSDQBsejErol4ZRlPlfKNYto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzb/N6mAW223XJbOZz9DliL6UzSaWeJ3q8feY0BlfvJQ2/g56b
	QyyGn7Ne/4hUB8ADeMCkvtsny96v5t0YeuZbjIulFrU+sjaqMLS8DhXSDXAwM5pnS0Q=
X-Gm-Gg: AY/fxX5UcTxgUv0MweTK7Eql61mgHS56eQj+/7Xkz369D/04aYtRfHi5WvRhZbH5Jkd
	UJdClMrr9nT/xuWvSJl2FJtxsH1QW+k9z3oJSXxgHrLznX9Z/YxJ/9wwGiEwrTA0EHxdkTLP9uY
	ydoWGauHpIMiwrpZhoK8BXvkJczFJ3F9X3U+XoVokyI4QlDNEKI3K26Kev3BKr71OPYhUqwWbFB
	uEqpxfxXlap6F+x5jfrF6OyVCCX/v28qc/PEMkjXrgFo/T+958ybuNaz1Qa8IuJEmGGdaOSbIXg
	hz6l9JqBwms7/fjXxtWiKoFVXqPkKYuT+Xf4f2mnjPm81baQW+T1aNV3K830QRlngrJJ+cRfKFj
	h8bu54u7jengzzYjVAjsxoTiJB5UxZIdiEF4XRuxNZEyPQsnfrhTpnrIeDgAKbNd3sIm0f8AyS2
	QIpvXLIkmhiekGI10T5PWmaIidx8TAkkWHAyVsl/sYyBVK/uPL+R8p5g==
X-Received: by 2002:a17:902:f683:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a59bb1748emr52234975ad.2.1768459932812;
        Wed, 14 Jan 2026 22:52:12 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:12 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:40 +0800
Subject: [PATCH v5 1/7] dt-bindings: riscv: add SpacemiT X100 CPU
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-1-6990ac9f4308@riscstar.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: b4 0.14.3

Add compatible string for the SpacemiT X100 core. [1]

The X100 is a 64-bit RVA23-compliant RISC-V core from SpacemiT. X100
supports the RISC-V vector and hypervisor extensions and all mandatory
extersions as required by the RVA23U64 and RVA23S64 profiles, per the
definition in 'RVA23 Profile, Version 1.0'. [2]

From a microarchieture viewpoint, the X100 features a 4-issue
out-of-order pipeline.

X100 is used in SpacemiT K3 SoC.

Acked-by: Paul Walmsley <pjw@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]
Link: https://docs.riscv.org/reference/profiles/rva23/_attachments/rva23-profile.pdf [2]
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: Added Acked-by from Paul.
v4: No change.
v3: Added Acked-by from Krzysztof.
v2: Fixed alphanumeric sorting of compatible strings, put x100 before x60,
     as per Krzysztof's feedback.
    Added reviewed-by from Yixun and Heinrich.
    Updated the commit message to provide more information about X100.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d733c0bd534f..5feeb2203050 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -61,6 +61,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x100
               - spacemit,x60
               - thead,c906
               - thead,c908

-- 
2.43.0

