Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD642701C7;
	Thu, 14 Aug 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156305; cv=none; b=RxjslOaWllo62iRlyIfBkW4u3HFPizCKk03qN/FmeAmS6M+6EzycHMWr+hoGpTfKG7GJUsXtjabZwOOeX9uDx6D6RSqC+KKZlSRy7J2NksySYvOBXJfDck6eE4W+0n861TYwBDMn3cfXDEXjkoXQPS+P99OgONddzESH66iaW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156305; c=relaxed/simple;
	bh=S1VXROGbdYGweB7NWPiJuBRig6fR6b4iGEMKTCBRAX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr5ZQ+WG0AR/Cn8khdF34q3LVhm45oWTl75qXbONPkhvUPtWn5mDlSSvCfhrJiLHICFSDGE58/A4nLMwMHTlcFMFHUogLIWPd9Y76DEBXCk0tOO3qb0eBbSeEUht17l8bPJaeoycuCWLqZIMWJQ3s8if8i2irUGxJuWSDJBDEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GODbWQ/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GODbWQ/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B680C4CEF4;
	Thu, 14 Aug 2025 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156305;
	bh=S1VXROGbdYGweB7NWPiJuBRig6fR6b4iGEMKTCBRAX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GODbWQ/uzHqLGxPZhaCpn6DYDPSc6ig7fCrsZgZvMlJC0/YXRRNQm50gN5IZxEidB
	 6zxDNfgGS0/1MyIoyjv9eu8RXbSZY55x4++AJedqA1Y0dcLa2g7+mKgtppKRt1mQ9V
	 jERhPBwXK1DWFIiI4cR337ls8XMMo92aovzavGRcqzHgbPCAVaFtHh8W58RnlkHVL9
	 N0u/Y1DXhxeRpnGEB+z8ZNlgkfHAPCVM0dbfgO1otzT47eta1c+6s+SAv3x4eTxwCU
	 L1xcEvI8wJbCbO0IEy4VQAgU249xa+JfJkidZWDdnKVS1rH7JrxUDTG4Uv3k1yf4AU
	 +ODaiTJJDig3w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/16] serial: 8250: introduce RPM guard()s
Date: Thu, 14 Aug 2025 09:24:44 +0200
Message-ID: <20250814072456.182853-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having this, guards like these work:
  guard(serial8250_rpm)(up);
or
  scoped_guard(serial8250_rpm, up) {
    ...
  }

See e.g. "serial: 8250: use guard()s" later in this series.

And make them available to anyone (EXPORT + put in 8250.h) as drivers
open code this anyway.

The _tx ones are not defined as they would have no user.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250.h      | 5 +++++
 drivers/tty/serial/8250/8250_port.c | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index cfe6ba286b45..58e64c4e1e3a 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -186,6 +186,11 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 
+void serial8250_rpm_get(struct uart_8250_port *p);
+void serial8250_rpm_put(struct uart_8250_port *p);
+DEFINE_GUARD(serial8250_rpm, struct uart_8250_port *,
+	     serial8250_rpm_get(_T), serial8250_rpm_put(_T));
+
 static inline u32 serial_dl_read(struct uart_8250_port *up)
 {
 	return up->dl_read(up);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2da9db960d09..5afae4025696 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -508,20 +508,22 @@ void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
 
-static void serial8250_rpm_get(struct uart_8250_port *p)
+void serial8250_rpm_get(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
 	pm_runtime_get_sync(p->port.dev);
 }
+EXPORT_SYMBOL_GPL(serial8250_rpm_get);
 
-static void serial8250_rpm_put(struct uart_8250_port *p)
+void serial8250_rpm_put(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
 	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
+EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 
 /**
  *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
-- 
2.50.1

