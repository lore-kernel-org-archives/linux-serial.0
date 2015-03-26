From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] serial/amba-pl011: Leave the TX IRQ alone when
 the UART is not open
Date: Thu, 26 Mar 2015 22:26:41 +0100
Message-ID: <20150326212641.GA21554@kroah.com>
References: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
 <1426262182-2298-3-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1426262182-2298-3-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 13, 2015 at 03:56:22PM +0000, Dave Martin wrote:
> Getting the TX IRQ re-asserted from scratch can be inefficient in
> some setups.
> 
> This patch avoids clearing the TX IRQ across pl011_shutdown()...
> pl011_startup(), so that if the port is closed and reopened, the
> IRQ will still work afterwards without having to bootstrap it again.
> 
> The TX IRQ continues to be masked in IMSC when the UART is not in
> use.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

This doesn't apply to my tty-testing branch of tty.git on git.kernel.org
:(

Can you please rebase it and resend?

thanks,

greg k-h
