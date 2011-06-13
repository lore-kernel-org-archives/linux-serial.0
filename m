From: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Re: "irq 42: nobody cared" and I/O errors on serial ports
Date: Mon, 13 Jun 2011 08:48:18 -0700
Message-ID: <20110613154818.GB32372@kroah.com>
References: <4DF5FAA3020000360001E08D@gwia.alliedtelesyn.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42862 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab1FMPsZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Jun 2011 11:48:25 -0400
Content-Disposition: inline
In-Reply-To: <4DF5FAA3020000360001E08D@gwia.alliedtelesyn.co.nz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: andrew mcgregor <andrew.mcgregor@alliedtelesis.co.nz>
Cc: linux-serial@vger.kernel.org

On Mon, Jun 13, 2011 at 11:55:14AM +1200, andrew mcgregor wrote:
> Ok, patch attached.
> 
> 
> 
> NOTICE: This message contains privileged and confidential
> information intended only for the use of the addressee
> named above. If you are not the intended recipient of
> this message you are hereby notified that you must not
> disseminate, copy or take any action in reliance on it.
> If you have received this message in error please
> notify Allied Telesis Labs Ltd immediately.
> Any views expressed in this message are those of the
> individual sender, except where the sender has the
> authority to issue and specifically states them to
> be the views of Allied Telesis Labs.


Because of this header, I can't accept any patches sent with it, as it
contridicts the "Signed-off-by:" line below.  Which should I believe?

Please resend without it and fix the email to: line, as that was quite
corrupted as well, and I will be glad to queue it up.

> >From 9c14cbc96253c90533a4dbd12fd8cc23955d7133 Mon Sep 17 00:00:00 2001
> From: Andrew McGregor <andrew.mcgregor@alliedtelesis.co.nz>
> Date: Mon, 13 Jun 2011 11:31:31 +1200
> Subject: [PATCH]  fix "IRQ45: nobody cared"
> 
> Unthrottling the TTY during close ends up enabling interrupts
> on a device not on the active list, which will never have the
> interrupts cleared.  Doctor, it hurts when I do this.
> 
> On Wed, 01 Jun 2011 10:34:07 +1200
> "andrew mcgregor" <andrew.mcgregor@alliedtelesis.co.nz> wrote:
> 
> > The LKML message
> > http://kerneltrap.org/mailarchive/linux-kernel/2010/2/25/4541847 from
> > February doesn't seem to have been resolved since.  We struck the
> > issue, and the patch below (against 2.6.32) fixes it.  Should I
> > supply a patch against 3.0.0rc?
> 
> I think that would be sensible. I don't actually see how you hit it as
> the IRQ ought to be masked by then but it's certainly wrong for n_tty
> to be calling into check_unthrottle at that point.
> 
> So yes please send a patch with a suitable Signed-off-by: line to
> linux-serial and cc GregKH <greg@kroah.com> as well.
> 
> Alan
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Wait, Alan wrote this?  Or you did?  You can't add someone elses
Signed-off-by: to a patch they didn't create.  Please read
Documentation/SubmittingPatches for what this line means.

thanks,

greg k-h
