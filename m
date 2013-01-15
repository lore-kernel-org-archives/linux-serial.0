From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RS485 serial communication on ColdFire
Date: Mon, 14 Jan 2013 18:30:29 -0800
Message-ID: <20130115023029.GA6049@kroah.com>
References: <CAODWn4qouGj+JGZzGrJD6b1Larc7v0rWE5t=_p5xW7SnVm3ErA@mail.gmail.com>
 <20130114033314.GB21784@kroah.com>
 <CAODWn4q=O6DrjxEpPU-eRrWRLRzFPzAe5XMJL1Oayeok79kyEA@mail.gmail.com>
 <20130114142815.GA20384@kroah.com>
 <CAODWn4ocfK7oxSNi-VNemuTGM1izZeCOPXD9rzN5aOMksZcrtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35180 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757088Ab3AOCab (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 21:30:31 -0500
Content-Disposition: inline
In-Reply-To: <CAODWn4ocfK7oxSNi-VNemuTGM1izZeCOPXD9rzN5aOMksZcrtA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Nguyen <afelion@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Jan 15, 2013 at 12:09:28PM +1000, Kevin Nguyen wrote:
> On Tue, Jan 15, 2013 at 12:28 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > Can you also remove the debugging printk() messages you added?  Or,
> > convert them to dev_dbg() calls instead?  If you run your patch through
> > the scripts/checkpatch.pl tool, it should tell you things like this.
> 
> Those issues are fixed in the patch attached.

Nice, I'll queue this up later this week unless someone objects.

thanks,

greg k-h
