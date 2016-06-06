From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] serial_core: Change UART PM state to OFF on failure
Date: Mon, 6 Jun 2016 17:36:03 +0530
Message-ID: <CANYu_0tkUWyNfB4Sysh0vbatvNErQNNeV7ZBNyqbOrdL5vEmWg@mail.gmail.com>
References: <1462527983-32108-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462527983-32108-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 6 May 2016 at 15:16, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> uart_change_pm is used to turn on the UART controller resources and
> change UART's PM status. On failure to allocate pages the controller
> be left in ON state. This will change the state to OFF on failure.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
>  drivers/tty/serial/serial_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 62fe368..58af2e9 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,9 +156,10 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>         if (!state->xmit.buf) {
>                 /* This is protected by the per port mutex */
>                 page = get_zeroed_page(GFP_KERNEL);
> -               if (!page)
> +               if (!page) {
> +                       uart_change_pm(state, UART_PM_STATE_OFF);
>                         return -ENOMEM;
> -
> +               }
>                 state->xmit.buf = (unsigned char *) page;
>                 uart_circ_clear(&state->xmit);
>         }

Greg,
Any comments on this change?

> --
> 1.8.2.1
>
