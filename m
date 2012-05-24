From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Thu, 24 May 2012 17:00:25 +0100
Message-ID: <20120524170025.6ca0407f@pyramind.ukuu.org.uk>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
	<4FBB8742.7050504@fastmail.fm>
	<20120522151033.33ef577a@pyramind.ukuu.org.uk>
	<1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
	<20120522172700.02d7915d@pyramind.ukuu.org.uk>
	<1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com>
	<1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com>
	<20120524142219.6606e57a@pyramind.ukuu.org.uk>
	<1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58983 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328Ab2EXP52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 May 2012 11:57:28 -0400
In-Reply-To: <1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, 24 May 2012 08:05:12 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> The link I gave is original source, which I afterwards changed accord=
ing to my parameters - clock and processor memory map.
>=20
> You right about offset 0x8, this is=A0offset between ports in my 68 m=
ode, I corrected, but it doesn't give any result.

You may have to stick some traces into drivers/tty/8250.c at this point
and see what is going on. It's clearly trying to do the set up right, a=
nd
created the ports but didn't believe the hardware. That usually implies
that a parameter is wrong somewhere.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
