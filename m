From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 2/2] tty: serial: msm: Disable pclk when port is closed
Date: Wed, 08 Apr 2015 16:51:57 -0700
Message-ID: <5525BF1D.3050408@codeaurora.org>
References: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org> <1428499733-21963-2-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428499733-21963-2-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/08/15 06:28, Pramod Gurav wrote:
> Disable the pclk when tty port is closed by user space.
>
> Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
> ---
>  drivers/tty/serial/msm_serial.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 4c1e9ea..f38565c 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -523,6 +523,7 @@ static void msm_shutdown(struct uart_port *port)
>  	msm_write(port, 0, UART_IMR); /* disable interrupts */
>  
>  	clk_disable_unprepare(msm_port->clk);
> +	clk_disable_unprepare(msm_port->pclk);
>  
>  	free_irq(port->irq, port);
>  }

It's not clear to me at all when this clock is enabled and when it's
disabled during the lifetime of this driver. For example, why do we have
a .pm op to turn clocks on and off? Shouldn't they already be on? Can
you please explain when the clocks are turned on and off and what
userspace actions cause that to happen? Looking at drivers like
amba-pl010.c I don't see any .pm op, just a
clk_prepare_enable/clk_disable_unprepare pair in the startup and
shutdown ops.

Minus my confusion of why our clocking is complicated, it looks correct
to me to do this, so

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
