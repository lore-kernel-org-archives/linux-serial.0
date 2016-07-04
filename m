From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH v2 0/9] Improve Rx/Tx DMA implementation
Date: Mon, 4 Jul 2016 11:54:13 +0530
Message-ID: <00c09dc2-da73-1415-9f9f-5dc6c56034c0@toradex.com>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Ping!

On 06/28/16 11:02, Bhuvanchandra DV wrote:

> Changes since v1:
> Split suspend/resume patch.
>
> Bhuvanchandra DV (5):
>    tty: serial: fsl_lpuart: Fix broken 8m/s1 support
>    tty: serial: fsl-lpuart: Use cyclic DMA for Rx
>    tty: serial: fsl-lpuart: Use scatter/gather DMA for Tx
>    tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
>    tty: serial: fsl_lpuart: Add support for RS-485
>
> Stefan Agner (4):
>    tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
>    clk: imx: vf610: Disable automatic clock gating for lpuart in LPSTOP mode
>    tty: serial: fsl_lpuart: support suspend/resume
>    tty: serial: fsl_lpuart: fix clearing of receive flag
>
>   drivers/clk/imx/clk-vf610.c     |  12 +-
>   drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
>   2 files changed, 482 insertions(+), 340 deletions(-)
>
