Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2EB126BF7;
	Mon, 16 Dec 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369168; cv=none; b=tSpIPlKQMA8M9k8ro9JOEUtA4WkFY9NDZWthppKIRkC0aawnxlK06srBRDwubJpYSI/pCobwyTPGwYlARRMJZqhPCkZT3lAaHf+7x/Zm60kWEy/3sRb8pmA6CiBUQN9VEzz4buLb8H1k3wmR3Wty7mH2i7RwSxj3jVy7GwoiQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369168; c=relaxed/simple;
	bh=J+INmCDmt5St8gFAVHmSSPAbzGu2w3mt8prIa6kyE10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVl/Xm+EDVq1OMR65iri5PWhK2VUPgU/i0rgxv8qdmEoRVgYGMfzWbT3a0AdJSo1SR5EX2ug9xqYbRVPykZYu02ZYUhISAr+gw8xChb6SHoy4ah3m248Cu0OG2WaGJ/96C2VVdDLvmNcQ6LL13qgLFzgYIbW0YQ3QoqVmQza7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqjXRxq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iv0r5I1G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqjXRxq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iv0r5I1G"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734369165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OzFjs73HSaheFSUIBvL6wjzasVUOcu0z3FSlXjmVgOo=;
	b=yqjXRxq712UhD3awCtucy+EWGh/7Gd3jlp1opzXUmAJgXSqaRWfyeUdj0b39YCD0wiNDFf
	2Nl8uIaknZ2iwGC41BgDajp7/fM+RZm+Ir+eAlov+e91FA4z6DgmM/vBm0RUv/fENhcwdr
	dEjb67s/UW6pmP/v3tfFcgNYfEwCDppXIbteP+7QFIDh0uHiGA97+9NLWYqPxjVJ7v4/ic
	6kGnJ4kq/d740k7ScmTvfXVPI2sLCfpthqB230iSGkeMlGCP6KLn8YDUZ2jFMw1KE7a6no
	Rr25J++C6bR2qBJyhwyOzCC/6QBDuCd5mrle8m0/2TN+sMLiE3ABv3YLgQGjog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734369165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OzFjs73HSaheFSUIBvL6wjzasVUOcu0z3FSlXjmVgOo=;
	b=Iv0r5I1G9wAwQddrK8HwAT7060gH/G24iPo64t28geGCo3qwXo9VXMDCHkFA/fXJK5lRvs
	A3xKdQfEjMynKNBA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Petr Mladek <pmladek@suse.com>,
	Tony Lindgren <tony@atomide.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH tty-next v1 0/4] serial: 8250: Fix LSR masking
Date: Mon, 16 Dec 2024 18:18:40 +0106
Message-Id: <20241216171244.12783-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

During the review process of my 8250 nbcon series, Petr Mladek
mentioned [0] that it was odd that the console driver clears
UART_LSR_DR from @read_status_mask but never sets it.

Since there is literally zero documentation on the
driver-specific fields @read_status_mask and
@ignore_status_mask, I embarked on a journey to figure out what
these fields are for and how they are supposed to be used.

My quest took me back to Linux 1.1.60, where there was the
first significant change in the purpose of these fields. That
purpose was then reverted in Linux 2.1.8, but some of the
pieces were forgotten. Over the years it seems no one really
noticed as these bogus pieces hung around and were even
expanded upon.

And yes, I uncovered a subtle bug that has been around longer
than git.

This series cleans up the usage for the @read_status_mask field
and adds some documentation so that future developers will know
what this field is actually for. And the series also fixes the
subtle bug.

Note that since the 8250 was the original serial driver and was
copy/pasted as a basis for many later serial drivers, the issue
may exist in other drivers as well.

[0] https://lore.kernel.org/lkml/ZyuOX4VVbfAFhMfV@pathway.suse.cz

John Ogness (4):
  serial: 8250: Use @ier bits to determine if Rx is stopped
  serial: 8250: Do not set UART_LSR_THRE in @read_status_mask
  serial: 8250: Never adjust UART_LSR_DR in @read_status_mask
  serial: 8250: Explain the role of @read_status_mask

 drivers/tty/serial/8250/8250_core.c |  1 -
 drivers/tty/serial/8250/8250_omap.c |  9 +++++++--
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)


base-commit: 30691a59c85c48575b04e849f675660fd8060cad
-- 
2.39.5

