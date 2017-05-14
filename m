From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: exar: Fix stuck MSIs
Date: Sun, 14 May 2017 13:32:22 +0200
Message-ID: <20170514113222.GA10578@kroah.com>
References: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
 <1493024379.24567.154.camel@linux.intel.com>
 <d227c786-24eb-5acb-777d-02bd28d14254@web.de>
 <1493027143.24567.155.camel@linux.intel.com>
 <b76259dc-42bf-4b3c-8122-04e0b0d217a2@siemens.com>
 <1493035647.24567.165.camel@linux.intel.com>
 <ffaa5003-c62a-1bce-eb59-827a762aefb0@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ffaa5003-c62a-1bce-eb59-827a762aefb0@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 09:09:17AM +0200, Jan Kiszka wrote:
> On 2017-04-24 14:07, Andy Shevchenko wrote:
> > On Mon, 2017-04-24 at 12:30 +0200, Jan Kiszka wrote:
> >> After migrating 8250_exar to MSI in 172c33cb61da, we can get stuck
> >> without further interrupts because of the special wake-up event these
> >> chips send. They are only cleared by reading INT0. As we fail to do so
> >> during startup and shutdown, we can leave the interrupt line asserted,
> >> which is fatal with edge-triggered MSIs.
> >>
> >> Add the required reading of INT0 to startup and shutdown. Also account
> >> for the fact that a pending wake-up interrupt means we have to return
> >> 1
> >> from exar_handle_irq. Drop the unneeded reading of INT1..3 along with
> >> this - those never reset anything.
> >>
> >> An alternative approach would have been disabling the wake-up
> >> interrupt.
> >> Unfortunately, this feature (REGB[17] = 1) is not available on the
> >> XR17D15X.
> > 
> > FWIW:
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> Ping. Needs to go into stable 4.11 now as well.

Relax, I'll get to it after 4.12-rc1 is out...
