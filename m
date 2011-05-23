From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/48] Serial: ifx6x60c: Remove duplicate includes of linux/tty.h
Date: Mon, 23 May 2011 12:10:28 -0700
Message-ID: <1306177854-18172-22-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTLD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:03 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jesper Juhl <jj@chaosbits.net>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jesper Juhl <jj@chaosbits.net>

Including linux/tty.h 3 times is a little over the top - once will do.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 8ee5a41..5315525 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -41,7 +41,6 @@
 #include <linux/tty.h>
 #include <linux/device.h>
 #include <linux/spi/spi.h>
-#include <linux/tty.h>
 #include <linux/kfifo.h>
 #include <linux/tty_flip.h>
 #include <linux/timer.h>
@@ -56,7 +55,6 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/wait.h>
-#include <linux/tty.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/ifx_modem.h>
-- 
1.7.4.2

