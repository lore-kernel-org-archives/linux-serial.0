From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/8] serial: tegra: check the count and read if any from dma
Date: Tue, 5 May 2015 15:17:54 +0100
Message-ID: <1430835479-6613-4-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

It is only necessary to read data from the dma buffer when the count
value is non-zero and hence, tegra_uart_copy_rx_to_tty() so only be
called when this is the case.

Although, this was being tested for in two places, there is a third
place where this was not tested. However, instead of adding another
if-statement prior to calling tegra_uart_copy_rx_to_tty(), move the test
inside the function.

Signed-off-by: Shardar Shariff Md <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Re-worked patch to move the check for the count
 value inside the function tegra_uart_copy_rx_to_tty(). Updated
 changelog with more commentary.]
Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 0d9d7ceb1dbb..a53899c47e60 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -554,6 +554,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 {
 	int copied;
 
+	/* If count is zero, then there is no data to be copied */
+	if (!count)
+		return;
+
 	tup->uport.icount.rx += count;
 	if (!tty) {
 		dev_err(tup->uport.dev, "No tty port\n");
@@ -588,8 +592,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 		set_rts(tup, false);
 
 	/* If we are here, DMA is stopped */
-	if (count)
-		tegra_uart_copy_rx_to_tty(tup, port, count);
+	tegra_uart_copy_rx_to_tty(tup, port, count);
 
 	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
@@ -626,8 +629,7 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
 	count = tup->rx_bytes_requested - state.residue;
 
 	/* If we are here, DMA is stopped */
-	if (count)
-		tegra_uart_copy_rx_to_tty(tup, port, count);
+	tegra_uart_copy_rx_to_tty(tup, port, count);
 
 	tegra_uart_handle_rx_pio(tup, port);
 	if (tty) {
-- 
1.9.1
