From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/8] tty: serial: fsl_lpuart: support suspend/resume
Date: Sat, 11 Jun 2016 22:03:41 +0800
Message-ID: <20160611140341.GT20243@tiger>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
 <20160609151039.20817-3-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609151039.20817-3-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 09, 2016 at 08:40:33PM +0530, Bhuvanchandra DV wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> In order to allow wake support in STOP sleep mode, clocks are
> needed. Use imx_clk_gate2_cgr to disable automatic clock gating
> in low power mode STOP. This allows to enable wake by UART using:
> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
> 
> However, if wake is not enabled, the driver should disable the
> clocks explicitly to save power.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/clk/imx/clk-vf610.c     | 12 ++++++------

Please send clock driver changes in a separate patch.

Shawn

>  drivers/tty/serial/fsl_lpuart.c | 16 ++++++++++++++--
>  2 files changed, 20 insertions(+), 8 deletions(-)
