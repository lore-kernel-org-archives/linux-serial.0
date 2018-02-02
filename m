From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: MAX310X transfers usage in DMA mode
Date: Fri, 02 Feb 2018 11:19:39 +0100
Message-ID: <59519abd-d268-4f7a-ace8-4fd61131bb0d@cesnet.cz>
References: <CABMprFg5N_Qxj6No0P8fkBfY6goB2wh4Q=kawNyOi2XjdkyZ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABMprFg5N_Qxj6No0P8fkBfY6goB2wh4Q=kawNyOi2XjdkyZ7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerlando Falauto <gerlando.falauto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On p=C3=A1tek 2. =C3=BAnora 2018 10:25:09 CET, Gerlando Falauto wrote:
> I saw your patches about max310x and all the improvements you brought in to=

> achieve
> burst transfers.
> My goal would be to push the chip to its limits (i.e. to 2.000.000bps) on a=

> raspberry pi.

Hi Gerlando,
I'm happy that these patches help others as well :).

> I had already noticed the inefficiencies and tried something similar to
> your approach for burst transfers (but sticking to regmap).

I wonder how you did that? I looked at regmap, but it felt as if it wasn't=20=

really possible to persuade regmap to just keep the SCLK line running for=20
batch-reading additional bytes from the same register (and just for=20
registers 0x00).

> In both cases
> (with or without regmap) it looks like the CPU is the bottleneck.
> I was thinking of using DMA and your approach looks just one step away from=

> achieving this.

Regarding DMA, I have no clue how it works on RPi. I know that the SoC I=20
have has something similar, but it's severely limited and the kernel=20
doesn't really support it.

> Did you ever consider this?

Here's what I think should help get you a better performance:

1) Ensure that the userspace actually configures the UART in a mode which=20
enables batched reads (also known as "SPI burst access"). This is a big=20
catch. By default, reading each byte requires two SPI transactions, one for=20=

reading one byte from the RX FIFO, and another one for the Line Status=20
Register. The HW does not support "batch reading" the RX buffer along with=20=

the LSR, unfortunately. This means that by default, each byte received by=20
the UART requires at least four bytes to be transmitted over SPI.

However, if the userspace tells the kernel that it is not interested in=20
checking the BREAK condition, in determining RX parity errors, etc, then=20
the kernel can skip (and does skip, at least in the tty-next tree) the LSR=20=

register. And because it's only reading from the RXFIFO, it can leverage=20
that SPI burst access.

Here's a snippet of my code which does that `termios` configuration:

    m_config.c_iflag =3D IGNPAR;
    m_config.c_oflag =3D 0;
    m_config.c_cflag =3D CLOCAL | CREAD | CS8 | B115200;
    m_config.c_lflag =3D 0;
    m_config.c_cc[VMIN] =3D 0;
    m_config.c_cc[VTIME] =3D 1;

2) Check the SPI frequency. The RPi's documentation suggests that there are=20=

some limitations of the maximal SPI frequency. It's apparently a bit=20
coarse, with a big gap between 16MHz and 32MHz. The chip that I use is=20
spec'ed to allow up to 26MHz, which means 16MHz on your system.

3) We can also improve the RX FIFO utilization. My device has a 128B=20
buffer, and when I added some debugging code to produce a histogram of the=20=

actual watermark level when reading the RX FIFO, I was surprised to see=20
plenty of small transfers. That's because the current driver prefers to=20
read from the RX buffer "ASAP", as soon as there's something in there.

The HW also allows another mode of operation where it only raises an IRQ=20
once either:

- more than X bytes are in the FIFO,
- or any byte in the FIFO has been there for more than Y "periods", where a=20=

"period" is the time it takes the UART to transmit/receive one byte.

Doing that would make a lot of sense in this context. If we always read=20
after, say, 32 bytes are in the buffer (or upon a matching timeout), then=20
it's likely that we will do 32byte SPI transactions much more often. That=20
should reduce the SPI utilization when reading by (asymptotically) 50%.

I plan to (eventually) send a patch doing just that, but ENOTIME for now.

Hope this helps.

With kind regards,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
