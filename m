Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799E13D521
	for <linux-serial@vger.kernel.org>; Tue, 12 Aug 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001001; cv=none; b=Hdg1g0oD1ONFY8P/rc4JsCutGfB/BX243OVRMV1qdlQe351LKp2sr5RjgrEdxnSVCYTcPZ0zydWlSmzqLfgAOOPJ261+Kzh0RmVAAEPzfn5y9BHFBH/C8yPEVdkL5b7T453AYiRzTt4zJaF1uXIyCUpM7L97RhaI+ufdScvNZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001001; c=relaxed/simple;
	bh=XzZlQ9CpcqoRYra25hFMzQMZp+oWGKxRUW/UE7qxBY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W27CTjFV+dUDNTNaj2WCW7TNG3nVecxIFuOE7xoLnzHFWVRy1bx4jvA9+JkHxV6YhUFNe9AdQ5PGc3c6mbv9q9XJw6393g95C7+tyUkomzGLQIFuda3PKeky/0sFz9FeAEwvHzBfzhRInjSZ5Snee6bDWpe943Mmjrvt1fBCTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpnRh8Tr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpnRh8Tr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6183b1541d0so293108a12.1
        for <linux-serial@vger.kernel.org>; Tue, 12 Aug 2025 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755000996; x=1755605796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OneOXe0VhrrvRj4ZZoP1wvaAywjVM1pAzoyJgA4BqFs=;
        b=HpnRh8TrinU9wEIMCx0P9yGkZDV5eZT9M/ZZiL6Fg/gbeyhXKEV/ftf1TiBsSAi9Mx
         s4XLxJTzY5PLrN2U0m/4aJ+skj03duOuTtFwmORlgKHPUZq3nsoeqzttzSjKX9DrStCU
         3vC1hKQgfcxXTkxh69HjZCopMHgLrXwchjTIDP2l5lT8Im9oez9AkO+5VuPUQB72CBdP
         SAouAeMMe3gRH4mYujOjGFVUmCJFqwxQcEaZCJCPVLZHMHLhP57lMIVnsyBhdKrlnRg8
         2exqTwZuJWcpb1o/tG0Z3VHF9JemdG3dxit49lBp8XAcIjuatr8/atUXJklYWfbJuZHm
         EpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000996; x=1755605796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OneOXe0VhrrvRj4ZZoP1wvaAywjVM1pAzoyJgA4BqFs=;
        b=IquIscBa87tU4t9kWVmFu3lSs0n6meUg/cYWkc9fXYjFH7HMFlE/ER3ifn2EF/Iekx
         WZpbzKMlkjONIU7KBUn00NPTbDcwYKO7ytnHL3dmietqno1+wWPWRwdvkR0Vuo0qZpy/
         Y8bf74oOogV2jzlvajYfb12LbxuqEhjI1ySw/Osv3U6GUzBQGFbi7bAhjBg4d1+wUxHM
         cRsR4XiigGBVvapIt1M9PxifdGu1eyXF+wbV9XIaihP1eNgV/m37VeSnFTOz0kgDwxQf
         /SXiXYiG6+Pe34c2Ik3wuvXoy/CQCOMAQkR06VWE5WiYllY/fPGgfBrT0HwrCDS3g1bE
         vcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDQlWyP/SKzP3/4tMZ2Tfvl9nyNdavUT98Iljm9LDNNlRyjSToZobAjdv3japkttY0K0fMGcmKUW6yuE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFi/fHOT4y0jhgi15FFi5E/EsYErp1b1ZrAsIZUknKR0gZvZ7
	C8fUkJid+USAr3EzUvHSJpuClvxkyvYLJ4395+poSFzLtYX4Y/IR4dvj3p/spC4OMPc=
