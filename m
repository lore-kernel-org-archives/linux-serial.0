From: Noam Camus <noamc@ezchip.com>
Subject: Re: [v2 2/3] serial: 8250_dw: dw8250_setup_port() use endianness
 aware read.
Date: Mon, 10 Aug 2015 19:13:39 +0000
Message-ID: <DB4PR02MB272D45ABADAF421FA8B149CD6700@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
 <1437886478-29273-3-git-send-email-noamc@ezchip.com>,<20150803234221.GA5257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803234221.GA5257@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Greg KH <greg@kroah.com>
Sent: Tuesday, August 4, 2015 2:42 AM

> > -     reg = readl(p->membase + DW_UART_CPR);
> > +     reg = (p->iotype == UPIO_MEM32BE) ?
> > +             ioread32be(p->membase + DW_UART_CPR) :
> > +             readl(p->membase + DW_UART_CPR);
>
> Same here.
>
> And shouldn't all of this be "hidden" behind something else?  You should
not have to do this for each readl call...
>

As I wrote for last patch, I will add another level for accessors and use it here.

Noam