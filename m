From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tty: fix typo in descripton of tty_termios_encode_baud_rate
Date: Tue, 12 Apr 2011 09:59:29 +0200
Message-ID: <1302595169-11607-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab1DLIAl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Apr 2011 04:00:41 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, trivial@kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/tty_ioctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 1a1135d..d73c593 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL(tty_termios_input_baud_rate);
  *	@ospeed: output speed
  *
  *	Encode the speeds set into the passed termios structure. This is
- *	used as a library helper for drivers os that they can report back
+ *	used as a library helper for drivers so that they can report back
  *	the actual speed selected when it differs from the speed requested
  *
  *	For maximal back compatibility with legacy SYS5/POSIX *nix behaviou=
r
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
