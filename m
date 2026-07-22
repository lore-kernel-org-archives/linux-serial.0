Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502654398FE;
	Wed, 22 Jul 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718569; cv=none; b=FDUCQN4PT+6wsKR48hcKnriVf1sOcI0Dt4to8fz7JnUEeR1AAr3+NmV4H8tqLlhg+ESyMvDjX9y+2XVQdGRPnWCTPOkoHB4H9ugfspOWn25G8yM1Rjt4dfZAEIzKemvz7p7Zewpwj0wLCUBjbC//aAtP7EsqrJt5FZtJW/5lggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718569; c=relaxed/simple;
	bh=oLktROvI9OTu72XSmKPYcPWOj+a+MQ4ZG+jCKCodlHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDB3a7Rvekt+xw0M3xRtYuMlmc11SbH8hk3dx6cPPLDlSRMK7Qs5K9EoJZOnia+romNsALBgiQtsmTT/O1r6PSqMR5V9MeD55zkB1B3SIqEDHY5gzCS4gzNq5X1gkdYNcJxi782uQ4IhIpgmcnmi9GeTVpSOwv7qK+6lmxmnr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPC/66cf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oiv7vQkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPC/66cf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oiv7vQkG"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784718566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=veux+1ZH5i5HFzPCkTSp7Ge+Jfjff6IR5oLk22AT/ag=;
	b=hPC/66cfM0dhT+Rj6YP1AW2gWCZVO3WvX+6A+LU1C+36rlRORnx2dGPNRASC74UWd1woKW
	TLPCd0l/VVINdykhbeKswcSr1dSm80724KVJ2vi0WfXNwenR4FSoYSUO/ajmmog3RbHp9S
	0sW30jfVV/tgq7fmeXWoPKWKIamTBh3GRlUQMKkBcxDxXM4Al+VFzxo9friLMNr//LAjqI
	IW7R6WfnosK3Yjiznxl9MDHF7aU2KEtL8fyDN4sXhZsxhbPOe4jYRos79ooylWahW9Z/s/
	N/BgTvX7cpVPg6UsKi7EQGsE54v9SHemfa7ieb4fK+eCrmFQdTrXBUl6vMiK9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784718566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=veux+1ZH5i5HFzPCkTSp7Ge+Jfjff6IR5oLk22AT/ag=;
	b=oiv7vQkG6ZDx6DWjshWY7kTGZuOvepLetQ9Xtn1FNcxkgLhIY8h0UOcR2msjIMaRjoiQRf
	wtEi0Hs0CvPc+VAA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v8 0/2] Convert 8250 to NBCON, take 2
Date: Wed, 22 Jul 2026 13:15:17 +0206
Message-ID: <20260722110925.74387-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v8 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v7 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

The changes since v7:

- Perform the following renames to make it clear that these
  fields and functions are only related to the console:

  In struct uart_8250_port:

    avoid_modem_status_work -> console_msr_work_allow
    modem_status_work       -> console_msr_work

  The irq_work handler:

    modem_status_handler()  -> console_msr_handler()

  Note that this also inverts the flag for allowing msr_work
  in order to avoid using a double-negative for the reader:

    if (!avoid_modem_status_work)

  changes to:

    if (console_msr_work_allow)

- Modify uart_8250_port->console_msr_work_allow under the
  port->lock in order to synchronize with its reader
  serial8250_console_write().

- In serial8250_suspend_port() and serial8250_resume_port(),
  move the @console_msr_work_allow update inside
  "if (uart_console(port))". This involves refactoring the
  neighboring code as well and has the nice side-effect of
  grouping all the console specialties into a single block.

- Change the IER-disabling comments in
  serial8250_console_write() and serial8250_put_poll_char()
  to mention what type of synchronization is used when the
  port->lock is not taken.

The changes v6 -> v7:

- Add irq_work_sync() calls to make sure there is no pending
  modem status work when suspending or unregistering the
  console.

- In the put_poll_char() callback, use __serial8250_clear_IER()
  because KDB/KGDB do not acquire the port lock to print.

- In serial8250_console_write(), re-enter unsafe section after
  printing text, even if ownership was _not_ lost. The final
  actions need to be performed within an unsafe section.

John Ogness

[0] https://lore.kernel.org/lkml/20260720135407.3925-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  Revert "serial: 8250: drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  65 +++++++--
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 200 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 236 insertions(+), 51 deletions(-)


base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

