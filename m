Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5841E1E19
	for <linux-serial@vger.kernel.org>; Tue, 13 May 2025 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104155; cv=none; b=jn5782UnAmuqrcNRdR4rjRteYCAoty6eRzHbZrFnHRQaw6BoYiM6H3zP1zpGcif2e0HhEgnNqWtyapJPzCh7FyQ2tUHf2+3bhhv3Dns0Wtz/VyQTRhNWKOGTm4mjAxBLJj6tYcWur8nohSjYk4tIlxoYxH8mxfZX1IeNYazEoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104155; c=relaxed/simple;
	bh=OerbYEH9aan42hzzV/wRELUdBfgesV08G2VZ/0m7zSA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2kzg+f1LQud6NRiRnQOTYmYZyBUomj8W0mmmtKvH3sn74mnDvl6dzg2IPp5C+i50OEt36N/WUZoFcDetpfO3s4w60MG6C4xjm6EC4CoNiEpRLyc+1kUe5dqzGu6Wq8bqjJJ0LTcRSlYHEZkH38QXVDtu4ywNOEb1j/TJ4S605k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KAiderUZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KAiderUZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e6344326dso51425525ad.1
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747104154; x=1747708954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmuAXvmJd0jC27AG4EPSnG7fBWxyoT/ec4fPaFjkqus=;
        b=KAiderUZhAAsWRf1f7mnKjlvQuOVt5U8HVtKhXzQJk9mEKIJxVHGa+S+UqS5pMAgMb
         IplFZeFxGm25GX0iP/5di2OA3ftlwo5ENdE8Z61A/C30xOJagianmGmM0EjZBdCT7f1M
         ssqsQVxQDzEB239YzFuNTgIXy3OhI0a+ZvM81NOp7UwFOyRCYP/Fuu/g61Eumgl9JEqm
         Ywgw/843qep85EECIIrUnqNGbD0p3XYYBYACqs9yZjkhBWJp/fFcxmdSdXiRW9yzKedt
         E3K4Mu36ZXvVZ+BLy2dOJCCUsFd2y5PugRAxmBDAP6CmtyOqS4j+85JlOvUShRxRmK12
         +Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104154; x=1747708954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmuAXvmJd0jC27AG4EPSnG7fBWxyoT/ec4fPaFjkqus=;
        b=M6OOtIjal+v05PDLwa5dt2YtnVtNo4XWDkWxKAbVLZ7uaUpGclJXWcCM683bbjWCAH
         LGT0UFHHiTulYLwZRJpnIjD3PYla3BFHksSHmpEKTGWHfs0omdweP3BzRbstA6JeRTXn
         by5pqdkdUtitudk8ikQm+WTe4+jgUVbvCDTV9qISJZNU0vw5c/lHZki66M2Z/AsmZ0uA
         XcbEbo/pLDvlXKSAFnLqzTz+/xrio2fYj0dgAq1hAkSLcXmFHS2MMDhB5ltqMAQitEfR
         HonLNf71rp7/4LtFBPcf3MxlrpFyKORXrCuQsHBWD9alRquroJpnuDs2zGIbV4yGYCNG
         XEDA==
X-Forwarded-Encrypted: i=1; AJvYcCXhJrNES/BXAipEn3iotVanuVPTS9joYcAXIPgKDLNxxrBtzJTgUbfCZHnwFfQsxc/6EC0J2c5KkTbfVd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyST37aIUB2FNbuHhL7SFT0ut6qMIPk6wlpsq8k/JaRu0kHARE7
	oKhZJl7cSD9kH4W9Gqy/Q/zkSbpkXDUDDQW+k0t277U5447rSb8BnJP8m1gH5rQ=
X-Gm-Gg: ASbGnct6X42wy8Fe2+xxh7RNqwRwAQ8r+i69i87+tx1OcWvivPxhMYAj7zWwszPJ0H6
	zlYFF8l786qKUgo0pZb+I6lFXznwlMu7XLSGf4Z5HGOalt+M5bffc7r6HhLvFfeSGkOhy4oZS2h
	Wk4Mj8he3DrcnWXQWtiaG/MIlhrxtVigkAFBZL3J+r7SSzlUCdlbYGIvbsnk19Gmc9RIE93CgRY
	r7JAOMSkAk6nsxsd3oInhYzOJxhA9EORbU4jxFF5nIRQS8I4PDyrhdAjkM2ibSicKO4t6CTe1+A
	abXpYlxvaN1Vdqf4JR0gS5e2trYW5B7tse6yINeyNJiQiR3cM+j4ldHo9DkFb79rW+daVKpwOb3
	oiuUu7A==
X-Google-Smtp-Source: AGHT+IEs59cG72mc12iDWVwIcXkohQ5FyOzxTaDCa4VbpdVsHcblBxos6sWT74Dsmk60b8uDhiwlMg==
X-Received: by 2002:a17:903:32ca:b0:22e:5e82:66fa with SMTP id d9443c01a7336-22fc8b3d3c6mr232138205ad.19.1747104153633;
        Mon, 12 May 2025 19:42:33 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829f532sm70592595ad.228.2025.05.12.19.42.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 May 2025 19:42:33 -0700 (PDT)
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
Subject: [PATCH v6 3/4] serial: 8250_dw: assert port->lock is held in dw8250_force_idle()
Date: Tue, 13 May 2025 10:42:11 +0800
Message-Id: <20250513024212.74658-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250513024212.74658-1-cuiyunhui@bytedance.com>
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
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
2.39.2

