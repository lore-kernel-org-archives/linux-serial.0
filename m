From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] This driver supports UART-DM HW on MSM platforms.
 It uses the on chip DMA to drive data transfers and has optional support
 for UART power management independent of Linux suspend/resume and wakeup
 from Rx.
Date: Tue, 14 Dec 2010 13:33:22 -0800
Message-ID: <20101214213322.GB11298@kroah.com>
References: <1292307586-6548-1-git-send-email-mrana@codeaurora.org>
 <20101214171404.GB3832@kroah.com>
 <AANLkTinVpJ-p648gOuRWyV2kp4U-HTu2rtirBnzOAJnK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46175 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760247Ab0LNVeT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Dec 2010 16:34:19 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinVpJ-p648gOuRWyV2kp4U-HTu2rtirBnzOAJnK@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nick Pelly <npelly@google.com>
Cc: Mayank Rana <mrana@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, Sankalp Bose <sankalpb@codeaurora.org>

On Tue, Dec 14, 2010 at 01:08:28PM -0800, Nick Pelly wrote:
> On Tue, Dec 14, 2010 at 9:14 AM, Greg KH <greg@kroah.com> wrote:
> >
> > That's some subject: are you sure that should really be the subject?
> >
> > On Tue, Dec 14, 2010 at 11:49:46AM +0530, Mayank Rana wrote:
> > > The driver was originally developed by Google. It is functionally
> > > equivalent to the version available at:
> > > http://android.git.kernel.org/?p=kernel/experimental.git
> > > the differences being:
> > > 1) Remove wakelocks and change unsupported DMA API.
> > > 2) Replace clock selection register codes by macros.
> > > 3) Fix checkpatch errors and add inline documentation.
> > > 4) Add runtime PM hooks for active power state transitions.
> > >
> > > CC: Nick Pelly <npelly@google.com>
> > > Signed-off-by: Sankalp Bose <sankalpb@codeaurora.org>
> > > Signed-off-by: Mayank Rana <mrana@codeaurora.org>
> >
> > <snip>
> >
> > I don't see the previous review comments I made addressed here, what
> > happened?
> >
> > Specifically, you need to sort out the ownership of this file (who wrote
> > the thing, why you are submitting something written by someone else
> > without their approval, etc.) and the like.
> 
> Glad someone is trying to get the patch upstream, but I think Mayank
> has taken it a step backwards from the version on Android open source.
> 
> Removing the wakelock's are fine since they are somewhat
> controversial, and not core to the driver.

Why are they removed?  We now have the infrastructure in the kernel to
keep them.  I say put them back so you can use the same driver in the
Android builds as well.

> But adding all the boilerplate comments on each function? They add no value.

For some functions, they can be helpful.

> As far as authorship, I took the original Qualcomm driver and re-wrote
> it. There is probably not a lot of code the same. The original driver
> was very useful for regression testing though.

A pointer to the original driver, and the copyright notice from it, and
authorship information is needed in this version of the driver then.

thanks,

greg k-h
