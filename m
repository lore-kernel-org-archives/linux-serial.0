From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] tty:serial:msm:Do not restore Rx interrupts in DMA
Date: Tue, 7 Jun 2016 16:08:44 -0700
Message-ID: <20160607230844.GA28218@codeaurora.org>
References: <1462896580-11554-1>
 <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Charanya Venkatraman <charanya@codeaurora.org>
Cc: agross@codeaurora.org, david.brown@linaro.org, andy.gross@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, absahu@codeaurora.org, njaigane@codeaurora.org
List-Id: linux-serial@vger.kernel.org

On 06/07, Charanya Venkatraman wrote:
> Avoid data corruption issues that result in CRC errors during file
> transfers over serial ports at higher baud rates.
> 
> The current msm_serial driver masks the FIFO Rx interrupts in
> msm_start_rx_dma() since Rx FIFO interrupts are not required in DMA
> mode. However, msm_complete_rx_dma() re-enables the Rx FIFO interrupts
> which could cause RXSTALE event to be processed when a TXLEV interrupt
> occurs.
> 
> The following is the sequence of events that could occur resulting in
> data corruption.
> 
> msm_start_rx_dma -> msm_complete_rx_dma -->
> spin_unlock_irqrestore(&port->lock) -->
> msm_uart_irq()(For TXLEV interrupt) -->  msm_handle_rx_dm() (Read from
> FIFO resulting in data corruption)
> 
> The patch fixes the issue by not restoring the RXLEV and RXSTALE
> interrupts in msm_complete_rx_dma(). These interrupts are required only
> in FIFO mode.
> 
> Signed-off-by: Charanya Venkatraman <charanya@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
