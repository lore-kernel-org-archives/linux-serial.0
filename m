Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DBC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B480661158
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhDZQQV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36638 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhDZQQT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QGAUVB176408;
        Mon, 26 Apr 2021 16:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eE7hM7p/lSw/EUJd13oVWz1YXSbnEvP1wEUSQdsCZfQ=;
 b=POTZXXFY+RuLtAuYCX82iZNutv4PsvibkgiPt4+/uFAE1dBJpAY+Ap+uX+Vmgp3HN/ke
 1x4/T2U1Q++bVMwjwOTL1AEkTci0uiMmLaFTWffeDQFQgwMb0Cxk8yMWF12qTHqXkWxc
 ndHebkIc4f0e9LV3YndiJMvvXkkj6FpGBUMg2qhYMmxZ2mv5sb7XnHZtEU3RjPC42KSt
 FYCs0alOg5wsvWIwkIEAxZHxkfOCErV2lPAwsF/rpNt1sPLEO/QlKpzO86vDdAlsdFXH
 7zXdpagOrhEt2ynyQowpRP11aHRDQY9qVrT8P8o0LRI1UiTfbHSmnwXCkyaIyyozqdAW MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 385afptmgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 16:15:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QGANr7181737;
        Mon, 26 Apr 2021 16:15:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3849cddpvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 16:15:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13QGFNnN017302;
        Mon, 26 Apr 2021 16:15:23 GMT
Received: from t460.home (dhcp-10-175-63-42.vpn.oracle.com [10.175.63.42])
        by aserp3030.oracle.com with ESMTP id 3849cddprr-1;
        Mon, 26 Apr 2021 16:15:23 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com,
        syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH] serial: 8250: fix NULL pointer dereference in serial8250_do_startup()
Date:   Mon, 26 Apr 2021 18:14:33 +0200
Message-Id: <20210426161433.20829-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9.dirty
In-Reply-To: <00000000000044a65205994a7e13@google.com>
References: <00000000000044a65205994a7e13@google.com>
X-Proofpoint-ORIG-GUID: yNUetMbxG64O1HiQf2pPLo7cT1Bj577S
X-Proofpoint-GUID: yNUetMbxG64O1HiQf2pPLo7cT1Bj577S
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260123
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Syzbot reported a crash, here reproduced on a recent mainline kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000005
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 120cf067 P4D 120cf067 PUD 135d4067 PMD 0
  Oops: 0000 [#1] PREEMPT SMP KASAN
  CPU: 2 PID: 4830 Comm: a.out Not tainted 5.12.0-rc7+ #209
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
  RIP: 0010:mem16_serial_in+0x83/0xa0
  [...]
    Call Trace:
    serial8250_do_startup+0x475/0x1e40
    serial8250_startup+0x5c/0x80
    uart_startup+0x360/0x870
    uart_set_info_user+0x13a3/0x1c30
    tty_ioctl+0x711/0x14f0
    __x64_sys_ioctl+0x193/0x200
    do_syscall_64+0x2d/0x70
    entry_SYSCALL_64_after_hwframe+0x44/0xae

A more readable reproducer is:

  #include <sys/ioctl.h>
  #include <fcntl.h>

  #include <linux/serial.h>

  #ifndef SERIAL_IO_MEM16
  #define SERIAL_IO_MEM16 7
  #endif

  int main(int argc, char *argv[])
  {
          int fd = open("/dev/ttyS3", O_RDONLY);

          struct serial_struct ss = {};
          ss.type = 0x10;
          ss.baud_base = 0x7fffffff;
          ss.io_type = SERIAL_IO_MEM16;
          ioctl(fd, TIOCSSERIAL, &ss);

          return 0;
  }

ioctl(TIOCSSERIAL) attempts to configure the serial port, but when
requesting io_type SERIAL_IO_MEM*/UPIO_MEM* it goes on to dereference
->membase in serial8250_do_startup().

I propose this fix, which will fail validation of the TIOCSSERIAL request
if you request a memory-based or io-based io_type when the underlying port
has no valid ->membase or ->iobase, respectively.

As far as I can tell, this driver was written to support being able to
switch between the two IO types for a given port (assuming the underlying
driver supports it); see serial8250_do_startup()/set_io_from_upio().

I'm also adding a couple of WARN_ON_ONCE()s which are technically
redundant, but which could help somebody else if they come across a
similar issue in the future.

Reported-by: syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Cc: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd36..aec3abff8e48e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -455,6 +455,33 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 
 static int serial8250_default_handle_irq(struct uart_port *port);
 
+static int needs_membase(int iotype)
+{
+	switch (iotype) {
+	case UPIO_MEM:
+	case UPIO_MEM16:
+	case UPIO_MEM32:
+	case UPIO_MEM32BE:
+#ifdef CONFIG_SERIAL_8250_RT288X
+	case UPIO_AU:
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+static int needs_iobase(int iotype)
+{
+	switch (iotype) {
+	case UPIO_HUB6:
+	case UPIO_PORT:
+		return 1;
+	}
+
+	return 0;
+}
+
 static void set_io_from_upio(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
@@ -2151,6 +2178,11 @@ int serial8250_do_startup(struct uart_port *port)
 	unsigned char lsr, iir;
 	int retval;
 
+	if (WARN_ON_ONCE(needs_membase(port->iotype) && !port->membase))
+		return -ENODEV;
+	if (WARN_ON_ONCE(needs_iobase(port->iotype) && !port->iobase))
+		return -ENODEV;
+
 	if (!port->fifosize)
 		port->fifosize = uart_config[port->type].fifo_size;
 	if (!up->tx_loadsz)
@@ -3157,6 +3189,17 @@ serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
 	    ser->type >= ARRAY_SIZE(uart_config) || ser->type == PORT_CIRRUS ||
 	    ser->type == PORT_STARTECH)
 		return -EINVAL;
+
+	/*
+	 * This driver clearly was intended to support switching between
+	 * io types (see serial8250_do_startup()), so we need to ensure that
+	 * the underlying port type will support the request.
+	 */
+	if (needs_membase(ser->io_type) && !port->membase)
+		return -EINVAL;
+	if (needs_iobase(ser->io_type) && !port->iobase)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.16.1.72.g5be1f00a9.dirty

