From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
Date: Mon, 21 Jan 2019 09:47:19 +0100
Message-ID: <20190121084719.GF3691@localhost>
References: <20190119002305.16639-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190119002305.16639-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Balakrishna Godavarthi <bgodavar@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 18, 2019 at 04:23:05PM -0800, Matthias Kaehlcke wrote:
> The geni set/get_mctrl() functions currently do nothing unless
> hardware flow control is enabled. Remove this arbitrary limitation.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Good to hear this was all that was needed. There don't happen to be any
publicly available documentation of these registers?

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index a72d6d9fb9834..38016609c7fa9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -225,7 +225,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
>  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
>  	u32 geni_ios;
>  
> -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> +	if (uart_console(uport)) {
>  		mctrl |= TIOCM_CTS;
>  	} else {
>  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>  {
>  	u32 uart_manual_rfr = 0;
>  
> -	if (uart_console(uport) || !uart_cts_enabled(uport))
> +	if (uart_console(uport))
>  		return;
>  
>  	if (!(mctrl & TIOCM_RTS))

Ignoring mctrl when the port is a console looks broken too by the way.
The driver parses and handles the flow control parameter, but these
conditionals later overrides it.

Could be fixed in the same patch or in a follow-up patch.

Either way, you can add my 

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
