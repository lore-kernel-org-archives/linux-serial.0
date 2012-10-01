From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PATCH] TTY patches for 3.7-rc1
Date: Mon, 1 Oct 2012 15:13:50 -0700
Message-ID: <20121001221350.GA10172@kroah.com>
References: <20121001183046.GA13042@kroah.com>
 <506A0FCA.2020908@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46262 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055Ab2JAWNw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Oct 2012 18:13:52 -0400
Content-Disposition: inline
In-Reply-To: <506A0FCA.2020908@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stanislav Kozina <skozina@redhat.com>

On Mon, Oct 01, 2012 at 11:48:58PM +0200, Jiri Slaby wrote:
> On 10/01/2012 08:30 PM, Greg KH wrote:
> > Stanislav Kozina (2):
> >       tty: Fix possible race in n_tty_read()
> 
> The (pretty hopeless) commit log says:
>     Fix possible panic caused by unlocked access to tty->read_cnt in
>     while-loop condition in n_tty_read().
> 
> Just curious, what kind of panic that can cause, can you be more
> concrete on that? I suppose two readers, one eats everything, the other
> is a killer? And should we backport to -stable?

Stanislav, you are the one who could reproduce this, any answers here?

thanks,

greg k-h
