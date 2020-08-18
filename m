Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27531C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32EE2067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHRI5L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHRI5C (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEC83B035;
        Tue, 18 Aug 2020 08:57:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/8] tty: synclink, fix kernel-doc
Date:   Tue, 18 Aug 2020 10:56:54 +0200
Message-Id: <20200818085655.12071-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As in the previous patches, fix kernel-doc in synclink drivers. This is
done separately from others, as kernel-doc comments were heavily broken
in these drivers. Convert them to proper ones.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/synclink.c    | 82 +++++++++++++++++++-------------------
 drivers/tty/synclink_gt.c | 81 ++++++++++++++++++--------------------
 drivers/tty/synclinkmp.c  | 83 +++++++++++++++++++--------------------
 3 files changed, 119 insertions(+), 127 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 0dba40eace46..c8324d58ef56 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -942,7 +942,7 @@ static inline int mgsl_paranoia_check(struct mgsl_struct *info,
 	return 0;
 }
 
-/**
+/*
  * line discipline callback wrappers
  *
  * The wrappers maintain line discipline references
@@ -7419,14 +7419,14 @@ static int usc_loopmode_active( struct mgsl_struct * info)
 #if SYNCLINK_GENERIC_HDLC
 
 /**
- * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
- * set encoding and frame check sequence (FCS) options
+ * hdlcdev_attach - called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
+ * @dev:      pointer to network device structure
+ * @encoding: serial encoding setting
+ * @parity:   FCS setting
  *
- * dev       pointer to network device structure
- * encoding  serial encoding setting
- * parity    FCS setting
+ * Set encoding and frame check sequence (FCS) options.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 			  unsigned short parity)
@@ -7468,10 +7468,9 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 }
 
 /**
- * called by generic HDLC layer to send frame
- *
- * skb  socket buffer containing HDLC frame
- * dev  pointer to network device structure
+ * hdlcdev_xmit - called by generic HDLC layer to send a frame
+ * @skb: socket buffer containing HDLC frame
+ * @dev: pointer to network device structure
  */
 static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
