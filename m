From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: close() handler of tty driver called for port that's not open?
Date: Wed, 14 Sep 2011 20:13:34 +0000 (UTC)
Message-ID: <j4r1td$67s$1@dough.gmane.org>
References: <j4qk9f$vro$1@dough.gmane.org>
 <20110914203353.08c715af@lxorguk.ukuu.org.uk>
 <j4r0mr$veq$1@dough.gmane.org>
 <20110914210543.6b35de4e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56303 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933151Ab1INUNt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Sep 2011 16:13:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1R3vq7-0003nk-Jq
	for linux-serial@vger.kernel.org; Wed, 14 Sep 2011 22:13:47 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 22:13:47 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 22:13:47 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-09-14, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> In my mind, a port was only open after my open() handler returns
>> success.  I guess that's wrong, and I should increment my use counter
>> unconditionally each time my open() handler is called.
>
> Probably - and remember to allow for hangup.

Thanks.  I was just looking at the way that is handled in the tty_port
helpers.

>> customers are running kernels recent enough to have those helpers. I
>> suppose I could look into writing compatibility versions compatible
>> with the range of kernels I have to support.
>
> It's actually pretty independant of the underlying tty code so may well
> backport quite easily although it does touch on the refcounting stuff a
> bit I guess.
>
>> The problem is how to make a driver written that way work for
>> somebody running a 2.4 kernel (or even a not-very-recent 2.6 kernel).
>> Yes, I have a few customers running 2.4 kernels, and lots of
>> customers running older 2.6 kernels.  I _might_ be able to convince
>> management it's time to drop support for 2.4, but there's no way I
>> can abandon customers using 2.6 kernels.
>
> For 2.4 I think you are on your own, but there are also no 2.4
> kernels without security holes so I tend to think of 2.4 as mostly
> dead.

I think a good argument can be made for that, but I AFAIK my 2.4
customers are running isolated, semi-embedded boxes where security
isn't a concern.  (I know... famous last words.)

> In the 2.6 case the tty_port code depends upon the tty layer
> refcounting, and the tty layer refcounting fixes exploitable races in
> tty hangup.
>
> At a certainly point you may actually be best supporting both setups
> as two driver variants. One for the kernels with old style
> lock_kernel assumptions and the like, one for those where tty_port
> appears and we relax the rest of the rules dramatically.

That's certainly worth considering.  Once done, it looks like it would
reduce future maintenance effort.

-- 
Grant Edwards               grant.b.edwards        Yow! One FISHWICH coming
                                  at               up!!
                              gmail.com            

