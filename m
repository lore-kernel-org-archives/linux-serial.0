From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 7 May 2019 10:32:39 +0100
Message-ID: <20190507093239.GB4529@dell>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87pnp11112.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 02 May 2019, Esben Haabendal wrote:

> Hi Lee
> 
> Could you help clarify whether or not this patch is trying to do
> something odd/wrong?
> 
> I might be misunderstanding Andy (probably is), but the discussion
> revolves around the changes I propose where I change the serial8250
> driver to use platform_get_resource() in favour of
> request_mem_region()/release_mem_region().

Since 'serial8250' is registered as a platform device, I don't see any
reason why it shouldn't have the capability to obtain its memory
regions from the platform_get_*() helpers.

> In my understanding, use of platform_get_resource() is the right thing
> to do in order to integrate properly with with MFD drivers that splits a
> common memory resource in mfd_add_device() using the mem_base argument.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
