From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Subject: Re: [PATCH] serial: samsung: add support for manual RTS setting
Date: Tue, 17 Sep 2013 20:08:33 +0100
Message-ID: <5238A8B1.9080105@inov.pt>
References: <1378894107-7904-1-git-send-email-jose.goncalves@inov.pt> <35383907.gKXZyKLrYq@amdc1227> <52385327.9020706@inov.pt> <2486439.1yKjlWu5X1@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2486439.1yKjlWu5X1@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

On 17-09-2013 16:21, Tomasz Figa wrote:
> I had the following scenario in mind:
> 1) enable CRTSCTS,
> 2) set RTS status using the IOCTL,
> 3) disable CRTSCTS,
> 4) do something,
> 5) enable CRTSCTS again.
>
> I would expect that the value set in point 2 would be still valid aft=
er
> point 5, while it will be reset.

Maybe I'm missing something but, as I see it, as soon as you enable AFC=
 in the=20
UART controller the RTS pin is no more manually controllable, so after =
point 5 the=20
pin is set automattically by the controller according with the Rx FIFO =
contents.=20
Don't you want to say instead that the value set in 2) will be valid in=
 4)?

>
>> Regarding port capability, if it's decided to validate it in
>> s3c24xx_serial_get_mctrl() and s3c24xx_serial_set_mctrl() it should =
also
>> be validated here. The question is how to validate for the full spec=
trum
>> of SoCs that this driver supports?
> Hmm, since the driver is already broken in this aspect, ignoring this=
 in
> your patch might be fine for now. A follow up patch fixing this would=
 be
> welcome, though. However I don't have any good idea how to implement =
this
> at the moment.
>
> First thing that comes to my mind is using the variant data structure=
s to
> store information about per port capability (different port FIFO size=
s are
> already handled like this), but this would imply splitting some of th=
e
> groups, as S5PC100 supports modem control for different subset of por=
ts
> than S3C64xx, while they both use the same variant data.
>
> Using device tree, this could be passed as an extra property, but som=
e of
> the platforms using samsung serial driver can be booted without devic=
e
> tree, so it wouldn't cover all the cases.

So, as I understand, for now is enough to resubmit the patch with the U=
MCON=20
register setting in s3c24xx_serial_set_termios() preserving the previou=
s manual=20
setting of the RTS pin, correct? I was thinking in something like this:

     umcon =3D rd_regb(port, S3C2410_UMCON);
     if (termios->c_cflag & CRTSCTS) {
         umcon |=3D S3C2410_UMCOM_AFC;
         umcon &=3D ~S3C2412_UMCON_AFC_8; // Disable RTS when RX FIFO c=
ontains 63 bytes
     } else {
         umcon &=3D ~S3C2410_UMCOM_AFC;
     }
     wr_regl(port, S3C2410_UMCON, umcon);

> Best regards,
> Tomasz
>
> P.S. Please remember to add all the relevant people to Cc when sendin=
g
> patches. You can use scripts/get_maintainer.pl to find them.

OK, sorry for that.

Bet regards,
Jos=E9 Gon=E7alves
