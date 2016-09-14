From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
Date: Wed, 14 Sep 2016 23:33:56 +0200
Message-ID: <5525856.MfDSSsiP5d@wuerfel>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <4340181.AghlmQIy28@wuerfel> <57D96701.4050700@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <57D96701.4050700@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, gabriele.paoloni@huawei.com, minyard@acm.org, gregkh@linuxfoundation.org, benh@kernel.crashing.org, john.garry@huawei.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linuxarm@huawei.com, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com, zhichang.yuan02@gmail.com
List-Id: linux-serial@vger.kernel.org

On Wednesday, September 14, 2016 11:04:33 PM CEST zhichang.yuan wrote:
> The 8250_hisi_lpc.c support both ACPI and dts similar to 8250_dw :
> 
> +static struct platform_driver hs_lpc8250_driver = {
> +       .driver = {
> +               .name           = "hisi-lpc-uart",
> +               .of_match_table = hs8250_of_match,
> +               .acpi_match_table = ACPI_PTR(hs8250_acpi_match),
> 
> So, I am a little confused why we need to support dts in 8250_of.c and support ACPI in another
> driver file.
> 

After looking again, I'm pretty sure that drivers/tty/serial/8250/8250_pnp.c
will handle the ACPI case without modifications, you just need to adapt
the 8250_of driver to handle IORESOURCE_IO ports. This will be required
anyway with the next version once the LPC bridge is on the PCI bus.

	Arnd
