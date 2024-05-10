Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C584135A63
	for <linux-serial@vger.kernel.org>; Fri, 10 May 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338951; cv=none; b=rq0e5jzHcsvVnA6AEpqby4Idv02Ax95DJRTig/da4tXV6J7n3ah1pucedpQlHERY0uFshs0dBpvtKKAptB+UlHu/15b9vzfhOWvvO2UQto+KxOokLKxv93EuT3lxnQv+rop6is9834YD2yK9GghD6i57BYng3aD5NoVZoHCoczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338951; c=relaxed/simple;
	bh=dUBrlzpR4IR+l7Ds9JK558DMuZcqv5kbZtHSgEgFyf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2pLUuzCmlUKn6m8PQScpM8/B0QLReC18Nd0dxBdpZ+swwBwAChMApad2n3+C4sbBBufN77+o6Dp9Sivfe8Gqe9gn2Cbl9fJwae9b9t09mS8DRK7+VWK3G9OuMUsGjzsf2yAePHknlT3t4IootPATBec6wTakDgjcyhTX9gWxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AWNDpV7u; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AWNDpV7u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715338946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OFi2O84ZjGzksvFyL3NIFcB+aK/jsbmnLmBT3YBCaAk=;
	b=AWNDpV7uTIIXRzzM91qkJ0TeQUeE5mDbcuP5z8TqZYrDUjl0k4z4OVEDx8o3gw7JU6F1na
	m4DgwJ0h6Q0n9OMad+A/n/3K3ph4tWxF9j7mNZ8cRtTHQEsi0CtJzGA0OD/T9Tgs2h7o+P
	Gh5ajN2j11yVoDb+QaxcAwKTEfNrWo0=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Date: Fri, 10 May 2024 11:04:05 +0000
Message-ID: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
of serial core port device") changed the hierarchy of serial port devices
and device_find_child_by_name cannot find ttyS* devices because they are
no longer directly attached. Add some logic to restore symlinks creation
to the driver for OCP TimeCard.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v2:
 add serial/8250 maintainers
---
 drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index ee2ced88ab34..50b7cb9db3be 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -25,6 +25,8 @@
 #include <linux/crc16.h>
 #include <linux/dpll.h>
 
+#include "../tty/serial/8250/8250.h"
+
 #define PCI_VENDOR_ID_FACEBOOK			0x1d9b
 #define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
 
@@ -4330,11 +4332,9 @@ ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
 }
 
 static void
-ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
+ptp_ocp_link_child(struct ptp_ocp *bp, struct device *dev, const char *name, const char *link)
 {
-	struct device *dev, *child;
-
-	dev = &bp->pdev->dev;
+	struct device *child;
 
 	child = device_find_child_by_name(dev, name);
 	if (!child) {
@@ -4349,27 +4349,39 @@ ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
 static int
 ptp_ocp_complete(struct ptp_ocp *bp)
 {
+	struct device *dev, *port_dev;
+	struct uart_8250_port *port;
 	struct pps_device *pps;
 	char buf[32];
 
+	dev = &bp->pdev->dev;
+
 	if (bp->gnss_port.line != -1) {
+		port = serial8250_get_port(bp->gnss_port.line);
+		port_dev = (struct device *)port->port.port_dev;
 		sprintf(buf, "ttyS%d", bp->gnss_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyGNSS");
+		ptp_ocp_link_child(bp, port_dev, buf, "ttyGNSS");
 	}
 	if (bp->gnss2_port.line != -1) {
+		port = serial8250_get_port(bp->gnss2_port.line);
+		port_dev = (struct device *)port->port.port_dev;
 		sprintf(buf, "ttyS%d", bp->gnss2_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyGNSS2");
+		ptp_ocp_link_child(bp, port_dev, buf, "ttyGNSS2");
 	}
 	if (bp->mac_port.line != -1) {
+		port = serial8250_get_port(bp->mac_port.line);
+		port_dev = (struct device *)port->port.port_dev;
 		sprintf(buf, "ttyS%d", bp->mac_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyMAC");
+		ptp_ocp_link_child(bp, port_dev, buf, "ttyMAC");
 	}
 	if (bp->nmea_port.line != -1) {
+		port = serial8250_get_port(bp->nmea_port.line);
+		port_dev = (struct device *)port->port.port_dev;
 		sprintf(buf, "ttyS%d", bp->nmea_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyNMEA");
+		ptp_ocp_link_child(bp, port_dev, buf, "ttyNMEA");
 	}
 	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
-	ptp_ocp_link_child(bp, buf, "ptp");
+	ptp_ocp_link_child(bp, dev, buf, "ptp");
 
 	pps = pps_lookup_dev(bp->ptp);
 	if (pps)
-- 
2.43.0

