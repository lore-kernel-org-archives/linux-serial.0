From: =?iso-8859-1?Q?=D8yvind_Grotmol?= <o.grotmol@energymicro.com>
Subject: RE: [Customers.Bosch-Gecko] [PATCH] serial/efm32: parse location	property
Date: Fri, 8 Mar 2013 09:51:57 +0100 (CET)
Message-ID: <e276ad4a.00001634.00000007@OGROTMOL-PC.ensemi.local>
References: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>	<20130304143854.395EF3E206B@localhost>	<CACRpkdZuNOFco+GTe9YOD=qy+dgEaokoqvWaPA2mCxYHs9oxVA@mail.gmail.com> <20130307093829.GG15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zimbra02.securesys.no ([88.87.43.37]:60936 "EHLO
	zimbra02.securesys.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab3CHJAc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Mar 2013 04:00:32 -0500
In-Reply-To: <20130307093829.GG15375@pengutronix.de>
Content-Language: no
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'PTX Customer Mailing List - Bosch AE / Energy Micro' <customers.bosch-gecko@pengutronix.de>, 'Linus Walleij' <linus.walleij@linaro.org>
Cc: kernel@pengutronix.de, linux-doc@vger.kernel.org, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, 'Grant Likely' <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, 'Jiri Slaby' <jslaby@suse.cz>

> -----Original Message-----
> From: customers.bosch-gecko-bounces@pengutronix.de
> [mailto:customers.bosch-gecko-bounces@pengutronix.de] On Behalf Of Uw=
e
> Kleine-K=F6nig
> Sent: 7. mars 2013 10:38
>
> > This is a new oddity: it's like multiplexing is distributed out amo=
ng
> > the peripherals on the EFM32, or atleast for this UART, so there is=
 a
> > register on the peripheral itself selecting where to route it.
> >
> > If all peripherals on the system follows this pattern, like if ther=
e
> > is some such "location" register on each and every peripheral,
> ideally
> I didn't check if all do, but it's a common pattern for the efm32
> peripherals to have such a ROUTE register.

Yes. In general, our analog modules (such as ADC and DAC) have a fixed =
pin
location which cannot be changed. All of our digital modules (UART etc)
have a ROUTE register inside each module. That is the general pattern.

Best regards,
=D8yvind

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
