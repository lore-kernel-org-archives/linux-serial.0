From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Wed, 3 Feb 2016 23:02:24 +0100
Message-ID: <20160203230224.5ea52f65@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
	<1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
	<CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Wilson Ding <dingwei@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Dear Marcin Wojtas,

On Wed, 3 Feb 2016 22:41:15 +0100, Marcin Wojtas wrote:
> Hi Gregory,
> 
> > +       port->irq        = irq->start;
> > +       port->irqflags   = 0;
> 
> Same request as for v1, which you must have overlooked:
> port->irqflags = IRQF_SHARED;

Gregory didn't overlook this comment you made on v1, he even replied to
it. Please check Gregory's reply to your review.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
