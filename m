From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH resend] serial: 8250: Add support for using platform_device resources
Date: Tue, 21 May 2019 16:45:34 +0200
Message-ID: <878suzn9wx.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190521113426.16790-1-esben@geanix.com>
        <20190521131131.GA19685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521131131.GA19685@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 21 May 2019 15:11:31 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
>> Allow getting memory resource (mapbase or iobase) as well as irq from
>> platform_device resources.
>> 
>> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
>> resources are to be used.  When not set, driver behaves as before.
>
> Nothing actually sets this flag in this patch, so I can't take this as
> you are adding new features that no one uses :(
>
> Where is the driver that sets this?

It sits here.  It is a rather big and clunky mfd driver, not ready for
upstreaming in its current form.  I hope to get around to clean it up.
But it is for a very specific hardware that is really available or
usable for anybody else.  Does it make sense to spend effort on
submitting such a driver?

/Esben
