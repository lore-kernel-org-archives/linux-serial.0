From: hhome liu <liuhhome@gmail.com>
Subject: Re: [PATCH v2] serial: sprd: Add polling IO support
Date: Thu, 19 Sep 2019 11:32:19 +0800
Message-ID: <CAHshu7PFHv_i=rvxkgdmPqyego1PsEO2z4qzi4pYnWH=6LovUg@mail.gmail.com>
References: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
 <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-serial@vger.kernel.org

Baolin Wang <baolin.wang@linaro.org> =E4=BA=8E2019=E5=B9=B49=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Thu, 19 Sep 2019 at 11:10, Lanqing Liu <liuhhome@gmail.com> wrote:
> >
> > In order to access the UART without the interrupts, the kernel uses
> > the basic polling methods for IO with the device. With these methods
> > implemented, it is now possible to enable kgdb during early boot over s=
erial.
> >
> > Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> > ---
> > Change from v1:
> >  - Add poll_init() support.
>
> Looks good to me and the KGDB can work well on my board, so feel free
> to add my tags:
> Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Baolin Wang <baolin.wang@linaro.org>
>
ok, thanks
> > ---
> >  drivers/tty/serial/sprd_serial.c | 33 ++++++++++++++++++++++++++++++++=
+
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 73d71a4..d833160 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -911,6 +911,34 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         }
> >  }
> >
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int sprd_poll_init(struct uart_port *port)
> > +{
> > +       if (port->state->pm_state !=3D UART_PM_STATE_ON) {
> > +               sprd_pm(port, UART_PM_STATE_ON, 0);
> > +               port->state->pm_state =3D UART_PM_STATE_ON;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
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
> > +
> >  static const struct uart_ops serial_sprd_ops =3D {
> >         .tx_empty =3D sprd_tx_empty,
> >         .get_mctrl =3D sprd_get_mctrl,
> > @@ -928,6 +956,11 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         .config_port =3D sprd_config_port,
> >         .verify_port =3D sprd_verify_port,
> >         .pm =3D sprd_pm,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +       .poll_init      =3D sprd_poll_init,
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
