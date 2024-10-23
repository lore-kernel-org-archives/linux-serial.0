Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC6165F0C;
	Wed, 23 Oct 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674554; cv=none; b=j75xbvbfL9GMwr5BAFLzpaV/gyF9pBVR//GyJFCLs4lbP+/YXdO3Lm58sXS2fqwwPVYHfsh9zJN5U7w9LxPopYMNE5+7nXWEgzF6NvWC+r7OxddxWoG+qrIVefD31vG8d7ZXQb/9zarjQOqP6UK+kzfEhQLhggsCCvqYgK00GdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674554; c=relaxed/simple;
	bh=Om64TYwexZyLOsmDkQOv+qwR/zTygbtHVmROeifn5zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHuF4aAX5Ky/3HIcC3sSSO18BO3Rkka5riqrXWGkuEzLgEwV7sx4cI527tnMcg5pzsuk9BYsAdl83ify1iWmCtevTaKg3qPyj7jWVORjQig7oA/se+Da3m6pqpFSiP7RbQWgsfJXhafGSalC/7xD5Igl+f5IOHt9o/jC7nw4ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ond+fpkT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ond+fpkT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so8323505a12.1;
        Wed, 23 Oct 2024 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729674551; x=1730279351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba/cw4au5kcFXJibXUgB+F+wGe28SwF33wetHiQmsUo=;
        b=Ond+fpkT15I/ICLmFeTJrHCHl0eOY1dS2BSzIrqJg5iQe0LFZWIRt/uvVykP09Tyfa
         ejkNkcRPxFDEeQrdThrNElnTfBj1IqafOQ7RMujdnKLcpjI7n5yMaP26fCmtTeIwzn3D
         MOpli3L/IDysGD6+oio0IvrP9tojUpEyyKqDDU0ABwrA7rU6iSH2mHZ3zuLErjBj/ZJB
         quhOG8PVtALcFi9P/Di9e9DHvgll4OqfmwngHx2pQIWJOeY93i6VlpLTnk73okGEQBPj
         pMbXHc+TncSjOoj9sthZZpj/lVWCxvZLKtt9Dy1FOTuVKOTshqb6jJAeRK9gWmKJf6Ux
         iXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674551; x=1730279351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba/cw4au5kcFXJibXUgB+F+wGe28SwF33wetHiQmsUo=;
        b=g0Ogu9/HAtHFz1J7+P6ABOKDHkpVMYPEzjB93bfIpb+jGS8WrN+EKAHytxXDZR+S7+
         owACM8vucaE4LG+TvFgcVOuIhS02oxahnfePHh7qLPLpxOvWCAD+I9MHvC/lUJDbx2iT
         raMerw/C7e3jyHjH3nytK07Tz4By72addxJFsemdVyjlL1JYtmm9QaG36Fte+1ly8Ao9
         sq3IitD9XwARBzMI2VcIoLXOVUxo+ysjqgI6aTeia0rJPx3moJ1Y8uvb0Es+NZ5oposH
         ZjbRybhFlpIQmb5aafB5+7pX7VeAf4DIDXpxW8pbk8jGNI/04qtePcTjOf4mVhpsqvJs
         5gPg==
X-Forwarded-Encrypted: i=1; AJvYcCW5qDF5U0yk436EC1QIlS5rEABmo1XmjwNUub7vin9bKrqydfMC7+b3S/MTek0pVWRmuGyfTqSQ1Zp8ZLzw@vger.kernel.org, AJvYcCXSRZmW06eZZb5imD2Qk43mPQlzvc/ZRSC9MhVsF58H4LFErYQu9QoZ1H+w70wWqeQwTnqFDM0bRySq/Wbv@vger.kernel.org, AJvYcCXlFBFJTvd01sMHbFowovp/SfelD/HHydfECkXErCYEhIoc3LpjqIGvUht8kG2Y5a4EyVLZBvTXSunh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EL65p1Gg2vUTgyTf2OwWAp9knUMLd7cHl7G5dHyWKHSx3idU
	WNsfLOER6uypVvA10PsgJ6jjw949Tl61x6QodgTgtQ+U8CTNm8NsmRwBM1g3
X-Google-Smtp-Source: AGHT+IHO2r2Fb0KSk//2ztDhmNspPxH2VnZgCoIaMT5NDnO0Xb49R+APqrWDyFGf+3F2IP9nOoiOSQ==
X-Received: by 2002:a05:6402:378d:b0:5cb:6729:feaf with SMTP id 4fb4d7f45d1cf-5cb8b1c24f5mr1519874a12.16.1729674550666;
        Wed, 23 Oct 2024 02:09:10 -0700 (PDT)
Received: from ivaylo-T580.. ([77.85.230.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a8efsm4133058a12.52.2024.10.23.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:09:10 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: samsung: Add samsung,exynos8895-uart compatible
Date: Wed, 23 Oct 2024 12:09:01 +0300
Message-ID: <20241023090902.538040-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated samsung,exynos8895-uart compatible to the dt-schema for
representing uart of the Exynos8895 SoC.

Like GS101, it has a required DT property samsung,uart-fifosize, but
it does not exhibit the 32 bit register access limit.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/serial/samsung_uart.yaml   | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 788c80e47..070eba9f1 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -27,6 +27,7 @@ properties:
           - samsung,exynos4210-uart
           - samsung,exynos5433-uart
           - samsung,exynos850-uart
+          - samsung,exynos8895-uart
       - items:
           - enum:
               - samsung,exynos7-uart
@@ -160,18 +161,27 @@ allOf:
           contains:
             enum:
               - google,gs101-uart
+              - samsung,exynos8895-uart
     then:
       required:
         - samsung,uart-fifosize
       properties:
-        reg-io-width: false
-
         clocks:
           maxItems: 2
 
         clock-names:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - google,gs101-uart
+    then:
+      properties:
+        reg-io-width: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

