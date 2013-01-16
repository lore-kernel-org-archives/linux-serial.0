From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Are calls to open()/close() serialized by tty layer?
Date: Wed, 16 Jan 2013 23:07:18 +0000 (UTC)
Message-ID: <kd7br6$fom$1@ger.gmane.org>
References: <kd71al$c78$1@ger.gmane.org>
 <20130116224400.67169491@pyramind.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37439 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337Ab3APXHc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 18:07:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Tvc5D-0001O9-DO
	for linux-serial@vger.kernel.org; Thu, 17 Jan 2013 00:07:47 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 17 Jan 2013 00:07:47 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 17 Jan 2013 00:07:47 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-16, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Grant Edwards <grant.b.edwards@gmail.com> wrote:
>
>> Are calls to a tty driver's open()/close() methods serialized by the
>> tty layer?  If so, has this always been the case?
>
> They are not fully serialized - never have been. A lot of the drivers
> were always racy, some that have not been fully converted to the port
> helpers still are.

That's what it looked like it to me, but I wasn't sure.

>> [...]
>> The old driver I'm working on had its own internal locking to protect
>> race conditiions when incrementing and decrementing of a port's open
>> count.  That counter is being replaced by tty->port->count, and in
>> existing in-kernel tty drivers it doesn't look like there is any
>> locking when that count is incremented during an open().
>
> Use the tty_port helpers.

That was the plan...

> They will also handle all the other detail you need. The helpers
> themselves provide serialized activate/shutdown callbacks on the port
> which are serialized against each other and hangups.

Ah! None of the examples I looked at so far were using tty_port_open()
and the port activate method, and I had somehow missed noticing their
existence when I was looking through tty_port sources.

> The port helpers will also ensure your refcounting is right, you
> don't have open/close/hangup races and that you get the required
> POSIX semantics.
>
> The port helpers are designed so you can propogate your own error
> codes either by wrapping them or by returning your own error code
> from port->activate() which will be duly propogated to user space.

Cool, thanks!

Which of the tty drivers is the best example to follow when it comes
to use of the tty_port_ helpers?

It looks like the tty_port_ helpers only go back to 2.6.33, so
supporting kernels older than that will require some sort of private,
backported versions of the helpers.  Maybe I can talk management and
tech support into dropping support for kernels older than 2.6.33...

-- 
Grant Edwards               grant.b.edwards        Yow! I threw up on my
                                  at               window!
                              gmail.com            

