From: charanya@codeaurora.org
Subject: Re: [PATCH] tty: serial: msm: Disable restoring Rx interrupts for DMA
 Mode
Date: Fri, 13 May 2016 14:48:27 +0530
Message-ID: <5cce36b3c1d62816feffb4048f782b20@codeaurora.org>
References: <1462896580-11554-1-git-send-email-absahu@codeaurora.org>
 <20160512014126.GK3492@codeaurora.org>
 <20160512050245.GD8453@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512050245.GD8453@hector.attlocal.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Abhishek Sahu <absahu@codeaurora.org>, agross@codeaurora.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2016-05-12 10:32, Andy Gross wrote:
> On Wed, May 11, 2016 at 06:41:26PM -0700, Stephen Boyd wrote:
>> On 05/10, Abhishek Sahu wrote:
>> > From: Charanya <charanya@codeaurora.org>
>> 
>> Was it intentional to only have one name here?
>> 
>> >
>> > The Data loss was happening with current QCOM MSM serial driver during
>> > large file transfer due to simultaneous enabling of both UART and
>> > DMA interrupt. When UART operates in DMA mode, RXLEV (Rx FIFO over
>> > watermark) or RXSTALE (stale interrupts) should not be enabled,
>> > since these conditions will be handled by DMA controller itself.
>> > If these interrupts are enabled then normal UART ISR will read some
>> > bytes of data from Rx Buffer and DMA controller will not receive
>> > these bytes of data, which will cause data loss.
>> >
>> > Now this patch removed the code for enabling of RXLEV and RXSTALE
>> > interrupt in DMA Rx completion routine.
>> 
>> I'm lost, we keep both these irqs masked (well only if uartdm
>> version is 1.4 or greater) pretty much the entire time we're
>> using DMA for RX. msm_start_rx_dma() will mask them and then when
>> the callback completes we'll unmask them (the part that's deleted
>> in this patch), but then we'll go back and remask them almost
>> immediately because we call msm_start_rx_dma() from the dma
>> completion handler.
>> 
>> Can you clearly describe how this is actually fixing any
>> problems? What's the sequence of events that happens to cause
>> corruption?
>> 
>> This does raise the question though why we ever mask/unmask these
>> interrupts if we're always going to keep them masked while doing
>> DMA RX. Presumably if we can use DMA to RX, we can always use it
>> and set things up properly at startup time instead of later on.
> 
> Thats probably the right thing to do.  We shouldn't be 
> masking/unmasking
> the unused IRQs to begin with.
Hi Stephen/Andy,

If both Tx and Rx are used simultaneously, restoring Rx interrupts in
msm_complete_rx_dma could lead to RXSTALE interrupt being triggered, 
when
the ISR execution for TXLEV interrupt is completed, since msm_port->imr 
is
rewritten to UART_IMR in msm_uart_irq. Hence, we do not have to restore
Rx interrupts since Rx is always in DMA mode once enabled.

Thanks.
Charanya.
