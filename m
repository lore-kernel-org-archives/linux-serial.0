From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Fw: struct tty_flip_buffer replacement in newer kernels
Date: Mon, 28 May 2012 05:52:55 -0700 (PDT)
Message-ID: <1338209575.52083.YahooMailNeo@web44915.mail.sp1.yahoo.com>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk> <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com> <20120522172700.02d7915d@pyramind.ukuu.org.uk> <1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com> <1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com> <20120524142219.6606e57a@pyramind.ukuu.org.uk> <1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com> <20120524170025.6ca0407f@pyramind.ukuu.org.uk> <1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm19-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.216]:21144 "HELO
	nm19-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753901Ab2E1Mwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 May 2012 08:52:55 -0400
In-Reply-To: <1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: =?utf-8?B?0K7RgNC40Lkg0JfQstC10YDQtdCy?= <yury.zverev@gmail.com>

Hi,

My st16c554 chip is connected with cpu (at91rm9200) in 68 (Motorola) mo=
de, and formally works as 68c554.
Is 8250 driver supports the 68 mode?
I thought the driver maintains whole 16c554 IC, or it means only mode 1=
6 is supported?

Thanks.

Best regards,
Dmitriy Alekseev

________________________________

=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitriy Alekseev <alexeev6@yahoo.com>=20
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>=20
Sent: Thursday, May 24, 2012 8:00 PM
Subject: Re: struct tty_flip_buffer replacement in newer kernels

On Thu, 24 May 2012 08:05:12 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> The link I gave is original source, which I afterwards changed accord=
ing to my parameters - clock and processor memory map.
>=20
> You right about offset 0x8, this is=C2=A0offset between ports in my 6=
8 mode, I corrected, but it doesn't give any result.

You may have to stick some traces into drivers/tty/8250.c at this point
and see what is going on. It's clearly trying to do the set up right, a=
nd
created the ports but didn't believe the hardware. That usually implies
that a parameter is wrong somewhere.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo
info at=C2=A0 http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
