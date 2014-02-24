From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: locking changes in tty broke low latency feature
Date: Mon, 24 Feb 2014 15:44:59 +0000 (UTC)
Message-ID: <lefpdr$br$1@ger.gmane.org>
References: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net>
 <53056E99.9070900@hurleysoftware.com> <53064672.3000807@hurleysoftware.com>
 <alpine.DEB.2.02.1402232330190.21251@ionos.tec.linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58274 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbaBXPpZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Feb 2014 10:45:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WHxid-0004j6-T7
	for linux-serial@vger.kernel.org; Mon, 24 Feb 2014 16:45:23 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2014 16:45:23 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2014 16:45:23 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org

On 2014-02-23, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 20 Feb 2014, Peter Hurley wrote:

>> Using Alan's idea to mock up a latency test, I threw together a test
>> jig using two computers running 3.14-rc1 and my fwserial driver
>> (modified to not aggregrate writes) in raw mode where the target does
>> this:
>
> This is a complete pointless test.

No, it isn't.  It tested exactly what it was supposed to test: latency
between the driver pushing bytes to the line discipline and user-space
read waking up.

> Use a bog standard 8250 UART on the PC and connect a microcontroller
> on the other end which serves you an continous stream of data at
> 115200 Baud.
>
> There is no way you can keep up with that without the low latency
> option neither on old and nor on new machines if you have enough
> other stuff going on in the system.

That makes no sense.  Enabling the low-latency option historically
made it _harder_ to keep up since it caused more overhead in the form
buffer processing and context switches.

-- 
Grant Edwards               grant.b.edwards        Yow! Look into my eyes and
                                  at               try to forget that you have
                              gmail.com            a Macy's charge card!

