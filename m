From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: sirf: Simplify a test
Date: Mon, 07 Nov 2016 14:50:27 +0100
Message-ID: <2916662.De1FDumaQl@wuerfel>
References: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: baohua@kernel.org, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Tuesday, November 1, 2016 8:03:33 AM CET Christophe JAILLET wrote:
> 'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the test
> can be simplified to be more consistent.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The change looks correct in principle. It would be good to automate looking
for other instances of this bug. How did you find it? Do you have e.g. a
coccinelle script or did you just stumble over the issue by accident?

There is one problem with your patch:

>  drivers/tty/serial/sirfsoc_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index b186c9c4f850..666ca3156961 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -609,7 +609,7 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
>                 sirfport->rx_dma_items.dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
>                 SIRFSOC_RX_DMA_BUF_SIZE / 2,
>                 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> -       if (IS_ERR_OR_NULL(sirfport->rx_dma_items.desc)) {
> +       if (!sirfport->rx_dma_items.desc) {
>                 dev_err(port->dev, "DMA slave single fail\n");
>                 return;
>         }

The serial driver is for the sirf platform, which uses the sirf-dma
dmaengine driver, and that particular driver has an incorrect
dma_prep_cyclic implementation, so I think we also need this fix:

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 8f62edad51be..220c611c89ae 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -775,7 +775,7 @@ sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
 	 * BUFB
 	 */
 	if (buf_len !=  2 * period_len)
-		return ERR_PTR(-EINVAL);
+		return NULL;
 
 	/* Get free descriptor */
 	spin_lock_irqsave(&schan->lock, iflags);


	Arnd
