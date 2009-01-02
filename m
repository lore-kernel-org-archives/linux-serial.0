From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 73/75] hso modem detect fix patch against Alan Cox'es tty tree
Date: Fri, 02 Jan 2009 13:50:29 +0000
Message-ID: <20090102135026.13472.63459.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50530 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757596AbZABNuQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:50:16 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Denis Joseph Barrow <D.Barow@option.com>

Fixed incorrect check for the modem port, this prevents
crashes caused by issueing a tiocmget_submit_urb
on endpoints which don't exist for non modem devices.

Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/net/usb/hso.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index d974d97..148af34 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2663,7 +2663,7 @@ static struct hso_device *hso_create_bulk_serial_device(
 	serial->parent = hso_dev;
 	hso_dev->port_data.dev_serial = serial;
 
-	if (port & HSO_PORT_MODEM) {
+	if ((port & HSO_PORT_MASK) == HSO_PORT_MODEM) {
 		num_urbs = 2;
 		serial->tiocmget = kzalloc(sizeof(struct hso_tiocmget),
 					   GFP_KERNEL);

