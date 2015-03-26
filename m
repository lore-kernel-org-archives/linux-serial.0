From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: protect Soft Reset of port with lock
Date: Thu, 26 Mar 2015 23:01:13 +0100
Message-ID: <20150326220113.GA24630@kroah.com>
References: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 13, 2015 at 03:38:11PM +0900, Jiada Wang wrote:
> Previously Soft Reset (clear of SRST bit in UCR2 register)
> of UART in startup is not protected by lock, which may have race
> with console_write, as console_write may occur at anytime even
> when UART port is shutdown.
> 
> To avoid this race, protect Soft reset of UART port with spin_lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Doesn't apply to my tree :(
