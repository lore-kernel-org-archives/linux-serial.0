From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 19:38:14 +0000 (UTC)
Message-ID: <iniff6$62e$1@dough.gmane.org>
References: <ini5hh$7s3$1@dough.gmane.org>
 <20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
 <ini718$hfj$1@dough.gmane.org>
 <20110406202347.61c5986e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49901 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663Ab1DFTic (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 15:38:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Q7YYf-0007Yc-S7
	for linux-serial@vger.kernel.org; Wed, 06 Apr 2011 21:38:29 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 21:38:29 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 21:38:29 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-04-06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> This raises a question I've been wondering about for some time.  While
>> the kernel and the serial driver API support arbitrary baud rates,
>> termios doesn't AFAICT.
>> 
>> How does one use the standard POSIX serial port API to obtain an
>> abritrary baud rate?
>
> The POSIX API is completely broken in this respect. So the kernel
> provides its own interface.
>
>> The only way I can find to get arbitrary baud rates from a user
>> perspective is to use the ASYNC_SPD_xxxx mechanism.
>
> Which is also not POSIX

Right.

> Simple example app:
>  
> http://www.kerneltrap.com/mailarchive/linux-usb/2008/10/2/3484644

Brilliant!

I've been looking for that (off and on) for months.  I knew that the
kernel/driver API supported arbitrary baud rates and that termios
didn't.  So I figured there must be an alternative to SPD_CUST, but
hadn't been able to figure out what it was.

I had found the BSD IOSSIOSPEED ioctl, but hadn't stumbled across the
Linux equivalent.

-- 
Grant Edwards               grant.b.edwards        Yow! Look DEEP into the
                                  at               OPENINGS!!  Do you see any
                              gmail.com            ELVES or EDSELS ... or a
                                                   HIGHBALL?? ...

