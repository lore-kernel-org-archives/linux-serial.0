From: Manuel Stahl <manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org>
Subject: Re: about sc16is7x2 drivier
Date: Tue, 14 Dec 2010 11:12:12 +0100
Message-ID: <4D0742FC.30403@iis.fraunhofer.de>
References: <4D05B269.1C890F.09519@m12-11.163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080106000807020604030208"
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D05B269.1C890F.09519-Qw2Xm1po45t0mzObsfW3tA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: changgx <changgx-9Onoh4P/yGk@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106000807020604030208
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hello Kathy,

this problem has been reported several times now. I'm still not sure
where the error is located. Please CC your mail related to sc16is7x2
also to the serial and spi kernel mailing lists.

Regards,
Manuel Stahl

On 13.12.2010 06:43, changgx wrote:
>     hello=A3=ACmanuel.stahl=A3=BA
>=20
>     excuse me!!
>=20
>     I found the sc16is7x2.c driver provided by you on the internet the
>     other day. And I explante it to my board.
>=20
>     My develop environment is about =A3=BACPU for AT91SAM9260 and kenne=
l for
>     linux-2.6.27.
>=20
>     But I found some questions in debugging.
>=20
>     In the function of sc16is7x2_startup( ), i add the sentence to read
>     register value after sc16is7x2_spi_async(ts->spi, cmds, 8) sentence
>     and i find that the return value is always 0xff.
>=20
>     for example:
>=20
>     int uier1,uier2;
>=20
>     uier1 =3D sc16is7x2_read(ts->spi, UART_IER,ch);
>     SC16_PRINTK("+++++++++++++++++++++> %s =A3=BA%d UART_IER =3D %x
>     \n",__func__,__LINE__,uier1);
>     uier2 =3D sc16is7x2_read(ts->spi, UART_IER,ch);
>     SC16_PRINTK("+++++++++++++++++++++> %s =A3=BA%d UART_IER =3D %x
>     \n",__func__,__LINE__,uier2);
>=20
>     the print result:
>=20
>     +++++++++++++++++++++> sc16is7x2_startup : 512 UART_IER =3D ff
>     +++++++++++++++++++++> sc16is7x2_startup : 515 UART_IER =3D 0
>=20
>     The results is that the first time is 0xff, the secend is 0.
>=20
>     And it is same to read other register.
>=20
>     please give me some advice for this question.
>=20
>     ps: thank you very much for your open souce and look forward to you=
r
>     email.
>=20
>     thanks=A3=A1
>=20
>     kathy chang
>=20
>     2010-12-13
>=20
>     ------------------------------------------------
>=20
>     Email=A3=BAchanggx-9Onoh4P/yGk@public.gmane.org <mailto:changgx-9Onoh4P/yGk@public.gmane.org>
>=20
>     ------------------------------------------------
>=20
>=20
>=20
> =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D
> =A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D6=C2
> =C0=F1=A3=A1
> changgx
> changgx-9Onoh4P/yGk@public.gmane.org <mailto:changgx-9Onoh4P/yGk@public.gmane.org>
> 2010-12-13
> =A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=
=A1=A1=A1=A1


--=20
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=A8=B9rnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--------------080106000807020604030208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
--------------080106000807020604030208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------080106000807020604030208--
