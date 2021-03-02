Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC4321A
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 03:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F0964EBD
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 03:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhCCCKl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:10:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:39600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577536AbhCBGXu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3BCCAF96;
        Tue,  2 Mar 2021 06:22:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/44] tty: remove TTY_LDISC_MAGIC
Date:   Tue,  2 Mar 2021 07:21:38 +0100
Message-Id: <20210302062214.29627-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

First, it is never checked. Second, use of it as a debugging aid is
at least questionable. With the current tools, I don't think anyone used
this kind of thing for debugging purposes for years.

On the top of that, e.g. serdev does not set this field of tty_ldisc_ops
at all.

So get rid of this legacy.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 drivers/accessibility/speakup/spk_ttyio.c                 | 1 -
 drivers/bluetooth/hci_ldisc.c                             | 1 -
 drivers/misc/ti-st/st_core.c                              | 1 -
 drivers/net/caif/caif_serial.c                            | 1 -
 drivers/net/can/slcan.c                                   | 1 -
 drivers/net/hamradio/6pack.c                              | 1 -
 drivers/net/hamradio/mkiss.c                              | 1 -
 drivers/net/ppp/ppp_async.c                               | 1 -
 drivers/net/ppp/ppp_synctty.c                             | 1 -
 drivers/net/slip/slip.c                                   | 1 -
 drivers/pps/clients/pps-ldisc.c                           | 3 ---
 drivers/tty/n_gsm.c                                       | 1 -
 drivers/tty/n_hdlc.c                                      | 1 -
 drivers/tty/n_null.c                                      | 1 -
 drivers/tty/n_r3964.c                                     | 1 -
 drivers/tty/n_tty.c                                       | 1 -
 include/linux/tty_ldisc.h                                 | 3 ---
 net/nfc/nci/uart.c                                        | 1 -
 sound/soc/codecs/cx20442.c                                | 1 -
 sound/soc/ti/ams-delta.c                                  | 1 -
 23 files changed, 27 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
index 89992fe4863f..f5ba36e96461 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -88,7 +88,6 @@ TTY_MAGIC             0x5401           tty_struct               ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
-TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/linux/tty_ldisc.h``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index 9be170ec0d02..e8c782d155a3 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -94,7 +94,6 @@ TTY_MAGIC             0x5401           tty_struct               ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
-TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/linux/tty_ldisc.h``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
index 191d705349ef..42f0635ca70a 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -77,7 +77,6 @@ TTY_MAGIC             0x5401           tty_struct               ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
-TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/linux/tty_ldisc.h``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/net/ethernet/dec/tulip/de2104x.c``
 USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/usb/class/bluetty.c``
diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 9af1d4c124d3..2e39fcf492d8 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -104,7 +104,6 @@ static int spk_ttyio_receive_buf2(struct tty_struct *tty,
 
 static struct tty_ldisc_ops spk_ttyio_ldisc_ops = {
 	.owner          = THIS_MODULE,
-	.magic          = TTY_LDISC_MAGIC,
 	.name           = "speakup_ldisc",
 	.open           = spk_ttyio_ldisc_open,
 	.close          = spk_ttyio_ldisc_close,
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 637c5b8c2aa1..71a4ca505e09 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -821,7 +821,6 @@ static __poll_t hci_uart_tty_poll(struct tty_struct *tty,
 
 static struct tty_ldisc_ops hci_uart_ldisc = {
 	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
 	.name		= "n_hci",
 	.open		= hci_uart_tty_open,
 	.close		= hci_uart_tty_close,
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 5a0a5fc3d3ab..071844b58073 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -845,7 +845,6 @@ static void st_tty_flush_buffer(struct tty_struct *tty)
 }
 
 static struct tty_ldisc_ops st_ldisc_ops = {
-	.magic = TTY_LDISC_MAGIC,
 	.name = "n_st",
 	.open = st_tty_open,
 	.close = st_tty_close,
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 8215cd77301f..675c374b32ee 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -382,7 +382,6 @@ static void ldisc_close(struct tty_struct *tty)
 /* The line discipline structure. */
 static struct tty_ldisc_ops caif_ldisc = {
 	.owner =	THIS_MODULE,
-	.magic =	TTY_LDISC_MAGIC,
 	.name =		"n_caif",
 	.open =		ldisc_open,
 	.close =	ldisc_close,
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 30c8d53c9745..31ba6664503d 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -697,7 +697,6 @@ static int slcan_ioctl(struct tty_struct *tty, struct file *file,
 
 static struct tty_ldisc_ops slc_ldisc = {
 	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
 	.name		= "slcan",
 	.open		= slcan_open,
 	.close		= slcan_close,
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 71d6629e65c9..6f71eff9c52e 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -749,7 +749,6 @@ static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 
 static struct tty_ldisc_ops sp_ldisc = {
 	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
 	.name		= "6pack",
 	.open		= sixpack_open,
 	.close		= sixpack_close,
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 17be2bb2985c..65154224d5b8 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -933,7 +933,6 @@ static void mkiss_write_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ax_ldisc = {
 	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
 	.name		= "mkiss",
 	.open		= mkiss_open,
 	.close		= mkiss_close,
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 2a91caa4f37b..8b41aa3fb64e 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -372,7 +372,6 @@ ppp_asynctty_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ppp_ldisc = {
 	.owner  = THIS_MODULE,
-	.magic	= TTY_LDISC_MAGIC,
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,
 	.close	= ppp_asynctty_close,
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index d8890923a9e3..576b6a93bf23 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -365,7 +365,6 @@ ppp_sync_wakeup(struct tty_struct *tty)
 
 static struct tty_ldisc_ops ppp_sync_ldisc = {
 	.owner	= THIS_MODULE,
-	.magic	= TTY_LDISC_MAGIC,
 	.name	= "pppsync",
 	.open	= ppp_sync_open,
 	.close	= ppp_sync_close,
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index f81fb0b13a94..1ab124eba8eb 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1263,7 +1263,6 @@ static int sl_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 static struct tty_ldisc_ops sl_ldisc = {
 	.owner 		= THIS_MODULE,
-	.magic 		= TTY_LDISC_MAGIC,
 	.name 		= "slip",
 	.open 		= slip_open,
 	.close	 	= slip_close,
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 4fd0cbf7f931..bf26cc56b863 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -13,8 +13,6 @@
 #include <linux/pps_kernel.h>
 #include <linux/bug.h>
 
-#define PPS_TTY_MAGIC		0x0001
-
 static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 {
 	struct pps_device *pps;
@@ -114,7 +112,6 @@ static int __init pps_tty_init(void)
 
 	/* Init PPS_TTY data */
 	pps_ldisc_ops.owner = THIS_MODULE;
-	pps_ldisc_ops.magic = PPS_TTY_MAGIC;
 	pps_ldisc_ops.name = "pps_tty";
 	pps_ldisc_ops.dcd_change = pps_tty_dcd_change;
 	pps_ldisc_ops.open = pps_tty_open;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 51dafc06f541..b063bc608a8c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2849,7 +2849,6 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 /* Line discipline for real tty */
 static struct tty_ldisc_ops tty_ldisc_packet = {
 	.owner		 = THIS_MODULE,
-	.magic           = TTY_LDISC_MAGIC,
 	.name            = "n_gsm",
 	.open            = gsmld_open,
 	.close           = gsmld_close,
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 1363e659dc1d..290c757db1b9 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -787,7 +787,6 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 
 static struct tty_ldisc_ops n_hdlc_ldisc = {
 	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
 	.name		= "hdlc",
 	.open		= n_hdlc_tty_open,
 	.close		= n_hdlc_tty_close,
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index ce03ae78f5c6..b8f67b5f1ef8 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -40,7 +40,6 @@ static void n_null_receivebuf(struct tty_struct *tty,
 
 static struct tty_ldisc_ops null_ldisc = {
 	.owner		=	THIS_MODULE,
-	.magic		=	TTY_LDISC_MAGIC,
 	.name		=	"n_null",
 	.open		=	n_null_open,
 	.close		=	n_null_close,
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index 3161f0a535e3..2eb76ea1d88d 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -146,7 +146,6 @@ static void r3964_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 
 static struct tty_ldisc_ops tty_ldisc_N_R3964 = {
 	.owner = THIS_MODULE,
-	.magic = TTY_LDISC_MAGIC,
 	.name = "R3964",
 	.open = r3964_open,
 	.close = r3964_close,
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 87ec15dbe10d..7c53185bce57 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2488,7 +2488,6 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 }
 
 static struct tty_ldisc_ops n_tty_ops = {
-	.magic           = TTY_LDISC_MAGIC,
 	.name            = "n_tty",
 	.open            = n_tty_open,
 	.close           = n_tty_close,
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 572a07976116..31284b55bd4f 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -173,7 +173,6 @@ extern int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
 
 
 struct tty_ldisc_ops {
-	int	magic;
 	char	*name;
 	int	num;
 	int	flags;
@@ -218,8 +217,6 @@ struct tty_ldisc {
 	struct tty_struct *tty;
 };
 
-#define TTY_LDISC_MAGIC	0x5403
-
 #define LDISC_FLAG_DEFINED	0x00000001
 
 #define MODULE_ALIAS_LDISC(ldisc) \
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 1204c438e87d..16d009c9b6a0 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -453,7 +453,6 @@ void nci_uart_set_config(struct nci_uart *nu, int baudrate, int flow_ctrl)
 EXPORT_SYMBOL_GPL(nci_uart_set_config);
 
 static struct tty_ldisc_ops nci_uart_ldisc = {
-	.magic		= TTY_LDISC_MAGIC,
 	.owner		= THIS_MODULE,
 	.name		= "n_nci",
 	.open		= nci_uart_tty_open,
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 161be8b7d131..61dfa86d444d 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -285,7 +285,6 @@ static void v253_wakeup(struct tty_struct *tty)
 }
 
 struct tty_ldisc_ops v253_ops = {
-	.magic = TTY_LDISC_MAGIC,
 	.name = "cx20442",
 	.owner = THIS_MODULE,
 	.open = v253_open,
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 57feb473a579..98198c7cc872 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -395,7 +395,6 @@ static void cx81801_wakeup(struct tty_struct *tty)
 }
 
 static struct tty_ldisc_ops cx81801_ops = {
-	.magic = TTY_LDISC_MAGIC,
 	.name = "cx81801",
 	.owner = THIS_MODULE,
 	.open = cx81801_open,
-- 
2.30.1

