From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Fri, 10 Dec 2010 16:10:30 +0100
Message-ID: <4D0242E6.4070604@visionsystems.de>
References: <4CDAA41F.1060402@visionsystems.de> <20101110160851.GA10708@kroah.com> <4CDAD02F.9080109@visionsystems.de> <20101110173303.GA12830@kroah.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:57560 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab0LJPKw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Dec 2010 10:10:52 -0500
In-Reply-To: <20101110173303.GA12830@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, matts@commtech-fastcom.com, u.kleine-koenig@pengutronix.de


>>>> This will make sure that multiple serial port cards can be
>>>> used out of the box. Otherwise the user must pass
>>>> nr_uarts parameter, that will be often forgotten and increases
>>>> support requests for serial card vendors.
>>> Has this really happened in the past?
>> It is still the case. The most requests that we get are "the card
>> doesn't function under Ubuntu...". After examining dmesg one could see
>> that 8250 driver is initialized with 4 UARTS.
>>
>> There are also lots of questions and bugs concerning this subject.
>> Like this one:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/125524. I even
>> found some entries from 2010:
>> http://www.gnulinux.in/forum/4-port-serial-card-installation-fedora-11
> Then get the distro to change the default setting of their kernels.
>
>>> What is the downside of changing
>>> this option that has been around for many years now?  Also note that
>>> multi-port serial cards are more rare these days than they used to be so
>>> changing this seems a bit pointless now.
>> I can say that those cards are still selling. They're not dead.
>>
>> The downside is that those card are not working out of the box and
>> users not experienced in Linux often miss this parameter. Also some
>> Live Linuxes like Ubuntu (perhaps I missed something) don't provide
>> command line parameter, so you have to reload the driver with proper
>> parameter.
>>
>> I understand that it is somehow a responsibility of distribution
>> maintainers to properly configure the kernel, but I hope that if
>> vanilla kernel would increase default value, then they will also
>> follow.
> I doubt it as they would never notice that the value changed at all
> (they run 'make oldconfig').  So please just work with the distros that
> you are having problems with to get the value changed.

I just want to summarize  the effort of increasing the number of run-time UARTs.

openSUSE and Ubuntu both accepted this change without long discussion:
https://bugzilla.novell.com/show_bug.cgi?id=652954
https://bugs.launchpad.net/ubuntu/+bug/675453

ReHat/Fedora rejected the change without really acceptable reason: https://bugzilla.redhat.com/show_bug.cgi?id=657530

By Debian is the question still in discussion: http://lists.debian.org/debian-kernel/2010/11/msg00211.html

Uwe pointed to the discussion about making 8250 UART detection dynamically: http://lists.debian.org/debian-kernel/2010/11/msg00286.html.

Yegor
