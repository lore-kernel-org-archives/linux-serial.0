Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240419D063;
	Thu,  5 Sep 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544043; cv=none; b=hERidQzo2mvke0hVRKVHN+CgPm7QWOqkSMWKsNODFSCEANkaiF41Sh2XYyXOh25XEbGmErBDoSiaca5RSuBtfm8yE6Y2r3A9vLxZT9zi4/fhIjBpzOXS/+8a9sLqczXnwMURQG0fzOjhgzhkixC8gm72XyZWzxBGjOtGTH+IRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544043; c=relaxed/simple;
	bh=+gxfcjR8qFfCmdVjqWZCvR/X4nSiLGlFoYa4M4P7OWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAbG+GeiCfA5GmSz8wSqGSvUWemPbW8Rw1J2D1NUhma84cl5Bqkr06gmTzncPWSlagItE3bAO55uFGkcZxRkRLBfIM5RFeAjjJCTiN91h/AJrusqglEgxFzXBFYBnhna+/2/my8x2s3oT4Y1kbix68+TBOpQt/bLqFANOl2jY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVII47RW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/PmF5ab; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVII47RW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/PmF5ab"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725544040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JbplEo/6jkwQPljc627RJR9CIzJ3Rs/Uhcltks5Xmo=;
	b=AVII47RWIsHYhA/7fmhhwa2CfL9UKQ6CYvYKVl/tk3l1hiybJ/JnX7qXeKljdAGyoJNyj1
	9rP7QR0+d9qBYTlSfdysdhCL3vlpj50MCYolBZy72fjO6qruHqUVOKCs65m/VLl3zg06bV
	hb4BFi430xd9HsPYCpdIlMw4R9UfG93O7nePPKLZ7ubrWO8/BKa2IToaMd7ySVPGZ7sHDm
	QGIYsZrl3PzlVn3awgthOrW8bBWgDSxeP9ixw+Hgu4U0qUugCdoB0hKt1GdLaxVMfz6/sv
	2NM/WG1YeqXC3DqAEfbqQcKO04Ucs2Xy+w+4jFQFI0op11oXm1XvdS74mz6Yaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725544040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JbplEo/6jkwQPljc627RJR9CIzJ3Rs/Uhcltks5Xmo=;
	b=x/PmF5abZcbnXEhdTzKmc8YK4JUP5VNUju/NJgfdI83681SuB2eRfW4Y/HPZkmy2MXNJwU
	UnvJhboEz9QwPoAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Derek Barbosa <debarbos@redhat.com>
Subject: [PATCH tty-next v1 0/2] convert 8250 to nbcon
Date: Thu,  5 Sep 2024 15:53:17 +0206
Message-Id: <20240905134719.142554-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent printk rework introduced a new type of console NBCON
that will perform printing via a dedicated kthread during
normal operation. For times when the kthread is not available
(early boot, panic, reboot/shutdown) the NBCON console will
print directly from the printk() calling context (even if from
NMI).

Futher details about NBCON consoles are available here [0].

This series converts the 8250 driver to an NBCON console,
providing both threaded and atomic printing implementations.
Users can verify the UART console is an NBCON console via the
proc filesystem. For example:

$  cat /proc/consoles
ttyS0                -W- (EC N  a)    4:64

The 'N' shows that it is an NBCON console.

There will also be a dedicated printing kthread. For example:

$ ps ax | grep pr/
   16 root       0:00 [pr/ttyS0]

Derek Barbosa performed extensive tests [1] using this driver
and encountered no issues. On the contrary, his tests showed
the improved reliability and non-interference features of the
NBCON-based driver.

Since this is the first console driver to be converted to an
NBCON console, it may include variables and functions that
could be abstracted to all UART consoles (such as the
@console_newline_needed field). However, we can abstract such
things later as more consoles are converted to NBCON.

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb

John Ogness (2):
  serial: 8250: Switch to nbcon console
  serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250_core.c |  42 +++++++-
 drivers/tty/serial/8250/8250_port.c | 151 +++++++++++++++++++++++++++-
 include/linux/serial_8250.h         |   6 ++
 3 files changed, 196 insertions(+), 3 deletions(-)


base-commit: f1ec92a066b2608e7c971dfce28ebe2d2cdb056e
-- 
2.39.2

