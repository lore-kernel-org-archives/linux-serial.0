From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/8] ARM: zynq: dts: add description of the second uart
Date: Mon, 5 Nov 2012 12:35:30 +0100
Message-ID: <CAHTX3d+WePMm16xK0Mub9EZMSX9vg_FTFQG-u0vxXXxuv9j4Vg@mail.gmail.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
	<8c2fac7167cd7c5201d5e1d8e1ceeb183ee2f63f.1351721190.git.josh.cartwright@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c2fac7167cd7c5201d5e1d8e1ceeb183ee2f63f.1351721190.git.josh.cartwright@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Cartwright <josh.cartwright@ni.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Linn <John.Linn@xilinx.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> The zynq-7000 has an additional UART at 0xE0001000.  Describe it in the
> device tree.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to my testing branch.

Thanks,
Michal
