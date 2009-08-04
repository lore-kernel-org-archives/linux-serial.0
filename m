From: Greg KH <greg@kroah.com>
Subject: Re: [Bugme-new] [Bug 13906] New: Huawei E169 GPRS connection
 causes Ooops
Date: Tue, 4 Aug 2009 08:12:21 -0700
Message-ID: <20090804151221.GB20276@kroah.com>
References: <20090804021637.ce7e62ad.akpm@linux-foundation.org>
 <Pine.LNX.4.44L0.0908041024050.2948-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34643 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbZHDPPM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Aug 2009 11:15:12 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908041024050.2948-100000@iolanthe.rowland.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Clemens Eisserer <linuxhippy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

On Tue, Aug 04, 2009 at 10:25:20AM -0400, Alan Stern wrote:
> On Tue, 4 Aug 2009, Andrew Morton wrote:
> 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=13906
> > > 
> > >            Summary: Huawei E169 GPRS connection causes Ooops
> 
> There are a lot of serial fixes in Greg KH's queue.  Try applying:
> 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.31-rc5.patch
> 
> to your 2.6.31-rc5 kernel.  In particular, this one patch:
> 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-tty/tty-usb-shutdown
> 
> might solve your problem.

If it does, I need to know soon, as that isn't queued up for a .31 release.

thanks,

greg k-h