@@ -7509,12 +7508,12 @@ static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 }
 
 /**
- * called by network layer when interface enabled
- * claim resources and initialize hardware
+ * hdlcdev_open - called by network layer when interface enabled
+ * @dev: pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Claim resources and initialize hardware.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_open(struct net_device *dev)
 {
@@ -7568,12 +7567,12 @@ static int hdlcdev_open(struct net_device *dev)
 }
 
 /**
- * called by network layer when interface is disabled
- * shutdown hardware and release resources
+ * hdlcdev_close - called by network layer when interface is disabled
+ * @dev: pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Shutdown hardware and release resources.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_close(struct net_device *dev)
 {
@@ -7598,13 +7597,12 @@ static int hdlcdev_close(struct net_device *dev)
 }
 
 /**
- * called by network layer to process IOCTL call to network device
- *
- * dev  pointer to network device structure
- * ifr  pointer to network interface request structure
- * cmd  IOCTL command code
+ * hdlcdev_ioctl - called by network layer to process IOCTL call to network device
+ * @dev: pointer to network device structure
+ * @ifr: pointer to network interface request structure
+ * @cmd: IOCTL command code
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
@@ -7702,9 +7700,9 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 /**
- * called by network layer when transmit timeout is detected
+ * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
  *
- * dev  pointer to network device structure
+ * @dev: pointer to network device structure
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -7725,10 +7723,10 @@ static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 /**
- * called by device driver when transmit completes
- * reenable network layer transmit if stopped
+ * hdlcdev_tx_done - called by device driver when transmit completes
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Reenable network layer transmit if stopped.
  */
 static void hdlcdev_tx_done(struct mgsl_struct *info)
 {
@@ -7737,12 +7735,12 @@ static void hdlcdev_tx_done(struct mgsl_struct *info)
 }
 
 /**
- * called by device driver when frame received
- * pass frame to network layer
+ * hdlcdev_rx - called by device driver when frame received
+ * @info: pointer to device instance information
+ * @buf:  pointer to buffer contianing frame data
+ * @size: count of data bytes in buf
  *
- * info  pointer to device instance information
- * buf   pointer to buffer contianing frame data
- * size  count of data bytes in buf
+ * Pass frame to network layer.
  */
 static void hdlcdev_rx(struct mgsl_struct *info, char *buf, int size)
 {
@@ -7778,12 +7776,12 @@ static const struct net_device_ops hdlcdev_ops = {
 };
 
 /**
- * called by device driver when adding device instance
- * do generic HDLC initialization
+ * hdlcdev_init - called by device driver when adding device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC initialization.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_init(struct mgsl_struct *info)
 {
@@ -7827,10 +7825,10 @@ static int hdlcdev_init(struct mgsl_struct *info)
 }
 
 /**
- * called by device driver when removing device instance
- * do generic HDLC cleanup
+ * hdlcdev_exit - called by device driver when removing device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC cleanup.
  */
 static void hdlcdev_exit(struct mgsl_struct *info)
 {
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index b794177ccfb9..917cc611ad25 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1395,14 +1395,14 @@ static int set_break(struct tty_struct *tty, int break_state)
 #if SYNCLINK_GENERIC_HDLC
 
 /**
- * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
- * set encoding and frame check sequence (FCS) options
+ * hdlcdev_attach - called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
+ * @dev:      pointer to network device structure
+ * @encoding: serial encoding setting
+ * @parity:   FCS setting
  *
- * dev       pointer to network device structure
- * encoding  serial encoding setting
- * parity    FCS setting
+ * Set encoding and frame check sequence (FCS) options.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 			  unsigned short parity)
@@ -1446,10 +1446,9 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 }
 
 /**
- * called by generic HDLC layer to send frame
- *
- * skb  socket buffer containing HDLC frame
- * dev  pointer to network device structure
+ * hdlcdev_xmit - called by generic HDLC layer to send a frame
+ * @skb: socket buffer containing HDLC frame
+ * @dev: pointer to network device structure
  */
 static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
@@ -1483,12 +1482,12 @@ static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 }
 
 /**
- * called by network layer when interface enabled
- * claim resources and initialize hardware
+ * hdlcdev_open - called by network layer when interface enabled
+ * @dev: pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Claim resources and initialize hardware.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_open(struct net_device *dev)
 {
@@ -1544,12 +1543,12 @@ static int hdlcdev_open(struct net_device *dev)
 }
 
 /**
- * called by network layer when interface is disabled
- * shutdown hardware and release resources
+ * hdlcdev_close - called by network layer when interface is disabled
+ * @dev:  pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Shutdown hardware and release resources.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_close(struct net_device *dev)
 {
@@ -1574,13 +1573,12 @@ static int hdlcdev_close(struct net_device *dev)
 }
 
 /**
- * called by network layer to process IOCTL call to network device
- *
- * dev  pointer to network device structure
- * ifr  pointer to network interface request structure
- * cmd  IOCTL command code
+ * hdlcdev_ioctl - called by network layer to process IOCTL call to network device
+ * @dev: pointer to network device structure
+ * @ifr: pointer to network interface request structure
+ * @cmd: IOCTL command code
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
@@ -1678,9 +1676,8 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 /**
- * called by network layer when transmit timeout is detected
- *
- * dev  pointer to network device structure
+ * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
+ * @dev: pointer to network device structure
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -1700,10 +1697,10 @@ static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 /**
- * called by device driver when transmit completes
- * reenable network layer transmit if stopped
+ * hdlcdev_tx_done - called by device driver when transmit completes
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Reenable network layer transmit if stopped.
  */
 static void hdlcdev_tx_done(struct slgt_info *info)
 {
@@ -1712,12 +1709,12 @@ static void hdlcdev_tx_done(struct slgt_info *info)
 }
 
 /**
- * called by device driver when frame received
- * pass frame to network layer
+ * hdlcdev_rx - called by device driver when frame received
+ * @info: pointer to device instance information
+ * @buf:  pointer to buffer contianing frame data
+ * @size: count of data bytes in buf
  *
- * info  pointer to device instance information
- * buf   pointer to buffer contianing frame data
- * size  count of data bytes in buf
+ * Pass frame to network layer.
  */
 static void hdlcdev_rx(struct slgt_info *info, char *buf, int size)
 {
@@ -1751,12 +1748,12 @@ static const struct net_device_ops hdlcdev_ops = {
 };
 
 /**
- * called by device driver when adding device instance
- * do generic HDLC initialization
+ * hdlcdev_init - called by device driver when adding device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC initialization.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_init(struct slgt_info *info)
 {
@@ -1800,10 +1797,10 @@ static int hdlcdev_init(struct slgt_info *info)
 }
 
 /**
- * called by device driver when removing device instance
- * do generic HDLC cleanup
+ * hdlcdev_exit - called by device driver when removing device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC cleanup.
  */
 static void hdlcdev_exit(struct slgt_info *info)
 {
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 33ff2dbb6650..ce08c5ec331c 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -685,7 +685,7 @@ static inline int sanity_check(SLMP_INFO *info,
 	return 0;
 }
 
-/**
+/*
  * line discipline callback wrappers
  *
  * The wrappers maintain line discipline references
@@ -1520,14 +1520,14 @@ static int set_break(struct tty_struct *tty, int break_state)
 #if SYNCLINK_GENERIC_HDLC
 
 /**
- * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
- * set encoding and frame check sequence (FCS) options
+ * hdlcdev_attach - called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
+ * @dev:      pointer to network device structure
+ * @encoding: serial encoding setting
+ * @parity:   FCS setting
  *
- * dev       pointer to network device structure
- * encoding  serial encoding setting
- * parity    FCS setting
+ * Set encoding and frame check sequence (FCS) options.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 			  unsigned short parity)
@@ -1569,10 +1569,9 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 }
 
 /**
- * called by generic HDLC layer to send frame
- *
- * skb  socket buffer containing HDLC frame
- * dev  pointer to network device structure
+ * hdlcdev_xmit - called by generic HDLC layer to send frame
+ * @skb: socket buffer containing HDLC frame
+ * @dev: pointer to network device structure
  */
 static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
@@ -1610,12 +1609,12 @@ static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 }
 
 /**
- * called by network layer when interface enabled
- * claim resources and initialize hardware
+ * hdlcdev_open - called by network layer when interface enabled
+ * @dev: pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Claim resources and initialize hardware.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_open(struct net_device *dev)
 {
@@ -1669,12 +1668,12 @@ static int hdlcdev_open(struct net_device *dev)
 }
 
 /**
- * called by network layer when interface is disabled
- * shutdown hardware and release resources
+ * hdlcdev_close - called by network layer when interface is disabled
+ * @dev: pointer to network device structure
  *
- * dev  pointer to network device structure
+ * Shutdown hardware and release resources.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_close(struct net_device *dev)
 {
@@ -1699,13 +1698,12 @@ static int hdlcdev_close(struct net_device *dev)
 }
 
 /**
- * called by network layer to process IOCTL call to network device
+ * hdlcdev_ioctl - called by network layer to process IOCTL call to network device
+ * @dev: pointer to network device structure
+ * @ifr: pointer to network interface request structure
+ * @cmd: IOCTL command code
  *
- * dev  pointer to network device structure
- * ifr  pointer to network interface request structure
- * cmd  IOCTL command code
- *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
@@ -1803,9 +1801,8 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 /**
- * called by network layer when transmit timeout is detected
- *
- * dev  pointer to network device structure
+ * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
+ * @dev: pointer to network device structure
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -1826,10 +1823,10 @@ static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 /**
- * called by device driver when transmit completes
- * reenable network layer transmit if stopped
+ * hdlcdev_tx_done - called by device driver when transmit completes
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Reenable network layer transmit if stopped.
  */
 static void hdlcdev_tx_done(SLMP_INFO *info)
 {
@@ -1838,12 +1835,12 @@ static void hdlcdev_tx_done(SLMP_INFO *info)
 }
 
 /**
- * called by device driver when frame received
- * pass frame to network layer
+ * hdlcdev_rx - called by device driver when frame received
+ * @info: pointer to device instance information
+ * @buf:  pointer to buffer contianing frame data
+ * @size: count of data bytes in buf
  *
- * info  pointer to device instance information
- * buf   pointer to buffer contianing frame data
- * size  count of data bytes in buf
+ * Pass frame to network layer.
  */
 static void hdlcdev_rx(SLMP_INFO *info, char *buf, int size)
 {
@@ -1879,12 +1876,12 @@ static const struct net_device_ops hdlcdev_ops = {
 };
 
 /**
- * called by device driver when adding device instance
- * do generic HDLC initialization
+ * hdlcdev_init - called by device driver when adding device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC initialization.
  *
- * returns 0 if success, otherwise error code
+ * Return: 0 if success, otherwise error code
  */
 static int hdlcdev_init(SLMP_INFO *info)
 {
@@ -1928,10 +1925,10 @@ static int hdlcdev_init(SLMP_INFO *info)
 }
 
 /**
- * called by device driver when removing device instance
- * do generic HDLC cleanup
+ * hdlcdev_exit - called by device driver when removing device instance
+ * @info: pointer to device instance information
  *
- * info  pointer to device instance information
+ * Do generic HDLC cleanup.
  */
 static void hdlcdev_exit(SLMP_INFO *info)
 {
-- 
2.28.0

