From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v3 01/21 resend] serial: rewrite pxa2xx-uart to use
 8250_core
Date: Thu, 19 Dec 2013 13:35:13 +0400
Message-ID: <1387445713.31516.30.camel@host5.omatika.ru>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
	 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	 <1387309071-22382-2-git-send-email-ynvich@gmail.com>
	 <20131219085145.GB20686@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131219085145.GB20686@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, James Cameron <quozl@laptop.org>, Zhou Zhu <zzhu3@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Heikki,

On Thu, 2013-12-19 at 10:51 +0200, Heikki Krogerus wrote:
> I noticed one more thing. I'm sorry about commenting this late.
> 
> Since you set the type PORT_XSCALE, don's you want to use
> UPF_FIXED_TYPE flag instead of the UPF_SKIP_TEST here? Otherwise the
> type will just get overridden and autoconfig() will be executed.

UPF_FIXED_PORT was my first guess. However, it didn't work.

I've also tried to do ioremap in serial_pxa_probe instead of using
UPF_IOREMAP. This didn't work as well.

I've left this

uart.port.type = PORT_XSCALE;

as an indicator that 8250_pxa depends on this port type, and anyone
changing its specific code paths should test with 8250_pxa. This line
could be safely removed or commented out, if you feel strongly about
that.

> I'm guessing you also want to prevent things like the irq and the
> uartclk from being changed by anybody by using the flag
> UPF_FIXED_PORT, right?

IIRC, autoprobing doesn't change irq or uartclk.
