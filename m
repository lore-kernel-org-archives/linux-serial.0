Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79241475348
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366453; cv=none; b=MwUKR5mLuBXtv3HRYcCrNE3Igw4AjQjLLzWJBmhKjenEjbM+o+8kxF8d8sc7Ej3NGlWe3wIIJxtF4nZAPGYBlP59mHjpZoX5rDvSOBeq/lyqTqU1xLAiy2iYf1jEB/pkAqScQi6Batubk7p2cZIX8rDhQgay+l/u4GX2aGVUaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366453; c=relaxed/simple;
	bh=FpL7jjwMY/apfHM93jjTPCGNB7TYjMZroVkZzCHVyBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi+MAj7UnQXo6w7wvq658gc9/0v144yrIkX8WTobXNHV2VbZqk5y6U6KWxe2fR9EhYowh0VrRgy+nnofsHw6RvHzGZKEVeTYhSBmufeNLZs88DXf3X29Cnq5Oh7DgPHDoh/cDKNF/Z9aToRYiuCEt63J/ElBF9c5Jp+CQGohiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW54BEM3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW54BEM3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a8af3a704fso204113a91.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366443; x=1791971243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPKaHWa3Bx0TPeANjm1JQtALevFITXOT/HiMP7XTIdE=;
        b=JW54BEM3ausoXQujOKMZ+r0q8jC/BsWwEH8cGfb1PO2vwdb5Ee72keVqcjFcJXlW7j
         ViJw5mNZ4HpWVh1A+CjDtQSOoXzwLherRj0+ek4lo17k3CB4xiGGoZEHJYMsCv1wi3Wq
         XIQrLvGQv668fat1ECsG4dzCnjBBSmvRSFiUsKLkX8Wzv5sRWOvvNObpZLgRS5+3Ac03
         1mw2WEKfc2YIGAOc6781LxoO8GJmUZLa3T+0vKTxtUe/pR7motpcAE9NhLn3ds+McXeD
         2QtLsaQ9H+doWi9Xy/tEGD+kKhxzVrHm6FUKlSOGL/P7JDkZwZN1Nb8CwpkA1z8vMJLC
         6C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366443; x=1791971243;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPKaHWa3Bx0TPeANjm1JQtALevFITXOT/HiMP7XTIdE=;
        b=XjHCsm/iHLbAZo9/g/TaPQsQEbMsIj2e3fxvdEEnXIICClwpcT9meOaPzYkGZQ7Pwr
         CGYG/cyN3l70Fo0iuRAb5RhD3UT6Yrdc+SGYXvjf0EsUpAGn+z7K1b/ezuZ/bTte/86U
         9NDuCTK+GTsCMveRjYBCUrav+jXENlJUiES7EDKWsG0h05wPgJTiCZYZSQ0LsTnc8V4X
         gLztAchycJU6LNtpVU92WSV7Hg89g/0LvsdsG4O8VL3BAXMwDBLg2PFZOS3bBS3y2Vib
         VbTkI38Xa+gTn8UZ59HEMf1RIv56vUI98WssKnsQlBo4O35qNhqqmHPc+JzIVjoP7QPV
         s6Gw==
X-Forwarded-Encrypted: i=1; AKwUvBw5UhiVfAi1S3L07l6E2uF/UBBxUkrpFulWx2PM5vQjOwY2ftL1cCVQsEJXGDdCTYCkijLK1S5wtYY8zmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqGsNNjy5FiSU7QH8xDSJMQLizjmbyTbkVnoR5xx554ea7peWS
	ORy/z5yW0PJAlpS6CdUXRc8vpcfgS0CZdAF4HWs87M36Bdk/KyU/tIPz
