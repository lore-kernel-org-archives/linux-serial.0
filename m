From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Found a bug in samsung serial tty code
Date: Sun, 17 Apr 2016 16:14:25 +0800
Message-ID: <CAAsE_ud2ia-b8xk63GiF-Mh1W2cwZPg0fUF6Mtmh1=nNiGcgQQ@mail.gmail.com>
References: <CAAsE_ud1FLGt=ufbYu9ppwKfbNVY4j4=Vb9=DMWGdmbpXrokaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAAsE_ud1FLGt=ufbYu9ppwKfbNVY4j4=Vb9=DMWGdmbpXrokaw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

forgot to mention: this bug will cause the tcdrain() return earlier.

On 17 April 2016 at 15:52, Woody Wu <narkewoody@gmail.com> wrote:
> Hi,
>
> The function s3c24xx_serial_tx_empty() in tty/serial/samsung.c is wrong:
>
> static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
> {
> struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> unsigned long ufstat = rd_regl(port, S3C2410_UFSTAT);
> unsigned long ufcon = rd_regl(port, S3C2410_UFCON);
>
> if (ufcon & S3C2410_UFCON_FIFOMODE) {
> if ((ufstat & info->tx_fifomask) != 0 ||
>    (ufstat & info->tx_fifofull))
> return 0;
>
> return 1;
> }
>
> return s3c24xx_serial_txempty_nofifo(port);
> }
>
> In FIFO mode, checking only ufcon is not enough to determine that the
> tx is really done, since there is still bits in shift register.  I
> found this is true at least in S3C2416 UARTs.  I have to remove the
> 'return 1' above to fix the bug.   Can anyone give me a confirmation?
> Thanks!
>
>
> --
> Life is the only flaw in an otherwise perfect nonexistence
>     -- Schopenhauer
>
> woody
> public key at http://subkeys.pgp.net:11371 (narkewoody@gmail.com)



-- 
Life is the only flaw in an otherwise perfect nonexistence
    -- Schopenhauer

woody
public key at http://subkeys.pgp.net:11371 (narkewoody@gmail.com)
