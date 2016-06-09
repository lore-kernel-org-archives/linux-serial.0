From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v3] tty:serial:msm:Do not restore Rx interrupts in DMA
Date: Thu, 9 Jun 2016 14:27:19 -0500
Message-ID: <20160609192719.GL13357@hector.attlocal.net>
References: <1462896580-11554-1>
 <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Charanya Venkatraman <charanya@codeaurora.org>
Cc: agross@codeaurora.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, absahu@codeaurora.org, njaigane@codeaurora.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 07, 2016 at 03:58:41PM +0530, Charanya Venkatraman wrote:
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

Acked-by: Andy Gross <andy.gross@linaro.org>
