Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF12146D76;
	Fri, 14 Jun 2024 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343960; cv=none; b=DaIE6CYg39lOS+YbsAI9Cl5YVtJjzcG4O5nfgSxpMtaukc6U1PIgBx2BF+1qK1hM77SOZCk0nd7mRmJSgi/ySqFbvGZ8Vu21bgfe0pfChJnwPUnxbbgfP6kiYgsU0iIY72zsIhJipJm3jVKv8xhkmXduWPiX11GOR71bvNrcybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343960; c=relaxed/simple;
	bh=cwZyF+XEGrqGRrFP15+iF9G07AtfyPuX0yJNnxRLfrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7+eXsF5pq9hnrsHR+9UL8HboFt5aH+mnZeCt3h9byOm685c+ijlst79JJ2MS1UgJFOxeYXxY5FBjzTp+M6jeGGp8imqKXTdpkTtapnYukKfRy9Urx9V7sV5+tVW9ndfs+qB1mAHx0lpLlV4L13kd7kyyI69tNb24xL05aPnQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pek3zBe9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pek3zBe9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso1603478a91.3;
        Thu, 13 Jun 2024 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718343959; x=1718948759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFWPlulDgeo8nuyNyqmM5xu7CgTaxuH0bDTkaYa0rIc=;
        b=Pek3zBe956DKVArJdOPXQLT3WpldMHRmY2tx4QLUzNYPAr2cTCA1+sP6rnC+/4Nhmv
         YhmVqVPjnzywsRICbXQvQkdMLLvbOryz/hle3Srw1wzCksLUuEOKWMJxjAm78ombAWxE
         QK+NVqAQmrsWvvmDGblVT36Zn99jmZPwqnTNyC26bay7sf6ZG0Rs53KPOELUgAg+/waG
         n/QUVweLOsCP3jKfyvCUTkgc0d2Uf7tyzSfyZf/pleGcGA8jCjDkPV8us4fxqlykwbOa
         eonrtwFoCzjtzqC+3OD2RzRVZ8vMn8dVnBU4W+2LdNL6SBFuB9wP1wnVWWy5IR3njwpF
         teJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718343959; x=1718948759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFWPlulDgeo8nuyNyqmM5xu7CgTaxuH0bDTkaYa0rIc=;
        b=Fb18W26lAUP8+PMl8VKTTbBIPsAFBgeIDPsslHuSArGhpjvZ7IQxW87kDYR1bxTjXM
         rlor0c93Jx1t4JtIJDmDwToxj97Glo60OzoJYYmXFGCUREJxLzfUd/izjeUjfV6c09RZ
         +K7oi/5LOGtQuA+glGgrxINaCn1jdmyALWslxulBL/4YrZr6xTd0qsLLUuK2V6goDP97
         IYgvfCNfVz9GuMkzwsZwuvvRhQKvr3a24CgAIn0UJciIiYO3oqeXE3IGd+vc120NATMI
         sWnIY7lQVoXT+MSf4m7TzX4co/CsQ3cDbptEFdvYnJ8gyeJFjmsc6WD4dDESzOPxQmg8
         JWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxpwsvC0tlQwtSo+RGdE9MI3KA09uyFLzmGdAcd7pBk6WjXny1C2v0BmRR7rXChiyDApixcpbBeV37el6iJH+fxQr6EjyZ9QlID0DimdHADaR/aCuncWjljK3eBCscoziLi75G9XzJEf7M
X-Gm-Message-State: AOJu0YwU60khRZyqMzuDlzBZed1A3NQRtwoH66W2O9ckc5L8i38TJBlg
	L/aptLiI1rY8bvMpAE8xLD4b9LuJ02si1FbY2bk23zAiei0vOCOK
X-Google-Smtp-Source: AGHT+IFN83p9O9atJzcMT+s+gHJY2ZZ2Q2NH1n5vXQA4BDtC2yeINZ7PMPFxt2qa8rJKgBFabUYAnw==
X-Received: by 2002:a17:90a:af04:b0:2c3:4ea:94bc with SMTP id 98e67ed59e1d1-2c4dbd440a1mr1581525a91.47.1718343958670;
        Thu, 13 Jun 2024 22:45:58 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769c8aesm5115536a91.39.2024.06.13.22.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:45:58 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2] tty: serial: ma35d1: Add a NULL check for of_node
Date: Fri, 14 Jun 2024 05:45:54 +0000
Message-Id: <20240614054554.80-1-ychuang570808@gmail.com>
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

