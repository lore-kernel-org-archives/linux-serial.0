From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Tue, 14 Jun 2016 19:00:46 +0300
Message-ID: <1465920046.30123.83.camel@linux.intel.com>
References: <575F7325.3030907@kernel.org>
    <1465897220.30123.26.camel@linux.intel.com>
	 <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dinh.linux@anniebear.net
Cc: Dinh Nguyen <dinguyen@kernel.org>, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-06-14 at 10:27 -0500, dinh.linux@anniebear.net wrote:
> > 
> > On Mon, 2016-06-13 at 21:59 -0500, Dinh Nguyen wrote:
> > > Apologies, but my original email bounced for Andy and Heikki,
> > > resending.
> > > ----
> > 
> > I suppose this one, i.e. commit dd4e91d538b3 ("dmaengine: slave
> > means at
> > least one of DMA_SLAVE, DMA_CYCLIC"), solves the issue.
> > 
> 
> Hmm...that commit didn't seem to fix my issue.
> 
> In regard to Peter's reply:
> 
> "The error is that your dmaengine driver doesn't support the
> functionality
> required by the 8250 driver."

Ah, sorry, indeed. Peter is right.

> Does this mean that the 8250_dw.c driver can no longer use DMA?

It means that previously the use of DMA engine whatever was used is not
correct in your case. There is no issues in UART driver, the issue is in
DMA controller driver.

I'm working on a quirk that will allow user to enforce PIO mode for
Rx/Tx or both. In that case if DMA controller can't be fixed you still
might use DMA for Tx.

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
