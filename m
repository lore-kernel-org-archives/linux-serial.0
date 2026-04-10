Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97D3D7D9C;
	Fri, 10 Apr 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832595; cv=none; b=EyEUFwicSq3qis45Bp+ZG+EJq4RvhDyiIus5MHomLAcGhQ9U5Om1LhKmQPF5l8SGpqmMCvtlK8NiOSA3nFFny2H/uUUuy65dUJEwYBSZ0k8kMsJXIUekqP4BEyED/XvxmizqlT9NZJ9xA1//eaeH3efKzIxFH5FqKsoG3yPk2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832595; c=relaxed/simple;
	bh=/yAY0jq1UuuQMLALUWAvKPM7S/M9RGbX50BvhrIk2Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRNWpeAOlY22LK91quVw80NvqTtftOyJ2bxlpXwFQ7Zdw3jYV+MgN/hZSaC9aCJ1HNzVJxjOqfNdzXC4wntbUNVMcj/UmcjaZwbA3N7gW0zckHlpFWo91R4jM++G1cDM63kMALO97ofnEwdZv5jibAmztRbWwkOp+obWw5aUVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hi1A6YdJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAle+BM6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hi1A6YdJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAle+BM6"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775832590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hlFZ3Ig9z6SfYLYDIIXN5HPB+W7QsQE7LAS17xMxh7o=;
	b=Hi1A6YdJWkgGTC9B5wIS54H3uzE+iRRp9kUD4S3OnUmhK1T5szWuMnoZL5i5uZ/2KCEfpJ
	TUcJMvquwUkA2Uf9uaF7hFZAd6Y5RoFGvaG08+i0Zc8GXakw//TOMfa5F0nlD7zbaiUvDF
	34JNGKDI4ZVUG2Ho1ashOuoHOTa0IalA8tsOntRmBJQwv809vOoL6tQFM2iVAsoyZplhLb
	TD9QeuarNyJex7pbQi40qAoN+CgbEtGuWpMeffA1upblYui3srVcTZaIV1NxcLvUZAV2p2
	gYAmC5wK26IOqfXEVFzJOp3sT7T+hiMTGlrdDL/DFe8z5UUPUII8ReIk90Vx4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775832590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hlFZ3Ig9z6SfYLYDIIXN5HPB+W7QsQE7LAS17xMxh7o=;
	b=UAle+BM6WKPlUDFfahg46hrHU/moj34iUAkYwU/x81O14cjrRJ62/s54FDoBLNKI6YOzlf
	BktzlSUu133t/jDw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Gerhard Engleder <eg@keba.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>
Subject: [PATCH tty v2 0/2] 8250: Add console flow control
Date: Fri, 10 Apr 2026 16:54:32 +0206
Message-ID: <20260410144949.16581-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of a series to implement console flow control for the
8250 serial driver. v1 is here [0].

The 8250 driver already has code in place to support console flow
control. However, there is no way to activate it and it is
incomplete. This series provides the necessary missing pieces while
attempting to be as conservative as possible, so as not to introduce
any side effects into the many 8250 variants or other non-8250 serial
drivers.

Changes since v1:

- Prepend a patch to perform an extra LSR wait after CTS assertion if
  the initial LSR wait timed out.

- Close a window in serial8250_register_8250_port() where console
  flow control was briefly disabled.

- Add port lock synchronization to the port->status RMW update in
  uart_set_options().

John Ogness

[0] https://lore.kernel.org/lkml/20260331141502.6233-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Check LSR timeout on console flow control
  serial: 8250: Add support for console hardware flow control

 drivers/tty/serial/8250/8250_core.c |  6 +++++-
 drivers/tty/serial/8250/8250_port.c | 22 ++++++++++++++++++----
 drivers/tty/serial/serial_core.c    | 21 ++++++++++++++++++++-
 include/linux/serial_core.h         |  8 ++++++++
 4 files changed, 51 insertions(+), 6 deletions(-)


base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
-- 
2.47.3

