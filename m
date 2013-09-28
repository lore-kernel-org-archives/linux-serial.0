From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: tty loop-back device
Date: Sat, 28 Sep 2013 10:15:27 -0700
Message-ID: <20130928171527.GA15805@kroah.com>
References: <l26jrq$48d$1@ger.gmane.org>
 <l26uk7$id2$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52364 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab3I1ROQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Sep 2013 13:14:16 -0400
Content-Disposition: inline
In-Reply-To: <l26uk7$id2$2@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sat, Sep 28, 2013 at 04:03:20PM +0000, Grant Edwards wrote:
> 
> I've suggested extending the Linux pty so that it _does_ support the
> rest of the serial port API.  I even offered to work on it if the
> results would likely be accepted into the kernel tree, but my
> questions/offers have never gotten any response.

I can't ever say that I'll "guarantee" acceptance of a patch into the
tree before I see what it looks like.  But if something like this is
reasonable, and doesn't break existing users, I don't see why it
wouldn't make sense to have merged.

thanks,

greg k-h
