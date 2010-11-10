From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 13:10:51 -0600
Message-ID: <AANLkTi=_RNAxSK_uVsVeO87w0HbUZWhKSgsbyHPnt-BN@mail.gmail.com>
References: <4CDAA41F.1060402@visionsystems.de> <20101110160851.GA10708@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43608 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab0KJTLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 14:11:15 -0500
Received: by gyh4 with SMTP id 4so637902gyh.19
        for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2010 11:11:14 -0800 (PST)
In-Reply-To: <20101110160851.GA10708@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, linux-serial@vger.kernel.org

On Wed, Nov 10, 2010 at 10:08 AM, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 10, 2010 at 02:54:39PM +0100, Yegor Yefremov wrote:
>> This will make sure that multiple serial port cards can be
>> used out of the box. Otherwise the user must pass
>> nr_uarts parameter, that will be often forgotten and increases
>> support requests for serial card vendors.
>
> Has this really happened in the past? =A0What is the downside of chan=
ging
> this option that has been around for many years now? =A0Also note tha=
t
> multi-port serial cards are more rare these days than they used to be=
 so
> changing this seems a bit pointless now.
>

Multiport serial cards are not dead, we still sell bunches.  This is
one of those problems that really frustrates our customers.  They want
their ports to show up by default and the only way to do it is to
recompile the kernel or modify the boot line.  A lot of my customers
don't like the 82510.nr_uarts work around in grub and so we have to
hold their hands while they figure out how to recompile the kernel
with support for more ports.  I think the default number of ports
should definitely be changed from 4 to at least 8, maybe even 16 or
32.

Matt Schulte
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
