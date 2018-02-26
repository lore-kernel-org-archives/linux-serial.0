From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 13:28:37 +0200
Message-ID: <1519644517.10722.179.camel@linux.intel.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-02-26 at 10:45 +0000, John Garry wrote:

> > > > > > >  for supporting an 8250-compatible UART with
> > > > > > > the following profile/features:
> > > > > > > - platform device
> > > > > > > - polling mode (i.e. no interrupt support)
> > > > > > > - ACPI FW
> > > > > > 
> > > > > > Elaborate this one, please.
> > > > > 
> > > > > So we need to define our own HID here, and cannot use PNP
> > > > > compatible
> > > > > CID
> > > > > (like PNP0501) as we cannot use the 8250 PNP driver.
> > > > 
> > > > Why not? What are the impediments?
> > > > 
> > > 
> > > To support the host controller for this device, we will create an
> > > MFD,
> > > i.e. platform device, per slave device.
> > 
> > There is no answer here...
> > 
> > > > > This is related to the Hisi LPC ACPI support, where we would
> > > > > create
> > > > > an
> > > > > MFD (i.e. platform device) for the UART.
> > > > 
> > > > Why you can't do properly in ACPI?
> > 
> > No answer here either.
> > 
> > Sorry, but with this level of communication it's no go for the
> > series.
> > 
> 
> Sorry if my answers did not tell you want you want to know.
> 
> My point was that the 8250_pnp driver would be used for a pnp_device, 
> but we are creating a platform device for this UART slave so would 
> require a platform device driver, that which 8250_dw.c is. But I will 
> check on pnp device support.

Perhaps it's not visible, though below is a description of the drivers
we have:

8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
8250_of -  generic 8250 compatible driver for OF
8250_pci - generic 8250 compatible driver for PCI
8250_pnp - generic 8250 compatible driver for ACPI

8250_* (except core parts) - custom glue drivers per some IPs

By description you gave your driver fits 8250_pnp if ACPI tables crafted
properly.

Share the ACPI excerpt and we can discuss further how to improve them.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
