From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Setting PL2303 baud rate
Date: Mon, 6 May 2013 20:42:01 +0000 (UTC)
Message-ID: <km94io$nj1$1@ger.gmane.org>
References: <51881247.9050809@alice.it>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55851 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226Ab3EFUmT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 16:42:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UZSEh-0007F5-Ic
	for linux-serial@vger.kernel.org; Mon, 06 May 2013 22:42:15 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 06 May 2013 22:42:15 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 06 May 2013 22:42:15 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-05-06, Fernando Di Nucci <f.dinucci@alice.it> wrote:
> I have a PL2303HX adapter and I need to set up its baud rate to 1228800 
> or 2457600
>
> (openwrt, linux kernel 3.3.8, coreutils 8.16 and ubuntu quantal 
> 3.5.0-28, same coreutils).
>
> I tried stty -F /dev/ttyUSB0 baudrate
>
> Well, when baudrate is 921600 or 3000000 everything is fine, but when I 
> try 1228800 or 2457600 stty complaints:
> stty: invalid argument '2457600'.
>
> I searched stty source and added:
>
> #ifdef B1228800
>    {"1228800", B1228800, 1228800},
> #endif
> #ifdef B2457600
>    {"2457600", B2457600, 2457600},
> #endif
>
> and compiled but no luck. I don't know where else those values need also 
> to be modified.
>
> Can you please point me to the right direction?
>
> Or there is another way to set pl2303 baud rate passing some
> information on the command line of kernel module?
>

I would _guess_ that the PL2303 driver is modern enough that it
supports termios interface that allows application code to specify
arbitrary baud rates -- so you could try that:

http://www.gossamer-threads.com/lists/python/python/1019389?do=post_view_threaded

-- 
Grant Edwards               grant.b.edwards        Yow! Should I get locked
                                  at               in the PRINCICAL'S
                              gmail.com            OFFICE today -- or have
                                                   a VASECTOMY??

