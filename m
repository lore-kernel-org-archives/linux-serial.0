From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Remove __init from
 msm_console_setup()
Date: Sat, 16 Feb 2019 23:14:55 -0800
Message-ID: <20190217071455.GH2173@tuxbook-pro>
References: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat 16 Feb 21:05 PST 2019, Jeffrey Hugo wrote:

> Due to the complexities of modern Qualcomm SoCs, about a half dozen drivers
> must successfully probe before the clocks for the console are present, and
> the console can successfully probe.  Depending on several random factors
> such as probe order and modules vs builtin, msm_serial may not be able to
> successfully probe for some, at which point, __init annotated functions
> may become unmapped.  If this occurs, msm_console_setup() will be called
> from the probe path, but will no longer exist, resulting in a kernel
> panic.
> 
> Resolve this issue by removing the __init annotation from
> msm_console_setup().

I'm pretty sure I've stumbled upon this several times without knowing
what hit me.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/tty/serial/msm_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 736b74f..1090960 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1634,7 +1634,7 @@ static void msm_console_write(struct console *co, const char *s,
>  	__msm_console_write(port, s, count, msm_port->is_uartdm);
>  }
>  
> -static int __init msm_console_setup(struct console *co, char *options)
> +static int msm_console_setup(struct console *co, char *options)
>  {
>  	struct uart_port *port;
>  	int baud = 115200;
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
