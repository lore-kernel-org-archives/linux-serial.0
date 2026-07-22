Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1E388E61
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714178; cv=none; b=k3Da6xOxi/8yXOdweBqTiVvwr25wA+Jk9lB5572SnKl4gyIn3WZipcU+OYzgH1SJ7LRQDwDSDm0QaJZHrlOH29Ri7KGu9i8+VoAMOj1Ksc3xVmOetETXEQve7aqHOjUlU1IoLQn234A+opWsW//tcbA6xBdGj74jCHoYqWUAqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714178; c=relaxed/simple;
	bh=l8/EKsiOhWbe4eZl51252HGz/A19lmdsN3st6z2vITw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fECcm/JuNkt1W9KRovM5NtzUwEuAtus7BJM9EgEARVBV7KsZnbuGqnq4cP/KvmUyHAu7orc6qdy0hjMM8fX33z/9ZjreFUBauYG3dYQE5Y4xI+tIUV1efi//D7J8JVHHYJTe7u5y3ZoPUwY7Qn+X5r3Edu7qd3GTjxluY5GyQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mdof7fv+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mdof7fv+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f633e6058so4780047f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784714171; x=1785318971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLAkjC7ZOsFkeH4UKT66qvPXrNClMizkw0LQHgeVsaI=;
        b=Mdof7fv+7tRdj8pSYvjAuz2Ib2+bVQfyjxRwypLgQt9nHmPKa1OQlG8S5OwiXfFfPc
         kqGGPAoSzUVxMJUTZDFYMMmbdzvEpkRQBGF8bq2kPKm14gbcKrQCukB6MxTYqYwTXZEm
         Vd/uTbyzexxnnMDyPupMLi9aRUaAH6cwHnYV+hrUraftY9DJDL9huxeUObmKB06gouiQ
         ipujV1Bpj4B4Eu7JlfFvblBWW45BdGyboeUhY5e4TGpUGfE0VvL/JMzkBiorbUkeoGAr
         UvQmyaMwDAaw0Udmd9Ol7ciaSUHCED771ganBQ/6Bl7rMM1MmgDuxPKJFU9Ls1zARq03
         4E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714171; x=1785318971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLAkjC7ZOsFkeH4UKT66qvPXrNClMizkw0LQHgeVsaI=;
        b=MUFUA+MjBSWJE9WB4+AyQRR9EdXCOujMk397Xj8ihdpnqr9WMBLGM4TDKduqODC5TW
         2DoO/Qw+NwaZOb6zNeBohMCqR1lMPCbpLu0DFsWo50IrtHjjWXT0hbOvoyNw5nWt171V
         5HdmK1n/zpa7Gdo70zu0ujK8g/I3jC52WQGqodN5R/UyShsmjI1rTo5zAWkUwO+bvVjx
         K3dQKAcz2TKQRT5tzCCpzgWG47hCTddHH/YoUb4S7Whv76OvoVkRN0kqwzESpQjGn9HU
         cyb4GnmNlx0YHZAhViiVjz3W2GT6w0GVcPD53Vvuxk1f/AwftNBqoERtb4lP7KTyXkq3
         M7sA==
X-Forwarded-Encrypted: i=1; AHgh+RrdiqgK5zMTNp3ZxTgxb6WdfrDfagcF+fxZ2aDt7ZzHV97EtRov4KL0a9tUrRBCnmyIpmN4Pb29xrM1/1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiMY2SWn3G6THOgo3ekTih6SQUsFtKd9SM+5ghJAY1v20CKU2
	3WAYgsy8WPNrdd5kOTYp9oYp3oe4W0sapn8rgJauUFovyg7lg/O+5H4xHfGBEQTVJy0=
