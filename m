From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 15/68] TTY: ipwireless, fix tty->index handling
Date: Mon, 5 Mar 2012 15:03:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203051503000.23367@pobox.suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz> <1330955575-26641-16-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52269 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932286Ab2CEOD3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 09:03:29 -0500
In-Reply-To: <1330955575-26641-16-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, David Sterba <dsterba@suse.cz>

On Mon, 5 Mar 2012, Jiri Slaby wrote:

> * do not test if tty->index is in bounds. It is always.
> * tty->index is not a minor! Fix that.
> 
> >From now on, let's assume that the parameter of the function is tty
> index with base being zero. This makes also the code more readable.
> 
> Factually, there is no real change as tty_driver->minor_start is zero,
> so the tests are equivalent. But it did not make sense. And if this
> had changed eventually, it would have caused troubles.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: David Sterba <dsterba@suse.cz>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks Jiri.

-- 
Jiri Kosina
SUSE Labs
