From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Mon, 28 May 2012 23:46:36 -0700 (PDT)
Message-ID: <1338273996.59244.YahooMailNeo@web44910.mail.sp1.yahoo.com>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk> <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com> <20120522172700.02d7915d@pyramind.ukuu.org.uk> <1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com> <1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com> <20120524142219.6606e57a@pyramind.ukuu.org.uk> <1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com> <20120524170025.6ca0407f@pyramind.ukuu.org.uk> <1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com> <20120528181251.7d5e6d9b@pyramind.ukuu.org.uk>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm14-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.246]:33216 "HELO
	nm14-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750951Ab2E2Gqh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 02:46:37 -0400
In-Reply-To: <20120528181251.7d5e6d9b@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?utf-8?B?0K7RgNC40Lkg0JfQstC10YDQtdCy?= <yury.zverev@gmail.com>

Sorry, that means, most probably I don't understand something. The IC S=
T16C554D combines the package interface modes of the 16C554 and 68C554 =
series on a single integrated chip. Earlier, I assumed, 8250.c is suppo=
rting both modes of the circuit.=C2=A0
Unfortunately I didn't understand the code of 8250.c enough to realise =
is 68 mode supported or not.

Best regards,
Dmitriy Alekseev


----- Original Message -----
=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>; =D0=AE=
=D1=80=D0=B8=D0=B9 =D0=97=D0=B2=D0=B5=D1=80=D0=B5=D0=B2 <yury.zverev@gm=
ail.com>
Sent: Monday, May 28, 2012 9:12 PM
Subject: Re: struct tty_flip_buffer replacement in newer kernels

On Mon, 28 May 2012 05:40:15 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> Hi,
>=20
> My st16c554 chip is connected with cpu (at91rm9200) in 68 (Motorola) =
mode, and formally works as 68c554.
> Is 8250 driver supports the 68 mode?
> I thought the driver maintains whole 16c554 IC, or it means only mode=
 16 is supported?

Not sure I understand the question

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
