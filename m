Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F077BC28E82
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DFA64E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbhCCCRV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835904AbhCBGZg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EF5CB03D;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 38/44] USB: serial/io_edgeport, drop unneeded forward declarations
Date:   Tue,  2 Mar 2021 07:22:08 +0100
Message-Id: <20210302062214.29627-38-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Forward declarations make the code larger and rewrites harder. Harder as
they are often omitted from global changes. Remove forward declarations
which are not really needed, i.e. the definition of the function is
before its first use.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 41 --------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index a493670c06e6..54b476a228d6 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -265,35 +265,7 @@ static atomic_t CmdUrbs = ATOMIC_INIT(0);
 
 /* local function prototypes */
 
-/* function prototypes for all URB callbacks */
-static void edge_interrupt_callback(struct urb *urb);
-static void edge_bulk_in_callback(struct urb *urb);
-static void edge_bulk_out_data_callback(struct urb *urb);
-static void edge_bulk_out_cmd_callback(struct urb *urb);
-
-/* function prototypes for the usbserial callbacks */
-static int edge_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void edge_close(struct usb_serial_port *port);
-static int edge_write(struct tty_struct *tty, struct usb_serial_port *port,
-					const unsigned char *buf, int count);
-static int edge_write_room(struct tty_struct *tty);
-static int edge_chars_in_buffer(struct tty_struct *tty);
-static void edge_throttle(struct tty_struct *tty);
-static void edge_unthrottle(struct tty_struct *tty);
-static void edge_set_termios(struct tty_struct *tty,
-					struct usb_serial_port *port,
-					struct ktermios *old_termios);
-static int  edge_ioctl(struct tty_struct *tty,
-					unsigned int cmd, unsigned long arg);
-static void edge_break(struct tty_struct *tty, int break_state);
-static int  edge_tiocmget(struct tty_struct *tty);
-static int  edge_tiocmset(struct tty_struct *tty,
-					unsigned int set, unsigned int clear);
-static int  edge_startup(struct usb_serial *serial);
-static void edge_disconnect(struct usb_serial *serial);
-static void edge_release(struct usb_serial *serial);
-static int edge_port_probe(struct usb_serial_port *port);
-static void edge_port_remove(struct usb_serial_port *port);
 
 /* function prototypes for all of our local functions */
 
@@ -309,8 +281,6 @@ static void handle_new_lsr(struct edgeport_port *edge_port, __u8 lsrData,
 static int  send_iosp_ext_cmd(struct edgeport_port *edge_port, __u8 command,
 				__u8 param);
 static int  calc_baud_rate_divisor(struct device *dev, int baud_rate, int *divisor);
-static int  send_cmd_write_baud_rate(struct edgeport_port *edge_port,
-				int baudRate);
 static void change_port_settings(struct tty_struct *tty,
 				struct edgeport_port *edge_port,
 				struct ktermios *old_termios);
@@ -321,19 +291,8 @@ static int  write_cmd_usb(struct edgeport_port *edge_port,
 static void send_more_port_data(struct edgeport_serial *edge_serial,
 				struct edgeport_port *edge_port);
 
-static int sram_write(struct usb_serial *serial, __u16 extAddr, __u16 addr,
-					__u16 length, const __u8 *data);
-static int rom_read(struct usb_serial *serial, __u16 extAddr, __u16 addr,
-						__u16 length, __u8 *data);
 static int rom_write(struct usb_serial *serial, __u16 extAddr, __u16 addr,
 					__u16 length, const __u8 *data);
-static void get_manufacturing_desc(struct edgeport_serial *edge_serial);
-static void get_boot_desc(struct edgeport_serial *edge_serial);
-static void load_application_firmware(struct edgeport_serial *edge_serial);
-
-static void unicode_to_ascii(char *string, int buflen,
-				__le16 *unicode, int unicode_size);
-
 
 /* ************************************************************************ */
 /* ************************************************************************ */
-- 
2.30.1

