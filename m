From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: stm32: use mapbase instead of membase for DMA
Date: Fri, 23 Sep 2016 21:38:51 +0200
Message-ID: <20160923193935.3726427-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Building this driver with a 64-bit dma_addr_t type results in
a compiler warning:

drivers/tty/serial/stm32-usart.c: In function 'stm32_of_dma_rx_probe':
drivers/tty/serial/stm32-usart.c:746:20: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
drivers/tty/serial/stm32-usart.c: In function 'stm32_of_dma_tx_probe':
drivers/tty/serial/stm32-usart.c:818:20: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

While the type conversion here is harmless, this hints at a different
problem: we pass an __iomem pointer into a DMA engine, which expects
a phys_addr_t. This happens to work because stm32 has no MMU and
ioremap() is an identity mapping here, but it's still an incorrect
API use. Using dma_addr_t is doubly wrong here, because that would
be the result of dma_map_single() rather than the physical address.

Using the mapbase instead fixes multiple issues:

- the warning is gone
- we don't go through ioremap in error
- the cast is gone, making it use the correct resource_size_t/phys_addr_t
  type in the process.

Fixes: 3489187204eb ("serial: stm32: adding dma support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4d3001b77e7e..2adb678a863b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -743,7 +743,7 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 
 	/* Configure DMA channel */
 	memset(&config, 0, sizeof(config));
-	config.src_addr = (dma_addr_t)port->membase + ofs->rdr;
+	config.src_addr = port->mapbase + ofs->rdr;
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	ret = dmaengine_slave_config(stm32port->rx_ch, &config);
@@ -815,7 +815,7 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 
 	/* Configure DMA channel */
 	memset(&config, 0, sizeof(config));
-	config.dst_addr = (dma_addr_t)port->membase + ofs->tdr;
+	config.dst_addr = port->mapbase + ofs->tdr;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	ret = dmaengine_slave_config(stm32port->tx_ch, &config);
-- 
2.9.0
