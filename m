From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: close() handler of tty driver called for port that's not open?
Date: Wed, 14 Sep 2011 20:33:53 +0100
Message-ID: <20110914203353.08c715af@lxorguk.ukuu.org.uk>
References: <j4qk9f$vro$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54843 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932890Ab1INTe3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Sep 2011 15:34:29 -0400
In-Reply-To: <j4qk9f$vro$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, 14 Sep 2011 16:21:03 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> Why does the tty layer call my tty driver's close() handler on a port
> that's not open?

Because a lot of the tty drivers it makes sense to structure the cleanup
this way.
 
> Why does the tty layer try to close a device that isn't open?

Because it was originally designed that way

> Does the tty consider a device to be open even if the open() handler
> returned an error?

Define "open". The answer depends upon what you mean by "open"

> The problem is that my driver keeps a usage count on the port so it
> can clean up some internal stuff when the last user closes a port.

Use the tty_port helpers and it'll do that for you including the locking,
blocking, POSIX open blocking/waiting semantics, error handling, callbacks
and hangup. Trying to open code this stuff is a world of pain and the
locking rules are now much more your problem as we strip out the remains
of the big kernel lock.

> Does the tty layer guarantee that the number of close() calls will
> match the number of open() calls regardless of whether the open()
> calls succeed or not?
> 
> If so, has that always been the policy, or is calling close() on
> non-open device a new feature?

The tty layer has always worked that way. It's I think unique in that
behaviour in the kernel.

If you use the tty_port_open/hangup/close boilerplate then you can
provide shutdown and activate port methods. The guarantee they provide is
that they will be called in matching pairs, they will be called in the
correct places, they will not be called in parallel with one another and
they will properly handle hangup() events - where you shutdown on the
hangup but the close occurs afterwards.

In an ideal world eventually everything will be using the tty port
helpers and then we can make that the underlying (sane) tty interface and
clean up the rest.

Alan
