From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v4 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Wed, 6 Jan 2016 11:03:50 +0000
Message-ID: <20160106110350.GB3599@xora-haswell.xora.org.uk>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
 <CAOZdJXUpjWi7Dy=GFi7_58FqD_UZxxrw_QKJ4sdHLKVOLCyNAA@mail.gmail.com>
 <CAGCh1+ksWFLkE8Y_a5SW98tpgGBWdVH5TYJAoS17EExuPd65oQ@mail.gmail.com>
 <568BEDEC.5010101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568BEDEC.5010101@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: G Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Vladimir Zapolskiy <vz@mleia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 05, 2016 at 10:23:08AM -0600, Timur Tabi wrote:
> G Gregory wrote:
> >>>I'm confused by this patch.  We already have code like this in
> >>>tty-next, in the form of sbsa_uart_probe():
> >>>
> >>>https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/+/tty-next/drivers/tty/serial/amba-pl011.c#2553
> >>>
> >Because Russell expressed unhappiness at that code existing. So this
> >is an alternative method to do same thing with ACPI.
> 
> FYI, this patch doesn't apply on tty-next as-is, so it would need to be
> updated anyway.  Then again, considering the latest drama with that driver,
> who knows what it will look like?
> 
> >If the "arm,sbsa-uart" id was added to drivers/of/platform.c as an
> >AMBA id then the same could be done for DT as well.
> >
> >Ultimately this patch is optional depending on maintainers opinion!
> 
> So with this patch, what is the difference between sbsa_uart_probe and
> pl011_probe?  Shouldn't the patch also remove sbsa_uart_probe?
> 

One is for amba_device and one is for platform_device and one maintainer
indicated displeasure at platfrom device being in an AMBA driver. So we would
like some guidance from maintainers what direction they would like to take.

We can either drop this patch and leave situation as is (and remove
ARMH0011 from scan handler) or add followup patches to also convert DT
usage of sbsa-uart to amba_device.

Graeme
