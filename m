From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 15:28:24 -0600
Message-ID: <AANLkTi=BzM4xYL2Y-OP+sHhWDXu56c7B+MMDrbEwO0Sr@mail.gmail.com>
References: <4CDAA41F.1060402@visionsystems.de> <20101110160851.GA10708@kroah.com>
 <AANLkTi=_RNAxSK_uVsVeO87w0HbUZWhKSgsbyHPnt-BN@mail.gmail.com> <20101110192853.GA16140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45876 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550Ab0KJV2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 16:28:47 -0500
Received: by fxm16 with SMTP id 16so797972fxm.19
        for <linux-serial@vger.kernel.org>; Wed, 10 Nov 2010 13:28:46 -0800 (PST)
In-Reply-To: <20101110192853.GA16140@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, linux-serial@vger.kernel.org

On Wed, Nov 10, 2010 at 1:28 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 10, 2010 at 01:10:51PM -0600, Matt Schulte wrote:
>> On Wed, Nov 10, 2010 at 10:08 AM, Greg KH <greg@kroah.com> wrote:
>> > On Wed, Nov 10, 2010 at 02:54:39PM +0100, Yegor Yefremov wrote:
>> >> This will make sure that multiple serial port cards can be
>> >> used out of the box. Otherwise the user must pass
>> >> nr_uarts parameter, that will be often forgotten and increases
>> >> support requests for serial card vendors.
>> >
>> > Has this really happened in the past? ?What is the downside of cha=
nging
>> > this option that has been around for many years now? ?Also note th=
at
>> > multi-port serial cards are more rare these days than they used to=
 be so
>> > changing this seems a bit pointless now.
>> >
>>
>> Multiport serial cards are not dead, we still sell bunches. =A0This =
is
>> one of those problems that really frustrates our customers. =A0They =
want
>> their ports to show up by default and the only way to do it is to
>> recompile the kernel or modify the boot line. =A0A lot of my custome=
rs
>> don't like the 82510.nr_uarts work around in grub and so we have to
>> hold their hands while they figure out how to recompile the kernel
>> with support for more ports. =A0I think the default number of ports
>> should definitely be changed from 4 to at least 8, maybe even 16 or
>> 32.
>
> Why not work with the distros to get it changed? =A0If we change the
> default within the kernel, it's still not going to change what they a=
re
> using at all, so you will still be having the same problem you are
> today.

Don't you think changing it here would eventually propagate down the
chain to all of the distros?  Or do you think they would ignore the
change up here?

Matt Schulte
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
