From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 13:48:14 -0700
Message-ID: <46AA5A0E.1050600@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	<46A84B4A.6070902@shaw.ca>	<46A8C6F1.4080309@howardsilvan.com> <20070726173121.70088a92@the-village.bc.nu> <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc> <46D33636.7070200@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:33105 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763471AbXG0Utb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 16:49:31 -0400
In-Reply-To: <46D33636.7070200@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Paul Fulghum wrote:

> Tilman Schmidt wrote:
>
>> Could this be related?
>>
>> http://lkml.org/lkml/2007/7/18/245
>>
>> Quote:
>> "I've recently found (using 2.6.21.4) that configuring a serial ports
>> (ST16654) which use the 8250 driver using setserial results in the
>> UART's FIFOs being disabled (unless you specify autoconfig)."
>
>
> That would make sense.
>
> Lee's error is a hardware FIFO overrun which could occur
> if the FIFO is being disabled as described in your
> link (by trying to set the uart type with setserial).


I'm not using setserial on this port, myself.  If something in init is 
calling on setserial then I don't know about it.

That said, tests on the serial port from within the application show 
that xmit_fifo_size is set to 16 as it should be.

I wrote up a little test app:

    struct serial_struct serial;
    ioctl(modemFd, TIOCGSERIAL, &serial);
    printf("            type: %d\n", serial.type);
    printf("            line: %d\n", serial.line);
    printf("            line: %u\n", serial.port);
    printf("             irq: %d\n", serial.irq);
    printf("           flags: %d\n", serial.flags);
    printf("  xmit_fifo_size: %d\n", serial.xmit_fifo_size);
    printf("  custom_divisor: %d\n", serial.custom_divisor);
    printf("       baud_base: %d\n", serial.baud_base);
    printf("     close_delay: %u\n", serial.close_delay);
    printf("         io_type: 0x%X\n", serial.io_type);
    printf("reserved_char[0]: 0x%X\n", serial.reserved_char[0]);
    printf("            hub6: %d\n", serial.hub6);
    printf("    closing_wait: %u\n", serial.closing_wait);
    printf("   closing_wait2: %u\n", serial.closing_wait2);
    printf(" iomem_reg_shift: %u\n", serial.iomem_reg_shift);
    printf("       port_high: %u\n", serial.port_high);
    printf("     reserved[0]: %d\n", serial.reserved[0]);

Here's the output:

            type: 4
            line: 1
            line: 760
             irq: 3
           flags: 1358954688
  xmit_fifo_size: 16
  custom_divisor: 0
       baud_base: 115200
     close_delay: 500
         io_type: 0x0
reserved_char[0]: 0x0
            hub6: 0
    closing_wait: 30000
   closing_wait2: 0
 iomem_reg_shift: 0
       port_high: 0
     reserved[0]: 0

Thanks,

Lee.
