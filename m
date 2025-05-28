Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F3228C8D
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413597; cv=none; b=T8r8ZRIp39/BVu19wvhPfahWmbPMSGwKGFy1WY7fVOC9bh7yqMVkchW8q99KnS2vQizXkex+y/9BWoVOmWSM94x32N6V2V2aGHgkKMoZM0gCaqk7yNoVDF298PDxEiGA47D/2ARWRa9+c+ED3XJsQI/QCtHhhVIyYuik1x/kHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413597; c=relaxed/simple;
	bh=sh1cGUiYYVGEGi8YqLowXFl/GRJaaw2ICSbcRxFVUtk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kH/7lXKriaRggEoE51pGGDZT/n86TW61ew5PapyiSQAUTDJDSZl2vL/yWGXY0zEYNFPV10Ncw6eyY6zVu5S3SdbC/2frAQbrH/gLlpwQ+DFglXqheeIvTOSN74NukKoetTbUNVCQhxRa/X6/dF8UGFux64ydvLRgXa03SjB1zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QhbjGgX4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QhbjGgX4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2347b7d6aeeso26626655ad.2
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2025 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748413595; x=1749018395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=QhbjGgX4fiBmX5P9KVykKiyVB88EhJgWGY27uWUonc1g2hwGg/HuVpZcSbh0gvI+/f
         fohlZWwZFVuHl0cLlC4KxpGe6jmmgfyexUaccS8AFAJgjX1Wr9YA8SUxZ0nqenTew5ng
         WFpw54iG3Lp8xosOD5mOuHocdcZyRPJB4rdhMCqnoua8z7RApiDI5lKF5lAk+I2OntwT
         3oXf4W2S/YKnFUA4faw3NijOvtQgs4rvHNH5K8b/A8isFcSWzQ9XVDhWbP1+aFH7efbq
         udtAdsrnO63k215nYXJuFp25oDYB3vA8qNglqQQ58wYwoZ7zVwLpbP+p/1DBl8TxBrhl
         sSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748413595; x=1749018395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=DPdBAlglOj/aYK2Z0i0hlvUthdLd3nAAc1sRUZTBgCrdEiM/rrbC5gmZO+nukQI+Fz
         VU4futl9kYi6tswnTy2jLkAVMWH+rIxCWD/k6mw7zdHOImw6wwABa0o6GtPzdHv791R9
         u3aoowul9cEwPQLMYN07FlWjHHkS9Mg6qAUyTkmd//k85kOQywCj6N1xRCkZMBZLHv2X
         LZZQ2Gr3Xjl6ebQ7hWpykCCbKG69qsO45OlfTE1FEoBmSDE6yGXVwpRF+UAWo4uowQu6
         nEex/9rJ2KVzARCbqdKnPmmIcPOfTZP8E9/a1jxJ68xJ3CbjeY4mYd8bBs3JY/NgC80M
         8KMg==
X-Forwarded-Encrypted: i=1; AJvYcCXftX/FNSn/bsEh5+Y7AkFJ3YRlCYFyOD19W64CHBZgAUAnxK+xLicd+ndHnOJLcObaw4BKRD4xqoif0zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4sfYY6ZeE3I3ud1UlHGk5uf+bo0JjKVBanpPwO6gvHqUUtmS
	052nKAAe7+lBTNgVc+8+Z3w1K6Aqgoxsbgvj09XCkr+UxkVpp392AyP0Jd+Y29Iwx7s=
X-Gm-Gg: ASbGnctzk2wZlZbj9A9MGr68t/Lg9i2mN+lI9mIJgzKpJS3MHr8IMSOdOPtZrzvnyfW
	bFjgp8Q2wleqSf3usrNJzf59XOqHzGfvQWTNAY7c7Wv7K3Puk8rVNbZ6JV6z8kqjaECDw8A2epV
	4Uzc++ONEW4ZeakP7+u7FS95HVeyIDQbLbwqykUwsyFIFrxP0IusmzZolPGJnV1BVfbpk3U7Sz2
	ztvHUEqdu2iMQE7S9oLLPXIxrG5RIvtaif96lFtWVnDhRv4pScv9FM1V5phBeUvtxWT2B/rhq8Y
	ZYQvAKW+csJPugmjD86FF54RG5gylTFJWM0jN2r3XNCv5vrY6TQO5i0FLiMjvblKToQQnuyfDDG
	a/7IGhp1nrA==
X-Google-Smtp-Source: AGHT+IHMwV9pu4i8J+GgFkOBOpyMXF805fnm3igvxyjsK4pKznBH1Watf3hetuV0tb6o3s9sRcJvDA==
X-Received: by 2002:a17:903:fa4:b0:220:e655:d77 with SMTP id d9443c01a7336-23414fcd21bmr292803245ad.36.1748413595413;
        Tue, 27 May 2025 23:26:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acf6dsm4619515ad.201.2025.05.27.23.26.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 23:26:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: [PATCH v7 3/4] serial: 8250_dw: assert port->lock is held in dw8250_force_idle()
Date: Wed, 28 May 2025 14:26:08 +0800
Message-Id: <20250528062609.25104-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250528062609.25104-1-cuiyunhui@bytedance.com>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading UART_RX and checking whether UART_LSR_DR is set should be
atomic. Ensure the caller of dw8250_force_idle() holds port->lock.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1c..8b0018fadccea 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -117,6 +118,9 @@ static void dw8250_force_idle(struct uart_port *p)
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/* Reading UART_LSR and UART_RX should be atomic. */
+	lockdep_assert_held_once(&p->lock);
+
 	/*
 	 * The following call currently performs serial_out()
 	 * against the FCR register. Because it differs to LCR
-- 
2.39.5

