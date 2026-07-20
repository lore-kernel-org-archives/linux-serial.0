Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B63CF661;
	Mon, 20 Jul 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543567; cv=none; b=CHws+8yV4tagbJ4szEsdC85wjCwCyeurue8K6HOCKplfma5dn5xbsPqZ5k04L0LsZiOVwB9/CWlzwBbGwNgrVYYjW+nfvtUle1QxK32XVQ5N+dAm6UqLGq4mxXfwGnPujShTU83sYrquLtykMnthh6ELKxU0fmWDbS88B9V7rdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543567; c=relaxed/simple;
	bh=fOLQPypBqLakN9NzeQOtRvF0zSrNRd6mu2INkigel7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBgl0ccef0q/RP3TdCEkIN4rN9k848lz3cur7j7YqCPWhndcFQSfSwknduQrNp4NxynkTcd/EfwXURmpBWvrJenfmWjddTpWeN4e7+gKEwkAYs/uwHjIHp9byG8nAeO/fjUjUOCxss/47Qj+IDY1l3WnNar9dwMfNockFcASSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQNBUS/4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wMWmWvkM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQNBUS/4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wMWmWvkM"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784543564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmzfUV7yN3t3OGtQoucKK5a3duwhcKv2UdUsSbzs070=;
	b=YQNBUS/4XdoAds7rTxR4AtTC6HSi2NzTLRanPmrq7H7OcKMaspCFXIjEF/2dtqxKNEXyzQ
	pvBwax8OK4kXxMSRkKmLYg9MKeD8WdweBm5rx8qtJj37x7OjCd6oWPtY85mLECcx2FSlYb
	YyY0RiNEr7PmfKPcLD4OE8Czg/Oyz7s98ml/0ivza1oVAvnIDbcKmrc4GdubFVcgeeQm1b
	fnhyFy9PxOrbpZM17G7jKrhVgrxGcIh1AJBla77Yjix2TzYaO0eHarXxEh+9D3OhiMI5Cf
	Xx36C9GiGWtUTRxtiYSSe0t3AZSuKoqQF9G2W6sWtfWt12Jff0vEaVSTB12fTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784543564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmzfUV7yN3t3OGtQoucKK5a3duwhcKv2UdUsSbzs070=;
	b=wMWmWvkMkWVk3xDLofDES0Dgnx9ugnOET2md1Dvu7Z1bY4s0DzAhkn22QW8VRp8HZzasLf
	TmluhcQYv3bj/BAw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v6 2/2] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Mon, 20 Jul 2026 12:38:36 +0206
Message-ID: <20260720103242.7265-3-john.ogness@linutronix.de>
In-Reply-To: <20260720103242.7265-1-john.ogness@linutronix.de>
References: <20260720103242.7265-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8250 driver no longer depends on @oops_in_progress and
will no longer violate the port->lock locking constraints.

This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3e623b71dadbc..ca736b1bd0726 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -719,6 +719,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.47.3

