Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC52344DB4
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278930; cv=none; b=ncbJvUi3I/5aV7DxFajD6KSXa0HrsKjjZxwPHQPlSlJdco3Lf+sy4ufaLMY/ibJDlG/L9LeTJmsMxPIor+mCDffSTt+ADmhTwx9IA2BtlJUIdxrjun9nqYXsqM2MQdI+xwkPNJLnkpT3UDwwE52KumERZcAOuvztZg0ImY7Z7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278930; c=relaxed/simple;
	bh=8jS45grgwD9AuchmvvovcOD11olnelHkn7VzLhgRL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5RK5ZhpAgHqVDwPdckbIWNJcbNpvbMWQ0zBAToeK605fmEHpeBRGlnBNyYNxw8uYOA3qDYdynOH8y2727PWccVq60sUhrZRIFQOEGFQ5LSwZgYTGkhdOl13b935c8iGqQkivQBUcMzsyWx2BkSe1DTJCLQE6bAYkawlXK/wqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU5MAMEb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU5MAMEb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaf43014d0so43424705ad.2
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278929; x=1776883729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpeiV1qmh0y7e3ItJrqeH+Ewf1lI+cym8OkHjOuiZhs=;
        b=MU5MAMEbkCnG5CbixzwSyXZpxsGZ/JYwOLnDO2lTMzGMHQbkkqVPaZkfYLITraDSjo
         HDDIAT/OASrXQKALtTksXY8fIdffwf9xQdPT/B1pNF8QvgPYMNcetnPSN7yzoL/g/Nhd
         EZHdwYazAK96BsXerbtk/UeG2le2KLZXLBFFZm8dZqSDpNEFYIZu8FHW1ga49CjZMVlc
         3wVf1a+dNSi1As49qW2Ipfw/E9xZXw2lpzED8gnNZFW0rV84vnVa7+etRKqR+JMLeFv9
         44kHHZEKYho43addMMiVJcUaK0L94pZZ+IsLuSErLqeOWG8Q6Fo5tIN58TP580b4sv7r
         DKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278929; x=1776883729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpeiV1qmh0y7e3ItJrqeH+Ewf1lI+cym8OkHjOuiZhs=;
        b=Oceb2t+A5BP6UAnkqF3i8WKJsN9QBCc8+D1fyPsHb/ME8ln763HNVyYTJnE1vMGxNy
         0pO3YKvR+DC19S/9VT7oHMF+n/iMJSH+TdflPuKBivHSeF+OEUGu/LSVWwrx7QUTSpSe
         +le/0d3v7+67bxy+QiFLDTVMRrVkPXlDU/4W1uurLCR/qrBdqR6XODYssCTlDnoiJr7c
         ZNQU2OvZyKdC5vV4+lKWJ11bGGpUWYPG9TiAnEzby9tGXDnPgvy5hjBowYUMIg2tBdqx
         oDZabL+knXQFrhKfr7RKt4egJYenK6sews15elW+nXSEK9pf9vjmTb0x2C8+kmahbI8a
         pxwg==
X-Forwarded-Encrypted: i=1; AFNElJ9KivZGre+kMvSH+ZniUWswbKNx4wkHMXFIX9LZ3gx+mULZZYdb0z82rdhHpVTu3K+QCvHGLgZQ23VEtrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5O4rTa69L1L2sr2cMbvNpwCouXVyQcGZ8Mgs81bwkjWBzZong
	HQN2YNU3QIc+Qge8TmYdXEPbr0xpyf4NCM5FaPrDRJ6g6MPEzLydk5tg
X-Gm-Gg: AeBDiespPAz134UWUQrbPlj1V18S2Xq1a/lRVO16mhbet8r+Izev3lSqTN7VJA6aeHo
	UgnB2pwrMPONkm/ecEMkdpJdCjFPF+Pe0Mnw9ANc2I2eEmYirqWrD9An6g1nLYgVMrYwsctHw9n
	skCHOyvyxCO6gabKqe0abusemMRysVGjVPPi8qhgMGAasQ7LpT3R/ribSteIDLTqPYQXEgeXIFg
	+I7wKzISjZTlXbzLj081UZE3QAhW3vqSJflU6Il+7kECRzIlfCGRtl4XD8BHTDwEzX5FH/aXSUG
	KqQ9KSkWPdEny3nU9aqhrk7koqIJw7IkNy7nPokNC+O9HjBM4E8ujOXEXrHyr+37f+rAUTF5AvD
	TT97bcvt4tuAJAa3LWjp1GMIoe825+pJBrlJunq1+nlHhMG5eXDMFG4tEHhc22Q/SWy4Rbg8aVO
	2ZgvdHX/7fdS70FylLZOzUdJVqDK3BxC9/Meo=
X-Received: by 2002:a17:903:b0e:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b45ceaf83emr141942895ad.4.1776278928666;
        Wed, 15 Apr 2026 11:48:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478109a4dsm29936525ad.18.2026.04.15.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:48:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_fourport: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:48:39 +0800
Message-ID: <20260415184839.3796326-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in fourport_init(), the embedded
struct device in fourport_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  fourport_init()
    -> platform_device_register(&fourport_device)
       -> device_initialize(&fourport_device.dev)
       -> setup_pdev_dma_masks(&fourport_device)
       -> platform_device_add(&fourport_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_fourport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fourport.c b/drivers/tty/serial/8250/8250_fourport.c
index 3215b9b7afde..a65bc7316655 100644
--- a/drivers/tty/serial/8250/8250_fourport.c
+++ b/drivers/tty/serial/8250/8250_fourport.c
@@ -34,7 +34,13 @@ static struct platform_device fourport_device = {
 
 static int __init fourport_init(void)
 {
-	return platform_device_register(&fourport_device);
+	int ret;
+
+	ret = platform_device_register(&fourport_device);
+	if (ret)
+		platform_device_put(&fourport_device);
+
+	return ret;
 }
 
 module_init(fourport_init);
-- 
2.43.0

