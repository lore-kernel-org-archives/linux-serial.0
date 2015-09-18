From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/7] tty: serial: msm: Fix command Stale Event Enable
 definition
Date: Fri, 18 Sep 2015 16:33:16 -0700
Message-ID: <20150918233316.GB23081@codeaurora.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
 <1442062934-13449-4-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442062934-13449-4-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/12, Ivan T. Ivanov wrote:
> Stale Event Enable command should be 5 not 8, fix this.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
> index 60917d30c6b5..223f961f992a 100644
> --- a/drivers/tty/serial/msm_serial.h
> +++ b/drivers/tty/serial/msm_serial.h
> @@ -59,7 +59,7 @@
>  #define UART_CR_CMD_SET_RFR		(13 << 4)
>  #define UART_CR_CMD_RESET_RFR		(14 << 4)
>  #define UART_CR_CMD_PROTECTION_EN	(16 << 4)
> -#define UART_CR_CMD_STALE_EVENT_ENABLE	(80 << 4)
> +#define UART_CR_CMD_STALE_EVENT_ENABLE	(5 << 8)

I don't get this one

 5 << 8 == 80 << 4

so this makes no difference.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
