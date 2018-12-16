From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 23:11:43 +0100
Message-ID: <b629cc98-8c80-bcc2-e973-94e1795b883e@denx.de>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Paul Burton <paul.burton@mips.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On 12/16/2018 10:52 PM, Ezequiel Garcia wrote:
> On Sun, 16 Dec 2018 at 18:45, Marek Vasut <marex@denx.de> wrote:
> [skips discussion]
>>
>>> Ultimately it's Greg's decision but it sounds like you're asking me to
>>> say it's OK to break the JZ4780 in a stable kernel with a patch that I
>>> think would be risky anyway, and I won't do that.
>>
>> I am saying this revert breaks AM335x, so this is a stalemate. I had a
>> discussion with Ezequiel (on CC) and he seems to have a different
>> smaller patch coming for this problem.
>>
> 
> Can you guys test this? Note that serial8250_do_startup has a comment
> stating clearly that it has the intention of disabling the FIFOs,
> so it seems this is the right thing to do.
> 
> Paul, this removes the garbage on my CI20 (rev.1)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index c39482b96111..fac19cbc51d1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Clear the FIFO buffers and disable them.
>          * (they will be reenabled in set_termios())
>          */
>         serial8250_clear_fifos(up);
> +       serial_out(up, UART_FCR, 0);
> 
>         /*
>          * Clear the interrupt registers.
>          */
>         serial_port_in(port, UART_LSR);
> 
> 

On AM335x pocketbeagle
Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
