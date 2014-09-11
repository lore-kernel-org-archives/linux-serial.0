From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
Date: Wed, 10 Sep 2014 17:03:43 -0700
Message-ID: <20140911000343.GA5328@kroah.com>
References: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59074 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaIKAEc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Sep 2014 20:04:32 -0400
Content-Disposition: inline
In-Reply-To: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 10, 2014 at 05:28:19PM -0400, Peter Hurley wrote:
> This patch changes user-space behavior (for the better) but I'm not sure
> that it's consequence-free. Also, it might not be enough to unwedge the
> terminal if the driver got its own flow control state mangled.
> 
> Thoughts?
> 
> --- >% ---
> Subject: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
> 
> If terminal flow has been stopped, the terminal can be unwedged
> by:
> 	tcflow(fd, TCOOFF);
> 	tcflow(fd, TCOON);
> This works because tcflow(TCOOFF) ensures that ->flow_stopped is set,
> which allows tcflow(TCOON) to override the terminal flow state in
> __start_tty().
> 
> Instead, allow unwedging with only:
>         tcflow(fd, TCOON);
> by disregarding the existing ->flow_stopped state.

I don't see the benifit here, what are you trying to solve?  Sending one
extra tcflow command?

thanks,

greg k-h
