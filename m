Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23471C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051432067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRI5B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgHRI47 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A13EFB032;
        Tue, 18 Aug 2020 08:57:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/8] tty: ldiscs, fix kernel-doc
Date:   Tue, 18 Aug 2020 10:56:52 +0200
Message-Id: <20200818085655.12071-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As in the previous patch, fix kernel-doc in line disciplines.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c  | 23 +++++++-------
 drivers/tty/n_hdlc.c | 72 ++++++++++++++++++++++----------------------
 drivers/tty/n_tty.c  |  4 +--
 3 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 10f8fc07f23c..67baa884b0c5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -76,10 +76,9 @@ module_param(debug, int, 0600);
 
 /**
  *	struct gsm_mux_net	-	network interface
- *	@struct gsm_dlci* dlci
  *
  *	Created when net interface is initialized.
- **/
+ */
 struct gsm_mux_net {
 	struct kref ref;
 	struct gsm_dlci *dlci;
@@ -399,7 +398,7 @@ static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
 /**
  *	gsm_read_ea		-	read a byte into an EA
  *	@val: variable holding value
- *	c: byte going into the EA
+ *	@c: byte going into the EA
  *
  *	Processes one byte of an EA. Updates the passed variable
  *	and returns 1 if the EA is now completely read
@@ -513,8 +512,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 
 /**
  *	gsm_stuff_packet	-	bytestuff a packet
- *	@ibuf: input
- *	@obuf: output
+ *	@input: input buffer
+ *	@output: output buffer
  *	@len: length of input
  *
  *	Expand a buffer by bytestuffing it. The worst case size change
@@ -1304,7 +1303,7 @@ static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 
 /**
  *	gsm_control_retransmit	-	retransmit a control frame
- *	@data: pointer to our gsm object
+ *	@t: timer contained in our gsm object
  *
  *	Called off the T2 timer expiry in order to retransmit control frames
  *	that have been lost in the system somewhere. The control_lock protects
@@ -1341,7 +1340,7 @@ static void gsm_control_retransmit(struct timer_list *t)
  *	@gsm: the GSM channel
  *	@command: command  to send including CR bit
  *	@data: bytes of data (must be kmalloced)
- *	@len: length of the block to send
+ *	@clen: length of the block to send
  *
  *	Queue and dispatch a control command. Only one command can be
  *	active at a time. In theory more can be outstanding but the matching
@@ -1453,7 +1452,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 
 /**
  *	gsm_dlci_t1		-	T1 timer expiry
- *	@dlci: DLCI that opened
+ *	@t: timer contained in the DLCI that opened
  *
  *	The T1 timer handles retransmits of control frames (essentially of
  *	SABM and DISC). We resend the command until the retry count runs out
@@ -1549,7 +1548,7 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
  *	gsm_dlci_data		-	data arrived
  *	@dlci: channel
  *	@data: block of bytes received
- *	@len: length of received block
+ *	@clen: length of received block
  *
  *	A UI or UIH frame has arrived which contains data for a channel
  *	other than the control channel. If the relevant virtual tty is
@@ -1671,7 +1670,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 
 /**
  *	gsm_dlci_free		-	free DLCI
- *	@dlci: DLCI to free
+ *	@port: tty port for DLCI to free
  *
  *	Free up a DLCI.
  *
@@ -2149,7 +2148,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 
 /**
  *	gsm_free_mux		-	free up a mux
- *	@mux: mux to free
+ *	@gsm: mux to free
  *
  *	Dispose of allocated resources for a dead mux
  */
@@ -2162,7 +2161,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 
 /**
  *	gsm_free_muxr		-	free up a mux
- *	@mux: mux to free
+ *	@ref: kreference to the mux to free
  *
  *	Dispose of allocated resources for a dead mux
  */
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index b09eac4b6d64..9ba967f8b7ca 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -123,13 +123,13 @@ struct n_hdlc_buf_list {
 
 /**
  * struct n_hdlc - per device instance data structure
- * @magic - magic value for structure
- * @tbusy - reentrancy flag for tx wakeup code
- * @woke_up - tx wakeup needs to be run again as it was called while @tbusy
- * @tx_buf_list - list of pending transmit frame buffers
- * @rx_buf_list - list of received frame buffers
- * @tx_free_buf_list - list unused transmit frame buffers
- * @rx_free_buf_list - list unused received frame buffers
+ * @magic: magic value for structure
+ * @tbusy: reentrancy flag for tx wakeup code
+ * @woke_up: tx wakeup needs to be run again as it was called while @tbusy
+ * @tx_buf_list: list of pending transmit frame buffers
+ * @rx_buf_list: list of received frame buffers
+ * @tx_free_buf_list: list unused transmit frame buffers
+ * @rx_free_buf_list: list unused received frame buffers
  */
 struct n_hdlc {
 	int			magic;
@@ -187,7 +187,7 @@ static void n_hdlc_free_buf_list(struct n_hdlc_buf_list *list)
 
 /**
  * n_hdlc_tty_close - line discipline close
- * @tty - pointer to tty info structure
+ * @tty: pointer to tty info structure
  *
  * Called when the line discipline is changed to something
  * else, the tty is closed, or the tty detects a hangup.
@@ -218,7 +218,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 
 /**
  * n_hdlc_tty_open - called when line discipline changed to n_hdlc
- * @tty - pointer to tty info structure
+ * @tty: pointer to tty info structure
  *
  * Returns 0 if success, otherwise error code
  */
@@ -255,8 +255,8 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
 
 /**
  * n_hdlc_send_frames - send frames on pending send buffer list
- * @n_hdlc - pointer to ldisc instance data
- * @tty - pointer to tty instance data
+ * @n_hdlc: pointer to ldisc instance data
+ * @tty: pointer to tty instance data
  *
  * Send frames on pending send buffer list until the driver does not accept a
  * frame (busy) this function is called after adding a frame to the send buffer
@@ -335,7 +335,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 /**
  * n_hdlc_tty_wakeup - Callback for transmit wakeup
- * @tty	- pointer to associated tty instance data
+ * @tty: pointer to associated tty instance data
  *
  * Called when low level device driver can accept more send data.
  */
@@ -348,10 +348,10 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 
 /**
  * n_hdlc_tty_receive - Called by tty driver when receive data is available
- * @tty	- pointer to tty instance data
- * @data - pointer to received data
- * @flags - pointer to flags for data
- * @count - count of received data in bytes
+ * @tty: pointer to tty instance data
+ * @data: pointer to received data
+ * @flags: pointer to flags for data
+ * @count: count of received data in bytes
  *
  * Called by tty low level driver when receive data is available. Data is
  * interpreted as one HDLC frame.
@@ -408,10 +408,10 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 
 /**
  * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
- * @tty - pointer to tty instance data
- * @file - pointer to open file object
- * @buf - pointer to returned data buffer
- * @nr - size of returned data buffer
+ * @tty: pointer to tty instance data
+ * @file: pointer to open file object
+ * @buf: pointer to returned data buffer
+ * @nr: size of returned data buffer
  *
  * Returns the number of bytes returned or error code.
  */
@@ -479,10 +479,10 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 
 /**
  * n_hdlc_tty_write - write a single frame of data to device
- * @tty	- pointer to associated tty device instance data
- * @file - pointer to file object data
- * @data - pointer to transmit data (one frame)
- * @count - size of transmit frame in bytes
+ * @tty: pointer to associated tty device instance data
+ * @file: pointer to file object data
+ * @data: pointer to transmit data (one frame)
+ * @count: size of transmit frame in bytes
  *
  * Returns the number of bytes written (or error code).
  */
@@ -546,10 +546,10 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 
 /**
  * n_hdlc_tty_ioctl - process IOCTL system call for the tty device.
- * @tty - pointer to tty instance data
- * @file - pointer to open file object for device
- * @cmd - IOCTL command code
- * @arg - argument for IOCTL call (cmd dependent)
+ * @tty: pointer to tty instance data
+ * @file: pointer to open file object for device
+ * @cmd: IOCTL command code
+ * @arg: argument for IOCTL call (cmd dependent)
  *
  * Returns command dependent result.
  */
@@ -614,9 +614,9 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 
 /**
  * n_hdlc_tty_poll - TTY callback for poll system call
- * @tty - pointer to tty instance data
- * @filp - pointer to open file object for device
- * @poll_table - wait queue for operations
+ * @tty: pointer to tty instance data
+ * @filp: pointer to open file object for device
+ * @wait: wait queue for operations
  *
  * Determine which operations (read/write) will not block and return info
  * to caller.
@@ -703,8 +703,8 @@ static struct n_hdlc *n_hdlc_alloc(void)
 
 /**
  * n_hdlc_buf_return - put the HDLC buffer after the head of the specified list
- * @buf_list - pointer to the buffer list
- * @buf - pointer to the buffer
+ * @buf_list: pointer to the buffer list
+ * @buf: pointer to the buffer
  */
 static void n_hdlc_buf_return(struct n_hdlc_buf_list *buf_list,
 						struct n_hdlc_buf *buf)
@@ -721,8 +721,8 @@ static void n_hdlc_buf_return(struct n_hdlc_buf_list *buf_list,
 
 /**
  * n_hdlc_buf_put - add specified HDLC buffer to tail of specified list
- * @buf_list - pointer to buffer list
- * @buf	- pointer to buffer
+ * @buf_list: pointer to buffer list
+ * @buf: pointer to buffer
  */
 static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 			   struct n_hdlc_buf *buf)
@@ -739,7 +739,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 
 /**
  * n_hdlc_buf_get - remove and return an HDLC buffer from list
- * @buf_list - pointer to HDLC buffer list
+ * @buf_list: pointer to HDLC buffer list
  *
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
  * list.
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1794d84e7bf6..7e5e36315260 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -322,7 +322,7 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 
 /**
  *	reset_buffer_flags	-	reset buffer state
- *	@tty: terminal to reset
+ *	@ldata: line disc data to reset
  *
  *	Reset the read buffer counters and clear the flags.
  *	Called from n_tty_open() and n_tty_flush_buffer().
@@ -906,7 +906,7 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
 /**
  *	echo_char_raw	-	echo a character raw
  *	@c: unicode byte to echo
- *	@tty: terminal device
+ *	@ldata: line disc data
  *
  *	Echo user input back onto the screen. This must be called only when
  *	L_ECHO(tty) is true. Called from the driver receive_buf path.
-- 
2.28.0

