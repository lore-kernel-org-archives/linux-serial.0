From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: prepare for 9bit data
Date: Fri, 11 Oct 2013 08:36:40 -0700
Message-ID: <20131011153640.GB14715@kroah.com>
References: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
 <20130926224755.GA15399@kroah.com>
 <5257E804.6020800@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43734 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3JKPgl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Oct 2013 11:36:41 -0400
Content-Disposition: inline
In-Reply-To: <5257E804.6020800@aksignal.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, nicolas.ferre@atmel.com

On Fri, Oct 11, 2013 at 01:59:00PM +0200, Ji=C5=99=C3=AD Prchal wrote:
>=20
>=20
> Dne 27.9.2013 00:47, Greg KH napsal(a):
> >On Mon, Sep 23, 2013 at 02:07:32PM +0200, Jiri Prchal wrote:
> >>This patch adds 9bit data possibility for serial_core. Please confi=
rm that I did it right way at right place. I'll make atmel_serial drive=
r for 9bit data later.
> >
> >Please wrap your lines properly.
> >
> >I'd rather wait to add this type of patch _after_ you have tested it=
 and
> >verified that your driver works, and take that patch at the same tim=
e.
> >
> >Otherwise, this is just added cruft that no one is using, and I'd ha=
ve
> >to remove it :)
> No one is using it because it is NOT implemented.

Then implement it.

> Try to search internet for "9bit serial" to see how many people like =
to use it.

Again, then implement it, I can't add code to the kernel that no one
uses, that would be cruft and be deleted, right?

> But I probably not bother to do it and I'll try some tricks with pari=
ty.
> As many others.

Why not just implement it, then it can stay, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
