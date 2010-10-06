From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: [PATCH] MAINTAINERS: add drivers/serial/jsm/ as maintained driver
Date: Wed,  6 Oct 2010 13:04:48 -0300
Message-ID: <1286381088-7614-1-git-send-email-leitao@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:60544 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758743Ab0JFQEy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Oct 2010 12:04:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: Scott.Kilau@digi.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Breno Leitao <leitao@linux.vnet.ibm.com>

Soott Kilau is handing off the maintainership of the jsm serial
driver to me, and this patch just add the driver as maintained.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f46d8e6..581a2e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3309,6 +3309,12 @@ F:	fs/jbd*/
 F:	include/linux/ext*jbd*.h
 F:	include/linux/jbd*.h
 
+JSM Neo PCI based serial card
+M:	Breno Leitao <leitao@linux.vnet.ibm.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/serial/jsm/
+
 K8TEMP HARDWARE MONITORING DRIVER
 M:	Rudolf Marek <r.marek@assembler.cz>
 L:	lm-sensors@lm-sensors.org
-- 
1.7.2.3