X-Gm-Gg: AYBFou3ZTc3iPge74/iCoo00/F5ukLOm+wANT2og8uzD3BjtXUDOa4pINXvrxnUyWLH
	7DWC3eHz8YKeBIpC7A5FQwHOKmJPownZkdtOOrJ4nPl5+AD1zKz1L2tQlOT6ewx8Uq0K+UCwO0h
	+Am9f0S3xDmG3lJ4rE07xtXZZgtUng071+ez2HipuZS+5u07Wa0oYC4Jx6AULkIrui+ZUmmvgwP
	qas+sM+RUvAfuk7qbA+zRJoJgp9/w4NK666lB8vWpuJvi1N145O+MjjfQpGMdylIOjwopBRTQRk
	81Bbue+qZmLVh35vl0TAe/AsEm1QGlgQA3hwvKd9q/j8GKKvbo6PJ7Iod+/uGFhDRG1+1y+uZ3M
	iuQ8EMEOy0pI+qP6vFThYh7KCfOOlHqdvUQs0vfNFmccoIpaJNWgANghLle+V35TYo2ZFMrydW4
	oHOmy2iCrUaBMaJcKKoE6uX75IrpBvvGl4rhW13uP2RCEpyDnA9L1i3JSYhWItJvAC4Gq8mwxvN
	NjQRNxcUyCZdJXHVlVDjeFwVjiKWQwSE0DlwqxdyuVivWtjsAEOEuYWqLsaEm5h+Js3W50UZA+W
	JJZJp/dqLw==
X-Received: by 2002:a17:90b:564e:b0:3a6:e8fb:76b5 with SMTP id 98e67ed59e1d1-3a8a1b48770mr1335998a91.37.1791366442618;
        Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8c46a2f9bsm265866a91.2.2026.10.07.02.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v8 1/2] serial: core: fix baud rate fallback in uart_get_baud_rate()
Date: Wed,  7 Oct 2026 09:47:17 +0000
Message-ID: <20261007094719.1362769-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261007094719.1362769-1-benquike@gmail.com>
References: <20261007094719.1362769-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When uart_get_baud_rate() evaluates a requested baud rate against a port's
supported limits [min, max], the retry loop operates as follows:

  try == 0: Evaluates the requested baud rate. If out of range and an old
            termios is available, it switches termios to old.
  try == 1: If old is also out of range (or unavailable), the fallback rule
            at the end of the loop clips baud to [min, max - 1] and encodes
            it into termios via tty_termios_encode_baud_rate(termios, baud,
            baud).
  try == 2: Evaluates baud = tty_termios_baud_rate(termios) for the newly
            encoded clipped rate, which now satisfies min <= baud && baud
            <= max and returns baud from within the loop body.

However, because the current loop bound is for (try = 0; try < 2; try++),
the loop terminates immediately after try == 1 without executing try == 2 to
re-evaluate the clipped rate. Upon loop exit, the function hits WARN_ON(1)
and returns 0, which triggers a fatal divide-by-zero (Oops: divide error)
in uart_get_divisor():

  WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260
  [ ... ]
  divide error: 0000 [#1] PREEMPT SMP KASAN

Increase the loop retry limit in uart_get_baud_rate() from 2 to 3 iterations
(try < 3) so that clipped fallback baud rates are re-evaluated in try == 2.

Tested in QEMU against Linux 7.3.0-rc3 by setting B4000000 on /dev/ttyS0 via
tcsetattr(): on the unfixed kernel it triggers WARN_ON(1) and divide-by-zero
Oops, whereas with this fix applied uart_get_baud_rate() smoothly falls back
to 115200 without error.

Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always returning non-zero baud rate")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v8:
- Rewrote commit description to detail the step-by-step loop iteration
  progression (try == 0, try == 1, try == 2) as requested by Ilpo Järvinen
  and Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f91bcfa30113..6ed0195e6912 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -470,7 +470,7 @@ unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termi
 	 * Ask the low level driver to verify the baud rate if it can't
 	 * then it will have encode_baud_rate set the Closet else .
 	 */
-	for (try = 0; try < 2; try++) {
+	for (try = 0; try < 3; try++) {
 		baud = tty_termios_baud_rate(termios);

 		/*
-- 
2.47.3
