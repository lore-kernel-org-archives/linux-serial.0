From: dwalker@fifo99.com
Subject: Re: [PATCH] tty: serial: msm_serial.c:  Cleaning up uninitialized
 variables
Date: Mon, 2 Jun 2014 23:15:10 +0000
Message-ID: <20140602231509.GA26069@fifo99.com>
References: <1401629904-19492-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401629904-19492-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jun 01, 2014 at 03:38:24PM +0200, Rickard Strandqvist wrote:
> There is a risk that the variable will be used without being initialized.
> 
> This was largely found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/tty/serial/msm_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 053b98e..c67f5c5 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -962,7 +962,7 @@ static int __init msm_console_setup(struct console *co, char *options)
>  {
>  	struct uart_port *port;
>  	struct msm_port *msm_port;
> -	int baud, flow, bits, parity;
> +	int baud = 0, flow, bits, parity;
>  

It looks valid .. We might want to just set it to 115200 which is what your change eventually does later in
the code.

Daniel
