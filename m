Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596866;
	b=DAcxCmLjyvGsiGZ5iLd6SJPJ3o9LoAO4/tjtoPjb7LCgtqrQLoFaikQ9cnp1S8Pmtyqb
	 KZvVYhlB8JV/bEs35ZT/vt8MXZ7GR3Si5Rem59CERgT3IOwIkKeY66YYI+NFDgdKr034+
	 umsqv6InyLCo//jF5qpQ2BjcZozkc2gEzKizVDE1VUWkCovECjt8M093Gf0OhX9DF33RN
	 S020MA+US6smx4LulgnTJGveHTY/FSeOA0X6tw06xX/HLL7C44lzE2gNtYgnWTXoaaSO9
	 L0dbcjEKUYZ2Bb5bM+6y15deUp/X/OX9UTZmuG+iNucnLwzPniFhHjzvpZgJZd22bxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
	b=J/cx8LoO6tgMfAQkez3XUwNC9UEuxRiZOEyS/wvEIhDOifLdM1Qk8IigfXcHHY9iof5I
	 bDdm/7D68Z0QshWIGFYU2G9XPuX2u34DhczkdMpJaOYY/xJuL54UXkWBSJKAUjQ3FOWq+
	 SLtrBvYUi9Cv4FHGXdgJqavbrmEA/fRE6hHgeHQ7OvBL4bPx32ouyXkLUiaQsCTJjxLpM
	 0mXdbJPTt8mW+xI4kbPqtHSinVCgLo1jX3UWlRDoQZqAyEIBCcN3mSAJlfmGx+jDgZSRy
	 lEvqM1/xOdNAYyWDwVMZf5lm4e85cG1xwJHb8C0FXFZu6s8+/8MD/TY45OTMGdhwYAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA0606A8A1
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFA0606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4697404c2bso227941766b.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596864; x=1795201664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=Vm6v1RTEA4FWJq25ASY1lb5MR5BgXMe4qoAyAKawSq9cDnRLqH/msUZtMegpu8mO31
         3alveRSeEqOlea3xa03rZSdDRmVsFWBqx0LvtXUYw2yHjLyfgd/DRtnPA2Kv33PBvdzq
         6/D04/Ychb3xeD7h2lFwdXVW9kehjlwqs6tQqZ6ir45YeFHjeC9p+tqjQCCzhCBM80Gc
         dDUSPmVKWoIld4xsa0FObxQKQoUQqEjgaxbgyLvcnnwHmjG7pd8skw7SxHTHjtYmY7Vu
         m8wlHEZ/BrlQKb0qUoRYpWhitGlL0IDd03p5YchHAQXI015wKWpYldCg/LZsRoMg6eGb
         Q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596864; x=1795201664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=mOlghb+vr8jtr2/xvwQviRcj1q5JpBFvdP9+RwaAyFGbCvWdPoACBsrfualLxkonCq
         Jq6FDOJ//zxssO0YmR89Lkm9hTbLmtwKHTY2ojFieQZiHniVZxEPlCzdd3w/A8LHYoe4
         BWSRMfNRcaAdI2oe9nxCe7K0OQPgtp2VCLH19bfx5oPugwE/OprYUYOitKyYQ4fPJFcM
         3CXpSToEBTnti6TGnuib5rr47uXUXT8UIAtIPmxh/NLwvxa6071F4gDYCTC/WIuSTlQW
         B0sDuXMHBVc+ADZa4MLKuXiwmoPJhNEQ+kIBEK1P37rIxjV2OXTlGCRcApvgKjZvc8Se
         I7Ug==
X-Forwarded-Encrypted: i=1; AL+hErG6VdOvtUMCclFS4kdx8LIR9DUyOUW+ca8rnO6/+zN+oRD9ZC7YSmIQYvZSwM4l3JIfBhN7+r9K3HEUooE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jcM+IKyrO9kckxaSsgJQL8INzieUb4bWJ9de9E6AN5cxali82
	nDRs+rS06zFYlVXZFhi0J3tfpU+1xjbPU+JJCGe2cShs6M2sSbyeOipu
X-Gm-Gg: AYBFou3OkE3POuRwYtGZWLIccmVS1WTfCj2pkkzOWxA88MIT82LRdLxOymVJLLD/aDy
	k9TpFuPiUSUlve/JfgomKFf/sZxde/KxEIhgltHNJpnn1/g3JjJ9vsLuLsS02lk9EddpiFaVzXk
	+fQsLDSVejws7/TPavkpLOhdF6hbumHQvFCifkREk+qN60szbyv4+kq5Di0LhWzNo3yupWV8cfU
	at8HmivjIG8U84R7U/8ly5nQzcj+EY0MEu3/18pM36uYwLcjB6lyMu0SiFms+U7m/gnRClGUEN6
	uUFVxdWw+rHCWRV+GCwR8tiaSDaaElxUi8PGqTACvzQcZu6LZq35bhiymKv17qLcCW3pBH2egQM
	JSEek/hJ0T5nns2nDi0N6uXIsn2BtxnFrdiI78sX1jFHe2fkv01H8/3ncLDxjeY4w5TeO2HNc7R
	t2kUSKeeDuFCrJpvQ9THoGQmd0FNScJ3hfVNopGhhVHC5cDrY6KFioG75RFl1rgPY/xPGgnismE
	SMuw5EzRfEJTkGZMu+OM+DnB8zzVur0X4prmaBJ4DihRmjtQVQ6Y4Zh2baekOG37o7x3Ju2PJty
	nE0GRGSjxbPA2st9n/RwX0KIc8Svm72PBLUNbq7L5yeBeWBnvuXqN5Rp5t9ExFZH
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c50963d50e5mr310340266b.16.1794596864130;
        Fri, 13 Nov 2026 11:07:44 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:43 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:57 +0300
Subject: [PATCH v2 1/9] dt-bindings: arm: mediatek: Add MT6895 and Xiaomi
 Poco X4 GT
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-initial-mt6895-v2-1-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
along with the Xiaomi xaga board based on it, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e7..28180ed0e815 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,xaga
+          - const: mediatek,mt6895
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
2.56.0

