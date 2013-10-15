From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip
 PI7C9X7952/4/8
Date: Tue, 15 Oct 2013 07:09:03 -0700
Message-ID: <20131015140903.GA20755@kroah.com>
References: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
 <CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50580 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758940Ab3JOOIE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 10:08:04 -0400
Content-Disposition: inline
In-Reply-To: <CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Angelo Butti <buttiangelo@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 15, 2013 at 03:48:55PM +0200, Angelo Butti wrote:
> Hi all,
> I'm here again to try to solve and add support to Pericom serial devices.
> 
> To solve is really simple, but I don't know if I make the correct
> procedure. The solution is change the clock value from 1.8432 to
> 14.7456.
> To do this I add a new setup specific for pericom devices, and I add
> this 3 devices inside the Master list of serial port.
> 
> Now, is possible add this to the standard linux kernel, so also the
> Pericom device will be ok ?
> 
> Below the patch for the 3.10.11 kernel ....

Can you generate the patch with 'diff -u' so that it is in a format that
I can apply it to the kernel tree?  Specifics on how to create the
patch, and what you need to include in it is in the
Documentation/SubmittingPatches file.

If you have any problems or questions after reading that file, please
let us know.

thanks,

greg k-h
