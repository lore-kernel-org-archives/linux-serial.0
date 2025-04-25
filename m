Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB3247296;
	Fri, 25 Apr 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579608; cv=none; b=nwqTE2MCludY4s773l9uF54GqNgTGFzl1XuC1g4EMKEwwLJiTDH2gVKyp7CJIv6s1wG6hi+5pp1SEk8GhQx3AADoBRCykxUgIJ3ZcsDaoOfarDW9Qr+cySpNK3uCTYzNZZCtwbK/DEDAnwdfjpT3qm9xF6vIovotCIFDM3kNPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579608; c=relaxed/simple;
	bh=eHzpMz9AO2Qs81JLFnHQfncC/xP1wFP/iEHlEzVp/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU0SEI+6m+qSooWyxCDGRuaIQddUa1zXH05dT9QTORX7MgV+QwCMKiOpvDGJgmTOoOeW/NiQ2a+qFJzuxgvHdmwzdZpZNO0ue3jVeR/6/cXvpZOp+3ehAf5kh2sL5pb11tKITVs3Cm9jrSpP2jHXqHJwY1H1noEjyCZuphaDV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOilTSPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOilTSPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BCBC4CEEB;
	Fri, 25 Apr 2025 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579607;
	bh=eHzpMz9AO2Qs81JLFnHQfncC/xP1wFP/iEHlEzVp/R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOilTSPn97sckrCaes4ytLfTlnasjomjxTYK1igsIYB+ZSi16VndVsaZnkqkarCfh
	 KnaWhepPzzbZEXRII+QdsaybpZ+1PaTyNQjhM7nBy4/ywTxW+KOXtSAPgVTxqXFdlf
	 xvnNeEaCGrbPkd/QHy85lhUaqpO2cEYtJkN84g5YFwsx0oPXdXY65m9Tl9kKohLpNj
	 O6DJdfmXjPK2L4d5bCPIrdOHW//A58B4RQvJ+idi1WFN1ZcLgH7Z2ZWgsky4SgmyJm
	 mbL5Li4JGW+3IWfKKZGtUDwkvkTc4tadvVIMBcHoY3OyvlWB/chWgRANWWnkQT5W/V
	 r8fpajVN1VnrQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/6] serial: 8250: unexport serial8250_rpm_*() functions
Date: Fri, 25 Apr 2025 13:13:15 +0200
Message-ID: <20250425111315.1036184-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8700a7ea5519 (serial: 8250_omap: Drop
pm_runtime_irq_safe()), all the serial8250_rpm_*() functions are used
solely in 8250_port.

Unexport them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250.h      |  6 ------
 drivers/tty/serial/8250/8250_port.c | 12 ++++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b861585ca02a..18530c31a598 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -223,12 +223,6 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 struct uart_8250_port *serial8250_setup_port(int index);
 struct uart_8250_port *serial8250_get_port(int line);
 
-void serial8250_rpm_get(struct uart_8250_port *p);
-void serial8250_rpm_put(struct uart_8250_port *p);
-
-void serial8250_rpm_get_tx(struct uart_8250_port *p);
-void serial8250_rpm_put_tx(struct uart_8250_port *p);
-
 int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 void serial8250_em485_start_tx(struct uart_8250_port *p, bool toggle_ier);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8d9bb91d4bae..6d7b8c4667c9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -517,22 +517,20 @@ void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
 
-void serial8250_rpm_get(struct uart_8250_port *p)
+static void serial8250_rpm_get(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
 	pm_runtime_get_sync(p->port.dev);
 }
-EXPORT_SYMBOL_GPL(serial8250_rpm_get);
 
-void serial8250_rpm_put(struct uart_8250_port *p)
+static void serial8250_rpm_put(struct uart_8250_port *p)
 {
 	if (!(p->capabilities & UART_CAP_RPM))
 		return;
 	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
-EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 
 /**
  *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
@@ -647,7 +645,7 @@ EXPORT_SYMBOL_GPL(serial8250_em485_config);
  * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
  * empty and the HW can idle again.
  */
-void serial8250_rpm_get_tx(struct uart_8250_port *p)
+static void serial8250_rpm_get_tx(struct uart_8250_port *p)
 {
 	unsigned char rpm_active;
 
@@ -659,9 +657,8 @@ void serial8250_rpm_get_tx(struct uart_8250_port *p)
 		return;
 	pm_runtime_get_sync(p->port.dev);
 }
-EXPORT_SYMBOL_GPL(serial8250_rpm_get_tx);
 
-void serial8250_rpm_put_tx(struct uart_8250_port *p)
+static void serial8250_rpm_put_tx(struct uart_8250_port *p)
 {
 	unsigned char rpm_active;
 
@@ -674,7 +671,6 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p)
 	pm_runtime_mark_last_busy(p->port.dev);
 	pm_runtime_put_autosuspend(p->port.dev);
 }
-EXPORT_SYMBOL_GPL(serial8250_rpm_put_tx);
 
 /*
  * IER sleep support.  UARTs which have EFRs need the "extended
-- 
2.49.0

