From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: HW Flow control in serial.c???
Date: Tue, 04 Feb 2003 13:26:08 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3E3FB160.7040706@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgate.berlin.imc-berlin.de (mailgate.berlin.imc-berlin.de [10.0.0.13])
	by mail.berlin.imc-berlin.de (8.12.3/8.12.3) with ESMTP id h14ARrLT025002
	for <linux-serial@vger.kernel.org>; Tue, 4 Feb 2003 11:27:53 +0100
Received: from imc-berlin.de (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailgate.berlin.imc-berlin.de (8.8.8/8.8.8) with ESMTP id NAA20241
	for <linux-serial@vger.kernel.org>; Tue, 4 Feb 2003 13:26:08 +0100 (CET)
	(envelope-from steven.scholz@imc-berlin.de)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi there,

while playing around with some serial device using RTS/CTS flow control I 
noticed the following behavior:

When the device activates it's CTS to signal that it can't take more date, the 
sender (i.e. drivers/char/serial.c) is still sending up to 16 (!) Bytes! I 
assume this is the contents of the 16550's FIFO.

Is it a bug or a feature?

Looking at the code drivers/char/serial.c and at the data sheet of a 16C550 
shows that to enable the (real) HW flow control one has to set the bit AFE (auto 
flow control enable) in the MCR register. But this is not done in serial.c.

Please look at drivers/char/mxser.c

...
#define         UART_MCR_AFE            0x20
...
         if (cflag & CRTSCTS) {
                 info->flags |= ASYNC_CTS_FLOW;
                 info->IER |= UART_IER_MSI;
                 if (info->type == PORT_16550A)
                         info->MCR |= UART_MCR_AFE;
         } else {
                 info->flags &= ~ASYNC_CTS_FLOW;
         }
...

I think this it the right way to do it.

BTW I am talking about linux 2.4.20.

Since I am not on the list so please CC me.

Thanks a million,

Steven Scholz



