From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH] serial: st-asc: Fix unused variable warning for non DT.
Date: Thu,  1 Aug 2013 11:12:32 +0100
Message-ID: <1375351952-8185-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:58995 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055Ab3HAKYQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 06:24:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, srinivas.kandagatla@st.com

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes a below warning reported by kbuild test robot from
Greg.

tree:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   a54a4d5171bab310cb20fb62242ef87fa8443efb
commit: c4b058560762ec7ffe159b668fc47a8b7e271949 [2237/2506]
serial:st-asc: Add ST ASC driver.
config: make ARCH=i386 allyesconfig

All warnings:
drivers/tty/serial/st-asc.c:727:28: warning: 'asc_match' defined but
 not used [-Wunused-variable]

The code used in DT case is now ifdefed under CONFIG_OF to fix this
warning.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi Greg, 

By mistake I did resend the original '[PATCH v7] serial:st-asc: Add ST ASC
driver' with this warning fix.
However I realised that you just requested me to fix this warning with a new patch.

Can you please ignore '[PATCH v7] serial:st-asc: Add ST ASC driver' patch
and consider this patch to fix the warning.

Thankyou,
srini

 drivers/tty/serial/st-asc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 1838798..2ff4b1b 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -724,12 +724,14 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
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

