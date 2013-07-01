From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] serial: imx: remove the uart_console() check
Date: Tue, 2 Jul 2013 00:08:36 +0800
Message-ID: <20130701160833.GC14172@S2101-09.ap.freescale.net>
References: <1372397982-19017-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1372397982-19017-1-git-send-email-b32955@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <b32955@freescale.com>
Cc: fabio.estevam@freescale.com, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 28, 2013 at 01:39:42PM +0800, Huang Shijie wrote:
> The uart_console() check makes the clocks(clk_per and clk_ipg) opened
> even when we close the console uart.
> 
> This patch enable/disable the clocks in imx_console_write(),
> so we can keep the clocks closed when the console uart is closed.
> 
> Also remove the clock enable/disable oprations in the probe, we do not
> need them any more.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
