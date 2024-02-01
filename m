Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBA3C478
	for <linux-serial@vger.kernel.org>; Thu,  1 Feb 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770781; cv=none; b=sE7Zsm4lSdS/l2T4zruOikw8ntaNbj4uayt86qMeehHt7g2XFUSgihJIeSqdnzhS33pJbL/+0yNA3cUTdYpLGB3g5cT9OY6EZs9i8zPNXbz86lkFkaoMA0Yw/YyrA5SFYR3OMvcd4ZHa/DazyTZveSKJsOlIIKrTZqX59RCSbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770781; c=relaxed/simple;
	bh=FspRv9+2XdwBy4/C2pBHs9xpo14Y41EgC1YBShaxUfk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kEcpuzhsm+Es/Q8zIOTKbKdL+9WxQnbtjc7XoPaZKHFi5MoURJN7S7b3K2Vc0HRtdEhzG93zsJoPjmGUTM9EI7zHW9FBi4cTaktr24VIDx/Sdtq5KcR7/bjzX3uKBaEpdkEwGKe8kOsIRcDFkVf6AN0QU9tQlh7O8SlpeqAQixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SqowonRP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SqowonRP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29041136f73so414130a91.0
        for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 22:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706770778; x=1707375578; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlIN8EUE48rC5uTTPPIhaWbjEtaHOruLs++XqNgVM0c=;
        b=SqowonRPmGoMLkj3L7u3BRtHP6AkRv+UH61Sx/rkvn6w0qx3CHosNQvNdMJydSQkkq
         68Ku8+qthPx4lDwqDqfMPDgq96991E4TakhvUqNY/d8bsrUEGaLu/Wh1HvjNKtCLM9tJ
         VNnd/tmq6ssScZDjz9eNGtYC3xVxJZChRFUFIKypuDS7QVmpedInXperSTk5cELT7by4
         4XB7ZqCVarOaSlovELeqi4yFRK6j1LnoaydRBg8sXIuwg0QL0NvP5TUp5sTWHt7b9061
         +l4YTQmmfRa6yjQUv0HsDCsT4TtcCKyL1promhtNNwuzclyjZWQfp7xhUIB9hALNGh0a
         uhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706770778; x=1707375578;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlIN8EUE48rC5uTTPPIhaWbjEtaHOruLs++XqNgVM0c=;
        b=AkR7j60dXqwsNPFUtTiYHPagbEf0cZRVlgmqJVLgH/LfM9xYn24I6Z1MbASMnEB49R
         zaAb4c8X6RiL7XziLPLvuFMVpcZPeUdTJ3eGWUOaycTzQBagyY5Io/GV2xgzDajoWSDR
         /ZB1/UvjDRgPFhZsjmXD1JQPgmpHh9zON9zxBtdOZJAJlxC/5YY0VwG7vf1LI9X+scFg
         p3i5NYffrnfeAtU+3zFJAJgN+zxuz+aWUUcMWiUMTJnYx4SoVQSCw5yMPHOUHnialg7P
         aPxAWi0gPdwdr7Ipbeyi1eMN7MGXEc5tQgl4preOrKAe79+lHgHmMcWu3RcBKDeyjGKG
         A38g==
X-Gm-Message-State: AOJu0Yzlu6WF3/TQEUXfp33M1KTZUiQ/7JvMSmIlPrj7G4hsT/VcRMbJ
	euUL5Zv0FuoPrT1XegJQzHafdZCBDDsbfW8pDLyhEXnUTndWc+trgQSGFqm9CzELpeSKr6N7EvO
	4jIEM3dBS/U4e7akdasaDbBraMjJRkBrW+t7p2o1NColW3lZCGAht+oNbJpKwedI5LsAPeNjbGX
	g/IFnxeR+eMlQV05l2EFtBKdYzrpKwEhKCOwIkXpO+u2yuYg==
X-Google-Smtp-Source: AGHT+IH/o/5JqeOA/x2iMwoniYizhXmfdnxdnTcGm27O4QdQUCPpzI7Y7LqIdMK6wYPdO68ohRayTw==
X-Received: by 2002:a17:90b:19c9:b0:296:1dcf:c296 with SMTP id nm9-20020a17090b19c900b002961dcfc296mr211546pjb.18.1706770778294;
        Wed, 31 Jan 2024 22:59:38 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id pq9-20020a17090b3d8900b0029051dad730sm2787838pjb.26.2024.01.31.22.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:59:37 -0800 (PST)
From: Andy Chiu <andy.chiu@sifive.com>
To: linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	gregkh@linuxfoundation.org
Cc: paul.walmsley@sifive.com,
	jirislaby@kernel.org,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH] tty: serial: manage irq with spin_lock_irqsave in SiFive console
Date: Thu,  1 Feb 2024 06:59:32 +0000
Message-Id: <20240201065932.19899-1-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

It is not safe to call spin_lock() with irq disabled on RT-linux.
Instead, transfer the code segment to spin_lock_irqsave to make it work
on both RT and non-RT linux.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 drivers/tty/serial/sifive.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index fa4c9336924f..3f0ddf8bfa7b 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -788,13 +788,12 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	if (!ssp)
 		return;
 
-	local_irq_save(flags);
 	if (ssp->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&ssp->port.lock);
+		locked = spin_trylock_irqsave(&ssp->port.lock, flags);
 	else
-		spin_lock(&ssp->port.lock);
+		spin_lock_irqsave(&ssp->port.lock, flags);
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
@@ -804,8 +803,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
 	if (locked)
-		spin_unlock(&ssp->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&ssp->port.lock, flags);
 }
 
 static int __init sifive_serial_console_setup(struct console *co, char *options)
-- 
2.17.1

