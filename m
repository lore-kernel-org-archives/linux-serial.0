From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 06 Oct 2006 00:15:11 -0400
Message-ID: <4525D84F.9090506@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <878xlgercm.fsf@slug.be.48ers.dk> <20060912093301.77f75bfb@localhost.localdomain> <87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain> <451E380B.5000401@dlasys.net> <878xjwkr2n.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:62425
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP
	id S1751778AbWJFESx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 00:18:53 -0400
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1237)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GVh1k-0001bh-9J by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2006 00:09:36 -0400
In-Reply-To: <878xjwkr2n.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
>  David> 	Your ulite_console_write performance is pretty slow -
>  David> almost an order of magnitude slower than what I am seeing in
>  David> my driver. I beleive it is because you are waiting for the Tx
>  David> FIFO to be empty before and after sending each character
>  David> rather than only waiting while the Tx FIFO is full.
>
> Really? The implementation is basically a copy of 8250.c, so I would
> imagine that would get similar performance. Perhaps it's related to
> your specific setup?
>
> The driver only waits before sending a character, not afterwards.
>   

    From your code:
    there is a call to ulite_console_wait_tx() in each call to 
ulite_console_putchar() and a call after uart_console_write()
    However as I later determined that is NOT the problem. Either 
uart_console_write() is very slow, or there is a parameter wrong - 
probably in uart_port.
    But if you have something wrong there. So do I because when I switch 
my code to uase uart_console_write() instead of the a manual 
implimentation of puts (what older drivers use, including older 8250's)
    I get the same problem. I think my driver using uart_console_write() 
may be faster - but that may be wishful thinking. Both are abysmal 
compared to a simple puts loop. The difference is dramatic.

+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+static void ulite_console_wait_tx(struct uart_port *port)
+{
+	int i;
+
+	/* wait up to 10ms for the character(s) to be sent */
+	for (i=0; i<10000; i++) {
+		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+			break;
+		udelay(1);
+	}
+}
+
+static void ulite_console_putchar(struct uart_port *port, int ch)
+{
+	ulite_console_wait_tx(port);
+	writeb(ch, port->membase + ULITE_TX);
+}
+
+static void ulite_console_write(struct console *co, const char *s,
+				unsigned int count)
+{
+	struct uart_port *port = &ports[co->index];
+	unsigned long flags;
+	unsigned int ier;
+	int locked = 1;
+
+	if (oops_in_progress) {
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	} else
+		spin_lock_irqsave(&port->lock, flags);
+
+	/* save and disable interrupt */
+	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
+	writeb(0, port->membase + ULITE_CONTROL);
+
+	uart_console_write(port, s, count, ulite_console_putchar);
+
+	ulite_console_wait_tx(port);
+
+	/* restore interrupt state */
+	if (ier)
+		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+
+	if (locked)
+		spin_unlock_irqrestore(&port->lock, flags);
+}
+




>  David> 	That may also be an issue in the rest of the driver but I have been
>  David> unable to get it to through registering the driver.
>  David> 	I suspect that is because your driver is a platform driver, but you did
>  David> not provide patches to the arch/ppc/platforms/4xx/virtex.* or
>  David> xilinx_ml???.* to setup the platform device structure.
>
> No, because the Xilinx boards don't have any uartlite devices.
>
>  David> 	If you could provide a copy I would appreciate it.
>
> Sure, just add something like this to your board code (with your base
> address/irq ofcause):
> 	
> static struct resource uartlite_resources[] = {
>        [0] = {
>            .start  = 0xa1000003,
>            .end    = 0xa1000012,
>            .flags  = IORESOURCE_MEM,
>        },
>        [1] = {
>            .start  = 2,
>            .end    = 2,
>            .flags  = IORESOURCE_IRQ,
>        },
> };
>
> static struct platform_device uartlite = {
>        .name              = "uartlite",
>        .id                = 0,
>        .num_resources     = ARRAY_SIZE(uartlite_resources),
>        .resource          = uartlite_resources,
>        .dev.platform_data = 0,
> };
>
> static struct platform_device *my_devices[] __initdata = {
>        &uartlite,
>        .
>        .
>        .
> };
>
> static int __init
> my_platform_add_devices(void)
> {
>         return platform_add_devices(my_devices, ARRAY_SIZE(my_devices));
>
> }
>
> arch_initcall(my_platform_add_devices);
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

