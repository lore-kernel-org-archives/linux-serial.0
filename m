From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Wed, 03 Feb 2016 17:43:59 +0100
Message-ID: <87io254ucw.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
	<CAPv3WKfGX2dVDu2zWG4gdEMf0vO-X+NMerh9PzNDjzLBDSQcUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPv3WKfGX2dVDu2zWG4gdEMf0vO-X+NMerh9PzNDjzLBDSQcUA@mail.gmail.com>
	(Marcin Wojtas's message of "Wed, 3 Feb 2016 09:05:55 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Wilson Ding <dingwei@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Marcin,
=20
 On mer., f=C3=A9vr. 03 2016, Marcin Wojtas <mw@semihalf.com> wrote:

> Hi Gregory
>
>> +
>> +static int mvebu_uart_startup(struct uart_port *port)
>> +{
>> +       int ret;
>> +
>> +       writel(CTRL_TXFIFO_RST | CTRL_RXFIFO_RST,
>> +              port->membase + UART_CTRL);
>> +       udelay(1);
>> +       writel(CTRL_RX_INT, port->membase + UART_CTRL);
>> +
>> +       ret =3D request_irq(port->irq, mvebu_uart_isr, port->irqflag=
s, "serial",
>> +                         port);
>> +       if (ret) {
>> +               dev_err(port->dev, "failed to request irq\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
>> +static int mvebu_uart_probe(struct platform_device *pdev)
>> +{
>> +       struct resource *reg =3D platform_get_resource(pdev, IORESOU=
RCE_MEM, 0);
>> +       struct resource *irq =3D platform_get_resource(pdev, IORESOU=
RCE_IRQ, 0);
>> +       struct uart_port *port;
>> +       struct mvebu_uart_data *data;
>> +       int ret;
>> +
>> +       if (!reg || !irq) {
>> +               dev_err(&pdev->dev, "no registers/irq defined\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       port =3D &mvebu_uart_ports[0];
>> +
>> +       spin_lock_init(&port->lock);
>> +
>> +       port->dev        =3D &pdev->dev;
>> +       port->type       =3D PORT_MVEBU;
>> +       port->ops        =3D &mvebu_uart_ops;
>> +       port->regshift   =3D 0;
>> +
>> +       port->fifosize   =3D 32;
>> +       port->iotype     =3D UPIO_MEM32;
>> +       port->flags      =3D UPF_FIXED_PORT;
>> +       port->line       =3D 0; /* single port: force line number to=
  0 */
>> +
>> +       port->irq        =3D irq->start;
>> +       port->irqflags   =3D 0;
>
> Please use port->irqflags =3D IRQF_SHARED;
> As ubuntu opens multiple consoles A3700 can't boot to it (only to
> buildroot with single console).

But this irq is not shared, this looks like a hack hidding the real
issue.

Gregory

>
> Best regards,
> Marcin

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
