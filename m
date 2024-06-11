Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C2176AA5;
	Tue, 11 Jun 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097778; cv=none; b=YXbhhf6z0KXj2hHaxHmmthaYB2hgVLxIoSITltIOdXn3tSyBv0gOjx1SL1e1G6IHCO3hsadIfIhNSinpUeWIAPJKri+H4tBVPJ9V1V/EUf3BWouM8TjIjPHl/+pd3uVIoS3o2NIa7y9JJX0UQzjCEufPKO2slaZNhwcn2k2glqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097778; c=relaxed/simple;
	bh=fp+JF0PenIVfExF3Ol/7GygM77eu/W8K9n56K0f0dDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0AqWD6lGe5OqJYvgTOP6s04MD1yR5T5j1hmU56Ede5tgdnaGrQsVtYAh8MlhnOM+4J+rjAMzRE4kygVJTkVmdBAvYHzR8c0QkZut4dYHcBILXPzCgor41Scp5XYNwtHGJWCA/MMc/mzUtvxIkbrnxEYgmdz1C1kpbsTaOMUGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ1gJzs1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ1gJzs1"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d215a594b9so1970597b6e.3;
        Tue, 11 Jun 2024 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718097776; x=1718702576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsSZjJYi2Nx5uLL2KWMNdlU8KMn1DODUxTte5l/ndgg=;
        b=fZ1gJzs1PrqWMcgqeC1Y72yfwRVHJE0nlU1CEHuGuBBdZd0lpCg/TVMHLS0DTCIGmk
         MOlgWeslS1XBNW9bGfOK51PjgSAf+nkvyfz69Cqf6503oV76KMJI7k33/gA26/1NUog6
         XrYqfeDRfmPY8BirSrse6sfbwdadViCsyDZZ6Cq9L9x+lXhMmqsMz7rOPXPoECmRic3u
         scH7WCQW7uZXxGjhwSQ5hOn4GyriCbRQZvM2KZnL4Dc9NUDUntTdNCsNcHWk4cTjxFeT
         UGknZ6zEsABSi8u5cm6ETEhRQ5Lr8bRjDgJohBR/42sw0Xa6RnDSc6N8pytaWTgn79Nw
         AYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097776; x=1718702576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsSZjJYi2Nx5uLL2KWMNdlU8KMn1DODUxTte5l/ndgg=;
        b=FIMt72QHc0KaXDYxzYmpUjDJ3syRA18IHI9CBbealqQ6vRPTyciWrilSxBLjKTM+i6
         hqAfjJxgxvUwWOGJyZG73exWMipSpH76TNK6HSIvrm2CrkyWJIxpYKZz46NzxkPARMo/
         tzNM9+TR518XUMOm2uU4VAJtZvfoYDrrM3vkBjQqJ8vL3JGRGP3/TR7b1bkireBskxdc
         asIPxTM1e12TyLJ4Eex5mk33Lvk4VtLbohvqNV/3p5rWSQDkQ1h1okWEpFtqBnfmwNW/
         Y4kZu3cF1VdU1sbD9nGQn7u3mqz+v+PU3Ps0w07IaUxr8t+TsKqEXFIF2dsUj7Vteq/S
         sEcw==
X-Forwarded-Encrypted: i=1; AJvYcCViaVQIFfkuudm9ipcl0Hc9u2vUsY2FeWmVgfZGHavz/lNxDQxoSkRJUd7LNbxRuFrrPTyHaWuriuMUAY7lYXRMVNTr91mE1IU9C+7CPFHoHjbM3vNpvTIl45G3MGV/jtz237XlsFmm2Wb9
X-Gm-Message-State: AOJu0YyZU9dpwlbs/bsYEaWTKtX7aUSdLbHyoIB5mjYSY0OaLlQUV2AM
	XBDP3yrn4CkX5JLiVfe/EhoY0d9PQLlaCrx7a3yfrYcgUZ/aRDuD
X-Google-Smtp-Source: AGHT+IEyG+pk/FChVcVFXKGDVLPcTkGKCczl4p5GmwV4XsFl+Q0rny6LJy1/Ao8UHHkuMx0DRQFj6A==
X-Received: by 2002:a05:6870:f144:b0:250:67c4:d73c with SMTP id 586e51a60fabf-25464ccb42amr12664378fac.28.1718097776235;
        Tue, 11 Jun 2024 02:22:56 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041043b2a5sm6904949b3a.148.2024.06.11.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:22:55 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH] tty: serial: ma35d1: Add a NULL check for of_node
Date: Tue, 11 Jun 2024 09:22:51 +0000
Message-Id: <20240611092251.159149-1-ychuang570808@gmail.com>
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

