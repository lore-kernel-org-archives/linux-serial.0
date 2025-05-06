Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786D27A939
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530624; cv=none; b=ivR0NsuNuO7rpkU8pLfyNwB+Y9NepeEIPWnj+yXL6PfDTZCkPxhYLq+iPE6WGHxDH5XGBTN7/YErswbDt5gpmVGfcVQ23xugVjykmsOfImYk9hhQy3QLzPVSj03jPV3rUR6DR2fAo7V1ZpYKiBE8hgaQk3c3uiM1PNeeIQ+Jv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530624; c=relaxed/simple;
	bh=Av1uBZ0UiDSTag4cG1ZoMvZ8Yr00ipFA4jvwEErTnds=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfAoqxZLYmDDw4UYbF65f5mFwWH9I1RXBKyj7cGASAmO8jV3MvGLDw7pjgVMuceNI3nYo+sxCQgOfw070Ph/QzgRHODs4kSOr2hdCal88RSX2b+OpktY3ElcrgYRmuhq73mjV3Xm1cUhqKh3astdK56Mgj39D9XCgpBlw0C9uag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fEq9TJii; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fEq9TJii"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3035858c687so4108944a91.2
        for <linux-serial@vger.kernel.org>; Tue, 06 May 2025 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746530622; x=1747135422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsFEelJoZFPGjqC5CS/HFrDUtUzRaRFJEqe02AReKwc=;
        b=fEq9TJiiO2Hu9aA0SLDWlxxe6EUhGygcZil5Du97iWC1VaUcRs2/y1Jldli9J3VNIt
         NnNtW0c7dHiRFjMaYzb4ifqjXMj70M7k4ysI75RqPUQEIacIxTjh4ZW85UbE+/wOeEJC
         2c9rPiQRz7iFK1PjlKYG5SkRJNz/ODkta6M4nqn/ws5rOHJfACTXsh1TdBOZztINjxYr
         HSy9/v1oy7FWPSONNt8+Kk7+Gx2UDyv8uLMwCwvKIY6V5OEA2Z1x/EGOj+/ZopFUOID+
         ebFzPJfLvvKEmEkovo3hEyOAo190DSrgdvpVu0nksYtqShpLSrMVzSkjuCZQElzZ8RxL
         CaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746530622; x=1747135422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsFEelJoZFPGjqC5CS/HFrDUtUzRaRFJEqe02AReKwc=;
        b=QdcIR0/2VXPLIon9SVE2TTtEmDMxaqyi8w2ehoaBpUCESHCktsxVEsUVm8Bkmf1UeR
         gxf/Ty37bXnN5QW1TkeM9TFpxztVM/jzkRPt80CcP+LVpBJTge5l5qyMvN7/NZJLGWFc
         iFAfmnrgIE/L4bgSEx8Sd2t+5afn34zrRJrATRyKEubGXZO+38z3rdlLhWvlxWDWtIFs
         ZjNrrbmianS1x2T3tTS8CsdA3WGWlOi22xprBbNR71C9GxnMqrTnfYhMOvH/EwyCzfaS
         wuvdJ1Cv1StxNw4/R+Pkok8x4oVmeZKUn6nT812z19EQiecAxhkdDjSM2mhpHTEGrNgi
         baEw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHgrye2uffEPYO6ODmRi756gCtV9RjbiGjKFVOYnfKaG6ZSAlZxnizWPLoJvGaXkAUHuuX2+0CbMWU+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+s9oMEVRdhQHsKirbFnjGgSWU5xHLuoqRu6GbxTjutm8b7rU
	F9NantCT2eYHxNlWdX01Ru1SOXniRqhGWD+A4DDJvPCGGj8t3yuVXCUSNHaxlaQ=
X-Gm-Gg: ASbGncs7FclW/GoQb1W2DD6fgKEOCzSb+P6NHGQXHMk3Kvae4fJpbFGPo0czFkyq1Mf
	COk4x29/o4Miu+zhqwcI/G65puIDXIGQOSvBpYjTUAe8khGtXp0JR7aJYnYJTze9hiTcGQdOKK5
	pF774uCjW7Z/1YmznBtWe0fMMenD7qGfUCerooR3MBa38MN/KybRMRW1z3jrZshCB85nwMgFOO3
	PbLh4HKneYqMTbyn2JzcRiDKTVB7sLYYMNweQgfypnIBTJtOohVaFQ8uLOAExyR4I464HdQuYsg
	bCyq3Bi4CzmIRMyjB5/E2M57aLotd/+xA1IQa7gpsA6obP5PRdIqFj6eAZccp/uBvHZYsi5K
X-Google-Smtp-Source: AGHT+IGD8/c2V6FEHQXVuQcalLttyvnSCx1zvvLwGRwurqvvghvKHkpqr9RcWbomLqdZzObfVoBOpw==
X-Received: by 2002:a17:90a:e188:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-30a61a7473bmr14100272a91.34.1746530622190;
        Tue, 06 May 2025 04:23:42 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480ea0dsm13630303a91.37.2025.05.06.04.23.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 May 2025 04:23:41 -0700 (PDT)
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
Subject: [PATCH v5 3/4] serial: 8250_dw: warning on entering dw8250_force_idle unlocked
Date: Tue,  6 May 2025 19:23:20 +0800
Message-Id: <20250506112321.61710-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250506112321.61710-1-cuiyunhui@bytedance.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read UART_RX and check UART_LSR_DR in critical section. Unsure if
caller of dw8250_force_idle() holds port->lock. Don't acquire it
directly to avoid deadlock. Use lockdep_assert_held_once for warning.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af24ec25d976..f41c4a9ed58b 100644
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
@@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/*
+	 * The serial_in(p, UART_RX) should be under port->lock, but we can't add
+	 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
+	 * is under port->lock.
+	 */
+	lockdep_assert_held_once(&p->lock);
+
 	serial8250_clear_and_reinit_fifos(up);
 
 	/*
-- 
2.39.2

