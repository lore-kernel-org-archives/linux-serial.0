From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/4] TTY: serial, fix locking imbalance
Date: Thu, 22 Sep 2011 11:38:43 -0700
Message-ID: <20110922183843.GA7652@suse.de>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
 <4E7B7EAA.50706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab1IVSjQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Sep 2011 14:39:16 -0400
Content-Disposition: inline
In-Reply-To: <4E7B7EAA.50706@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 22, 2011 at 08:30:02PM +0200, Jiri Slaby wrote:
> On 08/31/2011 09:24 PM, Jiri Slaby wrote:
> > Commit "TTY: serial, move locking in uart_close" moved the lock, but
> > omitted to update branches which unlock the lock. Now they try to
> > unlock the lock without holding it.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > ---
> > If possible, please, merge this into the patch mentioned above (it's
> > not upstream yet).
> 
> Hi Greg, should I resend these?

Sorry, no, I still have them and will queue them up to my internal tty
tree later today.  Just been swamped with "real work" since returning
from the openSUSE conference this past weekend.

thanks for your patience,

greg k-h
