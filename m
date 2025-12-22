Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD032ED23
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766420956; cv=none; b=tCEgbvncv4OYEiIQ3jHhkEDRbY8itSYu0Ei3rxo17XtOZEp7+ZgpOAsWOR0YXGPc1Gy5iEfry0t0lIi+Rj7O3E1MJ9deSOWVTNrj+m8Rep1Ku6o/9TWY3MAtR1JmWhQzoobsl4dkVGXWuAfK5P1RbosKfwNMHuhwKCeLaUwq5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766420956; c=relaxed/simple;
	bh=Dy/iCZc591fTXM1NlurWurScZtX+CWiYrJf2U1///FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJVllkjsUmPvR35GrZBE+qKkRPwBxP9aRkcns51idfPLRf2xijw8DH94wq9hCVDqrWs86eswl1xmujWJhDxPghfqtv6+xxBDNeptMgr2RO4dVceWcU180Edt2GO07Sju+Due0CtZwNNkE4VaHlWuaqtEecStI2CDkq56yeU32Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwW0HC5S; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwW0HC5S"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2098540f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766420953; x=1767025753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVVePL6nnCyJpfh1p8QmA9Q/bSlZ1ZK7e8Sn+qKYGBM=;
        b=HwW0HC5SgiNK4dVCV0Yb2HzEprKFc1M8pwwliM6LQ1SQcWKWNC1EPRafee1YPaUM8B
         r/K4JaqDFhQqh5QBGO4fJnBLBBhzBJt+e5pdTlnUI1D+HLSyOTwvw9ZhEPPl3FCZjIEL
         +xRfMifIcCVM0K6ZkFkLCp6o9dSL0N6fgx6n/sOqs7FyhCXGJA0ynk/M5qAmtcVPwr7T
         y5IgvV1dnNkjwcEHAawiRS8cCQE62mUiDD2srUY0iXE+wev39SxnsuWQV58AL9l6xRNr
         kvyJGnAMputCj0OKgNLB9VH+OpjGc6gTmc9NzDtqNRCl8DtFgT9a5HDoD6wt4QNZG+Bt
         9PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766420953; x=1767025753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVVePL6nnCyJpfh1p8QmA9Q/bSlZ1ZK7e8Sn+qKYGBM=;
        b=Ov2JS3aqvWVMNaqmsxDHClE2rHGO/9wMiYlb+0tTF/OPqcYJcdGfyApJbWUMFhkPFn
         100jdfd8u0gzBeks0QbnuSb9OM4iH2obfOjyYmGfUn8yLPyqo2OCFkolGaq5t6m3U27J
         qul4pKLw4Lkrn7fZEH6qcBuTfBTf648HstRan77zSEX6CVYSKJ97/6jpCvlK7x/4xqo7
         JqVIURlXjS/re1xL2iry2S1DO7e5GYZ/I0OTt1sZ6mQp5bPU3zt7XnwacoMxRlm8WUc+
         CZBSNyP2dIhWMEGb3CyVrqrsGFN8GYq1PnDezv7HXToNeFX1TDoIzxy8XQ6fFwpU9/Ki
         ktbA==
X-Forwarded-Encrypted: i=1; AJvYcCWywRLYqXSrAz+WW8x5pPOnyv+IZQDvDnan7DHYXrGbqM5YbPieRrgvGt+1elsy41ag5gD9YWOEthUIZYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvvoKsq4/taMO7if6BvwZcYgYgQSLGR0tQAWW8xu3Xe1dTFmY
	/EyTczr3Lgkz8Le7IQMQZUtZ0khSbf6X0VSA0A12coe9UBPHZ1GffK16
X-Gm-Gg: AY/fxX5dVT5glBmSYKfACEjYzqWEe6LI/GicHKglbQq2dXQBa81T2OwRvdZQzutMqMV
	n9eJwSGdOBSwKhrCrF2sNAnyPcOWSU+rPXr3SL/WgnUiqWKxT40Y8aF7gWDvpjwhtAN8d5ZXtym
	UPNBCLzcQPiI8w65rgzxNSYXpuj1x6KAmXExdw0ThOWoZNnFYdKqXZmw9gLU935IsRGzRXT+LOF
	9377kfYOz5gDQburA/SNrhdiqkJTHcOfn+bsc+pHogoT6y55uhJ/DTIWOEAGS6hRF6OmdvcMUOe
	88XOq8fUL9ixNUhyahCpBzg1QuigZkr+vWo4ekvMJc/e6K18Nq9P3EAq/yqXhvxbadIfLNVD/1/
	TL26Am5q7514fm6awfR8vqmt2MxvPddoABFOQRlKv8zY8RxT+hgcX42lOholyr2PLWiT5NrLqeF
	2WSmIn+WnplILicktpRkUDtwopbi8zPPX6AVYw3yKQBz5NqPu5DsUElH8JiYzkkTXTmx6hhWUnb
	INA22aPglloDuPfH33YP9A=
X-Google-Smtp-Source: AGHT+IEmzqCgGbE7s5GFKTMZ/TEykGpjkUE/yylqKBjpiGDrTr0RtJjyPZA2R2Gc7XIuClmlMSpg0A==
X-Received: by 2002:a5d:5f49:0:b0:42c:b8fd:21b4 with SMTP id ffacd0b85a97d-4324e709d72mr13923252f8f.57.1766420953079;
        Mon, 22 Dec 2025 08:29:13 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:4dd:df38:7864:a996])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08efsm23213962f8f.29.2025.12.22.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:29:12 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: serial: renesas,rsci: Document RZ/V2H(P) and RZ/V2N SoCs
Date: Mon, 22 Dec 2025 16:29:09 +0000
Message-ID: <20251222162909.155279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the serial communication interface (RSCI) used on the Renesas
RZ/V2H(P) (R9A09G057) and RZ/V2N (R9A09G056) SoCs. These SoCs integrate
the same RSCI IP block as the RZ/G3E (R9A09G047), so the RZ/G3E
compatible is used as a fallback for both.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 1f8cee8171de..e059b14775eb 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -17,6 +17,12 @@ properties:
           - renesas,r9a09g047-rsci # RZ/G3E
           - renesas,r9a09g077-rsci # RZ/T2H
 
+      - items:
+          - enum:
+              - renesas,r9a09g056-rsci # RZ/V2N
+              - renesas,r9a09g057-rsci # RZ/V2H(P)
+          - const: renesas,r9a09g047-rsci
+
       - items:
           - const: renesas,r9a09g087-rsci # RZ/N2H
           - const: renesas,r9a09g077-rsci # RZ/T2H
-- 
2.52.0

