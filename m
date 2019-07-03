From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
Date: Thu, 04 Jul 2019 09:04:55 +1000
Message-ID: <c8b5e295c34aaf8b3d8b03aeaa980c88d870443a.camel@kernel.crashing.org>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
         <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
         <20190703174926.GA12813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703174926.GA12813@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, "sudheer.v" <open.sudheer@gmail.com>
Cc: jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com, sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-07-03 at 19:49 +0200, Greg KH wrote:
> > +
> > +     if (tx_sts & UART_SDMA0_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA0_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[0]));
> > +     } else if (tx_sts & UART_SDMA1_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA1_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[1]));
> > +     } else if (tx_sts & UART_SDMA2_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA2_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[2]));
> > +     } else if (tx_sts & UART_SDMA3_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA3_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[3]));
> > +     } else if (tx_sts & UART_SDMA4_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA4_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[4]));
> > +     } else if (tx_sts & UART_SDMA5_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA5_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[5]));
> > +     } else if (tx_sts & UART_SDMA6_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA6_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[6]));
> > +     } else if (tx_sts & UART_SDMA7_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA7_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[7]));
> > +     } else if (tx_sts & UART_SDMA8_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA8_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[8]));
> > +     } else if (tx_sts & UART_SDMA9_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA9_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[9]));
> > +     } else if (tx_sts & UART_SDMA10_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA10_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[10]));
> > +     } else if (tx_sts & UART_SDMA11_INT) {
> > +             ast_uart_sdma_write(sdma, UART_SDMA11_INT, UART_TX_SDMA_ISR);
> > +             ast_sdma_bufffdone(&(sdma->dma_ch->tx_dma_info[11]));
> > +     } else {
> > +     }

Also this should be a for () loop...

Cheers,
Ben.
