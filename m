From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 11:53:48 +0200
Message-ID: <1519638828.10722.153.camel@linux.intel.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-02-26 at 09:33 +0000, John Garry wrote:
> On 23/02/2018 17:31, Andy Shevchenko wrote:
> > On Fri, 2018-02-23 at 11:02 +0000, John Garry wrote:
> > > On 23/02/2018 10:30, Andy Shevchenko wrote:
> > > > On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:

> > > We require it for a development board for our hip06 platform.
> > 
> > Okay, and this particular platform uses Synopsys IP?
> 
> As I see this uart is really a virtual 8250, so HW details like apb 
> clocks and the like are hidden, so may not be relevant.

Good to know.

> However I will check with the BMC team to know the specific details.

> > > > >  for supporting an 8250-compatible UART with
> > > > > the following profile/features:
> > > > > - platform device
> > > > > - polling mode (i.e. no interrupt support)
> > > > > - ACPI FW
> > > > 
> > > > Elaborate this one, please.
> > > 
> > > So we need to define our own HID here, and cannot use PNP
> > > compatible
> > > CID
> > > (like PNP0501) as we cannot use the 8250 PNP driver.
> > 
> > Why not? What are the impediments?
> > 
> 
> To support the host controller for this device, we will create an
> MFD, 
> i.e. platform device, per slave device.

There is no answer here...

> > > This is related to the Hisi LPC ACPI support, where we would
> > > create
> > > an
> > > MFD (i.e. platform device) for the UART.
> > 
> > Why you can't do properly in ACPI?

No answer here either.

Sorry, but with this level of communication it's no go for the series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
