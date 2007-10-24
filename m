From: "Andreas Baer" <andreas.8aer@googlemail.com>
Subject: How to really avoid serial buffer overruns for legacy ports?
Date: Wed, 24 Oct 2007 13:47:32 +0200
Message-ID: <307494fb0710240447q36301642ha75811e1b33826c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:59537 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbXJXLre (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2007 07:47:34 -0400
Received: by nz-out-0506.google.com with SMTP id s18so180603nze
        for <linux-serial@vger.kernel.org>; Wed, 24 Oct 2007 04:47:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi everyone,

I'm facing massive problems with serial port buffer overruns for the
following hardware/software constellation (and at least another one
with slightly changed hardware):

Kernel-2.6.23
(Setserial-2.17)

Serial ports:
4x RS232C NS16C550 (16550A) serial ports with 16 Byte FIFO

Chipsets:
Intel 855GME
Intel 6300ESB I/O Hub
Winbond W83627THF LPC Bus I/O Controller

The Intel 6300ESB I/O Hub is responsible for handling the first 2
ports and the other 2 are handled by the Winbond W83627THF.

IRQ assignment (via BIOS and setserial) is 4, 3, 10 and 11 (in order,
not shared).

I see overruns for every port (explained later), but one thing is
strange as I took a deeper look at the documentation of this Intel I/O
Hub, because they are not implementing 100% 16550-compatible serial
ports, e.g. the IER knows two additional bits 4 and 5 (usually always
set to 0 from the register definition of standard 16550). They provide
the following behavior, quote: "Receiver time out interrupt may be
configured to be separated from the receive data available interrupt
(using the bit5: COMP) to avoid interrupt controller and DMA
controller serving the receive FIFO at the same time.". Can anyone
tell me if this behavior causes general problems with the standard
linux driver? As far as I have seen, this shouldn't be an issue,
because the driver just looks at bit0 of IER to verify that an
interrupt is available, no matter which one, data available or
timeout. By the way, this is just additional information, because in
general all ports are somehow 'working' without seeing any problems
from outside.
Here the Intel 6300ESB I/O Hub data sheet if someone is interested
(page 671/672):
http://www.intel.com/design/intarch/datashts/30064103.pdf

The real problems:

I need stable serial port communication with external components
working at 115200 baud, so just decreasing the baudrate is not really
an issue here. The whole system also suffers already from quite a lot
of interrupts continuously thrown in every second from other devices.

I created a test scenario for my system using a null-modem cable, a
different machine working as sender unit and a simple asynchronous
application which creates, sends/receives and checks predefined 1KB
packages (primitive check through a XOR checksum at the end). With the
original configuration of the system this application is not able to
receive at least 100 packages without throwing the first checksum
error (we are always talking about 115200 baud of course). I could
verify that it really is an overrun by calling a simple printk
statement if the overrun flag is set for every serial8250-interrupt
that comes in.

Then I began to study a little bit about legacy serial ports and their
built-in problems. I read previous discussions about overruns (e.g.
http://lkml.org/lkml/2006/8/16/73) and tried almost everything which
is influenceable via parameters.

- Changing the FIFO trigger level (UART_FCR_R_TRIG_10) => no solution
I think it's also a bad idea because as mentioned above the system has
already enough interrupts to handle. Even if this would bring a slight
statistical improvement, it's far away from a solution.

- Change timer frequency + kernel preemptibility => no solution

Current configuration is:
UART_FCR_R_TRIG_10
CONFIG_PREEMPT_VOLUNTARY
CONFIG_HZ_300

- Using hardware (CRTSCTS) or sofware (Xon/Xoff) handshaking => no solution
Sadly this makes no difference because everything is controlled (at
least for these chipsets) by the software driver and handshaking is
not automatically handled by hardware, which would really prevent
buffer overruns, right?

- Create atomic interrupt handler in drivers/serial/8250.c
Before calling request_irq() in function serial_link_irq_chain() I do:
irq_flags |= IRQF_DISABLED;
Helped quite a lot (at least for my subjective view :)), but is also
not a final solution.

In my opinion, it's now all about decreasing the serial IRQ latency,
which is a result from this idiotic small 16 Byte FIFO buffer. I tried
to find a way increasing the general IRQ handling of all serial ports
by either implementing a general priority handling for IRQ's or to
change related APIC vectors (i'm using I/O APIC as PIC), both without
much success (at the moment). Is anyone an expert for these issues?

Here I found some (outdated) patches to add simple IRQ priorities:
http://users.informatik.uni-halle.de/~ladischc/linux_interrupt_priorities.html
This helped me to implement this little helper function for showing
the current interrupt priorities at boot time (in one line).

- arch/i386/kernel/io_apic.c
static inline void print_ioapic_priorities(void)
{
        int level, offset, i;

        printk(KERN_INFO "I/O-APIC interrupt priorities:");
        for (level = FIRST_DEVICE_VECTOR & 0xf0;
             level < FIRST_SYSTEM_VECTOR;
             level += 0x10) {
                for (offset = 0xf; offset >= 0; --offset) {
                        for (i = 0; i < NR_IRQS; ++i)
                                if (irq_vector[i] == level + offset)
                                        printk(" %d", i);
                }
        }
        printk("\n");
}

Output for my machine: 1 0 4 3 6 5 8 7 10 9 12 11 14 13 20 15
I don't believe this code is still correctly working (I have IRQ's
higher 20 in that system??), but according to this at least the first
2 serial ports (IRQ: 4 3) would already have a very good priority.

Next steps could be:
- removing every unnecessary interrupt handling code to improve performance
- trying realtime approaches, e.g. rt patches for kernel

Can someone help me with these issues I explained?
Maybe someone has similar problems?
Has anyone fixed some of these problems by decreasing IRQ latency?
Does anyone know if the rt patches make much difference?

By the way, I also tried an usb2serial converter (prolific chipset),
which solved every problem with overruns. I looked at the code and
found various 1K buffers being used for implementation. Can someone
verify that such "converters" usually work with much bigger hardware
buffers in compared to 16 Byte FIFO stuff? Also USB makes much of a
difference here, I think.

Any other information, advice or experience would be helpful and welcome.

Thanks in advance,
Andreas
