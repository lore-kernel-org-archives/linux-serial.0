From: "Donald" <donald@asix.com.tw>
Subject: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Mon, 21 May 2012 14:19:34 +0800
Message-ID: <00a301cd3719$b3faa370$1befea50$@com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from asix.com.tw ([113.196.140.82]:65324 "EHLO asix.com.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab2EUGwQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 02:52:16 -0400
Received: from DonaldNB ([10.1.2.21])
	by asix.com.tw (8.14.1/8.14.1) with ESMTP id q4L6K1g3043074
	for <linux-serial@vger.kernel.org>; Mon, 21 May 2012 14:20:05 +0800 (CST)
	(envelope-from donald@asix.com.tw)
Content-Language: zh-tw
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

This is Donald from ASIX Electronics Corp. My company has three PCI to Serial controllers, including MCS9845, MCS9835, and MCS9820.
Currently those serial devices using these three chips can directly use the Linux kernel's serial driver in
linux/drivers/char/8250.c. Recently we find these three chips have a hardware bug relating to parity error count function. We have a
software workaround for this issue. Below for reference is a pseudo code for this workaround.

serial8250_do_set_termios() {
	If ((PID == MCS9845 || PID == MCS935 || PID == MCS9820) && ((termios->c_cflag & PARENB))) {
		port->fifosize = 1; /* Change RX FIFO size to 1 byte */
		up->ier &= ~UART_IER_RLSI; /* Disable RLSI interrupt */
	}	
}

Is it possible to add a patch into linux/drivers/char/8250.c for our chips' hardware issue? If it's not feasible to add a patch into
linux/drivers/char/8250.c, could we submit a new driver (e.g., mcs78xx_8250.c) to Linux kernel for devices using these three chips
(i.e., those devices can use new driver mcs78xx_8250.c instead of 8250.c)

Your reply to my questions will be very appreciated.

Regards,
Donald Lee
~~~~~~~~~~~~~~~~~~~~~~~~
R&D Division
ASIX Electronics Corporation
TEL: 886-3-5799500 ext.515
http://asix.com.tw/
~~~~~~~~~~~~~~~~~~~~~~~~


