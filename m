From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Sun, 29 Apr 2018 15:18:57 +0200
Message-ID: <20180429131857.GC23018@kroah.com>
References: <1524823545-11309-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1524823545-11309-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Ciro Santilli <ciro.santilli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 27, 2018 at 11:05:44AM +0100, Dave Martin wrote:
> This is an update to a previous RFC [1], to fix a problem observed by
> the qemu community that causes serial input to hang when booting a
> simulated system with data already queued in the UART FIFO [2].
> 
> This patch could cause problems for people that are actually relying
> on chars queued in the PL011 RX FIFO during boot or while the UART is
> closed.  There are no guarantees about such things working in general.
> In either case, there is no protection against RX FIFO overflow or
> reprogramming of the UART parameters while Linux is not actively
> receiving chars.
> 
> Cheers
> ---Dave
> 
> [1] [RFC PATCH v4] tty: pl011: Avoid spuriously stuck-off interrupts
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/574033.html
> 
> [2] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
> before enabled the interruption
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html
> 
> Dave Martin (1):
>   tty: pl011: Avoid spuriously stuck-off interrupts
> 
>  drivers/tty/serial/amba-pl011.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> -- 
> 2.1.4

There is no patch here, did something go wrong?

You do not need a "cover letter" for a single patch...

thanks,

greg k-h
