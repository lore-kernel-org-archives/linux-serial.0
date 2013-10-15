From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] serial: core: delete .set_wake() callback
Date: Tue, 15 Oct 2013 09:20:52 +0200
Message-ID: <1381821652-19569-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:62304 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab3JOHU7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 03:20:59 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so8149205wes.32
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 00:20:58 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@deeprootsystems.com>, Dmitry Artamonow <mad_soft@inbox.ru>

This deletes the .set_wake() callback in the struct uart_ops.
Apparently this has been unused since pre-git times. In the
old-2.6-bkcvs it is deleted as part of a changeset removing
the PM_SET_WAKEUP from pm_request_t which is since also deleted
from the kernel.

The apropriate way to set wakeups in the kernel is to have a
code snippet like this in .suspend() or .runtime_suspend()
callbacks:

static int foo_suspend(struct device *dev)
{
	if (device_may_wakeup(dev)) {
		/* Enable wakeups, set internal states */
	}
}

This specific callback is not coming back.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/serial/driver | 4 ----
 include/linux/serial_core.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 067c47d..c3a7689 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -264,10 +264,6 @@ hardware.
 	Locking: none.
 	Interrupts: caller dependent.
 
-  set_wake(port,state)
-	Enable/disable power management wakeup on serial activity.  Not
-	currently implemented.
-
   type(port)
 	Return a pointer to a string constant describing the specified
 	port, or return NULL, in which case the string 'unknown' is
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b98291a..f729be9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -66,7 +66,6 @@ struct uart_ops {
 	void		(*set_ldisc)(struct uart_port *, int new);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned int oldstate);
-	int		(*set_wake)(struct uart_port *, unsigned int state);
 
 	/*
 	 * Return a string describing the type of the port
-- 
1.8.3.1

