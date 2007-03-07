From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 13:54:28 +0100
Message-ID: <57354eff0703070454u24e97309j55ec9de584ced71e@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <m3bqj6jebt.fsf@maximus.localdomain>
	 <200703061824.08834.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:20323 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965196AbXCGMy3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 07:54:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so182404nfa
        for <linux-serial@vger.kernel.org>; Wed, 07 Mar 2007 04:54:28 -0800 (PST)
In-Reply-To: <200703061824.08834.rgetz@blackfin.uclinux.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

> >  it's used for
> >  various purposes such as providing +12V to the device (and two pins
> >  can supply more power than one - sure, it isn't the best idea).
>
> I understand - the request wasn't to change the default operation - just add a
> method of controlling things, so those minority of people who want the
> control can have it.

There are two parts of at least my request.

The first part is, why should serial driver assert RTS when CRTSCTS is
not set and which problem may follow by changing this default behaviour.

The second part is that you are talking about. I don't see for a
moment some regular
way to preconfigure serial interface parameters before opening the
device, at the
same time current behaviour creates potentially dangerous RTS jerking
during device configuring.

May be it would be good idea to develop some tty control driver which
provides a
possibility to change default setting of the drivers?

-Oleksiy
