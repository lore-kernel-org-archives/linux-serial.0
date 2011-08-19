From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 21:52:27 +0000 (UTC)
Message-ID: <j2mlur$k3g$1@dough.gmane.org>
References: <j2med6$q2r$1@dough.gmane.org>
 <20110819212416.6f626852@lxorguk.ukuu.org.uk>
 <j2mhva$nmv$1@dough.gmane.org>
 <20110819220644.3166083d@lxorguk.ukuu.org.uk>
 <j2mkav$bat$1@dough.gmane.org>
 <20110819223141.6250087c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42093 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab1HSVwm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 17:52:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1QuWzZ-0005c0-Jp
	for linux-serial@vger.kernel.org; Fri, 19 Aug 2011 23:52:41 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 23:52:41 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 23:52:41 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-08-19, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I don't understand why the low_latency flag even exists when setting
>> it apparently breaks most all of the serial drivers.
>
> Mostly history. I'd not realised random users could fiddle with it - they
> shouldn't be able to do that so that wants fixing.
>
> Historically it made sense as with a 100Hz clock some algorithms with
> drivers that delayed stuff a lot got really slow (eg non windowed
> versions of firmware download protocols, kermit, xmodem etc)

I know why it used to be there, and "back in the day" setting it made
a very noticable difference in the latency on the receive data path.
In some situations, setting the low_latency flag could increase by a a
factor of 10 the number of command/reply transactions you could do per
second (particularly at high baud rates and commands/repsonses are
only a couple bytes).

> Nowdays the kernel is a bit more sophisticated and we should possibly
> re-arrange it so that it selects different workqueues or similar -
> low_latency meaning 'use a private hard rt work queue' perhaps.
>
> Or indeed possibly making ttys use threaded IRQs

For most of the drivers I'm maintaining, I've decided I'm going to
have to force low_latency = 0.  There is one driver that has one mode
where the receive data is handled in a non-atomic context, so that one
can still honor the low_latency flag, but the rest will have to force
it to 0.

[Why this only became a problem recently, I don't know.]

-- 
Grant Edwards               grant.b.edwards        Yow! Am I in Milwaukee?
                                  at               
                              gmail.com            

