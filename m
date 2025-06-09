Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA1281358
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455064; cv=none; b=rQjCLyDjKCrxFhVFytt6luuRGGhqCrg7nh0Rl4gKuIdKwcDgflECGbx2ye9/y+TRAYxEvYvRozeNjuppTSO7LAyTz/f1zLYj49ED1C8nBe04QsdeUd2M/WmOVzfvwBPQW958iVl5GTSl7qggFaQcvYMlXmD+QHLcvByojtPyg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455064; c=relaxed/simple;
	bh=sh1cGUiYYVGEGi8YqLowXFl/GRJaaw2ICSbcRxFVUtk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJ1UXwwXvMUi8uOKiZ1iLvyTenpIunnQfJJ+ed5lC2rv5OTJiIEM7ni1DQqI88kMW8lQa7LQnx4P6toTb4//96fd3Bo73K1YAXy+gniCb+V16ZMGCxGOJW3RPmNugJG+e6iZOvdQbUIQCZxUO+Nw85ghJuzus8gl1zUTWC8H8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=grPvD35x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="grPvD35x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9ea8d08so30281045ad.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455062; x=1750059862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=grPvD35xZq64cksE0uDYky34vJBZ4bByr2m+BlV3839saYONI7H2WaTe379QIXyo+L
         zSGy+12JIA2r3h2umsPDHjPox1dRycrlE3+CxcbBPZS3z5/35hRCvbLQn3NRJnfyP/V/
         HyOrgBjnlsHVGwMMUHGMdBvhZeM28xldjdxh+O06K6gHSfPYHPR32bWcZZDqzQxecuZD
         mMd/CD2K/jf4iJc+XyA7mhOBuOMApCLvhAyTFb7sTckOr0rXPM9S/pOdlBnyopEVw9n5
         eR3BtNegPzUxpVEvyhDIE4bmk1bTs2qLhprpgEowDy9ZrqtYUFkI/gLbViRM/Nqsb2P1
         NSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455062; x=1750059862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=DYfGXOqJ7EvUyuX69FNJZpYNtO7lGWsyrdqbx9BFQKryjkPpTJfHisXX+MVNYkLT2s
         8+1lpwOa/0aL2ptDaWm7vuTqYhS/LvPtLIajZyZ0GSMMj3+RlAgBy5sLfg05sXIEsIoV
         ZXQS0P9Q2aL+W9hen0i/QcpIPoWjS6qeQNvQaNSgD9KOwC6p41HN7B4xhUCfVcxkRqwx
         2q36a1ZsZRVG0X8u53hCLIsXCJQ8ube8TAKlzSvYOqCQ4qd2Dn+sdnnIT1ueWCQ1ZXCf
         cSWEak7rafsV0gJe5Kw8EOlwlQkGDMgZ1q99MmkmHJLu88x6oLfbyRYVOPIH361b/MDu
         6XEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAk3PFHCZl0epo05UO1ySa6aACZcWc8e2pc1zr1tYib0gl2BiQRA0tGgmsm00A1T7Dy3ySckgHS7RnhEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRDvlbsCddSzwzR36L3qS6IGLKBb3qf+5w2eOfGlpAvI+6cWH
	7ej/heBJHeF+6KMzDWCCq4YV+WUVICPvtKMrQHYEamF/QR1uVAilIU+tnq51lxnlS34=
X-Gm-Gg: ASbGncsSWO5AIUcF9zxyS7Qw0MJ8mW3ARusyk7k1cmUvHzNcswG21Eh2KNRevvD0Zrm
	b00xPz5Aj6RMJtrq1Crg7cUuTg+uofjRBArSSGsIrbA3rxYAM3u1t5cjdITuay9EdxWoP0xGId4
	ZT5NJGRc4UX6cCPgbRtfIICnOh5J7YthsfchFsGOO0yOisM7syEB7Dr/aT7tIjKcQhjHvCCYS3A
	JdEA2oN9kxadGmE9cCB3VPuz+5w3qxugQKGG3ETQ7cVPB64DjiUM3IrgM5I8pyE2WQLO5aWxAtk
	KxbrhSl3wkFw67YHBHJi4SLqObEO8h3pn2Dvv333fJJ2nTbpqK72CsZItEiuWSNuCJjnn0zSsPK
	VyIUGu403PnJP+YQiJzmPteOGoieT7/ksb1pEZXBItQ==
X-Google-Smtp-Source: AGHT+IEQ7dRItoYtft7Z73E1bG0AQUocTaShtV8m/XxHYF/+UtJ1i4g9HW/VM1Ga0ii/WT7qcpPUAw==
X-Received: by 2002:a17:902:d48e:b0:224:c46:d167 with SMTP id d9443c01a7336-23601e44edemr172981645ad.16.1749455062090;
        Mon, 09 Jun 2025 00:44:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:20 -0700 (PDT)
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
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 3/4] serial: 8250_dw: assert port->lock is held in dw8250_force_idle()
Date: Mon,  9 Jun 2025 15:43:47 +0800
Message-Id: <20250609074348.54899-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250609074348.54899-1-cuiyunhui@bytedance.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
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

