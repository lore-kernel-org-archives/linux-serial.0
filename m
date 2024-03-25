Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06F186384
	for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351062; cv=none; b=WKx9OkUpiNdtrDyJKh8qQqnsm04+Jl6iuELyAMNoSB1EjdLbyHF2SMM4VwPrFHrAGOIl2I4KHmqJsm9YM6bwT3ZWo1b9M+LQm26Ib55QJi32CLnDNhD8Z9dAv9QcOmnc8c2xscSotqgVOQJBYVwVZed3N6aQuXDT06m17E0HbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351062; c=relaxed/simple;
	bh=zMOcC1a59osUvpc/55HzXpX2Y+BiLY1d1zGVzvm3oPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlFu0PuAkpV+qJlki0puIL94yPLNdWQelYox6Bz3UF5vG4z5gxAdosTvjXJkD780pCKnCBwMzJxNKFt4L9Unn6RHJ0j11ixcdrPoUZLTot0GeXqj9WVI0cYXZ5ryVuj3yB1Bcwqdu4UbjwJM4P3X+8k0dWKWDFF9NkNrIVYs0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=F+MIFHTU; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="F+MIFHTU"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 56CD16035A;
	Mon, 25 Mar 2024 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711351053;
	bh=zMOcC1a59osUvpc/55HzXpX2Y+BiLY1d1zGVzvm3oPo=;
	h=From:To:Cc:Subject:Date:From;
	b=F+MIFHTUnXoB27fIGY8RwTvrEz6tdWBQp1hvcv5GEuQJLwSHOuAUR6l2WsZ1alpJf
	 7ex9w2Ye0BAtpPLrB86EYodDYBTGyjDVkdnqVGUPtrUwTIABsxvIFZFV6hSFDnk29s
	 gwt+ckfGVQh0pYI0Iyqfoi4aDdeJvqMQ7iSBrwehEQU+TVHtPq917J+/u0nkIDyvDk
	 XzPDlvBnKs9rHiE7uBJgngA62UpzlKhtFoErtA6/SWqWluyJ2vd7Ev99mzmYuhO0LA
	 /P35ebYIdPPIBy2gSgqVafgOEDVA+CfFHK81pFXkBpDb3jxTRn+TjiH9h7J4HdhvhH
	 SaX3fe0jIqlJA==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nick Bowler <nbowler@draconx.ca>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: core: Fix regression when runtime PM is not enabled
Date: Mon, 25 Mar 2024 09:16:47 +0200
Message-ID: <20240325071649.27040-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 45a3a8ef8129 ("serial: core: Revert checks for tx runtime PM state")
caused a regression for Sun Ultra 60 for the sunsab driver as reported by
Nick Bowler <nbowler@draconx.ca>.

We need to add back the check runtime PM enabled state for serial port
controller device, I wrongly assumed earlier we could just remove it.

Fixes: 45a3a8ef8129 ("serial: core: Revert checks for tx runtime PM state")
Reported-by: Nick Bowler <nbowler@draconx.ca>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
-- 
2.44.0
