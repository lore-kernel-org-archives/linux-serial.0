From: =?UTF-8?Q?lo=C3=AFc_tourlonias?= <loic.tourlonias@gmail.com>
Subject: Re: serial: start_tx & buffer handling
Date: Fri, 4 May 2018 14:13:22 +0200
Message-ID: <CA+XxOSG8UozW9uzmdrtmAOEYsgwxPVEUB8B=3HNnsrnZMuGF2w@mail.gmail.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
 <20180503183408.GA12152@kroah.com>
 <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7114374476200842349=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

--===============7114374476200842349==
Content-Type: multipart/alternative; boundary="00000000000014c4d0056b603f0d"

--00000000000014c4d0056b603f0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 4, 2018 at 6:31 AM, Muni Sekhar <munisekharrms@gmail.com> wrote=
:

> On Fri, May 4, 2018 at 12:04 AM, Greg KH <greg@kroah.com> wrote:
> > On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
> >> Hi All,
> >>
> >> I=E2=80=99m trying to understand how user mode buffer is written to lo=
w level
> >> serial hardware registers.
> >>
> >> For this I read the kernel code and I came to know that from user mode
> >> write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty_=
io.c")
> >> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
> >>
> >> In uart_write(), the buffer is copied to circ_buf and then it calls
> >> low level serial hardware driver=E2=80=99s start_tx() (struct uart_ops
> >> .start_tx). But here I could not find how the buffer kept in circ_buf
> >> is copied to serial port=E2=80=99s TX_FIFO registers?
> >>
> >> Can someone take a moment to explain me on this?
> >
> > It all depends on which specific UART driver you are looking at, they
> > all do it a bit different depending on the hardware.
> >
> > Which one are you looking at?  Look at what the start_tx callback does
> > for that specific driver, that should give you a hint as to how data
> > starts flowing.  Usually an interrupt is enabled that is used to flush
> > the buffer out to the hardware.
> >
>
> I=E2=80=99m looking for any existing sample code which does DMA transfers=
 of
> UART transmitted data. I looked at the bcm63xx_uart.c, it looks it
> does not handle DMA transfers. Even copying the Tx buffer (from
> circ_buf) to UART_FIFO_REG happening in ISR.
>

You can have a look at atmel_serial kernel module (built for ARM).
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/atmel_ser=
ial.c

The dma buffer is linked to uart circular buffer in prepare_tx() function
called from uart_startup(). It's released in release_tx() function called
from uart_shutdown(). DMA buffer is managed in schedule_tx() function
called from a tasklet triggered by the ISR.

HTH

>
>
> > thanks,
> >
> > greg k-h
>
>
>
> --
> Thanks,
> Sekhar
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>

--00000000000014c4d0056b603f0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Fri, May 4, 2018 at 6:31 AM, Muni Sekhar <span dir=3D"ltr">&l=
t;<a href=3D"mailto:munisekharrms@gmail.com" target=3D"_blank">munisekharrm=
s@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><span class=3D"gmail-">On Fri, May 4, 2018 at 12:04 AM, Greg KH=
 &lt;<a href=3D"mailto:greg@kroah.com">greg@kroah.com</a>&gt; wrote:<br>
&gt; On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:<br>
&gt;&gt; Hi All,<br>
&gt;&gt;<br>
&gt;&gt; I=E2=80=99m trying to understand how user mode buffer is written t=
o low level<br>
&gt;&gt; serial hardware registers.<br>
&gt;&gt;<br>
&gt;&gt; For this I read the kernel code and I came to know that from user =
mode<br>
&gt;&gt; write() API lands into kernel=E2=80=99s tty_write() (&quot;drivers=
/tty/tty_io.c&quot;)<br>
&gt;&gt; and then it calls a uart_write() (&quot;drivers/tty/serial/serial_=
<wbr>core.c&quot;).<br>
&gt;&gt;<br>
&gt;&gt; In uart_write(), the buffer is copied to circ_buf and then it call=
s<br>
&gt;&gt; low level serial hardware driver=E2=80=99s start_tx() (struct uart=
_ops<br>
&gt;&gt; .start_tx). But here I could not find how the buffer kept in circ_=
buf<br>
&gt;&gt; is copied to serial port=E2=80=99s TX_FIFO registers?<br>
&gt;&gt;<br>
&gt;&gt; Can someone take a moment to explain me on this?<br>
&gt;<br>
&gt; It all depends on which specific UART driver you are looking at, they<=
br>
&gt; all do it a bit different depending on the hardware.<br>
&gt;<br>
&gt; Which one are you looking at?=C2=A0 Look at what the start_tx callback=
 does<br>
&gt; for that specific driver, that should give you a hint as to how data<b=
r>
&gt; starts flowing.=C2=A0 Usually an interrupt is enabled that is used to =
flush<br>
&gt; the buffer out to the hardware.<br>
&gt;<br>
<br>
</span>I=E2=80=99m looking for any existing sample code which does DMA tran=
sfers of<br>
UART transmitted data. I looked at the bcm63xx_uart.c, it looks it<br>
does not handle DMA transfers. Even copying the Tx buffer (from<br>
circ_buf) to UART_FIFO_REG happening in ISR.<br></blockquote><div><br></div=
><div>You can have a look at atmel_serial kernel module (built for ARM).<br=
><a href=3D"https://elixir.bootlin.com/linux/latest/source/drivers/tty/seri=
al/atmel_serial.c">https://elixir.bootlin.com/linux/latest/source/drivers/t=
ty/serial/atmel_serial.c</a><br>=C2=A0<br></div><div>The dma buffer is link=
ed to uart circular buffer in prepare_tx() function called from uart_startu=
p(). It&#39;s released in release_tx() function called from uart_shutdown()=
. DMA buffer is managed in schedule_tx() function called from a tasklet tri=
ggered by the ISR.<br><br></div><div>HTH<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
<br>
&gt; thanks,<br>
&gt;<br>
&gt; greg k-h<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
-- <br>
Thanks,<br>
Sekhar<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
______________________________<wbr>_________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.<wbr>org</a><br>
<a href=3D"https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" =
rel=3D"noreferrer" target=3D"_blank">https://lists.kernelnewbies.<wbr>org/m=
ailman/listinfo/<wbr>kernelnewbies</a><br>
</div></div></blockquote></div><br></div></div></div>

--00000000000014c4d0056b603f0d--


--===============7114374476200842349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============7114374476200842349==--
