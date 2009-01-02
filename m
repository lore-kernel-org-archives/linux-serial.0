From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 18/75] sierra: Fix formatting
Date: Fri, 02 Jan 2009 13:42:56 +0000
Message-ID: <20090102134253.13472.47143.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60317 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755901AbZABNmm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:42:42 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Andrew Morton wrote:

in drivers/usb/serial/sierra.c:

        } else {
                if (urb->actual_length) {
+               tty = tty_port_tty_get(&port->port);
                        tty_buffer_request_room(tty, urb->actual_length);

it's missing a tab.


Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/sierra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 0f2b672..d9bf9a5 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -442,7 +442,7 @@ static void sierra_indat_callback(struct urb *urb)
 		    " endpoint %02x.", __func__, status, endpoint);
 	} else {
 		if (urb->actual_length) {
-		tty = tty_port_tty_get(&port->port);
+			tty = tty_port_tty_get(&port->port);
 			tty_buffer_request_room(tty, urb->actual_length);
 			tty_insert_flip_string(tty, data, urb->actual_length);
 			tty_flip_buffer_push(tty);

