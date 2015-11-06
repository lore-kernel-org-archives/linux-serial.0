From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 05/11] tty: amba-pl011: add register lookup table
Date: Thu, 5 Nov 2015 18:00:08 -0600
Message-ID: <563BED88.3040101@codeaurora.org>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 11/03/2015 08:51 AM, Russell King wrote:
>   enum {
> -	REG_DR = UART01x_DR,
> -	REG_ST_DMAWM = ST_UART011_DMAWM,
> -	REG_ST_TIMEOUT = ST_UART011_TIMEOUT,
> -	REG_FR = UART01x_FR,
> -	REG_ST_LCRH_RX = ST_UART011_LCRH_RX,
> -	REG_IBRD = UART011_IBRD,
> -	REG_FBRD = UART011_FBRD,
> -	REG_LCRH = UART011_LCRH,
> -	REG_ST_LCRH_TX = ST_UART011_LCRH_TX,
> -	REG_CR = UART011_CR,
> -	REG_IFLS = UART011_IFLS,
> -	REG_IMSC = UART011_IMSC,
> -	REG_RIS = UART011_RIS,
> -	REG_MIS = UART011_MIS,
> -	REG_ICR = UART011_ICR,
> -	REG_DMACR = UART011_DMACR,
> -	REG_ST_XFCR = ST_UART011_XFCR,
> -	REG_ST_XON1 = ST_UART011_XON1,
> -	REG_ST_XON2 = ST_UART011_XON2,
> -	REG_ST_XOFF1 = ST_UART011_XOFF1,
> -	REG_ST_XOFF2 = ST_UART011_XOFF2,
> -	REG_ST_ITCR = ST_UART011_ITCR,
> -	REG_ST_ITIP = ST_UART011_ITIP,
> -	REG_ST_ABCR = ST_UART011_ABCR,
> -	REG_ST_ABIMSC = ST_UART011_ABIMSC,
> +	REG_DR,
> +	REG_ST_DMAWM,
> +	REG_ST_TIMEOUT,
> +	REG_FR,
> +	REG_ST_LCRH_RX,
> +	REG_IBRD,
> +	REG_FBRD,
> +	REG_LCRH,
> +	REG_ST_LCRH_TX,
> +	REG_CR,
> +	REG_IFLS,
> +	REG_IMSC,
> +	REG_RIS,
> +	REG_MIS,
> +	REG_ICR,
> +	REG_DMACR,
> +	REG_ST_XFCR,
> +	REG_ST_XON1,
> +	REG_ST_XON2,
> +	REG_ST_XOFF1,
> +	REG_ST_XOFF2,
> +	REG_ST_ITCR,
> +	REG_ST_ITIP,
> +	REG_ST_ABCR,
> +	REG_ST_ABIMSC,
> +
> +	/* The size of the array - must be last */
> +	REG_ARRAY_SIZE,
>   };

This breaks early console because REG_DR and REG_FR are now enums 
instead of an actual register offset, and so

static void pl011_putc(struct uart_port *port, int c)
{
	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
		;
	writeb(c, port->membase + REG_DR);
	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
		;
}

is wrong.  I get alignment violations because REG_FR is equal to 3 
instead of 0x18.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
