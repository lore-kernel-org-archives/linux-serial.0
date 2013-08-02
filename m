From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH-tty-next v2] serial: st-asc: Fix unused variable warning for non DT.
Date: Fri,  2 Aug 2013 10:23:51 +0100
Message-ID: <1375435431-7980-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:46172 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758440Ab3HBJff (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 05:35:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, srinivas.kandagatla@st.com

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes a below warning reported by kbuild test robot.

drivers/tty/serial/st-asc.c:727:28: warning: 'asc_match' defined but
 not used [-Wunused-variable]

The code used in DT case is now ifdefed under CONFIG_OF to fix this
warning.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Reported-by: Kbuild Test Robot <fengguang.wu@intel.com>
---
 drivers/tty/serial/st-asc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 1c1ecbd..81eb126 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -727,12 +727,14 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 	return &asc_ports[id];
 }
 
+#ifdef CONFIG_OF
 static struct of_device_id asc_match[] = {
 	{ .compatible = "st,asc", },
 	{},
 };
 
 MODULE_DEVICE_TABLE(of, asc_match);
+#endif
 
 static int asc_serial_probe(struct platform_device *pdev)
 {
-- 
1.7.6.5

