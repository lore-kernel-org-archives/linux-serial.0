From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: samsung: Remove hard-coded major/minor numbers
Date: Fri, 27 Dec 2013 10:44:24 -0800
Message-ID: <20131227184424.GA4938@kroah.com>
References: <1388120848-15879-1-git-send-email-tushar.behera@linaro.org>
 <20131227051843.GA840@kroah.com>
 <CAHbNUh27ZZ5UxuLMPvv6weNOSG4XKV9ZRrmTB9F0RvgQxufGDQ@mail.gmail.com>
 <20131227063843.GA3310@kroah.com>
 <CAHbNUh0NBVEBJbSG7UWgnHbORgbKCrA_74=jiArSvv5jaFk1SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHbNUh0NBVEBJbSG7UWgnHbORgbKCrA_74=jiArSvv5jaFk1SQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-serial <linux-serial@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, jslaby <jslaby@suse.cz>, Patch Tracking <patches@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, ben@simtec.co.uk, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, heiko <heiko@sntech.de>, Kgene Kim <kgene.kim@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 27, 2013 at 03:47:31PM +0530, Tushar Behera wrote:
> On 27 December 2013 12:08, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Dec 27, 2013 at 12:00:20PM +0530, Tushar Behera wrote:
> >> On 27 December 2013 10:48, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > On Fri, Dec 27, 2013 at 10:37:28AM +0530, Tushar Behera wrote:
> 
> [ ... ]
> 
> >> >> @@ -951,8 +949,6 @@ static struct uart_driver s3c24xx_uart_drv = {
> >> >>       .nr             = CONFIG_SERIAL_SAMSUNG_UARTS,
> >> >>       .cons           = S3C24XX_SERIAL_CONSOLE,
> >> >>       .dev_name       = S3C24XX_SERIAL_NAME,
> >> >> -     .major          = S3C24XX_SERIAL_MAJOR,
> >> >> -     .minor          = S3C24XX_SERIAL_MINOR,
> >> >
> >> > Doesn't this break existing systems and configurations that are
> >> > expecting 204:64 as the location of this serial port?
> >> >
> >>
> >> I tested this on Exynos4210-Origen, Exynos5250-Arndale board, it works
> >> fine there. I haven't tested on any older boards.
> >
> > How did it work?  You are relying on some userspace tools to do this
> > properly, right?  What about systems without those specific tools?
> >
> 
> Enabling CONFIG_DEVTMPFS, all the /dev/ttySAC<n> nodes are generated
> and the appropriate console is specified through command line
> argument.

But what about systems that rely on a hard-coded /dev?

Look, I'm all for making everyone use devtmpfs, but just changing
major:minor numbers for drivers isn't ok, as you are changing the
userspace ABI for the device.

Please realize what you are asking for here, I really don't think you
grasp it given that you didn't ask any of the maintainers of this driver
about the change in the first place.

Please get approval for this patch from others within Linaro before
sending it out again.  Linaro has a process in place for this type of
thing, please use it, otherwise it makes people like me really grumpy
and upset and causes me to yell at people at their conferences.

greg k-h
