From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/8] ARM: zynq: move arm-specific sys_timer out of ttc
Date: Mon, 5 Nov 2012 12:20:16 +0100
Message-ID: <CAHTX3d+H7QOUgk8HxekEHd-=XV4k=pTbMcC_cAxkhj1z0s+TWg@mail.gmail.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <3ec3531d21c247ac3dcc76d91ff6be13ebfc733b.1351721190.git.josh.cartwright@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3ec3531d21c247ac3dcc76d91ff6be13ebfc733b.1351721190.git.josh.cartwright@ni.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Josh Cartwright <josh.cartwright@ni.com>
Cc: Russell King <linux@arm.linux.org.uk>, John Stultz <johnstul@us.ibm.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>
List-Id: linux-serial@vger.kernel.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> Move the sys_timer definition out of ttc driver and make it part of the
> common zynq code.  This is preparation for renaming and COMMON_CLK
> support.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/mach-zynq/common.c | 13 +++++++++++++
>  arch/arm/mach-zynq/common.h |  4 +---
>  arch/arm/mach-zynq/timer.c  | 10 +---------
>  3 files changed, 15 insertions(+), 12 deletions(-)
>

Tested-by: Michal Simek <michal.simek@xilinx.com>

Looks good to me. I have added it to my testing branch
and will provide path to mainline through xilinx arm-next branch

Thanks,
Michal