X-Gm-Gg: ASbGncv3Z3xcQ49yZ10QaiQWiBdrbTt1A8dF9ufXs+3pXK6BwdgF69X+mkKn76NSdgX
	i/KLEDOaIJAzVY7EMLnS75T58m7HRTOe6OstGlahWueOcBA2A14Zzd4mLVVpyKE4Gj0gIOJfJUZ
	5zaYSvHXWfG265knTEuyNc++QxqCfl7ZAMqDZ9J8Eqz9sBngSY4vJSywi1GWCqLs86dQJleiLh2
	5EjZA40NFavBeLWHFNIR0zJLcR7yHm2Lanpl9zmu7l3nA+o7RPctQDOltEttzbV8dyrbctOJt8o
	vtcUsxPtcNHcmGQT53ywDQPIILadkB5DVGARJ63nn4h3pQrBFGs7/LSHb8YCWeZY9qdFyQFuI83
	mEDLwLWxqDjRvZiVEVVURBWkcd8KDW8zwn72D9ldTIuxY
X-Google-Smtp-Source: AGHT+IGgkpeCBHiMX+ZCXuYMNHSA3+r79eSoJ++4bt1uHFFktJRJKVYvOUa9RPJyTGturdLEcYtmug==
X-Received: by 2002:a05:6402:2684:b0:617:b5bf:f03f with SMTP id 4fb4d7f45d1cf-618599c6889mr544726a12.4.1755000995890;
        Tue, 12 Aug 2025 05:16:35 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm19888749a12.38.2025.08.12.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:16:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
Date: Tue, 12 Aug 2025 14:16:31 +0200
Message-ID: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=XzZlQ9CpcqoRYra25hFMzQMZp+oWGKxRUW/UE7qxBY8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomzCerwxWnIoEgaq14ySKDTWBOjr5uoLvVvf/R
 SDtaLlL/bGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJswngAKCRDBN2bmhouD
 1xsCD/96YrcHWBUbiFDVP+LAlTvkyA3Yk3QTKe6l+ISGm31TGejijRzLkdkpVmwIiRqu3WdMgKg
 p5INDv2pq5URbuC/07E69YJw/GJyyTzmilY0iiM+njU9kF8m1N9jr9E+VvS+72/vm57yycYo/y4
 LHC0dykO+fm0DtV4dqTydXzTJZ5Vl87W/i37zWg+90+QoX+mnqEE91J8WNdJMLDo714U8rWw3SN
 BN3YIsGrmpQe+8d/6Fo1ZfgXXS7Ibk6M+E+IieZg8QuNNxjYC40tFulqgeFbG0IsiCXlyufbt55
 APR0a1RhgfbfcZFnTzDlaARDIgcGx/KNpuPxuw6kXY74DM/cKApEFk6Cq0b91u+quT4XoKidbPI
 y+bcNobU0zkBPsvTm0ar5JPfvTLaHltGGInwIKcMzqwSY/V09qui0u9doi9BvMdpJU2ytmof5uq
 7d1pyUqnKzR33nDyL3Moj05O7jZ7zNJiIZZtUgkXWT8OdMYWA7S1tq7PMRqzztXdnXNlf8gfRkQ
 oQ5bBsjddk6YxIXf0M2ZhL77bn2Y9phMbQNu+KqRKnEZRCw7XghE2lTi4cU5a0mqCmSI6hbhbRp
 B1RfTg6s1PgM4aCSRU/TjaWQuZYRCTeHMInX1Dbh0c/rilQ+ZZAP/KFTX5CF50IcRaAzZSmcLj4 J0yl7rALCFW6KKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Lists should have fixed constraints, because binding must be specific in
respect to hardware, thus add missing constraints to number of clocks.

Cc: <stable@vger.kernel.org>
Fixes: 88a499cd70d4 ("dt-bindings: Add support for the Broadcom UART driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Greg, patch for serial tree.
---
 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 89c462653e2d..8cc848ae11cb 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -41,7 +41,7 @@ properties:
           - const: dma_intr2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     const: sw_baud
-- 
2.48.1

