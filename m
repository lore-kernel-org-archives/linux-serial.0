From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] tty: Allow uart_register/unregister/register
Date: Mon, 14 May 2012 14:51:22 +0100
Message-ID: <20120514135110.22791.13351.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43129 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab2ENNwV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 May 2012 09:52:21 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This is legitimate but because we don't clear the drv->state pointer in the
unregister code causes a bogus BUG().

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=42880
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/serial_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c4c05b..246b823 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2282,6 +2282,7 @@ void uart_unregister_driver(struct uart_driver *drv)
 	tty_unregister_driver(p);
 	put_tty_driver(p);
 	kfree(drv->state);
+	drv->state = NULL;
 	drv->tty_driver = NULL;
 }
 

