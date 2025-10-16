Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D62343B6
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598328; cv=none; b=iocuLi0T2hQBd3arZGm+NdUQZWZKOo3sHEg5vZ5KTtyP18b8k7CiJkmJ+gbSRA3lQfo/AgLhCEYeH7zpjQPlDsy4T6dm6qjyUJ13Lq2RN/Y+lDaiZ4a0cUG9BHors/neblP09uObCjRcPq1UQjx/kB7+0sg1QprrdEdf1jLTAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598328; c=relaxed/simple;
	bh=p0myo92MmjxlvZuAoHPLrlj0DNjkKh00FfJsrOtYC58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ddg0e47LMzE9YffDEotryKy3iie2Uo0hGogQ2Q0UaWckXnEK6tNYrYGN+h5bpd9oxkFypdIHa11oyJ/Xx+R2m8Dbm80yFIcASrWxa/NNfHu7ysZEPXgH689ThiaLU7kaheigrvhQxzHZmT5ZakiHgHg9ILsh2ipslssqyhE9vuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JigxG606; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JigxG606"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so588850b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760598326; x=1761203126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=JigxG606i3zg0l9ISOhmVN+m4SBteP6CsnkqooJYr+3V+AJaSXYBgWlJLNO9K8c3mx
         fLUCkI7a432HKcP9t35SeWN0LL90d5mdffO0eVL+gazccg8OD4BHOTA9F59Udm7kEXXl
         rvA8HRkMlXZg9QfGjy83uQqXDn/TCzJHmgI3hyQjJD/jCPEnvlf9oLhDpkQVGCoC0fqF
         zyTFwOCpLwgDLXPDOdM/rOTmOj9Z6EYujXxcaDEqLxQGv+uKdqJD+iPqLiEINzZWZyJJ
         KDlaXSy+L+AJgsgvB6LzVEAR5S2gCYuxyjSzelDVJuaiOeVIO13a+wLudDbErAbRuNN7
         vtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598326; x=1761203126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=pItQoAnYXP4KDb7Nv1IvtSm+xrsS3njp2YN0gwS1NrC7b0b2PHtgayMOqnrI4etzGq
         Ic8dzu2C8NfPV2qxm1rF6198Bk30z2bThNP6po5EFqzuKikBh2qBc12bLTzz7x01m6mL
         W7rcpkEm2GUaKHrD1rsSLvj0fgvrOeYo/sUfFRykabaUQ5xeJT2v81x4Y+jl59rLDp+A
         hwkDnPzBjAaA9Tg2WAiDq3e8Th7/PHpzNQpVutx6ojFzCFBQozFTOFNSacUaGLrIppvq
         Ay5QUfXILS0Udh2xQtM9PqkF0PTA23i5cDQtE9rZ6U3sZVTbjlFVmmCv+W/tB5S7rlar
         kgaA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ph1rU1+v5RthDb6WXJsJ67O52ZqfuU4T4Mjwypw8TaQ15CQEBtMWISPMmgoEo8r2MW0E9VSPjoFGTRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TD5etJVaEbq8ksEdi0RQ5LQdXeFYuMfBLCJm2ltoieGOjBoy
	Pu82QOaXTktelu9sQahqLBkx/8aW8Jp3zWg+lVc+3FpeLESLp19HHkiut94vceJLmkpTQ9sADO8
	+BC6kr2U=
X-Gm-Gg: ASbGncsJUMFx9guOkag4pb7mGFj66RZQFpP8a2F3FLGOZY7gcggWsx2O4DFvi7/TQgI
	UUeOyszZd2leptVWD6tSl5Ur6wARtucIhxPGc+SbCFpg5ow7tOKYw+5jWHxNk/Ti+HUvR+vS7ny
	l42MuT1n5altM07kTtxwubpWdCBRXgHA5XPGuI0rQBVwoKn4obPHw+kUQS464h1USDwmYjwTysD
	itO7kXgfhDJiQltNWd1JCDW0u7GjayrYyPwlirxtEVHLOBJ2VfoVxqzQWWQUzCUq8tvYZoneGW/
	jMNaO9eINvFTgetMZBkHT1ruDY24e8WeymhWTiJhSQ633q3rvTzg/9eyBA6BbPP0fyxV7dO/Cxp
	5FMZAXrCZBs9TdArv706KbRb6kcGG3ewjuZ+a32iGoNKS1ABxIFw1d+Z1yI81v9Bor6wVJ5yfMs
	zhkHd35WgCcFpG5RDiq5SnYaKr7CNLwI79HkAsuDn761YUYUfkgCKc
X-Google-Smtp-Source: AGHT+IF1MUyIStDGYZTHEyg8E2ywDZduM7sqAh10ehYvS4mTZJXKLG3YccUhx6i6ZwBsPOUw0Zd0Wg==
X-Received: by 2002:a05:6a00:b85:b0:781:2069:1eea with SMTP id d2e1a72fcca58-79387828612mr39359235b3a.24.1760598325971;
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm21105126b3a.63.2025.10.16.00.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250: always disable IRQ during THRE test
Date: Thu, 16 Oct 2025 15:05:16 +0800
Message-Id: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, so the interrupt
handler can run during the test and race with its IIR reads. This can
produce wrong THRE test results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
short duration of the test and re-enable it afterwards to avoid the race.

Cc: stable@vger.kernel.org
Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f1740cc91143 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
-- 
2.20.1

