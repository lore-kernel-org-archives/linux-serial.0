From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
Date: Tue, 20 Feb 2018 11:22:05 +0100
Message-ID: <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 20.2.2018 10:40, Geert Uytterhoeven wrote:
> The cdns_uart_port[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")

I didn't find this sha1 - patch name is this one.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
>  	struct uart_port *port;
>  
>  	/* Try the given port id if failed use default method */
> -	if (cdns_uart_port[id].mapbase != 0) {
> +	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
>  		/* Find the next unused port */
>  		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
>  			if (cdns_uart_port[id].mapbase == 0)
> 

Below should be better fix for this driver.

Thanks,
Michal

diff --git a/drivers/tty/serial/xilinx_uartps.c
b/drivers/tty/serial/xilinx_uartps.c
index b9b2bc76bcac..b77c6477ed93 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1109,6 +1109,9 @@ static struct uart_port *cdns_uart_get_port(int id)
 {
        struct uart_port *port;

+       if (id >= CDNS_UART_NR_PORTS)
+               return NULL;
+
        /* Try the given port id if failed use default method */
        if (cdns_uart_port[id].mapbase != 0) {
                /* Find the next unused port */
@@ -1117,9 +1120,6 @@ static struct uart_port *cdns_uart_get_port(int id)
                                break;
        }

-       if (id >= CDNS_UART_NR_PORTS)
-               return NULL;
-
        port = &cdns_uart_port[id];

        /* At this point, we've got an empty uart_port struct,
initialize it */
