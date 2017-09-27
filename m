From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 4/8] mtd: nand: atmel: Avoid ECC errors when leaving
 backup mode
Date: Wed, 27 Sep 2017 17:08:11 +0200
Message-ID: <20170927170811.57830c1f@bbrezillon>
References: <20170927083555.16580-1-romain.izard.pro@gmail.com>
        <20170927083555.16580-5-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927083555.16580-5-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 27 Sep 2017 10:35:51 +0200
Romain Izard <romain.izard.pro@gmail.com> wrote:

> During backup mode, the contents of all registers will be cleared as the
> SoC will be completely powered down. For a product that boots on NAND
> Flash memory, the bootloader will obviously use the related controller
> to read the Flash and correct any detected error in the memory, before
> handling back control to the kernel's resuming entry point.
> 
> But it does not clean the NAND controller registers after use and on its
> side the kernel driver expects the error locator to be powered down and
> in a clean state. Add a resume hook for the PMECC error locator, and
> reset its registers.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
> Change in v3:
> * keep the PMECC disabled when not in use, and use atmel_pmecc_resume to
>   reset the controller after the bootloader has left it enabled.
> 
>  drivers/mtd/nand/atmel/nand-controller.c |  3 +++
>  drivers/mtd/nand/atmel/pmecc.c           | 22 ++++++++++++++--------
>  drivers/mtd/nand/atmel/pmecc.h           |  1 +
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> index f25eca79f4e5..86c2199380c2 100644
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -2530,6 +2530,9 @@ static __maybe_unused int atmel_nand_controller_resume(struct device *dev)
>  	struct atmel_nand_controller *nc = dev_get_drvdata(dev);
>  	struct atmel_nand *nand;
>  
> +	if (nand->pmecc)
> +		atmel_pmecc_resume(nand->pmecc);
> +

nand is used uninitialized here, and atmel_pmecc_resume() should be
passed a atmel_pmecc object not a atmel_pmecc_user.

	if (nc->pmecc)
		atmel_pmecc_resume(nc->pmecc);

>  	list_for_each_entry(nand, &nc->chips, node) {
>  		int i;
>  
> diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
> index 146af8218314..ff09c0f25dd4 100644
> --- a/drivers/mtd/nand/atmel/pmecc.c
> +++ b/drivers/mtd/nand/atmel/pmecc.c
> @@ -765,6 +765,12 @@ void atmel_pmecc_get_generated_eccbytes(struct atmel_pmecc_user *user,
>  }
>  EXPORT_SYMBOL_GPL(atmel_pmecc_get_generated_eccbytes);
>  
> +void atmel_pmecc_reset(struct atmel_pmecc *pmecc)
> +{
> +	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +}

It's not used outside of this file, so it should have a static
specifier. Anyway, I wonder why you don't expose atmel_pmecc_reset()
directly instead of creating this atmel_pmecc_resume() wrapper.
