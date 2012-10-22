From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH-v3] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Mon, 22 Oct 2012 16:47:46 -0700
Message-ID: <20121022234746.GA12743@kroah.com>
References: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
 <1348747325-13539-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48141 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2JVXru (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Oct 2012 19:47:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2458pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 22 Oct 2012 16:47:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348747325-13539-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>

On Thu, Sep 27, 2012 at 02:02:05PM +0200, Ivo Sieben wrote:
> When low_latency flag is set the TTY receive flip buffer is copied to the
> line discipline directly instead of using a work queue in the background.
> Therefor only in case a workqueue is actually used for copying data to the
> line discipline we'll have to flush the workqueue.
> 
> This prevents unnecessary spin lock/unlock on the workqueue spin lock that
> can cause additional scheduling overhead on a PREEMPT_RT system. On a 200
> MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
> overhead on the TTY read call.
> 
> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

Note, I took out the WARN_ON() in this patch, as what is that really
going to help here?  It also will conflict with a patch from Jiri I'll
ba applying after this one, so if you think it's needed, care to send a
follow-on patch based on linux-next in a few days?

thanks,

greg k-h
