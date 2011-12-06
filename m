From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/16 v2] pmac_zilog: fix unexpected irq
Date: Tue, 6 Dec 2011 16:27:20 +0100
Message-ID: <CAMuHMdUB-jQQB=ieumYTehdZz1EnoSazEAhsnEunHSnK2o=k8Q@mail.gmail.com>
References: <20111023141108.856998818@telegraphics.com.au>
	<20111023141115.208699274@telegraphics.com.au>
	<alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Finn,

On Tue, Dec 6, 2011 at 16:13, Finn Thain <fthain@telegraphics.com.au> w=
rote:
> +static void pmz_interrupt_control(struct uart_pmac_port *uap, int en=
able)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (enable) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] |=3D=
 INT_ALL_Rx | TxINT_ENAB;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ZS_IS_EXTCLK(=
uap))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uap->curregs[1] |=3D EXT_INT_ENAB;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] &=3D=
 ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);

Should there be a call to zssync() here?
The old code always did that after disabling interrupts.

> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[1]);
> +}
> +
> =C2=A0static struct tty_struct *pmz_receive_chars(struct uart_pmac_po=
rt *uap)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tty_struct *tty =3D NULL;
> @@ -339,9 +351,7 @@ static struct tty_struct *pmz_receive_ch
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> =C2=A0flood:
> - =C2=A0 =C2=A0 =C2=A0 uap->curregs[R1] &=3D ~(EXT_INT_ENAB | TxINT_E=
NAB | RxINT_MASK);
> - =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[R1]);
> - =C2=A0 =C2=A0 =C2=A0 zssync(uap);

Cfr. e.g. here.

> + =C2=A0 =C2=A0 =C2=A0 pmz_interrupt_control(uap, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pmz_error("pmz: rx irq flood !\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> =C2=A0}

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
