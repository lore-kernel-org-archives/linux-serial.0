Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D230E0D8
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459979; cv=none; b=YF+D4v64eaf5ZlfSSpnA4lBAsB8tyaqkSjcHiu5wjftOU3dMYnKgw98ODcLd7wtEnz1KHUO6E8ge+5tk8nTwK1DcwSttd0SHxykQZgQPeSHaUx+3fZmJZf6PK1DvqLfmegO/yc6xUKj+fAnKMPvBAbOjyy518JPBfwk3LVtlito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459979; c=relaxed/simple;
	bh=k4VYJTSgNG2EBcFca+PjRqHwafPCJ6Z9F1DCzhfpcUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxOBJp+BHkROqIHSwyY1PN2SY1AshsnnmYEoupetDyjt4JtNoxoj8C6GchEzmuUZJOy33R1ZvJ+ebf/c+mW0m7+QL88wHK1IfL5tw4jCh+t8ndMaQLz+kAkBhupo/wkOloLFgAmkumEUelco1GDpSvtC7rz2xXTQT0knZRQ4nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=BhqjN2Ns; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="BhqjN2Ns"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so4952575ad.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459973; x=1769064773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSxOkq26KY5aFi9jIDHJotlQaCGxwZHXeVQL20enYRs=;
        b=BhqjN2NsOWZF4yghpc9GaG+3z+84O7VdZo05dkdCczI28tmBOf3XhpahFgpVB0Luj/
         gASxCkTDvg2Ce/DArtL/pxqJf6t5NiAwy4mE9N1d+tY84iUXSC/9s4/Of0RgaevIdxrJ
         CzDtcFqGWHXGbU8vq8zE06xaY7H5JERYK3LGSl2wjDLefXFCeYAzdQZzmskylB07F1QJ
         hyO0+P3O3RI0nd9VU100fLEtqoc4ETrfaZyXMQiW4Gi55KED1309CQXD1w1WVyBUvAG/
         3PxdRNUFbba+KSBOitxNGwnvi8DBRQPYoPDJiIFTI8TyI7xXE+WuKrJ93KPsdZG/bLNo
         lkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459973; x=1769064773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSxOkq26KY5aFi9jIDHJotlQaCGxwZHXeVQL20enYRs=;
        b=mVoUi/lUSpuWVUSx/YJ5KaqYHvQXyPHUwVrSVZLhGp9fLg6FIa8e0UpghLP+wxUwvA
         vJLkPRQnkxucFG8R3A9+XyHxiuUhrG5wF8jiiVxPvbGBZXxXnXajPWSKPfbUg0z2LfSp
         FzrryNxJBT3zvypYueSRxXusaDkB0Vx26gF7CZFpTZ6///F86R7kqxeqd+FLZEZfHX9g
         KUwb8cSfPH+wD4FcJE8h9rCCkeBtdlUsoJ3jqxd76YybkVNM20fFKwg//vj+UPInjznc
         5zFo/wm1WhAOG96yRuKCVJmWR6OCbcBzrdMAbpedvJgHPqFJ/00BE2m2jaVML5GBbsaL
         6L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyDZQdXiGhGZIyT6tW8Xd1DlgfEi8TgkNhyznZjclCx37ibheOW+DDKG1dZSuxrzS2mcu7eb2Wc4TWdyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMQHSWNUIY7XuHC0f6CrtfRV/evOP0tiLc9aRM8gLKypOBYcT
	UbPmlxYpXPshDKFHzvLigPM1YI4QaleU/rBfQYxZ4T/KSFlgExBNVV0QLcnzQ/fF3U4=
X-Gm-Gg: AY/fxX7ZMb9AFai42Hi5D4mGdElxKZFF5Sk1zZXTjPUcwGFxcnsTcXvxuEgExyxWWKT
	YKCSRtncLQw+MRnf7iITlqcly3Kgpt85E3zWnAnwfFHVNNmTCToOOZURLNk5exjs9Yn48B79Yf0
	1OhvBigiJTfv8KjfmSzdyVG3DCC+orXstKq/Z46IuhEz22tApWTWC1CatEqZtKLw6/86e+y6UvN
	awuESCevf6+R5KuWEk+utExsRLFY5WKsMY1WUBwEELt42LQg/6ihwnia5sAYoJQSnXiNMNonPek
	rHsx3oXioevKyDeUJISgeDfMVA+tWdbh2nx+lteomqzSxuyLjHuMMdjvTTFrI6cjigGRfUzIZIV
	WFdav/eeHpQXJqSlS+bXFw1VZpfr5FJvt3aN4PnnCAPg9v4ZHXGzYGujWsQZ4WeWpAjnIOSLhNb
	kPESk3+SAe2ACJvqZHxlAVk47l0dUvByeCWnohEGWM764eHMEy9piy0Q==
X-Received: by 2002:a17:902:f788:b0:2a0:e94f:f4e3 with SMTP id d9443c01a7336-2a59bb726afmr48755255ad.23.1768459973590;
        Wed, 14 Jan 2026 22:52:53 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:52:53 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:44 +0800
Subject: [PATCH v5 5/7] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-5-6990ac9f4308@riscstar.com>
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

Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
which is a 2.5-inch single-board computer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: Add Reviewed-by from Yixun.
    Add Acked-by from Conor.
v4: Adjust maintainers list in alphabetic order.
    Declare spacemit,k3-pico-itx as an enum, which can save future
     code change when adding new boards.
v3: No change.
v2: Use one-blank-space between name and email address.
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 9c49482002f7..b958b94a924d 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -7,6 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SpacemiT SoC-based boards
 
 maintainers:
+  - Guodong Xu <guodong@riscstar.com>
   - Yangyu Chen <cyy@cyyself.name>
   - Yixun Lan <dlan@gentoo.org>
 
@@ -26,6 +27,10 @@ properties:
               - xunlong,orangepi-r2s
               - xunlong,orangepi-rv2
           - const: spacemit,k1
+      - items:
+          - enum:
+              - spacemit,k3-pico-itx
+          - const: spacemit,k3
 
 additionalProperties: true
 

-- 
2.43.0

