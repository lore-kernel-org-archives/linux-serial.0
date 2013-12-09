From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 tty-next 7/8] n_tty: Extend debug tracing
Date: Sun, 8 Dec 2013 16:54:41 -0800
Message-ID: <20131209005441.GA17588@kroah.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
 <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
 <1386012288-5079-8-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47923 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760645Ab3LIITD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 03:19:03 -0500
Content-Disposition: inline
In-Reply-To: <1386012288-5079-8-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Mon, Dec 02, 2013 at 02:24:47PM -0500, Peter Hurley wrote:
> Add configurable trace support to allow tracing with dev_dbg,
> pr_dbg, or trace_printk. Instrument .receive_buf() and read()
> paths with traces to aid in debugging flow control changes.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/n_tty.c | 79 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 16 deletions(-)

If we are going to do tracing in the tty layer, why not use the
in-kernel tracing functionality instead of having this mis-mash of
different ways to get tracing data out?

I'd much rather prefer that, so I've stopped applying things in this
series at this point, I've applied the 6 previous ones.

thanks,

greg k-h
