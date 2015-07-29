From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 4/5] tty/serial: at91: add support to FIFOs
Date: Wed, 29 Jul 2015 17:07:33 +0200
Message-ID: <20150729150733.GB6073@piout.net>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com>
 <4d8e90ad2cbb0d020dae4a4806ffc8864b5b22b6.1435842688.git.cyrille.pitchen@atmel.com>
 <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On 29/07/2015 at 17:51:38 +0300, Andy Shevchenko wrote :
> On Thu, Jul 2, 2015 at 4:18 PM, Cyrille Pitchen
> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> > Depending on the hardware, TX and RX FIFOs may be available. The RX
> > FIFO can avoid receive overruns, especially when DMA transfers are
> > not used to read data from the Receive Holding Register. For heavy
> > system load, The CPU is likely not be able to fetch data fast enough
> > from the RHR.
> 
> This patch broke avr32 console (as seen in today's linux-next) on ATNGW100.
> Reverting helps. I'm pretty sure the issue is in 8 bit vs. 32 bit I/O access.
> 
> # uname -a
> Linux buildroot 4.2.0-rc4-next-20150729+ #97 Wed Jul 29 17:50:11 EEST
> 2015 avr32 GNU/Linux
> 
> Do you, guys, have that board (NGW100) or it's officially unsupported?
> If the latter is the case I would really appreciate if you remove the
> support from the kernel side.
> 

The main issue here is that the main atmel arm developers don't have
access to any avr32 board. I'd say that everything that is done is best
effort to not break avr32 but it is not tested at all.

Don't hesitate to submit patches when something breaks...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
