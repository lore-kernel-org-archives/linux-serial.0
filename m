From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] disable RTS override on LPSS UART with Auto Flow Control
Date: Wed, 15 Mar 2017 17:39:27 +0200
Message-ID: <1489592367.19767.3.camel@linux.intel.com>
References: <1489587228-10764-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489587228-10764-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan O'Donovan <dan@emutex.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-03-15 at 14:13 +0000, Dan O'Donovan wrote:
> Currently, Auto Flow Control is not working correctly on the Atom
> X5-Z8350 "Cherry Trail" SoC, because an "RTS override" feature is
> enabled in a vendor-specific register in the LPSS UART. The symptom
> is that RTS is not de-asserted as it should be when RTS/CTS flow
> control is enabled and the RX FIFO fills up.
> 
> This appears to be introduced by commit 1f47a77c4e49 ("ACPI / LPSS:
> not using UART RTS override with Auto Flow Control").
> 
> To _disable_ the RTS override, bit 3 needs to be _set_ in the
> "GENERAL" register at offset 808h.  The power-on default is 0. The
> aforementioned commit appears to have assumed the inverse of this.

Thanks for spotting this.

Documentation I have says the same.

Nevertheless I would like to have Heikki's Ack before going with this
one.

Moreover, some tests on Baytrail and Cherrytrail platforms should be
performed. Do you have a test case step-by-step to reproduce the issue?

It might also explain the following (would be nice to test with this
revert reverted):

commit f967fc8f165fadb72166f2bd4785094b3ca21307
Author: Frederic Danis <frederic.danis@linux.intel.com>
Date:   Fri Oct 9 17:14:56 2015 +0200

    Revert "serial: 8250_dma: don't bother DMA with small transfers"


See my comments regarding to code below.

> 
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/acpi/acpi_lpss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 8ea836c..4b3f2d5 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -45,7 +45,7 @@ ACPI_MODULE_NAME("acpi_lpss");
>  #define LPSS_RESETS_RESET_APB		BIT(1)
>  #define LPSS_GENERAL			0x08
>  #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
> -#define LPSS_GENERAL_UART_RTS_OVRD	BIT(3)
> +#define LPSS_GENERAL_UART_RTS_NO_OVRD	BIT(3)

Better to use closer to documentation, i.e.

_RTS_DIS_OVRD


>  #define LPSS_SW_LTR			0x10
>  #define LPSS_AUTO_LTR			0x14
>  #define LPSS_LTR_SNOOP_REQ		BIT(15)
> @@ -123,10 +123,10 @@ static void lpss_uart_setup(struct
> lpss_private_data *pdata)
>  	writel(val | LPSS_TX_INT_MASK, pdata->mmio_base + offset);
>  
>  	val = readl(pdata->mmio_base + LPSS_UART_CPR);
> -	if (!(val & LPSS_UART_CPR_AFCE)) {
> +	if (val & LPSS_UART_CPR_AFCE) {

Perhaps we need to clear it otherwise to be sure

something like

offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
val = readl(pdata->mmio_base + offset);
if (..._AFCE)
 val |= LPSS_GENERAL_UART_RTS_DIS_OVRD;
else
 val &= ~LPSS_GENERAL_UART_RTS_DIS_OVRD;
writel(val, pdata->mmio_base +
offset);


>  		offset = pdata->dev_desc->prv_offset + LPSS_GENERAL;
>  		val = readl(pdata->mmio_base + offset);
> -		val |= LPSS_GENERAL_UART_RTS_OVRD;
> +		val |= LPSS_GENERAL_UART_RTS_NO_OVRD;
>  		writel(val, pdata->mmio_base + offset);
>  	}
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
