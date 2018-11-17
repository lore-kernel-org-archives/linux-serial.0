From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Sat, 17 Nov 2018 11:27:17 -0600
Message-ID: <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-2-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The mailbox framework supports blocking transfers via completions for
> clients that can sleep. In order to support blocking transfers in cases
> where the transmission is not permitted to sleep, add a new ->flush()
> callback that controller drivers can implement to busy loop until the
> transmission has been completed. This will automatically be called when
> available and interrupts are disabled for clients that request blocking
> transfers.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c          | 8 ++++++++
>  include/linux/mailbox_controller.h | 4 ++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 674b35f402f5..0eaf21259874 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
>                 unsigned long wait;
>                 int ret;
>
> +               if (irqs_disabled() && chan->mbox->ops->flush) {
> +                       ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> +                       if (ret < 0)
> +                               tx_tick(chan, ret);
> +
> +                       return ret;
> +               }
> +
This is hacky. I think we can do without busy waiting in atomic
context. You could queue locally while in atomic context and then
transfer in blocking mode. I don't think we should worry about the
'throughput' as there already is no h/w rate control even with
busy-waiting.

Thanks.
