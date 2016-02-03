From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Wed, 3 Feb 2016 23:22:36 +0100
Message-ID: <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
	<1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
	<CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
	<20160203230224.5ea52f65@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20160203230224.5ea52f65@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ofer Heifetz <oferh@marvell.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Wilson Ding <dingwei@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

I'm sorry, indeed, I was the one to overlook - there was a lot going
on in a thread and I missed it.

Ofer, as you found out that IRQF_SHARED help booting ubuntu - do you
think it's a hack or fix?

Best regards,
Marcin

2016-02-03 23:02 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Wed, 3 Feb 2016 22:41:15 +0100, Marcin Wojtas wrote:
>> Hi Gregory,
>>
>> > +       port->irq        = irq->start;
>> > +       port->irqflags   = 0;
>>
>> Same request as for v1, which you must have overlooked:
>> port->irqflags = IRQF_SHARED;
>
> Gregory didn't overlook this comment you made on v1, he even replied to
> it. Please check Gregory's reply to your review.
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
