Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2962AD2C;
	Mon, 16 Dec 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369168; cv=none; b=ONCau07PGw3O1EFJajhVeEVMnuFawSq6TOTJwvLPav55/2P0jmLLBbcJnhxAt9b7ASe+3s8x1PiuXFMNQ+xJetEMjhrfhNRFi6vCeG1TQZp9RyR+jrX5qRBGT9MA2et2qcwY1fEf+kufg2qnvIPISc5GRIYefsd2VoaNg3hR0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369168; c=relaxed/simple;
	bh=2zHGMhXczieY8uy03r4x9wyNQErE608yROGA/U9K5GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFr5rpMpjUIZZ6P1GMvIdNYGBjzFISQRwj3ZlGwqxFTsJ69xC17ERTmBa0/+nLGWYWfk0pnripbQY6MyekyNiymU8FQ+mfPcGt4+mmQ7A0HE2MqUxz/8r7F+uoLGEnNmQ/OuinZma1j7QoFObousOXjXor0NILa1/EJ2w7WP3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZjolHmA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nWHBpZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZjolHmA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nWHBpZY"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734369165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ho2g2JVR/Wkh20uSYT1koH8iN5EU9nEd431AmzNkK0=;
	b=tZjolHmAa84GEQRZ+3Vx76cAXFZNIz9SwAlBhtJg894g7JzkWM2edI13BEN5PrvF7sl8oj
	jFU1meOAVPukd9oBoiPm9saY07iISQOtKx4TIKx5ObL7G5wyBfjoG8AItsObvPtC48QF54
	SB+R5etiJ49E3GFNrcvBWH+GCV5ItFZLXgJRhtgzqWO7bJUYAoJZ0G9+Onrea68atyfcYB
	iNvpuBsQ3BKGr5kIUiW8EWp4f78wdp6P5ju/PYj0MXPcp9bhMuRwkfUG6fhw+8ADbMFHeN
	cl4v+d08Adal+p0+j7DWmLnaansm3tRz6TUozyWgIYwy86hd1j1crcCLAYsppA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734369165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ho2g2JVR/Wkh20uSYT1koH8iN5EU9nEd431AmzNkK0=;
	b=4nWHBpZYK9THsJ7KAOWOZmMRG6EtQ3gJBVHg86XvG4ZBsokVNF+U4hf4XShEL01ysRAu/8
	bAIo93W1FTI4gSCQ==
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
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH tty-next v1 1/4] serial: 8250: Use @ier bits to determine if Rx is stopped
Date: Mon, 16 Dec 2024 18:18:41 +0106
Message-Id: <20241216171244.12783-2-john.ogness@linutronix.de>
In-Reply-To: <20241216171244.12783-1-john.ogness@linutronix.de>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f19c3f6c8109 ("serial: 8250_port: Don't service RX FIFO if
throttled") uses @read_status_mask (bit UART_LSR_DR) to determine
if Rx has been stopped. However, the bit UART_LSR_DR is not
managed properly in @read_status_mask for all Rx stop/start
situations and is therefore not suitable for this purpose.

Use the UART_IER_RLSI and UART_IER_RDI bits in @ier instead, as
this is already common in 8250-variants and drivers.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1ea52fce9bf1..4d742bfb7e9a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1931,7 +1931,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	 */
 	if (!(status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
 	    (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
-	    !(port->read_status_mask & UART_LSR_DR))
+	    !(up->ier & (UART_IER_RLSI | UART_IER_RDI)))
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-- 
2.39.5

