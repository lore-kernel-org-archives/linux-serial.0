Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F91D516C;
	Wed, 25 Jun 2025 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821258; cv=none; b=TceDF7r/4OwEwDvTCuTk8jzhb3HuvtgUo0W0HrHfUn0jP/u/osIji2nXQENp0+LU5yRLDEgScewiLiYESrNWTKdgIjl0DrnXHeiYFpEMd2HrB9S9PRz2KE8MPrl2XQCiz4mYt2ZqSqnqzzJyubZARayM7om1ryLQHQLZ1zdrBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821258; c=relaxed/simple;
	bh=VvtHxnylhSLrtK4u9pXQjcg/NXaQmsuM8astEtYv8TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PalbMvHWNmmpNCUhW1R3Q7Co5JsI+LoUNZy9Ri0XiN0Ov6LOX20OOlhwJsgWONN1u69EpWWvhuYrLcLKW+exl4ynbHFTnLabZaMDIO0rheFB0ooiDaAXPb/RgjvxFlYMDzu/fkpMREOKm8gBBAqR2rVcEMaGkEWqYRBMueNFJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcAOhV6n; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcAOhV6n"
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e81826d5b72so994279276.3;
        Tue, 24 Jun 2025 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821255; x=1751426055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XliS24+bqo7Xr78T7xsRrF7dkire3TcIUk88N8Pm/HA=;
        b=IcAOhV6n4LNVckSenb7XlPISCoLp1Ux/xMgk8w5Pd5mrWGbjAve5zfl6bOBGmZTQaY
         G5W4Ymf+GWAwBj3QvxLKSl2o8hI+Y5YtAJEK+X8jc2ZOupBCYxqJCaCJ+XvFre7/gdEm
         gc+G8xj4WsDT9cvSGy0NVc2xKLKI54aThn6WN6RDF05kQ/daZStXn7PQcKWn/ZDNtayB
         4QIeSmEayMLU7ntTVz+zvN0FKppBQBrRh/OXYipSPTo1H4MoCG+vWkK3rUMTz8DLEntn
         Wwyrso5cAyZrt+BVQeyleD697CCY4I6xkJtyv//pN5+/Or9t/UyLZkZWFj12MbU6rZxy
         SHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821255; x=1751426055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XliS24+bqo7Xr78T7xsRrF7dkire3TcIUk88N8Pm/HA=;
        b=fmElls98dz7XewFxXOqc/e2nzNr+YfxgSBiToqmJ//pISo7mME/tn4Ck3T45sqfSFF
         Xh2IlcgDqwKtn8bZUTq96XP1tViVj7Bb2E9tB7OqgQ+x+zY5X4M/ljZpedsulW1GHp2+
         +sVHZjhkvyWFc1CfWom0OV1CNgafxy/gS6ogHV/9viaU3qE2HR70KmYDDPPyL4j83iQD
         vXJsTKZ5XKk5QJMFSPLcK7jJkUv1k2d+/AliMoTE1m/8g5XfVWWpUPlR3HfbcDH1MOZ0
         +/mGgoCfsX0K2Gmwbcbfpl7QbbLZ7VmJBVTPuGGzgPCR+20cBNuJu+dm8QElElq8IBXM
         jFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj1fafmGGI4ANtmoJ29otnjqRVWM5lfsCXugh+8xOgLHbZDNh06ZnvzdFyI7RwXCWGWCaUrrbPyuQL7EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzIY0qD46lS1hRL0XKU6kVvuM19vDJev33FkVOGOGcvA0YrnK
	u1vrOMIPV/ofTcGMg6wgFJ+IMoar/xSSLgwbaJudzTMIujZ356v8UB85bSShZ2IWEcKPNA==
X-Gm-Gg: ASbGncujm4c1FKDhZ2NipSUhHIc5xwGp9hm1Ia4xcY4H5yTK2Ip1clPPgKrbqN7WHWC
	b0CNozsHd1KqJUIH8U/f84MIFC2ol8S0OOdJS5B6XrujryQClwHLYOV1X0aAcgeuM6jX0q5ONvr
	9hkTfxbXxPYthawcE6QTQktJQfBld1sm6E7nALxomLmZGPuKv9IFPz3UTyA6hGaG1ORau8e4KWI
	i+xmqOzxOe5VHkkkW/mjdl15kkgv+NUr531gxei+Qb33pHMOgLO7PjRYUb6MUmhRE+H2J0LGkTQ
	J0FcA7kYA+yOxQeTXhErRzEFnULUIMe+yID4lbcuxg==
X-Google-Smtp-Source: AGHT+IFfNwWQqRH8f9eAU3LTsYJgYOvzcrKu/9FLowpkLOvAw2WXPo5zL1pdnYN0kI59Km/8UNflxw==
X-Received: by 2002:a05:6902:1028:b0:e85:ea51:d827 with SMTP id 3f1490d57ef6-e8601765ddemr1575334276.24.1750821255541;
        Tue, 24 Jun 2025 20:14:15 -0700 (PDT)
Received: from localhost ([2600:1700:45b:ee00::16])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac684e2sm3418051276.32.2025.06.24.20.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:14:15 -0700 (PDT)
From: micas-opensource <zjianan156@gmail.com>
X-Google-Original-From: micas-opensource <opensource@ruijie.com.cn>
To: andy@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Philo Shao <philo@micasnetworks.com>
Subject: tty/8250: Deactivate the HSUART DMA for the DNV CPU
Date: Tue, 24 Jun 2025 22:14:09 -0500
Message-Id: <20250625031409.2404219-1-opensource@ruijie.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philo Shao <philo@micasnetworks.com>

Intel DNV CPU reports an error, indicating that there is a possibility of abnormal serial port functionality and the CPU may hang. 
The HSUART DMA will be deactivated for the DNV CPU.

Signed-off-by: Philo Shao<philo@micasnetworks.com>
---
 drivers/tty/serial/8250/8250_mid.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 2cc78a4bf..e4a5d6358 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -321,13 +321,17 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	ret = mid->board->setup(mid, &uart.port);
-	if (ret)
-		return ret;
-
-	ret = mid8250_dma_setup(mid, &uart);
-	if (ret)
-		goto err;
+	if (id->device != PCI_DEVICE_ID_INTEL_DNV_UART) {
+		ret = mid->board->setup(mid, &uart.port);
+		if (ret)
+			return ret;
+
+		ret = mid8250_dma_setup(mid, &uart);
+		if (ret)
+			goto err;
+	} else {
+		uart.port.handle_irq = dnv_handle_irq;
+	}
 
 	ret = serial8250_register_8250_port(&uart);
 	if (ret < 0)
-- 
2.25.1

