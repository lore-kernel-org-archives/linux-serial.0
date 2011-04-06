From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 17:06:31 +0000 (UTC)
Message-ID: <ini6in$gno$1@dough.gmane.org>
References: <ini5hh$7s3$1@dough.gmane.org>
 <20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40482 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab1DFRGq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 13:06:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Q7WBp-0000LJ-Np
	for linux-serial@vger.kernel.org; Wed, 06 Apr 2011 19:06:45 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 19:06:45 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 19:06:45 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-04-06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 6 Apr 2011 16:48:49 +0000 (UTC)
> Grant Edwards <grant.b.edwards@gmail.com> wrote:
>
>> I'm working on a driver for a serial board that supports 921600 bps,
>> and it would be awfully nice if there was a way to specify that using
>> the ASYNC_SPD_xxxxx mechanism.  Is there any reason why this wouldn't
>> work?
>
> The ASYNC_SPD_xxxx mechanism is obsolete.

I know -- unfortunately, so are many customer applications.

> Just set the baud rate to 921600, the kernel has supported arbitary
> baud rates for some time.

Yep, but there are customers with existing, fielded, applications that
depend on the ASYNC_SPD_xxxx mechanism to map 38400 to <whatever>
[where <whatever> is determined by the SPD_xxxx flags controlled by
setserial].

In the past, we've provided a customized version of setserial that
supported a SPD_WARP13 flag setting for 921600, but it only worked
with a particular driver.  I'd like to ditch that and in future use
the standard setserial and standard SPD_xxxx flags.  But, there is no
standard way to set flags for 921600.

I could tell them to go the SPD_CUST route to get 921600, but I was
hoping to provide an option that would support 921600 the same way
that 57600, 230400, and 460800 are supported.

-- 
Grant Edwards               grant.b.edwards        Yow! I'm dressing up in
                                  at               an ill-fitting IVY-LEAGUE
                              gmail.com            SUIT!!  Too late...

