Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6617B437;
	Wed, 12 Jun 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211344; cv=none; b=uWxkMMPjFndwvlOICugGDQl3wXFGTtPOGcDwrT4T4oQujjfxJhDD95dL4A8/7R+hCYXjqn/6uyMf+vHhEXhGodKepv2lcT3j4ndMAj3rpGydCcU/DCZFKNsGwPuzFoV3/XBfz6s6qYU9GP/kwCZ8SXAr3zE7ObT6SPAlQgzdqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211344; c=relaxed/simple;
	bh=KEigEmaM4Bgy0UfbEbKbIhA0Ndjs89ehHeiMCsBe1Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+bs284KpBJskUIn5nc/47kqpM0vtEySAwqU3O3xArAT3E7dw9wU3ez4ei8kFIBLZUvH3GcXZ7SOozszyEFYRZPJQFnZXtHJYD6eEq6kKCDd13xfhxEwiHBVz2VpyTHiruKIJICrOKHyBSfwsYDVrlF/wL1JOoWPp+pWbENKXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZPW3+2U; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZPW3+2U"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b45d6abso1043525ad.0;
        Wed, 12 Jun 2024 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718211343; x=1718816143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezWpinzUl8erONkbD/y5khH8TAKVckebPB7LaqPHoHI=;
        b=CZPW3+2UNnq+Qu9uTIJxMCCktcAz/74q05Qq5dt86z6c2FsKijcowbrDL5u8qak4qe
         TPiEqwLZAXhh1vTRElTqHuXCJkAZRlwyW9ebyZTXEXdDAl/tbT6UT6WivUbWULCPFbLW
         YEB1nY9d+KuEA6RIwtoeMfi3nmskmoAdZH69/aUPRPTRf/KFSFbhQmr0H5ujUujcZtEt
         CfI5CHM5b4vxsz8qD/EDDVHObaR0NG4kWKjjaopT4AeCipv5L3a1/5Qx3gJVdd1Mcni7
         hyjegRbeEo0PvfjnOmjQTD5LFP78lK8y7sLAWUGiw9T0AX0s9l3BGvG92fJmkAglpILd
         LNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211343; x=1718816143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezWpinzUl8erONkbD/y5khH8TAKVckebPB7LaqPHoHI=;
        b=KD0xzFFY7uH6RZxv5KeCkEcAycdJs4mLEt1pt7ob1JOoMud6nbmn2sZxFNnpdoarhT
         79aJNf0csJq0zK39W2IAoEtpedSWo1zNbX80v2kB/dbNNqSS4AJoDnWF+kxkUj54lWwi
         Z5exaoendKIu17SRLy94z53GtWuZcGJVuHxW3HlTaF+1Ru8JtzZ/F+8+AwT4Uw22QKIV
         HUj423HCjuCQdabBoSHsMu7af1zTjrehp74n1YOxCnfWqAr/GUnwOqAFfUcU72YGIWx8
         YkYCGaQYQVqozW12JLoOyTVOAZsg1ik6QBQkiYstCEgfOCR5Ls9qRtQrZYbO7zUYM2KJ
         j+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrcOu9XTjTEv7JTfoPgJRbg1wPqitCVjkbp2DWe4clKvWG+kpJZCnsJeCiUnHfB8i3oMzMXeDoY0YorHmgvHXSUPJYPRVJ7WaUzUdtvPE/SaKIwPczHdSPf3CbWb4mP7y9+7drrvfL5o17Y+6C1zjKHSya3xrgal4J3xgEgSPzlvsPWpwDOg==
X-Gm-Message-State: AOJu0YyOrn0k1fwud5GA6UPaJqc0YZN5Ucb/zOa0YToNFrEkaZdgvnqq
	jAOrZsos33G7JJOz/0gfZ7zqfJ0kOzgz5Sa8M6qyqliMn1L7dtHO
X-Google-Smtp-Source: AGHT+IEYN+NKFQ62L1iRJ2d8loPKcOYD0p4c8lW5UuYKg41ftwzbs0S8YP6Mp3I857PTvxFwJa+96w==
X-Received: by 2002:a17:902:f54f:b0:1f7:82b:903c with SMTP id d9443c01a7336-1f83b6f650emr29949915ad.32.1718211342611;
        Wed, 12 Jun 2024 09:55:42 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75efb4sm124218495ad.14.2024.06.12.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:55:42 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: nxp,sc16is7xx: Add missing child node
Date: Wed, 12 Jun 2024 22:24:55 +0530
Message-ID: <20240612165457.103575-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing child node property clock-sc16is7xx to nxp,sc16is7xx.yaml. This
fixes the following warning upon running make dtbs_check:

./arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: serial@0:
Unevaluated properties are not allowed ('clock-sc16is7xx' was unexpected)
from schema $id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/serial/nxp,sc16is7xx.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..d572b7e76c39 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -70,6 +70,25 @@ properties:
       minimum: 0
       maximum: 1
 
+  clock-sc16is7xx:
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: fixed-clock
+
+      "#clock-cells":
+        const: 0
+
+      clock-frequency: true
+
+    required:
+      - compatible
+      - "#clock-cells"
+      - clock-frequency
+
 required:
   - compatible
   - reg
-- 
2.45.2

