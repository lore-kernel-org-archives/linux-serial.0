From: Noam Camus <noamc@ezchip.com>
Subject: RE: [v2 1/3] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Mon, 10 Aug 2015 19:08:44 +0000
Message-ID: <DB4PR02MB2726A3A761927DBF6A53B7BD6700@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
 <20150803234326.GB5257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803234326.GB5257@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Greg KH [mailto:greg@kroah.com] 
Sent: Tuesday, August 04, 2015 2:43 AM

> > -	writel(value, p->membase + (offset << p->regshift));

> Why drop this write?
This was not dropped, it is now part of dw8250_serial_out32().
Now it is called before updating last_mcr.

> > -			writel(value, p->membase + (UART_LCR << p->regshift));
> > +			if (p->iotype == UPIO_MEM32BE)
> > +				iowrite32be(value,
> > +					p->membase + (UART_LCR << p->regshift));
> > +			else
> > +				writel(value,
> > +					p->membase + (UART_LCR << p->regshift));

> Shouldn't this be hidden behind some other type of accessor?  Why is this one writel() "special"?

I will add inner level accessors into "struct dw8250_data" for in32/out32. new accessors will be used in few places in this driver that still uses writel/readl without considering iotype.

Noam