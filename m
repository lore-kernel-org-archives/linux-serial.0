From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: serial: msm_serial regression fix data
 corruption
Date: Mon, 25 Apr 2016 13:47:20 -0700
Message-ID: <20160425204720.GF13149@codeaurora.org>
References: <571BAC8B.80001@gmail.com>
 <571BAD78.4020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571BAD78.4020609@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 04/23, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Commit 3a878c430fd6 ("tty: serial: msm: Add TX DMA support") regression.
> The calculation of tx_count was moved from the old msm_handle_tx(),
> now renamed msm_handle_tx_pio(), to the new msm_handle_tx().  The
> move left out one size test.
> 
> The regression seen on the qcom-apq8074-dragonboard is dropped
> characters and corrupted characters (values greater than 0x7f)
> when DMA is not enabled.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for finding this!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
