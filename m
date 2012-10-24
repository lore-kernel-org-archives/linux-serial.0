From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH-v3] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Wed, 24 Oct 2012 11:22:12 -0700
Message-ID: <20121024182212.GA23291@kroah.com>
References: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
 <1348747325-13539-1-git-send-email-meltedpianoman@gmail.com>
 <20121022234746.GA12743@kroah.com>
 <20121023111659.6f4427c7@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50157 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935321Ab2JXSWP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2012 14:22:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so544222pad.19
        for <linux-serial@vger.kernel.org>; Wed, 24 Oct 2012 11:22:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121023111659.6f4427c7@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Ivo Sieben <meltedpianoman@gmail.com>, linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>

On Tue, Oct 23, 2012 at 11:16:59AM +0100, Alan Cox wrote:
> > Note, I took out the WARN_ON() in this patch, as what is that really
> > going to help here?  It also will conflict with a patch from Jiri I'll
> > ba applying after this one, so if you think it's needed, care to send
> > a follow-on patch based on linux-next in a few days?
> 
> It catches anyone flipping low_latency wrongly or in other places. It's
> fairly important as WARN_ON() goes !

Ok, I've applied the patch that Ivo sent doing this.

greg k-h