X-Gm-Gg: AR+sD11VMh+zWEs4cMrwWtOuu0bLRTIcjC2otFAtIR4zWcnb/xUHz5fcE0S/LGnhYLD
	ziAYdFTDzdtvQQtNPJsAPM3WXCAcMUQD+l7q+PBPOfaJwarPaKedODJ4Nj3V1FsOk+OFBZGcaXf
	S1iwq3S4XPIa44CXkckhpmQteV2FfiNvKGWgm1e1oLreSIyIr412gMo9FsKxKEUVEIDU8dFsWd/
	9l/cKo+MmQaZha9UrSIRERCi15bvTFJm7vAmoxzsJDI0aN/wbyZmciqS0whJ6QM0R7Z1xBIutJs
	SLmeQqiKTk19yvvXNwMHSyjqPJaE/FE8lOPhTJCkcc2GOarIDP8hrvpEjYKZBj1CHzoxnMsY6It
	0Qu4hUC8oxR943owvTO7jnJC97v6Np0Gj4HCsUhhxpnjdMpY77r+Ef3uaPzhwKOJpyVGPCgqX3H
	iYYWeK87y/E1F4tcRObskDYE4rl7odSRf+Yg==
X-Received: by 2002:a05:6000:4b07:b0:47d:ef38:260 with SMTP id ffacd0b85a97d-47f6230aca5mr25975619f8f.27.1784714171048;
        Wed, 22 Jul 2026 02:56:11 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([2a00:23c7:314c:4601:ea7:d5d4:79db:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm4414533f8f.22.2026.07.22.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:56:10 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 22 Jul 2026 10:55:53 +0100
Subject: [PATCH v2 2/5] dt-bindings: serial: snps-dw-apb-uart: Add
 "google,lga-uart"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-contrib-pg-pixel10-initial-dts-v2-2-3abae9717feb@linaro.org>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-serial@vger.kernel.org, soc@lists.linux.dev, 
 Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
 RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=UIAuCpn9sBr07oQ2RwIwe4pVzRGN2evRfhuSeBFU/iE=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqYJO2S5G3RXrgDdc0iZBu1hTMoCLLrgE6SJbjY
 TVJinLwtlOJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCamCTtgAKCRDO6LjWAjRy
 uqBaEACecjhHzGhUtBGP2AxwpzQCb4I9hjLzjVA8jel/swb5ul1VNx1d33WlrwkkFTN37u+iL6f
 RToG6IHnRdaPjHsxUYQLr5fWNm2eb0Z84Lf7e6k2slRSz0W8CvExX797OFAIcT7OEiUNlZLsRMH
 ksu5N7kYRnG6YnvIf9qo+NHRWWsAG3U1RrrTAbtc0fQZrax1ruAc9ku5b5fge2NLdft9CSNKWlo
 rg4Gd/sQ5eoT7f5Da4zLKz3xnkt18jGUuqPZ8CZihaQ5eKs2Gf9zwCMU+ZAZsBgbpwXnHUhvZHF
 o+dcAJHqoId0jbRYc2rK5I8gBj5uLvTEr/Aug8sxICYE15Q8wVjI9UB4vQ3ds88Kehjw5OC3sN+
 /AfaQRq4yBX8KTFf2HDtl/IFm8Zg1pBDmkB4mROcen7Lly6fvdCBPp6Cj5SZFcn0jiDCD7gRMSu
 XTMVmblIjGBcMllV4+aYIjXsWabeJFGKxV0fppeVhQPiSUN/apDQbejChCTeB6wUQzpXyRvIWVS
 nFxJ7I8LlLBn/zGwuFKB2qiXM2Ak1x+T5suXnWeAvWFM/9nqdQ5kEqLRvsO2r2CRD7kLBvr5aeg
 QWSfClbNCzjPa6WsUkXVRyDc+NKTs+iBTjJLW/riV6YG4AooRnm8elO2hpnxbNr6yloQjXtp12X
 4gZTgROw5MX8Z3w==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

From: Douglas Anderson <dianders@chromium.org>

The Google Tensor G5 SoC (known as "laguna" and canonically written in
code as "lga") has a UART based on Designware IP. The UART appears to
work reasonably well, at least for serial console, with the existing
driver in Linux. Add a compatible for this UART based on the canonical
"lga" name for this SoC with a fallback to the existing
"snps,dw-apb-uart".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 685c1eceb782..24589466a4be 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -54,6 +54,7 @@ properties:
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
+              - google,lga-uart
               - rockchip,px30-uart
               - rockchip,rk1808-uart
               - rockchip,rk3036-uart

-- 
2.55.0.229.g6434b31f56-goog

