From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "tty: serial: pl011: add ttyAMA for matching pl011
 console"
Date: Wed, 1 Mar 2017 12:59:41 +0000
Message-ID: <af761742-1362-a120-3f54-4cbe92ddbbbb@arm.com>
References: <20170301122602.30025-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301122602.30025-1-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 01/03/17 12:26, Aleksey Makarov wrote:
> The original patch makes condition always true, so it is wrong.
> 
> This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.

It seems fairly clear that the intent of the code merely warrants
s/||/&&/ - wouldn't it be more straightforward to just fix that?

Robin.

> ---
>  drivers/tty/serial/amba-pl011.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 8789ea423ccf..56f92d7348bf 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2373,7 +2373,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
>  	if (strcmp(name, "qdf2400_e44") == 0) {
>  		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
>  		qdf2400_e44_present = true;
> -	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
> +	} else if (strcmp(name, "pl011") != 0) {
>  		return -ENODEV;
>  	}
>  
> 
