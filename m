Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91177326D73
	for <linux-serial@vger.kernel.org>; Tue, 11 Nov 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889205; cv=none; b=YRvotTmjAnZycm84WcIB9I0rOZUXmRxgLAzHk8KuX5DwHbeAeVOlnGED4t+VHf4EV7UaSXN4bp8Xb2ZkTCR8oshLJj5P97m8RgsA6Um8sKMz+Um26pC7ScXGevze6ERlqxuby1nwwQdgF0yCG0jOQrQOtwvAERdixQ0AHMIYSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889205; c=relaxed/simple;
	bh=PuM1AACg2d+I1zG41cyM/NLvQTJ2/H6JFpNiUOMJQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEH7v5cYjMO3uB794AaqqwbFGu6lGmkZpc/dSoYBVaW1Ieo8n0HnXn1/czxrtaH7zkIhk9HLhXUC8s4IKsWPknKNwOk8dvkHXbnLp0ED0NAhG8Pil7I5xUbHaZ1VqUe1M4F+JNWqPG2PoAMYUaNrzI+3ouwHMlOSQIQCzR/9eBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=czTSgGHG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czTSgGHG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297e239baecso11698645ad.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Nov 2025 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762889203; x=1763494003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdNxsDJ9m7UGbRcYc8TABHid3VHQHv2h0LQ2tYeasVo=;
        b=czTSgGHGABHc27+UBO36i8NZqqDMtOKmZJeshxFQSzE7w8yHWNBVghJ1OKn+sh/OTr
         pO7ohLbAh3htpT5Tab1CnPR28QtdkyFyl1OX0XN2t7g8oGbTYQI7SVLTchelDU8JgIxB
         AvhMjwViVRw3M+mr9FgRdEyIebm2BDdUMFLy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889203; x=1763494003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdNxsDJ9m7UGbRcYc8TABHid3VHQHv2h0LQ2tYeasVo=;
        b=CnWRuCrRgwdvpC/m5SIa0X3M6zL4/p+5hr97KllCB0xljQw8LQuFH7irhwJFsuQ+qU
         X3IQrM3EusEp9ZuCWND6aj/RLhUFhb5W1apnuHzmNeF7Q8Aa4Qs+djdmz/g0igYbhs5r
         3GSOvZPqk/xGFuStFzuCj1dPb1biD28Gc9BRwRO1ba4tnixk/IOk89MBjLT9BmXYn+0C
         KHzeMwwJPthGi3jom7x6/pA2h7xK4FQmFmIjL6iAms7xB29jjmmsS0Hn41nbzsVZd6aM
         1eHZuUfJBoEd12Hls+SON63PkkgZXYC5olF2ZKxdFGAxQ0f/DlAhSSCKYzEUj1Ebbqt1
         nnpA==
X-Forwarded-Encrypted: i=1; AJvYcCVyDBy/tF3IjDT6hbjRF23wfpSvJoC6i6RLMQv14j4vjDr2cDvN0cpkgr66NAzufldgO70AQz7+YyltP3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwYfpaVzTbokwThrjbCo7od0zpE+LoeunDBKyaPzgQDQ3sYhD
	Y2qhGFN3mYUZB0ct5IDfbLnYCA5phWslUebZMd6hU53fzJpeLYaD3ilJdBAG7j2KNQ==
X-Gm-Gg: ASbGncvLHfveVrjHwpdXndQ2yVj79g7R1GMfwA9A/1WpgghIBCP1/+vl53XkF4s4bPT
	gZpLbtaIWjuCOXfOQUAhmFABO9KMR4iJpfPm/C3dk1mg7VLNgRB0xvWJC4+w3YAGfBMxTfrS+p8
	ZwYENl7GlC3rChOVrdEnq3K5liackCbWpH4hwDuVSEwvccrZmJPaAv8VuEZddgr4To2QwlD/dVq
	IxT+lKhnDIAK3fIE4fqDS3I/aLqIJk7V0Z2YRLeHpdQUTojh+WJmhSPj9wHOBYp3jikWVVNbHF5
	dbMPf0vOsG4hOWdWAMJZ/wLF6Nk1WVD1sJlrg9aryHcWCkOogzyC43xVxjzD38joJMnz3rKKfPt
	l5Mu71jjHAWTCqMZqwj2e2yMOo/NJ3LKHNq9NIw5xrpMeBcZyPJe3CHOjYboM9OZbj8UlN6fFrk
	4qYlJYcBRQKPPf34CbswShCxk/M5c3U6ixsjjSOSgVS5NoJ6CLrowFuqa5CHOkpxs7xTW+4w==
X-Google-Smtp-Source: AGHT+IFUhgG9WpQVUBXncCvJtpv/AdoMd+/rut91fwnGCd4l3imDRqM9pTW1tm/5jIJ9RftY3SLcaw==
X-Received: by 2002:a17:903:944:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2984ec88253mr6581805ad.0.1762889202759;
        Tue, 11 Nov 2025 11:26:42 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:ba9f:d4c6:9323:4864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0974sm4861075ad.90.2025.11.11.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:26:41 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"
Date: Tue, 11 Nov 2025 11:22:05 -0800
Message-ID: <20251111112158.2.I040412d80bc262f213444aa6f6ec4f0334315a67@changeid>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111192422.4180216-1-dianders@chromium.org>
References: <20251111192422.4180216-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Google Tensor G5 SoC (known as "laguna" and canonically written in
code as "lga") has a UART based on Designware IP. The UART appears to
work reasonably well, at least for serial console, with the existing
driver in Linux. Add a compatible for this UART based on the canonical
"lga" name for this SoC with a fallback to the existing
"snps,dw-apb-uart".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index cb9da6c97afc..df6a7558a9f2 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -53,6 +53,7 @@ properties:
           - enum:
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
+              - google,lga-uart
               - rockchip,px30-uart
               - rockchip,rk1808-uart
               - rockchip,rk3036-uart
-- 
2.51.2.1041.gc1ab5b90ca-goog

