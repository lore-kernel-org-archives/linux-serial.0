From: charanya@codeaurora.org
Subject: Re: [PATCH] tty: serial: msm: Disable restoring Rx interrupts for DMA
 Mode
Date: Thu, 02 Jun 2016 14:37:57 +0530
Message-ID: <9c627293b1a13f5e71ba1a61c3bc2bfa@codeaurora.org>
References: <1462896580-11554-1-git-send-email-absahu@codeaurora.org>
 <20160512014126.GK3492@codeaurora.org>
 <20160512050245.GD8453@hector.attlocal.net>
 <5cce36b3c1d62816feffb4048f782b20@codeaurora.org>
 <20160525224623.GS3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525224623.GS3492@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Abhishek Sahu <absahu@codeaurora.org>, agross@codeaurora.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2016-05-26 04:16, Stephen Boyd wrote:
> On 05/13, charanya@codeaurora.org wrote:
>> Hi Stephen/Andy,
>> 
>> If both Tx and Rx are used simultaneously, restoring Rx interrupts in
>> msm_complete_rx_dma could lead to RXSTALE interrupt being triggered,
>> when
>> the ISR execution for TXLEV interrupt is completed, since
>> msm_port->imr is
>> rewritten to UART_IMR in msm_uart_irq. Hence, we do not have to 
>> restore
>> Rx interrupts since Rx is always in DMA mode once enabled.
>> 
> 
> Ok, but what's the exact sequence of events that happens? I think
> we unlock the spinlock in the dma completion handler and then the
> txlev interrupt runs? At that point we may have more data to push
> out and then rx stale handling runs and corrupts the fifo state?
> 
> I was hoping for some sort of CPU sequence of events like:
> 
>  CPU0                   CPU1
>  ----                   ----
> 
>  msm_start_rx_dma()
>                        msm_complete_rx_dma()
> 		        spin_unlock_irqrestore(&port->lock)
>  msm_uart_irq()
>   msm_handle_rx_dm()
>    <Read from FIFO and breaks>
> 
> This patch seems correct, but the commit text isn't fully
> describing the sequence of events that causes this to happen, so
> it's taking a while to convince myself that this patch fixes
> anything.


The sequence of events is as mentioned. When the TXLEV interrupt occurs 
after the
spinlock is unlocked, the rx stale handling runs since the interrupts 
are restored
and hence it corrupts the fifo state.
