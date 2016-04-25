From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Mon, 25 Apr 2016 13:48:06 -0700
Message-ID: <20160425204806.GG13149@codeaurora.org>
References: <571BAC8B.80001@gmail.com>
 <571BAE11.3020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571BAE11.3020706@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 04/23, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Failure to enable DMA by the msm_serial driver is silent.
> Add a message to report the failure.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  drivers/tty/serial/msm_serial.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: b/drivers/tty/serial/msm_serial.c
> ===================================================================
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -170,6 +170,7 @@ rel_tx:
>  	dma_release_channel(dma->chan);
>  no_tx:
>  	memset(dma, 0, sizeof(*dma));
> +	dev_info(dev, "msm_serial: DMA not enabled\n");
>  }
>  

Wouldn't this print twice for TX and RX channels? I'd prefer we
not print anything when this driver probes, just because it's a
bunch of log spam that we don't really need.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
