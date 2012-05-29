From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 29 May 2012 11:41:27 +0100
Message-ID: <20120529114127.262719d8@pyramind.ukuu.org.uk>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
	<4FBB8742.7050504@fastmail.fm>
	<20120522151033.33ef577a@pyramind.ukuu.org.uk>
	<1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
	<20120522172700.02d7915d@pyramind.ukuu.org.uk>
	<1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com>
	<1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com>
	<20120524142219.6606e57a@pyramind.ukuu.org.uk>
	<1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com>
	<20120524170025.6ca0407f@pyramind.ukuu.org.uk>
	<1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com>
	<20120528181251.7d5e6d9b@pyramind.ukuu.org.uk>
	<1338273996.59244.YahooMailNeo@web44910.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35677 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2E2KiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 06:38:25 -0400
In-Reply-To: <1338273996.59244.YahooMailNeo@web44910.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?utf-8?B?0K7RgNC40Lkg0JfQstC10YDQtdCy?= <yury.zverev@gmail.com>

On Mon, 28 May 2012 23:46:36 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> Sorry, that means, most probably I don't understand something. The IC=
 ST16C554D combines the package interface modes of the 16C554 and 68C55=
4 series on a single integrated chip. Earlier, I assumed, 8250.c is sup=
porting both modes of the circuit.=A0
> Unfortunately I didn't understand the code of 8250.c enough to realis=
e is 68 mode supported or not.


Thats an electrical signal difference not an interface one as I underst=
and
it (beyond the fact it might change the register offsets depending how
the board was wired)

I don't think it matters therefore.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
