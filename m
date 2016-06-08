From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial_core: Change UART PM state to OFF on failure
Date: Wed, 8 Jun 2016 09:47:12 -0700
Message-ID: <57584C10.5090300@hurleysoftware.com>
References: <1462527983-32108-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462527983-32108-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Pramod,

On 05/06/2016 02:46 AM, Pramod Gurav wrote:
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
>  	if (!state->xmit.buf) {
>  		/* This is protected by the per port mutex */
>  		page = get_zeroed_page(GFP_KERNEL);
> -		if (!page)
> +		if (!page) {

	if (!uart_console(uport))

Otherwise, you'll be powering off the console.

Just out of curiosity, did you actually hit this error?

Regards,
Peter Hurley

> +			uart_change_pm(state, UART_PM_STATE_OFF);
>  			return -ENOMEM;
> -
> +		}
>  		state->xmit.buf = (unsigned char *) page;
>  		uart_circ_clear(&state->xmit);
>  	}
> 
