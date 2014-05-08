From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Fwd: Issues with parity error handling in s3c2410 serial driver
Date: Thu, 8 May 2014 21:55:10 +0200
Message-ID: <20140508195510.GA8479@kroah.com>
References: <CABDcavZnY8-uNhYZkvCEy5sdbAQB2vgcYq1PFiNwpvxj32Xn2Q@mail.gmail.com>
 <CABDcavZyCDPpt1MTGpJfgaYnG=oaHcmB-Sqe=PC1SWuQhf-iTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41020 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214AbaEHTz0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 May 2014 15:55:26 -0400
Content-Disposition: inline
In-Reply-To: <CABDcavZyCDPpt1MTGpJfgaYnG=oaHcmB-Sqe=PC1SWuQhf-iTg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc: linux-serial@vger.kernel.org

On Thu, May 08, 2014 at 01:31:10PM +0200, Guillermo Rodriguez Garcia wrote:
> Hello all,
> 
> I think I have found some issues with the handling of parity errors in the
> s3c2410 serial driver (drivers/tty/serial/samsung.c)
> 
> 1.
> The driver defines S3C2410_UERSTAT_PARITY as 0x1000
> (see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung.c#L265)
> 
> However, at least in the S3C2440, the correct value should be 0x02.
> This matches the definition in include/linux/serial_s3c.h for the S3C2443 (see
> http://lxr.free-electrons.com/source/include/linux/serial_s3c.h#L165)
> 
> 2.
> The driver currently contains code to detect parity errors, but this code is
> guarded by the following check:
> 
> if (unlikely(uerstat & S3C2410_UERSTAT_ANY)) {
> ...
> }
> 
> And the definition of S3C2410_UERSTAT_ANY in include/linux/serial_s3c.h
> does not include the parity bit.
> 
> This means that the code that currently checks for parity errors in the serial
> driver won't actually be run when a parity error occurs. I think that this is a
> bug and that S3C2410_UERSTAT_ANY should also contain the parity bit
> 
> 3.
> The code that detects parity errors does not increment the parity error
> counter in the serial_icounter_struct structure. Other errors (framing and
> overrun) are accounted for -- it is just the parity error that is not traced
> (see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung.c#L277).
> 
> This means that parity errors will not be reported via the TIOCGICOUNT
> ioctl call.
> 
> 
> Can someone comment on the above?

Can you make up a patch to resolve these and be sure to cc: the driver
authors and this list?

thanks,

greg k-h
