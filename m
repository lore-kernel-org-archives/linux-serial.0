From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 00/24] lockless n_tty receive path
Date: Tue, 23 Jul 2013 16:44:52 -0700
Message-ID: <20130723234452.GB27433@kroah.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
 <20130617200138.GA8199@kroah.com>
 <51BF724A.505@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42655 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933968Ab3GWXox (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jul 2013 19:44:53 -0400
Content-Disposition: inline
In-Reply-To: <51BF724A.505@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Jun 17, 2013 at 04:32:10PM -0400, Peter Hurley wrote:
> On 06/17/2013 04:01 PM, Greg Kroah-Hartman wrote:
> >On Sat, Jun 15, 2013 at 09:14:12AM -0400, Peter Hurley wrote:
> >>Greg,
> >>
> >>As before, this patchset is dependent on the 'ldsem patchset'.
> >>The reason is that this series abandons tty->receive_room as
> >>a flow control mechanism (because that requires locking),
> >>and the TIOCSETD ioctl _without ldsem_ uses tty->receive_room
> >>to shutoff i/o.
> >>
> >>It is also dependent on 'n_tty fixes' which I recently resent
> >>to you.
> >
> >Thanks for rebasing all of this, and resending it.  It's late in the
> >3.11 development cycle, so I'm going to wait unto 3.11-rc1 is out to
> >queue it up for 3.12, to get it lots of testing in linux-next.
> 
> Thanks Greg. I actually meant to suggest these be held until after
> the merge window but I got distracted by the VT1 deallocation bug
> report.

Now applied, thanks.

greg k-h
