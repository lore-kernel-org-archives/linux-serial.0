From: Sheng Yang <sheng@linux.intel.com>
Subject: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 11:55:20 +0800
Message-ID: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36520 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbYKYD7E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2008 22:59:04 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Sheng Yang <sheng@linux.intel.com>, Alan Cox <alan@redhat.com>

The patch based on linux-2.6 upstream and elimiate this compile warning
info:

drivers/serial/8250.c: In function =E2=80=98serial8250_shutdown=E2=80=99=
:
drivers/serial/8250.c:1612: warning: =E2=80=98i=E2=80=99 may be used un=
initialized in this
function

Signed-off-by: Sheng Yang <sheng@linux.intel.com>
CC: Alan Cox <alan@redhat.com>
---
 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..c78eee6 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1609,7 +1609,7 @@ static int serial_link_irq_chain(struct uart_8250=
_port *up)
=20
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i =3D NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
=20
--=20
1.5.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
