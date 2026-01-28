Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EA2DC798;
	Wed, 28 Jan 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597603; cv=none; b=LxyTIUkFvgMqKn0uyAyMre2O8jgHBA8/n4FlpnH02dIChfRI8N8n+k37cNhg7Zxn+XTY7UgnjTO/KhkaEBq3etr4z8qcreDntFYb6+9KWLui/2oUsNWL343zTRaV29ifN4YnUSO3Z0Swtd4ehp3syMjMNZLi3UjnS6Mp4zGyNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597603; c=relaxed/simple;
	bh=cxqya6naV8BftSWo4ZmUemQF8/Oa+5qqwuL49Z2lcIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyIRAv6Wlh/G3HCLgEGxqi50WbbDWNVId5vNQeyfQkCUGOaSOKlcsbs9lxXs7s1fXDpzhiR3U5v2dwqbmsd2vmrYKm5Y8e5IVic24r5MePtC+OVV/H3QtanIDIk5PXzlYm+o6cctQmcUsoaP+7FRt84trcs+3nHWEwkwQTKNh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/TqquI3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/TqquI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769597602; x=1801133602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxqya6naV8BftSWo4ZmUemQF8/Oa+5qqwuL49Z2lcIo=;
  b=f/TqquI3EjBHsaF7qaOsNZ8f159FaHvKbYq3AXdEe6M44yyIBrDh19vx
   VyhgH38nArSp6NtX1kJKUIsMIg/+z9v2Rw6zie4R65NFhrwl8qc9w31qG
   bVe7f7fQvjGanDoTYOOWwdlDT5qea7WhbOZ/eXD1rqWcoB2mnTkRY81eH
   FiHreFDBKvReq9e2rUnr7YO4zPwiTh4YUgjv4miBhn/RWdiDd05qUfQzK
   n9MUUdlHamZ4UelPvwmhqkkQNQgArxn8w0sjP2KF5DgHqJcvOxVFWBsBk
   bT3BV9Sorl+u8L26JLvtto0h0OtyQKXZGvWCO5wJCIhUHHtvwt8qNT0yi
   w==;
X-CSE-ConnectionGUID: 6de7jBFmSDS3mf665MITZw==
X-CSE-MsgGUID: z4wS1iIhSyuWlmVT9L1xUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70848795"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70848795"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:53:21 -0800
X-CSE-ConnectionGUID: lC6IONHgR/+9JrPD17Z4Sg==
X-CSE-MsgGUID: T3zc19QiRNeWuF2RlX4BoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212788070"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:53:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/7] serial: 8250: Protect LCR write in shutdown
Date: Wed, 28 Jan 2026 12:52:55 +0200
Message-Id: <20260128105301.1869-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 8250_dw driver needs to potentially perform very complex operations
during LCR writes because its BUSY handling prevents updates to LCR
while UART is BUSY (which is not fully under our control without those
complex operations). Thus, LCR writes should occur under port's lock.

Move LCR write under port's lock in serial8250_do_shutdown(). Also
split the LCR RMW so that the logic is on a separate line for clarity.

Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f7a3c5555204 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2350,6 +2350,7 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2376,13 +2377,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 			port->mctrl &= ~TIOCM_OUT2;
 
 		serial8250_set_mctrl(port, port->mctrl);
+
+		/* Disable break condition */
+		lcr = serial_port_in(port, UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+		serial_port_out(port, UART_LCR, lcr);
 	}
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 	rsa_disable(up);
-- 
2.39.5

