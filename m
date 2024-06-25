Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE383611A;
	Tue, 25 Jun 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297696; cv=none; b=W52WvXfX1O8cJSHMT5LBYKxye0WueqQtJQziyCN+mdNSa9WAxTPtiZ6WZeblvnjHDAJa1MJFdxlpcelfMQTBsH0IqRQBMNDasX/VH6GaEz+ZWsqivTYultXfPtDBa/Ut4NHnEInS56cJtXTm7XGuGwmKWkQwxApne6y6kjbUu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297696; c=relaxed/simple;
	bh=SS9OXazpq+Dbe9vH0PFJ2x3IjkLpsy3HIL/GYHKk8P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JMkk7PKO51TQ793L526+AKWxcjeBP4nR8E2hOplvl+UHFB0asDpvFvaJDnCtYdqtAKF1idMR7FXAfmDc+CjknVx697B/qeeA4XdW9EN/x9VmNSUHSgANIWYI0dk6K1YDR7k80DWfaEl0X189mN0MgLv1Pd+NYyGbVSCWNlSvCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mItU8yRL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mItU8yRL"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9b94951cfso2959288b6e.3;
        Mon, 24 Jun 2024 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719297694; x=1719902494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FiSYpkCCJa2ynYPvssadIcTJSgGBXf+md4v4r1uNPxk=;
        b=mItU8yRLn/7r5ShQF5soBqRHN3HGwIJQVuITnWHfbacQK02Dxj4PcFHt/sy8RJ7pwN
         tFqNl8XGFoyJXtULCzZQIXycU/6BHCezb8ynLOhmBLTsUAMDyul44YMpD/cMcjI9dKnG
         rKTKUiRQhem2sNwsWO9uuR5CAGjHqU4/u+ONN+H4arYVGyCg7N67jc8sNXq0Sr/DmbeE
         jy66Sf70qwvOx968+m0oMbBTHgqFtkcigL3ffsTL4sBdtwfYENj6apCpPBTbsbt6hWIM
         TKgaqDHID/JPqazDab4QcFTLQaRVLLehRJozrmX+yYtLNtHIL3ZlWC6cUABVVogUSRW2
         Bmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719297694; x=1719902494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiSYpkCCJa2ynYPvssadIcTJSgGBXf+md4v4r1uNPxk=;
        b=QnNy12+jz8HYXnzaD1tpe4O8HMEQDq8bxmxK6aymgtfFNBRS7NTGIDxqOKG1t++IR2
         3POePxz9zEU2xHWjnGhgLBjHI9KBxJrzVngJTKDXff7HvzPGC5Sj04XOvt3wUVS0eZ43
         Hv5fA9Iagg+7kPaR169vKh5JZ1j+wI4wmbkLWWmixuxg1YhFp4ZgUhh/BatfgXS55rLK
         nADLkm26ZN6K2iHjVghPvmAnsQt6j6WkF+y76IJ5RlWRnyZllpf093BmVup5zdw0l/nX
         KbcuM/8+CroEVYZANkaHRvQ9mIMc080KAtRDBl4EzSn6LXX2jNUehYcVXAEH5GuWmWwA
         uycw==
X-Forwarded-Encrypted: i=1; AJvYcCVCbZjOp5nSWCdCmqQte4sEZFdkPDCaQurJSG3ku0uRdN4BJYnRMroyHYUOD9HfPV16EdqVSIICUEiiTrDW2vEVQi0RnjNtatKildpt2Kak7pp8KZsHLtUvqfktHjRAynBOHqY2xgt5v+Hd
X-Gm-Message-State: AOJu0YzodgMS3PZWeWMpkeyUemHl9DLDjp6nCv0V61+inoYcVhitCMYc
	OuWur+JmiDBC4vkUuj4Z3LaxULsS4Cf4CFf5m65d2AoxU03SczfZ
X-Google-Smtp-Source: AGHT+IGmIpEK4h/noSZzXdtXPUoa2gfvobkZ9aziSZjqfvV0nYXycfKGs8LIX1ntFV+Jz3PSf+QVjw==
X-Received: by 2002:a05:6870:1654:b0:254:affe:5a05 with SMTP id 586e51a60fabf-25d06c1c1ddmr6826956fac.21.1719297693828;
        Mon, 24 Jun 2024 23:41:33 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512e64afsm7317879b3a.189.2024.06.24.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 23:41:33 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v4] tty: serial: ma35d1: Add a NULL check for of_node
Date: Tue, 25 Jun 2024 06:41:28 +0000
Message-Id: <20240625064128.127-1-ychuang570808@gmail.com>
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

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain/
Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
  V3 -> V4: Move the version info lines to the correct position.
  V2 -> V3: Added the "Reported-by:" line.
  V1 -> V2: Added the "Fixes" line.

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

