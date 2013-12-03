From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH tty-next 0/4] tty: Fix ^C echo
Date: Tue, 3 Dec 2013 00:01:16 +0000
Message-ID: <20131203000116.0d512b59@alan.etchedpixels.co.uk>
References: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52170 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3LCAB0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 19:01:26 -0500
In-Reply-To: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> I cc'd you because of your recent involvement in other
> tty patches/bug fixes and because it's your FIXME comment.
> Feel free to ignore and/or let me know you would prefer not to
> be bothered.

It does seem horribly convoluted and likely to dig bigger long term holes
than the one its filling. The tty layer has suffered far too much from
"dodging one bullet by being clever and then getting shot at twice more"

Bigger question (and one I'm not going to try and untangle at quarter to
midnight). Is there any reason that the buffer locking has to be per tty
not a shared lock in some cases.

My thinking is that we never sit hogging the buffer lock for long periods
(even though someone has now made it a mutex which seems an odd
performance choice) and it is the deepest lock in the subsystem we take

So:

if the tty_buffer contained a mutex and a pointer to that mutex then for
the pty pairs you could set them to point to the same mutex but default
to separate mutexes.

At that point you swap all the locks on the mutex to simply lock through
the pointer, you don't need the nested hack and there are no special case
paths or uglies in the general code. The only special is that pty init
paths set the points to both point at the same mutex and no kittens die.

Alan
