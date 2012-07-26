From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No big TTY/serial patch merge for 3.6-rc1
Date: Thu, 26 Jul 2012 22:23:13 +0100
Message-ID: <20120726222313.5993a550@pyramind.ukuu.org.uk>
References: <20120726190814.GA2194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49464 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2GZVTn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2012 17:19:43 -0400
In-Reply-To: <20120726190814.GA2194@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, 26 Jul 2012 12:08:14 -0700
Greg KH <gregkh@linuxfoundation.org> wrote:

>       tty: Move the handling of the tty release logic

Can we lose that one specifically. I've chased down Ian Abbotts problem
and replicated it and that is the offending patch not the lock localise
(which still needs to be kept out as it depends upon this one)

I have it fixed but it's not had enough testing for -rc1 and moving the
termios data has enough spectacular hits all drivers fallout for 3.6

Alan
