Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186782D8774
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143069; cv=none; b=m/RzIPHpZYdCG0otvB0prskejZgUoSjqXhhosaov6AI7DATGnIgZpmHxYN+A4gqQyGQ+8WVr0VYdHPaCUIKlJ60KURsgRPqNN5DgjXczeg0AD/08ziaNzoLr92SUUrYMXxQT7ND+mkwGin5pDa7BU97seX8ILgNwiQS+kHBeVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143069; c=relaxed/simple;
	bh=r2bRl4B4OF/qKIhdCBGgWHHiscJkRg/BHw+S8XdcwM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YD/fxSIQaOAKJ28YCxY4AQ3hvFICXZNz+Z3IXDvJxQnj2UAJA0vmtmVrLMazZ107VA4npTuqSa3Z9IypVqe3gfZbpYG4U3S8RUDXDQ2pOmsggT5hcivyqt7aL/inp1PBTexTqCm0emtEkAJuc7nRH5S3CWyf01iFQinZPo64PmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9RZO4/0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9RZO4/0"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78de32583fbso1554396d6.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143066; x=1758747866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLjc6vgKJXwelgY/kFV/7fD4NVClmcvjL7QnlQQl+JY=;
        b=W9RZO4/0DliJmALonxeiq538anDPYMHS1SiGkE3jmI4AyzaAepJ8CKZIWDuOVs9ejf
         ZDTPCjqz2+9MBOnBiJra4IE6iHa/0s0QVbJEC7AUhyNpWVGRhtbKWACq8TLHHQAQLHZo
         NVWp7LOSI2ozZM8vJ8jX7yumSDuTtlH6W1g0F4Xrbus3YqDC8P5KGdoCU0zhRuWs7Yks
         N8z+EmAM30gPJQOp1xs9wyRxCDd+lbBrTfVCOBb4qyMgjtu5PYX4H4bU/CRjMmWEGRQH
         YJq1uhkvtCRW2qGMKGA2GW5Z8PXu0tCVNcOgVaxE5k49PFc817+Ow6qREx8y2nJ13Kmr
         Iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143066; x=1758747866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLjc6vgKJXwelgY/kFV/7fD4NVClmcvjL7QnlQQl+JY=;
        b=P/Fsfs+9KOe6dDlkN4ZpyWZ3dI7EkXwzM2ZoQYaFg8my3ymnpu+g64UICftuh+hAAN
         AKtghAtgsaRBx/5DQ5U93hD1NnnCBBngJnflyPotAA2SmhPnV9ADGoEou6lgA9DJlt6I
         QewJLG/qd7aIADm2FCJ0AHTGhYuaLwfIEr963/8LT9aoQ43omvqCfTSrWOcI11U1nrpm
         /WjtUmKtUt3+WKTgAlqhCFJ8IKhPpkcR7Nu5ZF3CWEzA4nLk04mDWHq5ZlzTZBwttk5K
         GU5YvNASTOaG8vJnXhtQfwvGX6VlJyRBht+4Ji/q+VvDdPxQAdQV0KCuUikXyNG2JAyw
         PPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl27Dw8rsgdam1yQWbj8teQMJpWrZlSkEWF5mWBWX+fP8CqawZTIzsU8XhzH+puoE1ixPUctTY1a1Cp2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gKMD8lrcGElcIvhSt1ZFbiETQ7bZhIUCfJ3dsN0vE+iOWojE
	Sk45+gyKPJE9bVGSY1wgt2wRWmX/cffuD7jXnuvKPTj/5O5pVzqF5K73
X-Gm-Gg: ASbGncsulivZgVM7IFqm3FzBYc+wjgGiGDm9chrDHxzqDgB5k5crffgCOSkn1JC+hdS
	iTPdUpK3OdAyYzdguWOvsE1jqTAOCRDDF7y3wnsLqJywyHWvioliyN/Focj+EKNpMdwSZtCDVDZ
	1LJ5z6AmYqL7fJw4eMII1m5fK2X+N/y6Bac7YFQl1axG1b52HBsIs0IKWkqMKs0SdQWmBL2zTM2
	EwUkuUay5hTGsBjYfXgVYrw2LTVseDeFAZOCDuQWmo6NAlvl5t3OTBfyPq4YIEOZcohhXSHVSKf
	bBv+JlQSLZrUTuHFXzfkXhgFyYFm/giB69mroeqm0n44jpxMRepUnBYSmC2Kke7QDqTzE1SDdWv
	KeXsBJWFvtzaB4aEzEuLGUO6MQhRycTXHU9/0uVTMrgS4ob+jQmJg6qY=
X-Google-Smtp-Source: AGHT+IFrkfpjfpj4V1IzxwzgKJOiCNq9/t9HIBwNE2UrLVBPq1G0Uq+ssai2vuM9RqyWADLBL3pR8A==
X-Received: by 2002:a05:6214:f6d:b0:76e:7c27:f040 with SMTP id 6a1803df08f44-78ecf20bc3cmr46716026d6.54.1758143065909;
        Wed, 17 Sep 2025 14:04:25 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm1897226d6.53.2025.09.17.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:04:25 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Wed, 17 Sep 2025 21:04:23 +0000
Subject: [PATCH v3 3/7] dt-bindings: soc: samsung: Add Exynos990 USI
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-perics-add-usinodes-v3-3-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
In-Reply-To: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758143062; l=951;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=r2bRl4B4OF/qKIhdCBGgWHHiscJkRg/BHw+S8XdcwM0=;
 b=YwGiTLaTBVm47v5bQ1r7SxkCTmRNrDBm0v+/xK7ZoG2m3QWbczPFTXoj63VvdUma7/FMZZavm
 PNX+CL7qfzgAUhzJGU6eQe3/hjmT/WCuBfEKA95LyjY8PVKIYEYFIUp
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Add samsung,exynos990-usi compatible string to the
Universal Serial Interface (USI) bindings.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index c694926e56ef991965153b94d704fd53addb5cbe..4a719cea81f9d3c3b5296ba2d45b05dd014a1d9d 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -39,6 +39,7 @@ properties:
               - samsung,exynos2200-usi
               - samsung,exynosautov9-usi
               - samsung,exynosautov920-usi
+              - samsung,exynos990-usi
           - const: samsung,exynos850-usi
       - enum:
           - samsung,exynos850-usi

-- 
2.50.1

