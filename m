From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty_reopen() returning -EIO because port is closing
Date: Fri, 18 Jan 2013 22:06:54 +0000 (UTC)
Message-ID: <kdch1t$4p0$1@ger.gmane.org>
References: <kdcefu$dbc$1@ger.gmane.org>
 <20130118215258.263e7c2a@pyramind.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55192 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab3ARWHQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 17:07:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TwK5w-0005jW-NI
	for linux-serial@vger.kernel.org; Fri, 18 Jan 2013 23:07:28 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 23:07:28 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 23:07:28 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-18, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>> If not, is it a bug in the tty layer?
>
> Our tty layer has always done this.

We'll call it a feature, then.

I don't remember ever seeing it before.  Either the test is different
(which might be), or the old non-helper tty driver would somehow cause
the open() to block/retry.

It looks like the old open() code checked to see if the port was
closing, waited for the close to finish, and then returned either
EAGAIN or ERESTARTSYS:

  // If we are in the process of closing, wait for it to complete, then return
  if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING) 
    {
       wait_event_interruptible(info->close_wait, !(info->flags & ASYNC_CLOSING));
       return (info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS;
    }

I do think I recall seeing a user-space open() block for some time
under certain circumstances.
    
>> Does Posix say than an open() may fail if it's called while another
>> process is calling close()?  IOW, is user-space code expected to retry
>> an open() call that returns EIO?  [I've never seen user-space code
>> that did that...]
>
> Interesting question. I've never liked the fact we do it (its rude to
> the userspace) but it's not clear what the correct semantics are of
> an open as a port closes, given the close must complete first
> including any drains and control changes and the open may well not
> expect to block or hang for a long time.

If my driver now behaves the same as the "standard" driver where it
didn't used to, I'm going to claim it's an improvement.

-- 
Grant Edwards               grant.b.edwards        Yow! I'm sitting on my
                                  at               SPEED QUEEN ... To me,
                              gmail.com            it's ENJOYABLE ... I'm WARM
                                                   ... I'm VIBRATORY ...

