Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDD221FAE
	for <linux-serial@vger.kernel.org>; Sun, 14 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856129; cv=none; b=tow2pvI0mQgI+YPjYjfkUzbqqFL4+/Z+7bBkZTYJ8ChEFYCApHlGEkg+vqLESSrxch5nKj6bim+BFHSm/JCHy0ODnv25/1x8kPZ+UJz5FpycuUaENko0cK89mINjwwTMnKjd3AghQq7jfRwUTQ6k4ZEebtPecEm8x8HHdOB5Dwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856129; c=relaxed/simple;
	bh=D+jsMAX5sO7tM7JCwP4lIE5kV4IK9JY+U63ovtSevuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN5WtXzISa6Fr1ZfkGIUzB2d0DnwA5CPgyPCAaxY7ULSYooAAvwskfEd4PG/qqFJc3U/wugTDVxmdAO0fNobegyjYrdEQbbBXQgTCvdXatXZNzDv+I79xs1Yy14iRQTDzz6UEjD/EEuNaXy9V3QpGiEzk99AIZqAli2RK217zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6+UKgGD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6+UKgGD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3df3be0e098so2001593f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 14 Sep 2025 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856126; x=1758460926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gwU2jvcuEz7Zmi2rF3iYuLef34+LUaEBtsQc2TxOPc=;
        b=H6+UKgGDXpBjQelfL2yrkcSgIbnVCS+reMOREteoSOhB3VOXmfwkqpmxu6Ie1x2Jlt
         fig6llTKXCF8mTRU3fqhvxdLwgTkh1rhNwlHmAggvKNNZdI6MKIqh/9iA7ZPMIaNrvsu
         6X0nQAmqwhGAG/H+jFULf5xVHCzmjRnC5aeXCaY1R51sQp4ojphTqJKVOdqwWozY1mdb
         8J3kflnotSEtcUFJfqyFKOvh9AMj5mXB4tSsMPUzZE/OEmI+XrshBMF2B1lls6hZ0vvT
         9FZezbDrWkETuSQnUS4rghdibCXtvvSQj/0i7zSXgljhX/ZVIJHAv+CeWge7mhhScu5E
         fYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856126; x=1758460926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gwU2jvcuEz7Zmi2rF3iYuLef34+LUaEBtsQc2TxOPc=;
        b=vMAHCvsXBzoG2MISl/JxcwMKJRGDQxJCNpG7yvmm0tBmst0tzkkvhOw4cRmyiOmGOU
         NB7QAKI43zB76uGjUxlcLoSMffiuTAyQqWLin/8LzMj6P98WkUsrUnH1WJFpZpOXT9uh
         AtoEGX0W9m8IfhcIJCM9MB/tW/NCunyyJMNwhTrP8DtPhUQd2p70SaN56MOr1tRCximb
         c9dRQeeZav/w7QCBVe5f9PE0Irv1fAXJvLi77aXV2FpmtzVY5sYdPxHVbtoTmkt2wZGq
         61CG5ZqdQU7WEA2h9u3kpDq1Gk17wKIzkhZOWH2fsxx1nCIM2A7A91qZa+a2HmiRPqtA
         XOTA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Lb9NVFki0QnZ89G3EC3UatNb0dZkVQgIeLSEa1pWUVINsjpsdKzoTXUPCjLQApH3P5B/5G/sqIhrZbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUbskMtNBRm8eHkywjhq1Aj87l5nSphjzk/7TvE4BerlwQjEP
	eyK5hAQpTVKlb9UHbA5xEoo5nJB9Du0qJ6x33DFiWgSVr4lAPGn2bgem
X-Gm-Gg: ASbGncvvZ1zq/DyP1pQ1IM/b/Bak5+WAmbNZyh+fVayMJGI701AvSx+budJPqYZQWT/
	PtEhFeT/Mf62gr8Mh5MgkEfGOoO2TaXcQx5SF43ZhCBqQcHiYgiwm6rdWdnu34KtLIWorDaDP0G
	87GLQ97mbuh0B7U4YzPpKxfpKMKuZABc3K+A9kLsCs5wRLQAsB6cihPvlrAZxF7v4iQP1F+Nccz
	9PKaYeXrSLv1yEAOZ6RgtThnA/zVy3kxtaAEYI+vglirnjhwwofUp+WfSl0GwAosxt84XowVtOp
	2Amfa8ZThgYPNMkQZo2Kpi+qhqvK6tRzV3ZqGXQOFCU6MD1r6WF1KRz4R/XBYv5lhyNZg0jHGOL
	IkiJQt3UqxFHOyIWy4Wc5O26HSbPJ7X75vvQj4v3FjLFwbNig7W1sf87AZfhoz9Rf8HSecgxR1Z
	nqIlXvVRAE
X-Google-Smtp-Source: AGHT+IE7WXHLfVH2u4+DSdlsFQ3ngfdBOj6lQTdYHkhX00KlElTNErFlDHZmemjLFy+aNAvICL1RWA==
X-Received: by 2002:a5d:5f42:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-3e800683aeemr6491401f8f.60.1757856126372;
        Sun, 14 Sep 2025 06:22:06 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm7274707f8f.8.2025.09.14.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:22:06 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: serial: samsung: add samsung,exynos8890-uart compatible
Date: Sun, 14 Sep 2025 16:22:01 +0300
Message-ID: <20250914132201.2622955-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated samsung,exynos8890-uart compatible to the dt-schema for
representing uart of the exynos8890.

Like exynos8895, it has a required DT property samsung,uart-fifosize,
so reuse support for it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5..6ebe8a869 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -49,6 +49,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos7870-uart
+              - samsung,exynos8890-uart
           - const: samsung,exynos8895-uart
 
   reg:
-- 
2.43.0

