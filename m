From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add hardware handshaking to pseudo-tty and USB serial gadget
Date: Fri, 22 Mar 2013 14:22:39 +0000 (UTC)
Message-ID: <kihpff$3mi$1@ger.gmane.org>
References: <5D7CD300-386D-4AA1-B48A-0051D17C1F1F@beamcommunications.com>
 <kifr4e$kc5$1@ger.gmane.org> <1363904564.4488.47.camel@thor.lan>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59451 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932928Ab3CVOWz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Mar 2013 10:22:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UJ2sG-0005Wq-JY
	for linux-serial@vger.kernel.org; Fri, 22 Mar 2013 15:23:16 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 22 Mar 2013 15:23:16 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 22 Mar 2013 15:23:16 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-03-21, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Thu, 2013-03-21 at 20:38 +0000, Grant Edwards wrote:
>> On 2013-03-21, Craig McQueen <craig.mcqueen@beamcommunications.com> wrote:

>> > It sounds as though people have done pseudo-ttys with HW handshaking
>> > support--eg tty0tty project. However I'd rather implement this
>> > function in the kernel pseudo-terminal driver itself. Is there any
>> > reason not to do that?
>> 
>> No reason other than you and I are the only two people who care about
>> it. :)
>
> Assuming you're leaning toward an in-kernel solution, why not just
> implement a new tty driver that behaves like a local serial port?

I've been thinking about trying to do that except making it a
serial_core driver on the slave side rather than a tty driver.  I just
converted a tty driver to the serial-core API and the code-size
dropped by almost 70% (hopefully the undiscovered bug count dropped as
well).  I hadn't decided what to do for a master-side API.  I'd
probably abandon the standard tty API altogether and do something from
scratch as a plain char device driver with custom ioctl calls.

-- 
Grant Edwards               grant.b.edwards        Yow! A dwarf is passing out
                                  at               somewhere in Detroit!
                              gmail.com            

