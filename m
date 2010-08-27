From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: serial.h v serial_core.h PORT_ defines?
Date: Fri, 27 Aug 2010 20:35:41 +0100
Message-ID: <20100827193541.GA29541@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx.treblig.org ([80.68.94.177]:60310 "EHLO mx.treblig.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab0H0UDS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Aug 2010 16:03:18 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: philippe.langlais@stericsson.com

Hi,
  I was playing with sparse and it flagged that in drivers/serial/8250.c
there is a duplicate initialiser in the uart_config[] array
(from Linus's git):

       [PORT_NS16550A] = {
                .name           = "NS16550A",
                .fifo_size      = 16,
                .tx_loadsz      = 16,
                .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
                .flags          = UART_CAP_FIFO | UART_NATSEMI,
        },

and
       [PORT_U6_16550A] = {
                .name           = "U6_16550A",
                .fifo_size      = 64,
                .tx_loadsz      = 64,
                .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
                .flags          = UART_CAP_FIFO | UART_CAP_AFE,
        },

now PORT_NS16550A is defined as 14 in serial_core.h:

#define PORT_NS16550A   14

and PORT_U6_16550A is defined as 14 in serial.h:

235dae5d (Philippe Langlais 2010-07-29 17:13:57 +0200  80) #define PORT_U6_16550A       14

I guess that might subtly break NS16550A users?

My assumption is that Philippe's addition should actually
be to the serial_core.h list which currently goes upto 18.

However, that leaves the question of why is there a set of nearly
but not quite idential defines in serial.h and serial_core.h?

(please leave me on cc for replies)

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
