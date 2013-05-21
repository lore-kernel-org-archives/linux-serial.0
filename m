From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: add ACPI ID for Intel BayTrail
Date: Tue, 21 May 2013 09:34:24 +0300
Message-ID: <1369118064-21863-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15534 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab3EUGe1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 May 2013 02:34:27 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

This is the same controller as on Intel Lynxpoint but the
ACPI ID is different.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0b0eef9..d07b6af 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -369,6 +369,7 @@ MODULE_DEVICE_TABLE(of, dw8250_of_match);
 static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C4", 0 },
 	{ "INT33C5", 0 },
+	{ "80860F0A", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
1.7.10.4

