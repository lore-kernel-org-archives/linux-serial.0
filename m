From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 07:38:28 -0700 (PDT)
Message-ID: <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm16.bullet.mail.sp2.yahoo.com ([98.139.91.86]:44549 "HELO
	nm16.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757664Ab2EVOi3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 10:38:29 -0400
In-Reply-To: <20120522151033.33ef577a@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

This is driver source I found:
http://www.codeforge.com/read/118181/st16c554_serial.c__html

It was written for quad uart st16c554 for arm chip s3c2410, which I tri=
ed to adapt for at91rm9200 board and newer kernel version.

Best regards,
Dmitriy Alekseev


----- Original Message -----
=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Stone <jwjstone@fastmail.fm>
Cc: gregkh@linuxfoundation.org; alan@linux.intel.com; linux-serial@vger=
=2Ekernel.org
Sent: Tuesday, May 22, 2012 6:10 PM
Subject: Re: struct tty_flip_buffer replacement in newer kernels

> I'm newbie, working under existed serial driver, adapting it for 2.6.=
32.
> During the compilation I have had several problems, which I
> succesfully solved except this one:
> error: 'struct tty_struct' has no member named 'flip'
> In particular, cound you advice correct replacement of "tty->flip.cou=
nt"

Your driver shouldn't be looking in those areas. There isn't a correct
replacement. You will need to update it to use the flip buffers properl=
y
not poke its nose in places it shouldn't have.

Perhaps the best thing would be to post a link to the driver ?

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
