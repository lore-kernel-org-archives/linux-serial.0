From: msavaliy@codeaurora.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
Date: Mon, 21 Jan 2019 20:05:10 +0530
Message-ID: <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
References: <20190119002305.16639-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119002305.16639-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Balakrishna Godavarthi <bgodavar@codeaurora.org>, linux-kernel-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2019-01-19 05:53, Matthias Kaehlcke wrote:
> The geni set/get_mctrl() functions currently do nothing unless
> hardware flow control is enabled. Remove this arbitrary limitation.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for
> flow control")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c
> b/drivers/tty/serial/qcom_geni_serial.c
> index a72d6d9fb9834..38016609c7fa9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -225,7 +225,7 @@ static unsigned int
> qcom_geni_serial_get_mctrl(struct uart_port *uport)
>  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
>  	u32 geni_ios;
> 
> -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> +	if (uart_console(uport)) {
>  		mctrl |= TIOCM_CTS;
>  	} else {
>  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct
> uart_port *uport,
>  {
>  	u32 uart_manual_rfr = 0;
> 
> -	if (uart_console(uport) || !uart_cts_enabled(uport))
> +	if (uart_console(uport))
>  		return;
> 
>  	if (!(mctrl & TIOCM_RTS))

Though late but wanted to check on why flow control is disabled in a BT 
case ?
If i understand, CRTSCTS at serial core is what makes flow as enabled 
with UPSTAT_CTS_ENABLE set and that in turn returned by 
uart_cts_enabled(uport).
So is there any settings or configuration missing to enable flow control 
?
There could be a case to have 2 wire UART without flow control 
enablement, In that case we may need check for uart_cts_enabled() right 
?
Please add/correct if i missed something.
