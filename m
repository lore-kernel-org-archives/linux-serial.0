From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm: Fix mask value of RFR level
Date: Tue, 07 Apr 2015 16:07:35 -0700
Message-ID: <55246337.2000804@codeaurora.org>
References: <1428414446-21282-1-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428414446-21282-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/07/15 06:47, Pramod Gurav wrote:
> According to documents The RFR_LEVEL1 in UART_DM_MR1 can be

That is UART_DM_MR1

> programmed in bits 31:8 but the masks only bits 17:8.
> Correct the same.
>
> Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
> ---
>  drivers/tty/serial/msm_serial.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
> index 8f7806d..5ff9ebf 100644
> --- a/drivers/tty/serial/msm_serial.h
> +++ b/drivers/tty/serial/msm_serial.h
> @@ -19,7 +19,7 @@
>  #define UART_MR1			0x0000
>  
>  #define UART_MR1_AUTO_RFR_LEVEL0	0x3F
> -#define UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
> +#define UART_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00

But this is UART_MR1. The two hardware cores share the same driver
because the DM hardware is based on the non-DM hardware. I suppose we
need to make another #define UART_DM_MR1_AUTO_RFR_LEVEL1 and then have
an if (msm_port->is_uartdm) in msm_startup() path to handle the
differences here.

>  #define UART_MR1_RX_RDY_CTL    		(1 << 7)
>  #define UART_MR1_CTS_CTL       		(1 << 6)
>  


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
