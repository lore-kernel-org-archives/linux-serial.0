From: Karthik Manamcheri <karthik.manamcheri@ni.com>
Subject: Re: Revert "serial: 8250: Make SERIAL_8250_RUNTIME_UARTS work correctly"
Date: Mon, 3 Jun 2013 15:05:55 -0500
Message-ID: <OF9219EF22.9BB86D35-ON86257B7F.006E67B1-86257B7F.006E67B5@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 
References: 
Sender: linux-kernel-owner@vger.kernel.org
To: kyle@infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, torvalds@linuxfoundation.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> No worries, I undertand what Karthik is talking about, so I'll try to
> figure this out.
>
> CONFIG_SERIAL_8250_NR_UARTS=32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4

The description for "CONFIG_SERIAL_8250_RUNTIME_UARTS" is "Set this to the maximum number of serial ports you want the kernel to register at boot time."
Setting it to 4 means that you want to use 4 legacy ports! If you do not have any legacy UARTs, you are to set this to 0.

>
> is what was set in my .config, resulting in:
>
> [3.9.y]
> 0: uart:16550A port:00001030 irq:16 tx:16522 rx:0 RTS|CTS|DTR|CD
> 1: uart:unknown port:000002F8 irq:3
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
>
> [3.10-rc2]
> 0: uart:unknown port:000003F8 irq:4
> 1: uart:unknown port:000002F8 irq:3
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
> 4: uart:16550A port:00001030 irq:16 tx:16226 rx:0 RTS|CTS|DTR|CD

You have five ports because you set CONFIG_SERIAL_8250_RUNTIME_UARTS to 4 and then you have to PCI port. This is exactly what my change addressed. We had issues with the ghost ports created in the system. In your case, if you set CONFIG_SERIAL_8250_RUNTIME_UARTS to 0, you'll have just one port which is the working available port.

> There's undeniably something wrong if RUNTIME_UARTS=0 doesn't result
> in his serial ports showing up, I'll try to help debug that, but I
> think the 3.9 behaviour is desireable if no "legacy" uarts are found.

The variable nr_uarts is set to CONFIG_SERIAL_8250_RUNTIME_UARTS and if you set it to 0, then well, nothing will be created since you are looping to nr_uarts time, which is what I changed.

> regards, Kyle

Karthik Manamcheri | Software R&D | Instrument control products | National Instruments | (512) 683 6174