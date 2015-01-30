From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 3.19-rc4: Fix race condition in i.MX serial port driver
Date: Fri, 30 Jan 2015 15:25:09 -0800
Message-ID: <20150130232509.GA21337@kroah.com>
References: <trinity-2ff5fec6-196c-4ecc-9ec2-f1b223f0ea25-1421165228466@3capp-gmx-bs70>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <trinity-2ff5fec6-196c-4ecc-9ec2-f1b223f0ea25-1421165228466@3capp-gmx-bs70>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Doswald <michael.doswald@gmx.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 13, 2015 at 05:07:08PM +0100, Michael Doswald wrote:
> Under pressure, the imx.c device driver may transfer the same data multiple
> times. 
> 
> Reason: 
> Function imx_dma_tx checks for an active DMA transfer by calling
> dmaengine_tx_status. The return value may indicate that no transfer is 
> running while the dma_tx_callback function is still being executed. In 
> this case the xmit->tail pointer may not be updated to the correct value 
> when imx_dma_tx initiates a new DMA transfer, which will result in a DMA
> transfer with the same base address as the previous one.
> 
> Patch:
> Use existing dma_is_txing variable to guard DMA transfer initiation instead
> of dmaengine_tx_status. Clear dma_is_txing at the end of the DMA callback
> function therefore extending the critical section where the port lock is
> held. Critical section extension is in line with the callback function 
> of other drivers, e.g. serial-tegra.c (tegra_uart_tx_dma_complete).
>  
>  
> Signed-off-by: Michael Doswald <michael.doswald@gmx.net>
> ---
>  drivers/tty/serial/imx.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Fails to apply to my tree :(
