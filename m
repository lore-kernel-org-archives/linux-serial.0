From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_reopen() returning -EIO because port is closing
Date: Fri, 18 Jan 2013 21:52:58 +0000
Message-ID: <20130118215258.263e7c2a@pyramind.ukuu.org.uk>
References: <kdcefu$dbc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57776 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab3ARVqG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 16:46:06 -0500
In-Reply-To: <kdcefu$dbc$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> If not, is it a bug in the tty layer?


Our tty layer has always done this.
 
> Does Posix say than an open() may fail if it's called while another
> process is calling close()?  IOW, is user-space code expected to retry
> an open() call that returns EIO?  [I've never seen user-space code
> that did that...]

Interesting question. I've never liked the fact we do it (its rude to
the userspace) but it's not clear what the correct semantics are of an
open as a port closes, given the close must complete first including any
drains and control changes and the open may well not expect to block or
hang for a long time.

Alan
 
