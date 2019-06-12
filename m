From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 5/6] serial: uartps: Do not add a trailing semicolon
 to macro
Date: Wed, 12 Jun 2019 10:07:25 -0700
Message-ID: <fc69912c14ead80f371e2136d43db4af1f4b72aa.camel@perches.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
         <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, johan@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-06-12 at 13:14 +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch fixes this checkpatch warning:
> WARNING: macros should not use a trailing semicolon
> +#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> +		clk_rate_change_nb);
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
[]
> @@ -199,7 +199,7 @@ struct cdns_platform_data {
>  	u32 quirks;
>  };
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> -		clk_rate_change_nb);
> +		clk_rate_change_nb)
>  
>  /**
>   * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.

trivia:

Perhaps this is easier for humans to read with the macro
on two lines like:

#define to_cdns_uart(_nb) \
	container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or just ignore the 80 column limit

#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or because the macro is only used in one place,
just get rid of it and use container_of directly.
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..ca5cec2b83ce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -195,11 +195,10 @@ struct cdns_uart {
 	u32			quirks;
 	bool cts_override;
 };
+
 struct cdns_platform_data {
 	u32 quirks;
 };
-#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
@@ -489,8 +488,9 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 	int locked = 0;
 	struct clk_notifier_data *ndata = data;
 	unsigned long flags = 0;
-	struct cdns_uart *cdns_uart = to_cdns_uart(nb);
+	struct cdns_uart *cdns_uart;
 
+	cdns_uart = container_of(nb, struct cdns_uart, clk_rate_change_nb);
 	port = cdns_uart->port;
 	if (port->suspended)
 		return NOTIFY_OK;
