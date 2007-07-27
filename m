From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 13:05:15 -0700
Message-ID: <46AA4FFB.9010402@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	<46A84B4A.6070902@shaw.ca>	<46A8C6F1.4080309@howardsilvan.com> <20070726173121.70088a92@the-village.bc.nu> <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:55695 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763617AbXG0UGa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 16:06:30 -0400
In-Reply-To: <46A9F712.70706@imap.cc>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Tilman Schmidt wrote:

>Lee Howard schrieb:
>  
>
>>So, does this explain why I wouldn't have a problem at 115200 bps with 
>>kernel 2.2.5 but why I do with 2.6.5 and 2.6.18?  Both hardware and 
>>software flow control work fine with 2.2.5 (meaning I don't see any 
>>error message and I don't have any data corruption), but neither works 
>>to avoid the "kernel: ttyS1: 1 input overrun(s)" and consequent data 
>>corruption issue in 2.6.5 nor 2.6.18.
>>
>>Was there some associated application change in tty handling that needed 
>>to occur between the 2.2 and 2.6 kernels to properly implement flow control?
>>    
>>
>
>Could this be related?
>
>http://lkml.org/lkml/2007/7/18/245
>
>Quote:
>"I've recently found (using 2.6.21.4) that configuring a serial ports
>(ST16654) which use the 8250 driver using setserial results in the
>UART's FIFOs being disabled (unless you specify autoconfig)."
>  
>

I'm not running setserial on the port, myself.  But to test to see if it 
is related, I included this code in the application:

#include <linux/serial.h>
....
struct serial_struct serial;
ioctl(modemFd, TIOCGSERIAL, &serial);
traceModemOp("modem xmit_fifo_size: %u", serial.xmit_fifo_size);

And I get this resulting logging:

"MODEM modem xmit_fifo_size: 16"

So it's clear from here that the xmit_fifo_size is set correctly on this 
system.

Thanks,

Lee.

