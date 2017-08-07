From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Move request_irq to the end of startup
Date: Mon, 7 Aug 2017 14:31:13 -0500
Message-ID: <20170807193113.GA26499@hector.attlocal.net>
References: <1502086885-8390-1-git-send-email-neeraju@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502086885-8390-1-git-send-email-neeraju@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sramana@codeaurora.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 07, 2017 at 11:51:25AM +0530, Neeraj Upadhyay wrote:
> Move the request_irq() call to the end of the msm_startup(),
> so that we don't handle interrupts while msm_startup() is
> running. This avoids potential races while initialization
> is in progress. For example, consider below scenario
> where rx handler reads the intermediate value of dma->chan,
> set in msm_request_rx_dma(), and tries to do dma mapping,
> which results in data abort.
> 
> uart_port_startup()
>   msm_startup()
>    request_irq()
>    ...
>    msm_request_rx_dma()
>     ...
>     dma->chan = dma_request_slave_channel_reason(dev, "rx");
>     <UART RX IRQ>
>      msm_uart_irq()
>       msm_handle_rx_dm()
>        msm_start_rx_dma()
>         dma->desc = dma_map_single()
>          <data abort>
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

This seems reasonable.

Reviewd-by: Andy Gross <andy.gross@linaro.org>
