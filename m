From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] serial: tegra: Fix a typo in a comment line
Date: Thu, 7 Dec 2017 21:21:15 +0100
Message-ID: <2b7ff65b-dcb8-996b-1f34-f1bff28bb515@users.sourceforge.net>
References: <605adc2b-3591-86fc-410a-370f48dfb14e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <605adc2b-3591-86fc-410a-370f48dfb14e@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 7 Dec 2017 21:06:25 +0100

Delete a duplicate character in a word of this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/serial-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 46233c5974f1..a731b2d61d3e 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -888,7 +888,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
 	 * the DATA is sitting in the FIFO and couldn't be transferred to the
 	 * DMA as the DMA size alignment(4 bytes) is not met. EORD will be
-	 * triggered when there is a pause of the incomming data stream for 4
+	 * triggered when there is a pause of the incoming data stream for 4
 	 * characters long.
 	 *
 	 * For pauses in the data which is not aligned to 4 bytes, we get
-- 
2.15.1
