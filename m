From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 58/79] tty/n_gsm: fix bug in tiocmset
Date: Wed, 26 Oct 2011 14:13:03 +0200
Message-ID: <1319631204-23262-58-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32831 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab1JZMNz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:55 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>

Clear bitmask was not inverted before masking modem_tx.

Calling ioctl(fd, TIOCMBIC, TIOCM_RTS) results in:

[  197.430000] pre_modem_tx:	0x00000006
[  197.430000] clear:			0x00000004
[  197.430000] set:			0x00000000
[  197.440000] post_modem_tx:	0x00000004

which is wrong.

Signed-off-by: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>
Acked-by: Alan Cox <alan@linx.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8d7766b..da3b31a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2989,7 +2989,7 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 	struct gsm_dlci *dlci = tty->driver_data;
 	unsigned int modem_tx = dlci->modem_tx;
 
-	modem_tx &= clear;
+	modem_tx &= ~clear;
 	modem_tx |= set;
 
 	if (modem_tx != dlci->modem_tx) {
-- 
1.7.7

