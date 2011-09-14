From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: close() handler of tty driver called for port that's not open?
Date: Wed, 14 Sep 2011 19:52:59 +0000 (UTC)
Message-ID: <j4r0mr$veq$1@dough.gmane.org>
References: <j4qk9f$vro$1@dough.gmane.org>
 <20110914203353.08c715af@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54947 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932918Ab1INTxM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Sep 2011 15:53:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1R3vWB-0002Js-Ml
	for linux-serial@vger.kernel.org; Wed, 14 Sep 2011 21:53:11 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 21:53:11 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 21:53:11 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-09-14, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Grant Edwards <grant.b.edwards@gmail.com> wrote:
>
>> Why does the tty layer call my tty driver's close() handler on a port
>> that's not open?
>
> Because a lot of the tty drivers it makes sense to structure the
> cleanup this way.
>  
>> Why does the tty layer try to close a device that isn't open?
>
> Because it was originally designed that way

Interesting.  I only noticed it recently, but I think that may be
because of other changes made to the kernel.

>> Does the tty consider a device to be open even if the open() handler
>> returned an error?
>
> Define "open". The answer depends upon what you mean by "open"

In my mind, a port was only open after my open() handler returns
success.  I guess that's wrong, and I should increment my use counter
unconditionally each time my open() handler is called.

>> The problem is that my driver keeps a usage count on the port so it
>> can clean up some internal stuff when the last user closes a port.
>
> Use the tty_port helpers and it'll do that for you including the
> locking, blocking, POSIX open blocking/waiting semantics, error
> handling, callbacks and hangup. Trying to open code this stuff is a
> world of pain and the locking rules are now much more your problem as
> we strip out the remains of the big kernel lock.

Thanks for the suggestion.  I've looked at those, but not all my
customers are running kernels recent enough to have those helpers. I
suppose I could look into writing compatibility versions compatible
with the range of kernels I have to support.

>> Does the tty layer guarantee that the number of close() calls will
>> match the number of open() calls regardless of whether the open()
>> calls succeed or not?
>> 
>> If so, has that always been the policy, or is calling close() on
>> non-open device a new feature?
>
> The tty layer has always worked that way. It's I think unique in that
> behaviour in the kernel.

It seems that recent improvements to the kenel's pre-emptibility are
showing up all sorts of decade-old holes in this driver.  :/

> If you use the tty_port_open/hangup/close boilerplate then you can
> provide shutdown and activate port methods. The guarantee they
> provide is that they will be called in matching pairs, they will be
> called in the correct places, they will not be called in parallel
> with one another and they will properly handle hangup() events -
> where you shutdown on the hangup but the close occurs afterwards.

The problem is how to make a driver written that way work for somebody
running a 2.4 kernel (or even a not-very-recent 2.6 kernel).  Yes, I
have a few customers running 2.4 kernels, and lots of customers
running older 2.6 kernels.  I _might_ be able to convince management
it's time to drop support for 2.4, but there's no way I can abandon
customers using 2.6 kernels.

> In an ideal world eventually everything will be using the tty port
> helpers and then we can make that the underlying (sane) tty interface
> and clean up the rest.

-- 
Grant Edwards               grant.b.edwards        Yow! ... I have read the
                                  at               INSTRUCTIONS ...
                              gmail.com            

