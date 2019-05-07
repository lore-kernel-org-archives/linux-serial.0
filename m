From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 7 May 2019 14:53:25 +0300
Message-ID: <20190507115325.GV9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sgtqjy3l.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> > On Thu, 02 May 2019, Esben Haabendal wrote:
> >
> >> Could you help clarify whether or not this patch is trying to do
> >> something odd/wrong?
> >> 
> >> I might be misunderstanding Andy (probably is), but the discussion
> >> revolves around the changes I propose where I change the serial8250
> >> driver to use platform_get_resource() in favour of
> >> request_mem_region()/release_mem_region().
> >
> > Since 'serial8250' is registered as a platform device, I don't see any
> > reason why it shouldn't have the capability to obtain its memory
> > regions from the platform_get_*() helpers.
> 
> Good to hear.  That is exactly what I am trying do with this patch.
> 
> @Andy: If you still don't like my approach, could you please advice an
> acceptable method for improving the serial8250 driver to allow the use
> of platform_get_*() helpers?

I still don't get why you need this.

If it's MFD, you may use "serial8250" with a given platform data like dozens of
current users do.

Another approach is to use 8250 library, thus, creating a specific glue driver
(like all 8250_* do).

Yes, I understand that 8250 driver is full of quirks and not modern approaches
to do one or another thing. Unfortunately it's not too easy to fix it without
uglifying code and doing some kind of ping-pong thru the conversion. I don't
think it worth to do it in the current state of affairs. Though, cleaning up
the core part from the quirks and custom pieces would make this task
achievable.

I'm also puzzled why you don't use FPGA manager which should handle, as far as
I understand, very flexible configurations of FPGAs.

Btw, what exact IP of UART do you have implemented there?

-- 
With Best Regards,
Andy Shevchenko
