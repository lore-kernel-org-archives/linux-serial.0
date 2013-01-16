From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Are calls to open()/close() serialized by tty layer?
Date: Wed, 16 Jan 2013 22:44:00 +0000
Message-ID: <20130116224400.67169491@pyramind.ukuu.org.uk>
References: <kd71al$c78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54435 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840Ab3APWhJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 17:37:09 -0500
In-Reply-To: <kd71al$c78$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, 16 Jan 2013 20:07:49 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> Are calls to a tty driver's open()/close() methods serialized by the
> tty layer?  If so, has this always been the case?

They are not fully serialized - never have been. A lot of the drivers were
always racy, some that have not been fully converted to the port helpers
still are.

> >From looking at example tty drivers in the 3.7.2 source tree, it
> appears that they assume calls to open()/close() are serialized.
> 
> The old driver I'm working on had its own internal locking to protect
> race conditiions when incrementing and decrementing of a port's open
> count.  That counter is being prelaced by tty->port->count, and in
> existing in-kernel tty drivers it doesn't look like there is any
> locking when that count is incremented during an open().

Use the tty_port helpers. They will also handle all the other detail you
need. The helpers themselves provide serialized activate/shutdown
callbacks on the port which are serialized against each other and hangups.

The port helpers will also ensure your refcounting is right, you don't
have open/close/hangup races and that you get the required POSIX
semantics.

The port helpers are designed so you can propogate your own error codes
either by wrapping them or by returning your own error code from
port->activate() which will be duly propogated to user space.

Alan
