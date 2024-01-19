Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E64C3CD
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661134; cv=none; b=VuvyAZKMO0tR4JN5HABXwpIyoHngSx26Njafm/32ccd3kIfOziqzsSczhyNpdJSnKyf43L6pnwaW5y3YKE53ndGZEHuEaQf2vr5H4McvJiUfZn5/Eb/Xj1g2v8KVZiq5PFxZedkIHMkzvJWur3afmKLxq5bQi9JVoS9bKF1H0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661134; c=relaxed/simple;
	bh=37jpLv6HsDjfq58UT+g6uG00C2Y7+aRvCtuRbHaslLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xni/gs+BM/4DaVO/cFwdG5BkKJGsfqFeIhOMDed7wljbfXUtvuWkFKo/41EjjTtu5tRZ/gnOINrcWWB4JaicEM5rbOFHI0lWrMpbURdnD2pREbub4vXRLXpMuLLWpKif9J/dNm2/+gEPouKwNu4nxFIgI/FHookXfiolRfggpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8PDrjNL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8PDrjNL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e775695c6so5499115e9.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661131; x=1706265931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74QYBuoWbNPw1IrHpaPtV5Fr/Jo8QfnPV+pn460u7Q=;
        b=M8PDrjNLebLy9eSHsN/cvhQ311/guZHaF8bjFlOIRwXxQKwsyXEMETqssTV61V/RS0
         qm7SwmDz8dzpqMG0mIm8vnlJNo1GYSlkePKjkvxIDCrvcDvsfmT8u38AKclWqPuIVr8n
         5kH1R4gZl+YhxNTH2zqIlWXy46HhW3+GDcmkGKB1+2W3WAKLfrDJn/JndgWoY3AMVmzm
         HdDdpYgrciw22SFl5612fNrP+dqIi/MSg+GOZEdTNQYJt/VUxviYyF3UeeMHsHJrVnLL
         kOQDSMtqc8Sx2SIkUPXcTxt8xf6hvI+0qdtqXhOqOoz1+sLsRqM9pZidz8vTMYDIdytt
         nXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661131; x=1706265931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H74QYBuoWbNPw1IrHpaPtV5Fr/Jo8QfnPV+pn460u7Q=;
        b=qd/UOgFxrnjNJAQKSu1VU5FrViPauIUZplLWxQlSY1VnSSOP6153I123RtTAullETB
         jNkOVqziNrI24+mNyiKTER27N4uutUH6VUXs2dUt3XJzIaQh+tPwiXKOXgSZSSG6Igwz
         qF7n2nQEjoYTg8qbdDsqffIOeabIqg8XqyPMLz45vZHQwzihuYj+qF17fhML8+tjiKNU
         sLuyInxgZbYZQyQbGbQ1zlhw9tUuC1nAWIvKUUop9aGA8qMWNUnjVAnxAHGoYDOF+vgT
         3o6x5lXiSCv1c5y1CNnXTVsu+r9h1P9lWFOAeSdHl1IjmTUMI9SPClVQ6guQn3Y8SCB9
         8NRA==
X-Gm-Message-State: AOJu0YwU/VSC5p+E+UMsTYqohQ0Jt8Qa0dXyn1fqdHXHvqCI7GMa/USZ
	iTvNbPvSvWjK3A+8xXB9q6vi90BIe1tu/Gnh9Z/4E72/e7gMeo9LIIkB9iut9yg=
X-Google-Smtp-Source: AGHT+IGe2DxncF/tdHEyEyQetNG3qty4lJaRlXD9UVpv8DePV8y20R67SD2hJpbDmH4wko4vUgqtqQ==
X-Received: by 2002:a05:600c:2152:b0:40e:6587:edc8 with SMTP id v18-20020a05600c215200b0040e6587edc8mr1512939wml.91.1705661130766;
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/19] dt-bindings: serial: samsung: do not allow reg-io-width for gs101
Date: Fri, 19 Jan 2024 10:45:09 +0000
Message-ID: <20240119104526.1221243-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All gs101 serial ports are restricted to 32-bit register accesses.
This requirement will be inferred from the compatible. Do not allow
the reg-io-width property for the google,gs101-uart compatible.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 133259ed3a34..0f0131026911 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -143,6 +143,8 @@ allOf:
     then:
       required:
         - samsung,uart-fifosize
+      properties:
+        reg-io-width: false
 
 unevaluatedProperties: false
 
-- 
2.43.0.429.g432eaa2c6b-goog

