Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB48248F62
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000234; cv=none; b=gGpzYprOlX8oQd2uySTrxj9rQ4qGe2g/jzWL1J6h8zQtNh3X87Ep2G05i01tt4u2LNxI2pOEx2nYNQ5GcU8OlxlEVhJLLa2RDXlongHCfFckGpHpHC0fZnLecJIDnkHYCp3BuQaFfHlzISgatg5/rdMEWQ+AWzZ7KUnVpT7ZuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000234; c=relaxed/simple;
	bh=REJQ7rBnQJpIiLyuuNmPWn7oGf/gdM2oe6iZ7QI5fPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S930FcaNCmPx8lB7Ci7iP7fERCIK3tdKcW9gZp+X4tKLduG+2+MrJEirxUzgSGKLP6y/TIPqUKTuskWkK8nviyOvnIiSG+XtvGwJCs7hx69G9pz+kZgNrTuKcAGXqpEJcaSLUXuqPz3QCKkjJwlftptvkHbJr6qSjVd3XWX93/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS/mMtvj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS/mMtvj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba6485d219so102165385ad.3
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000231; x=1780605031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDIXwe3ooO105k5CTV06eh6doyUKsBOeZuBsSpw25Kg=;
        b=MS/mMtvjnp03ioyXiHILF5XAi5LwUfRGlWhBZbKk4qzmbLmutpOmQ2PHYWlELKacOJ
         zl5hkpR0y4iCQ5MxEEzBHzkGA8pqYHG6+6UJom5y7170ziFxoumf5KwRsTigaefRniBB
         tc06+Qjm+Mk+N9vPE4P3tXDnpIhN+FOXtxew+XA6o7efKxTRBZDetsx+vZ8J14a1Ssjf
         CmxmuT7BxsJH1V1xm6br0W1PXdOwFR9JUEQJ5wpD2gAOQR12Y4hiUH5EgtptUb9C3CiY
         KB4K7rWIqKBL8eptk9DJfD17oOvHpMnSHHZJaLhhJb5SnU7swGWkznRAXs/+vyBlKg5N
         udYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000231; x=1780605031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDIXwe3ooO105k5CTV06eh6doyUKsBOeZuBsSpw25Kg=;
        b=N6BAewG/R9/XnB/8k9y/wcEd8Ya7TYmgG3g0kePD3LPNaRScq6OpRVnGej+Z6m8zp1
         3BmNIig1ci64AI5UsIXdDT/ys4mm8e1lq83OYp37NxjH29wVIT5ajq9hp4xb06KJg0UQ
         36lLAjlPSh/bIhGJ7unCPLz8xFAOIPN2PCiaKjfZ7pnjtQo2AIoQNS+bTx6M/vQOd5/l
         J9iVBRPrSrGVvb0L5yzi5goo4oxflh5nOtDgG9eW/VgF03TruDd4ZOG22Tfw6YiY584N
         E0CbkY4UGvy3tH3bnbL1BLxwblhNuPITX16rKoUKnui3QKX5+/xfP1dNtqMl7g0NJiwX
         AbvQ==
X-Gm-Message-State: AOJu0Yzi7132eEesK2DLt2iqtj1WvsDxoKlfE2ziOjNSZcOmCTtU78HN
	uN8fZQnNgiS4yCD7Cp7zmF/0cdKb79M8Cu6mDU9St0cvIPVZyRkcVI1dHE9bUV4F
X-Gm-Gg: Acq92OFfQJY+IfPitlRFSoa4P/p2KOHHqOZOPqRiQvTtrHi/VsLdOvXqfK/aKlyiHYS
	EBpK/npRfUU348Ah2MDwPKowmsI5dGmbKvIghmLju/h0p27fmEmn+78L+SZQGzjYcQvZj2vFhQL
	yK5+RRHVNPW8x5YI1NI6IJfcfS8B3bnpO3kxGFeeu60FRmzd5ULvCOAY1zDnpBCeGe/pqr3h6xP
	oGdQTwWFhdN1JVEnSBD7DDR5Fm/eQ9ACLgwlUfcMFbtPrQ5qoHDFUS8d2UF9+qfovzb5AQtCWZH
	6cnglcS9jRPxfO8hoRr8ni1l997Ej4XZbARPYeZXmnAjgj4bz3k88DDGYJn48JwQtJn3s9KlYTn
	e6eXkzzqGFX2xAY03JBr03Z0Qci28lZYmVEZaCPdv0JbNIUcv4wgs3O0RCgZHc/5Z5o0keo3IRq
	8DV5cC8A5422jBcQcZ9msm6eha0nWokI+nNof5uI4SIs7qq/DH+4nDoVeEXhqMrhTMWQDQaWmFS
	/DdH0i4r+KVseF+oHjVl2U3wsfl8iH85aUy8BVm0al6DA==
X-Received: by 2002:a17:903:2347:b0:2bc:d1ec:9f09 with SMTP id d9443c01a7336-2bf1ed5e4bamr3535035ad.40.1780000231091;
        Thu, 28 May 2026 13:30:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e604dbesm1786475ad.25.2026.05.28.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:30:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH] serial: mxs-auart: fix 64-bit cast in probe
Date: Thu, 28 May 2026 13:30:11 -0700
Message-ID: <20260528203011.137338-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_device_get_match_data() returns a pointer. Casting it directly to
enum truncates on 64-bit platforms. Cast to unsigned long instead.

Fixes compilation with W=1.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..de97c0f74e7d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}

-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);

 	ret = mxs_get_clks(s, pdev);
 	if (ret)
--
2.54.0

