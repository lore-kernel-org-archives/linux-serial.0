Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158E1DB521;
	Fri, 13 Sep 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236345; cv=none; b=PrE5o8/VebHhrMnUR2CU2+aORuoWhpxADQedSZ9tkd9irlzz2KYODrvH+KXcC2k+9xwIpb6FSnL5Iz+4PP/QXvMBUw5Nyy2N0G4epTsGIw91lSog7JCr3CB7/pbBK7dEpERKM1YgWC60VMX6pGJtCMjapm7yIsEfDPThGnB9jlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236345; c=relaxed/simple;
	bh=VgUE9iKQg3t9VILMC/cL4jeuipS0PmTMx2nqI8uzrew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBQb6OOoY9ShTd+U4mclG6bOQoMaPU2g0+LwPjzU+f8Yn3I6dkoWemc3Q1+esRJn8eUg5mlY8eoiJdbxTUhXObfm+EDGPRAka1DrbYlzmXXa4imvPMVRPWjy4/0zQ2zXXq7y364XvZVZQCd3ItPZ/qV0lXaYZzZW0lzEkahp73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4NVa4cCm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X2knGMLG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4NVa4cCm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2knGMLG"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726236339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=swhm+/MbcA57eNfow0mlHpf/Bf7nq7jlFlNjFeLsrNA=;
	b=4NVa4cCm3nArFN5av6pTBoRtSxKgctX8tZ+wDbAbV469krBRu0WHybtjuh5k0FeT4zcj9f
	WSh40348ACMz8Jb93bTUQ3d54nfpl9bfWQRQ81GaQ2i69v9p1bMZ/gStNkzPKjQT5IF91U
	mMtZlgVPRReRJzkCJCLPOO5Ymzollhh510nCCw2j/nstIXoSxLwuCE1RCTBgR9pHzPbwM1
	GZ6l57M4L2iRZovP3US0VwEg3P+ZM7FR1ESklVOGR4lRkIn1gFuUeg0+lgX3lzZ8SwCCOz
	qbJhvUlpMjLyy88tpaL3jfRnLBFHuiy+FIMUQ9hnGXFnm6wmG3NF3CtHdK8Rvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726236339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=swhm+/MbcA57eNfow0mlHpf/Bf7nq7jlFlNjFeLsrNA=;
	b=X2knGMLGxyjeD2tCXBkMs/3UrRaazvTBviH5qIku+vFcKkqdhMX6re4AeRwHzccY/s/QuD
	XhhzdNyCBCL2GBDA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH next v2 0/4] convert 8250 to nbcon
Date: Fri, 13 Sep 2024 16:11:34 +0206
Message-Id: <20240913140538.221708-1-john.ogness@linutronix.de>
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

Futher details about NBCON consoles are in the cover letter of
v1 of the NBCON series [0]. (Note that they were originally
named NOBKL consoles, but were later renamed to NBCON.)

This is v2 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v1 of this series is here [1].

Users can verify the UART console is an NBCON console via the
proc filesystem. For example:

$  cat /proc/consoles
ttyS0                -W- (EC N  a)    4:64

The 'N' shows that it is an NBCON console.

There will also be a dedicated printing kthread. For example:

$ ps ax | grep pr/
   16 root       0:00 [pr/ttyS0]

Derek Barbosa performed extensive tests [2] using this driver
and encountered no issues. On the contrary, his tests showed
the improved reliability and non-interference features of the
NBCON-based driver.

Since this is the first console driver to be converted to an
NBCON console, it may include variables and functions that
could be abstracted to all UART consoles (such as the
@console_line_ended field). However, we can abstract such
things later as more consoles are converted to NBCON.

Here are the changes since v1:

- Remove legacy write() code rather than hide it under the
  macro USE_SERIAL_8250_LEGACY_CONSOLE.

- Implement write_atomic() support for RS485 by splitting out
  the IER register modifications into separate wrapper
  functions.

- Update the RS485 call sites to use the new wrapper functions.

- Implement write_atomic() support for modem control by
  deferring to a new dedicated irq_work.

- Rename @console_newline_needed to @console_line_ended and
  invert the logic.

Note that this series is based on the "for-next" branch of the
printk git [3]. This is because the tty-next tree does not have
the NBCON series and thus causes problems for the kbuild
robots. However, this series does apply cleanly on the tty-next
tree (it just will not build).

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20240905134719.142554-1-john.ogness@linutronix.de
[2] https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb
[3] https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git

John Ogness (4):
  serial: 8250: Split out IER from rs485_start_tx()
  serial: 8250: Split out IER from rs485_stop_tx()
  serial: 8250: Switch to nbcon console
  serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   3 +
 drivers/tty/serial/8250/8250_core.c |  35 +++-
 drivers/tty/serial/8250/8250_omap.c |   2 +-
 drivers/tty/serial/8250/8250_port.c | 248 ++++++++++++++++++----------
 include/linux/serial_8250.h         |   9 +-
 5 files changed, 200 insertions(+), 97 deletions(-)


base-commit: b794563ea12fb46d9499da9e30c33d9607e33697
-- 
2.39.2

