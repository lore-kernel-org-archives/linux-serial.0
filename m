From: Yuriy Kozlov <ykozlov@ptcusa.com>
Subject: Re: [PATCH] tty: serial: altera_uart: Check for NULL platform_data in probe.
Date: Thu, 29 Mar 2012 16:02:07 -0400
Message-ID: <2271072.B4UpndiPVz@hyrum>
References: <1333007727-24045-1-git-send-email-tklauser@distanz.ch> <20120329193855.GW21503@distanz.ch> <20120329194711.GB12194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ptcusa.com ([74.92.30.165]:40221 "HELO ptcusa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933223Ab2C2VEH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 17:04:07 -0400
In-Reply-To: <20120329194711.GB12194@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Thursday, March 29, 2012 12:47:11 Greg Kroah-Hartman wrote:
> On Thu, Mar 29, 2012 at 09:38:55PM +0200, Tobias Klauser wrote:
> > On 2012-03-29 at 18:13:37 +0200, Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> wrote:
> > > On Thu, Mar 29, 2012 at 09:55:27AM +0200, Tobias Klauser wrote:
> > > > From: Yuriy Kozlov <ykozlov@ptcusa.com>
> > > > 
> > > > Follow altera_jtag_uart.  This fixes a crash if there is a mistake in
> > > > the DTS.> > 
> > > Is this something you have seen in the wild?  Is this something to be
> > > backported to stable kernels?
> > 
> > Not that I know of. But nevertheless it might be worthwhile. Shall I
> > send the patch again with Cc: stable@kernel.org?
> 
> Nope, I can add it.
> 
> But, if this isn't something that you have seen, why is it needed to be
> checked for?  What is this making work properly that isn't working
> properly now?
> 
> thanks,
> 
> greg k-h

The driver is designed to use Device Tree to get hardware information, so 
platp (platform_data) is usually NULL.  platform_data is still used as a 
fallback mechanism.  The problem arises when the device is in the DT, but is 
missing a required property (address or irq).  The driver falls back to 
looking for it in the null platp and panics.  The function actually already 
checks platp for other properties later on, but under this condition it tried 
to dereference it before the null checks.

-- 
~ Yuriy Kozlov
 Pyramid Technical Consultants, Inc.
---------------------------------------------------------

