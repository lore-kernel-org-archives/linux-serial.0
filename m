From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] RFC: MFD: driver for Atmel Microcontroller on iPaq h3xxx
Date: Mon, 10 Feb 2014 11:53:18 +0000
Message-ID: <20140210115318.GD22773@lee--X1>
References: <1391175275-27347-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdb1LFP45Oy0YJ6DSHriSorvHacH=RRWb4LmZ286LJJX0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60166 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaBJLxZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 06:53:25 -0500
Received: by mail-wi0-f182.google.com with SMTP id f8so2705261wiw.9
        for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 03:53:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdb1LFP45Oy0YJ6DSHriSorvHacH=RRWb4LmZ286LJJX0g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alessandro Gardich <gremlin@gremlin.it>, Dmitry Artamonow <mad_soft@inbox.ru>

> > This adds a driver for the Atmel Microcontroller found on the
> > iPAQ h3xxx series. This device handles some keys, the
> > touchscreen, and the battery monitoring.
>=20
> Any opinions on this driver or should we queue it in MFD as-is?

I have no problem taking this through the MFD tree with Greg's nod.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
