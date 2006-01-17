From: gxatzipavlis@softnet.tuc.gr
Subject: Re: selfmade serial driver problem with chipset other than VIA
Date: Tue, 17 Jan 2006 16:07:01 +0200 (EET)
Message-ID: <50246.147.27.7.175.1137506821.squirrel@147.27.7.175>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panoramix.softnet.tuc.gr ([147.27.14.5]:47044 "HELO
	softnet.tuc.gr") by vger.kernel.org with SMTP id S932497AbWAQOHK
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2006 09:07:10 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gxatzipavlis@softnet.tuc.gr
Cc: linux-serial@vger.kernel.org

hello
a summary of my prob.
i have a problem communicating with serial port in low level programming.
i communicate with inb,outb with serial registers
in my computer everything is working fine. in other m/b with different
chipset my module doesn't work. i have a via kt133 chipset.

linux-os (Dick Johnson) <linux-os@analogic.com> had proposed me some
modifications in my module that i have done but they didn't solved my
problem.

i want a 8E1 format frames in 19200bps so i do

outb( UART_LCR_DLAB , eib_io + UART_LCR );
outb(0X06,eib_io+UART_DLL);
outb(0X00,eib_io+UART_DLM);
outb( 0x00 , eib_io + UART_LCR );
//19200 done

outb( UART_LCR_WLEN8 | UART_LCR_PARITY | UART_LCR_EPAR , eib_io + UART_LCR );
//8E1

outb( UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI , eib_io+UART_IER);
//interrupt when data for receive and when transmiter empty

now when for debuging purpose i print the UART_IIR i get 2 (means that
interrupt pending for transmiter register empty) and UART_IIR gets 1.

when i don't print the UART_IIR i expect to jump to my ISR routine that
has already been registered in the kernel according to "cat
/proc/interrupts" with IRQ 4 and I/O 0x03f8.
i don't have compiled the serial support in the kernel. i have it as a
module that i don't load it.

is there maybe any problem with the APIC controllers that i have to
program myself?
thanks




