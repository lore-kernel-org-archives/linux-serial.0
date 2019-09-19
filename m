From: hhome liu <liuhhome@gmail.com>
Subject: Re: [PATCH] serial: sprd: Add polling IO support
Date: Thu, 19 Sep 2019 10:14:31 +0800
Message-ID: <CAHshu7PoJriq6R+rNzqAVrEy=mSWvu6k=83=pkRo0dNhrS1xhw@mail.gmail.com>
References: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
 <CAMz4kuLrAWDaZj2Am452BX+aVO0yCQB_cCiNUx4FAamoX6KWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuLrAWDaZj2Am452BX+aVO0yCQB_cCiNUx4FAamoX6KWtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-serial@vger.kernel.org

Baolin Wang <baolin.wang@linaro.org> =E4=BA=8E2019=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Lanqing,
>
> On Wed, 18 Sep 2019 at 16:16, Lanqing Liu <liuhhome@gmail.com> wrote:
> >
> > In order to access the UART without the interrupts, the kernel uses
> > the basic polling methods for IO with the device. With these methods
> > implemented, it is now possible to enable kgdb during early boot over s=
erial.
> >
> > Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 73d71a4..579ab41 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -911,6 +911,24 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         }
> >  }
> >
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int sprd_poll_get_char(struct uart_port *port)
> > +{
> > +       while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
> > +               cpu_relax();
> > +
> > +       return serial_in(port, SPRD_RXD);
> > +}
> > +
> > +static void sprd_poll_put_char(struct uart_port *port, unsigned char c=
h)
> > +{
> > +       while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
> > +               cpu_relax();
> > +
> > +       serial_out(port, SPRD_TXD, ch);
> > +}
> > +#endif
>
> When I tested your patch, I found only one case can work if the port
> used by KGDB is same with the port selected as console, which means
> this port will be powered on all the time. We had implemented the
> power management for the UART ports, so I think you should enable the
> clock for the port used by KGDB in poll_init(), then other ports can
> be used by KGDB.
>
Yes, agree with you. I will add poll_init()  support.  Thanks for your
comments.
> > +
> >  static const struct uart_ops serial_sprd_ops =3D {
> >         .tx_empty =3D sprd_tx_empty,
> >         .get_mctrl =3D sprd_get_mctrl,
> > @@ -928,6 +946,10 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         .config_port =3D sprd_config_port,
> >         .verify_port =3D sprd_verify_port,
> >         .pm =3D sprd_pm,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +       .poll_get_char  =3D sprd_poll_get_char,
> > +       .poll_put_char  =3D sprd_poll_put_char,
> > +#endif
> >  };
> >
> >  #ifdef CONFIG_SERIAL_SPRD_CONSOLE
> > --
> > 1.9.1
> >
>
>
> --
> Baolin Wang
> Best Regards
