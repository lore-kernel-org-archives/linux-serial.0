From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] serial: mps2-uart: Add parentheses around conditional in mps2_uart_shutdown
Date: Thu, 31 Jan 2019 10:21:05 -0800
Message-ID: <CAKwvOdkHyfUOSNYD22adGtBfPeHA=HMGk5oM5R-9QP2u6uK1Rw@mail.gmail.com>
References: <20190131180627.19944-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131180627.19944-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jiri Slaby <jslaby@suse.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-serial@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 31, 2019 at 10:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
> applied to the left hand side of this bitwise operator
> [-Wlogical-not-parentheses]
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^                ~
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
> '!' to evaluate the bitwise operator first
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>              (                                       )
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
> hand side expression to silence this warning
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>             (               )
> 1 warning generated.
>
> As it was intended for this check to be the inverse of the one at the
> bottom of mps2_init_port, add parentheses around the whole conditional.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/tty/serial/mps2-uart.c
That function currently has the code:

if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
  mps_port->port.irq = platform_get_irq(pdev, 0);
} else {
  mps_port->rx_irq = platform_get_irq(pdev, 0);
  mps_port->tx_irq = platform_get_irq(pdev, 1);
  mps_port->port.irq = platform_get_irq(pdev, 2);
}

while shutdown has:

if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
  free_irq(mps_port->rx_irq, mps_port);
  free_irq(mps_port->tx_irq, mps_port);
}

free_irq(port->irq, mps_port);

So port->irq is always assigned an irq, and rx_irq & tx_irq are
assigned only if !(mps_port->flags & UART_PORT_COMBINED_IRQ).

Yep, patch looks good. Thanks for fixing a real bug here, Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/344


>
> Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/serial/mps2-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 4404eb7d118f..587b42f754cb 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
>
>         mps2_uart_write8(port, control, UARTn_CTRL);
>
> -       if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
> +       if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
>                 free_irq(mps_port->rx_irq, mps_port);
>                 free_irq(mps_port->tx_irq, mps_port);
>         }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
