Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760F33A6F7
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304037; cv=none; b=C2heA2bVncw2i8Qtw/yqe898kDmupCWBf5aWDEN9QHieUEsazohKixZ9RmUeJbqRv/wxCCHNzhZsP5lB2O4TTpFdd6MeTRfxeFMbsJmXKVlY85roy0gxJB8uwcME7HI3fY9lvW40GUCY7VPxrdDIKQ5iKJNLfS3MOT4gFi7ngro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304037; c=relaxed/simple;
	bh=wBxyqppGt2i2tSwcaWrs1I6l6vXH1+ZcfjTJ0ISdvaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHz37ss4R4tdUatHJoSvuv0aQo6pOUYG0OakTndN+f51wMnomkoB9GyOLsgLcaB5aFYNZL4J2k511Pu6daguSay1atfYfP/JqTnlEHULSk0gNTxj8kvZ1R9H/bqf9pPm/lXhemaWWWXZbzGFWIH1Uh3gWalVPIBWjIjuOf+gwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUNucwN6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUNucwN6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48539d21b76so4414575e9.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773304034; x=1773908834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uedDcFbH0r3wxJK4Nkw9V1od9AYnobc+4Fv3N7Cy3Y=;
        b=SUNucwN6YSPwE2CFKcy247ib7Ns75R5Iy3NNIIgtqd16X7246hRF+fjBqNr4isjGET
         yIahl3nJ09fY9ePy7q4ebZA6X5qDGv61waeI/yOdno/tb+fOvMruSHg4s5HPQFOeA8fr
         EXm1bTJ5zdn+Tk48XiT79mgDngBA3D+u07YugCns0VTY0mCamHd+rPrB9NnZO/YQodhe
         t1+NV3KwA9c1pHETn6cKph0awPw5bquZqXaLMC+9XKA/OdN3i+Ru1pX67MaB4PhaIAZc
         8lmBQd/tWHjI0ggXpahX8EHZJP334t46zIrVx7dRKmfTgzjR1rjKQzixPc6R8e1kNWoE
         0fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304034; x=1773908834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uedDcFbH0r3wxJK4Nkw9V1od9AYnobc+4Fv3N7Cy3Y=;
        b=q9FaIWRTS6US9CstJVX6oNMJiIwghGbOygcSDhovcsfA1RnJKCHtH9HezIRcdyFnFn
         6X++uiOWE4x0Hh7ZyuqDdfNUNKdL3cMla3frAZXTeUyFytOJ/VyOkmx0AWQEacHW5Jdq
         flR8Dz6ly5ScBYBJyJfK+emZpaq0rRsANi14f5JWLMVMRjA6GxoE4/MteNW4YWYzwzvR
         MB5Dv7TdNdulynYkJDaN4wkjU2uSi5LpQRHuJ+YdXV/+u9iqfIsQmnlVy8iVHcdX2fjt
         sNDa4hyew1V9y9W22DRTK1FyFCFg+wY0ZbosAJWWCD2ypJjjO3VByCYwbcm9PqNbX90H
         k79g==
X-Forwarded-Encrypted: i=1; AJvYcCUDJKwDvyA69xmiMogp/AdaLvzb1xAuWzG6hgbYFmN9h7CrvFk/DRfHioIdwWUsj/vZKgrx1dvpzXxtsjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgNqGP0UcJ55EudGbMv2xXXqwkFjG5y1ATw/SbwmAir32CG+K
	mHZ/Ix3c3PFzlmnYuHatCmSi9zBC1IcRPd+NRm5IdtrLN9Q9fKnwL/cq
X-Gm-Gg: ATEYQzyjzqDZV9RIpUNnV9foCu2nSTas3ud4rzJ9k6zaBGbMIg0ZxNyh5cwwPIJ/EeD
	ZvT8rqhW55wkYmok7QqbwxPE4epO05DXazF4lOZ5p/MP1j8qPzmL383KZPGTG0Jcuwk3Q7tkyQW
	JD4zMdiIfEjZ5ku99KTU9CP9m+SjuG1vVZclkfNeTfz13eEGAJJcsiPOCyrEWbtONj2Rh3u5bx/
	jXoR8G2A80MEmxsqxapzJy8Wfn6XjABE+DQR/J7H5ach3v9g9E3XjHccPW0QQCepV0ODV4ibo+w
	0d3NlPchKkTpIOxF3rHDqjtubzEaoVIfxorxjTMz6L5qVICa8bR3kL80P3BO4iyRiw/cuawiag6
	rggBAOb4NQYFT8imCFiV60oSciwUjFKrojopij+5oqO/ThVh5v+hq+5cDk/tzy1XUnUvhzZTAi1
	aa60b7RD7CYADVqaKLB+tKsfeks58UbPk7OaNz7Qr/edMTEEckK/+iIGbeYQ==
X-Received: by 2002:a05:600c:3b18:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-4854b0b32d8mr96124265e9.8.1773304033517;
        Thu, 12 Mar 2026 01:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eea84sm65925065e9.1.2026.03.12.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:27:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 1/2] dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
Date: Thu, 12 Mar 2026 08:26:58 +0000
Message-ID: <20260312082708.98835-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
References: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the serial communication interface (RSCI) used on the Renesas
RZ/G3L (R9A08G046) SoC. This SoC integrates the same RSCI IP block as
the RZ/G3E (R9A09G047), but it has 3 clocks compared to 6 clocks on
the RZ/G3E SoC. The RZ/G3L has a single TCLK with internal dividers,
whereas the RZ/G3E has explicit clocks for TCLK and its dividers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index e059b14775eb..85ebb3056066 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a08g046-rsci # RZ/G3L
           - renesas,r9a09g047-rsci # RZ/G3E
           - renesas,r9a09g077-rsci # RZ/T2H
 
@@ -145,6 +146,31 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-rsci
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

