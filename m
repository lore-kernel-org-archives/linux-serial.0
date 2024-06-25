Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8323D6B;
	Tue, 25 Jun 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286166; cv=none; b=ndpNCrBDMVmLZqmftAKPNPOIN37Z5+OH5TuU0WniJrKRZfl8iTUiIxLQH7SfVmJuuGMXAWCwZS12alo5u61L/gxm821mA4YZuc5df+cvxdfK6Sw4fw84Rd5D52l/mdLUTxALCngBvVhFwupQnpQc26G94TK9QXqLoYeRS/+jJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286166; c=relaxed/simple;
	bh=hMt95qPFh9h9Zx/Ca4oF85z9W6nnZ+/2MO02CE5C0ho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spZsLNfNhr0ukS88SGFz5vcyEY4fSyXBx3kadMC31kucyAQipxn6QZvLu0VyPb56ZVoTIGqOxYvjRbse2nfzxfovk59JhKgs29RrdH2IMQC56nsoQn9Hsq5NUbhv6xZRW+wxfyIma5217YzP5CreXNOwMRGkDKxvMZFCGCpDnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo9yWolK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo9yWolK"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cba5eea69so2420048fac.2;
        Mon, 24 Jun 2024 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719286164; x=1719890964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbyQAZieaq4eQ23w2TzylROJa2sRShj9GyMl0x0ukyk=;
        b=eo9yWolKiOJ0FOH5GGbKZpORlFw9S7LGsbq+PHZ+QYcVSnJAMeqs96D/lPIcLJlMUM
         k7aTENLFSq+JJPvy8KPgXOMofbiyqxfD16tnwaMQ2EswZcv4ou9ZK+43aRnPycaVKNbP
         n8Tt/oRoWMLTYzncntrHbP7mN2xQ75RPdTSo8F17x6LBJB8ciyEZN/89AXjKEMSxqPS+
         eG+iWZMRDwzU3cHqyJYDFatvKdciBFUXfq2AdVmBYGh1Pp+XbzoeOtAIXNCY5BXI1iUY
         MuoIr8ha+9neWanB3aJoOrgruhtX3ifrPb6jH3ELa2+w/QtxnxgEJmP+z/qnGtwRyvN9
         YauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719286164; x=1719890964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbyQAZieaq4eQ23w2TzylROJa2sRShj9GyMl0x0ukyk=;
        b=EDwjTSiiC5qdAblt44y1x64XPdd01gYHN1SwbABf+lK7PBw1B0Kg77dDhxUkfUDX65
         BDxAYAFvqd2zXoDoDEqvT4FFO3NVxBNtlMAJadQAI8sC3W3imyVOdSMktBLFXJ1+Jduk
         k/y7UtaWk12njxonmmRHqsAq0vOm7tmRRp+mkc6vAiKQqxppaUyp1jKDy4p13YGDbqW2
         x9e1Ay+ToI9mOKpzLJrCQDgZ1co/iy5XXfNnEnxUBpGhM9m7z6WrW+U4i9de8ADDevrK
         NkxgPhAt1Nv+d0qSXFdV6fNOXf081t8OxM2XS3nuU8387zsDtBgR70BQBBMH07788266
         aEww==
X-Forwarded-Encrypted: i=1; AJvYcCXBb5ANozwnCn4T+vS2i4LTg8BFJiZJLEIA+FhabPL8+jvA3WLnRoOug9ijeTsVioP5EKOgqAUKq6OV9L8diCuy3qfTq/pSaAFynJcNR7WKhgFZfCbgv8IM2K8D37Kdt7LGWGpwcqyduHqg
X-Gm-Message-State: AOJu0Yy7Hrk33eW2Mg01FFCM3GQdoJWVmNuUNYPS1frd6+z+l7Xylrqy
	M1dxJNqflY+GFRCvCCIeoGsY9B2EMU7R6aw1rjUARW/y369q0Uyf
X-Google-Smtp-Source: AGHT+IFGBxRpq0C82hTfGZ42YkgflUopHUOHx0vsbP08KBRE2jMXSSB/smCiH3gnRYrK1egFXazYJg==
X-Received: by 2002:a05:6870:55d0:b0:259:89a5:440e with SMTP id 586e51a60fabf-25d016d2a18mr7438054fac.27.1719286164365;
        Mon, 24 Jun 2024 20:29:24 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067ce3670asm3288937b3a.76.2024.06.24.20.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 20:29:23 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3] tty: serial: ma35d1: Add a NULL check for of_node
Date: Tue, 25 Jun 2024 03:29:19 +0000
Message-Id: <20240625032919.73-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

The pdev->dev.of_node can be NULL if the "serial" node is absent.
Add a NULL check to return an error in such cases.

v3:
    - Added "Reported-by:" line.
v2:
    - Added "Fixes" line.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain/
Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 19f0a305cc43..3b4206e815fe 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 	struct uart_ma35d1_port *up;
 	int ret = 0;
 
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "serial");
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
-			return ret;
-		}
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
+		return ret;
 	}
 	up = &ma35d1serial_ports[ret];
 	up->port.line = ret;
-- 
2.34.1

