Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39401EA95
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630008; cv=none; b=T3PawhL1w6gPN4pNTtsEKnrei7T/YY556RqyANWFGHpti7C6yUB+STlsDkq9jZr52avH0prxpzRl55tRHcwXoZOBsEKCqHHeW6QuBYAtJdzv49wDIvwnN35HzE92eJuH18OzNZ8Q3ICgRp2Cu+JflUXJGbOP6IUD+wTaeIwyNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630008; c=relaxed/simple;
	bh=91aDpj0J1suQKpEMGdpopPbtClBGYCSdmwQ3drsbMQU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=YsiAYSACn2M1xy8Jdum8VOQORKFngIaK7PvHinbQSgEpp4g5Gcz/uho+qlnuftb7JBZ78Rupny5Hyut3pYAte9eXFLgKbZXi2BW33z0NBiFFy5n0C59APruBmOav4WLHy3lGH06Dt/s5p26SwrYkcH5gOglAm6TugdbalM/v5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJmXB1rI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJmXB1rI"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dce775fa8adso80804276.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708630005; x=1709234805; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4GkCuqwCSEAB8nvds1ZFkf95AtYbW9zdNmctGggYMc=;
        b=bJmXB1rIhKzm0Tlh+MTlxUSfthKI7xUAUtrKzie9Oqnu9GpKxrXI7Nk39tlWvdFU5z
         B6HWkC/N2KSdp9w3obmcpTNfMbGNw5fi17xvetMNlxQvVQ+TnYW+VGr+Y5q9v9CpcM1X
         Je4Oncl1VL6YCA1egmQ+fufz53WvMIH7qf9iXy5enCN7QYbKQNGWNeuqQo6llEVWcKeZ
         9iRbJ6fpoRBqMwM11MP0bYaBOaUtUrb7Aum+LudU3aDVWntyb0WKM7YlqPMR7bOy0JeU
         kFMDCYbXb8kexYCmx75Tk3dRagnJnN4eUDRR9NW8lvH17/vOSqSAJRc1Fl/Amps51298
         pGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630006; x=1709234806;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4GkCuqwCSEAB8nvds1ZFkf95AtYbW9zdNmctGggYMc=;
        b=pncsWrpYhIK6wOdU+T1C7t/CdgByGm5jOKvSqWsDK5UtWx7ScokKzHGPTrwsbDnLJ0
         dye7pCRQW+7CG9EXvAFha7HgO6W5uvcqWwr9xarw1hETFHexXFoweZYXpY7LT2fCdNu8
         jEo0nkkaa2mzuzKMbj9NY2Rlq2qmmZ4AKrXN+clukBpXxmzXjGmaGbX97eCKygU1ScD2
         dBkLaUaa1DgWwNzbcu4iW7xmJeONMwCD91183A7y40Oz8LK+F65hbwZigjcQ/GfhKri7
         sXXevbdMPVSvTezgj8uhvVB6ClJlzLRf7Dw/Y48ejOK9JVDizUupxxHUHMpIBfV0WVpm
         94oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEXDORPUD8lZLNdB1//lpYgcLmG+P9dibWcgDAtOP/EJtnhA9/WJaFmDouMu3OTTMHZU1AhkhJSehUhC//1o09wKR8eV8u41nG4BPM
X-Gm-Message-State: AOJu0YwRzNl7umEXFnqzUvyt9GkIfzZSXJHWNHL1n6jtSOb/D07jJvIi
	fMDwWgHRnNRf+H3Z+v5+8aQN0Jhzdutjwtj6r9CzLJo9w5zVbexbvZn/UpazqnuPKQ==
X-Google-Smtp-Source: AGHT+IEPTCoweL32yIVLMQ5Ekqsq7q2DSUkOe3t5EWJqj+LBbv7Z1eeSfkvDbIFHGrbMPsAjyVNsE3c=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:26c7:da00:ce0c:dbd5])
 (user=pcc job=sendgmr) by 2002:a05:6902:1141:b0:dbd:b165:441 with SMTP id
 p1-20020a056902114100b00dbdb1650441mr28329ybu.0.1708630005724; Thu, 22 Feb
 2024 11:26:45 -0800 (PST)
Date: Thu, 22 Feb 2024 11:26:34 -0800
Message-Id: <20240222192635.1050502-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH] serial: 8250_dw: Do not reclock if already at correct rate
From: Peter Collingbourne <pcc@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When userspace opens the console, we call set_termios() passing a
termios with the console's configured baud rate. Currently this causes
dw8250_set_termios() to disable and then re-enable the UART clock at
the same frequency as it was originally. This can cause corruption
of any concurrent console output. Fix it by skipping the reclocking
if we are already at the correct rate.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I2e3761d239cbf29ed41412e5338f30bffe1efc70
Fixes: 4e26b134bd17 ("serial: 8250_dw: clock rate handling for all ACPI platforms")
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d1f350a4bea..c1d43f040c43 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -357,9 +357,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0) {
+	if (rate > 0 && p->uartclk != rate) {
+		clk_disable_unprepare(d->clk);
 		/*
 		 * Note that any clock-notifer worker will block in
 		 * serial8250_update_uartclk() until we are done.
@@ -367,8 +367,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
+		clk_prepare_enable(d->clk);
 	}
-	clk_prepare_enable(d->clk);
 
 	dw8250_do_set_termios(p, termios, old);
 }
-- 
2.44.0.rc1.240.g4c46232300-goog

