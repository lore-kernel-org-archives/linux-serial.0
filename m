From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Mon, 25 Apr 2016 14:35:27 -0700
Message-ID: <20160425213527.GH13149@codeaurora.org>
References: <571BAC8B.80001@gmail.com>
 <571BAE11.3020706@gmail.com>
 <20160425204806.GG13149@codeaurora.org>
 <571E8CAF.4060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571E8CAF.4060601@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 04/25, Frank Rowand wrote:
>
> This is in msm_request_tx_dma().  I should have made the message
> "msm_serial: TX DMA not enabled\n" and added a similar message
> to msm_request_rx_dma().
> 
> Then it could print twice, once for TX and once for RX. :-)
> For my board it would print twice because both requests would
> fail for the same reason.

Ah right, the 3 line diff window caught me here.

> 
> Should I add it to msm_request_rx_dma() also, but make both
> locations dev_debug() instead of dev_info()?

Honestly I don't see much point in having this at all. Why does
the user care if DMA is used or not? Don't they just want the
hardware to work? Maybe dev_dbg(), but again, debug junk. I'll
leave it up to you and Greg.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
