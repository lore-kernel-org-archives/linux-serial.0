From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Wed, 28 Nov 2018 09:43:29 +0000
Message-ID: <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-2-thierry.reding@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On 12/11/2018 15:18, Thierry Reding wrote:
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
>  		unsigned long wait;
>  		int ret;
>  
> +		if (irqs_disabled() && chan->mbox->ops->flush) {
> +			ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> +			if (ret < 0)
> +				tx_tick(chan, ret);
> +
> +			return ret;
> +		}

It seems to me that if mbox_send_message() is called from an atomic
context AND tx_block is true, then if 'flush' is not populated this
should be an error condition as we do not wish to call
wait_for_completion from an atomic context.

I understand that there is some debate about adding such flush support,
but irrespective of the above change, it seems to me that if the
mbox_send_message() can be called from an atomic context (which it
appears to), then it should be detecting if someone is trying to do so
with 'tx_block' set as this should be an error.

Furthermore, if the underlying mailbox driver can support sending a
message from an atomic context and busy wait until it is done, surely
the mailbox framework should provide a means to support this?

Now it could be possible for the underlying mailbox driver to detect we
are in an atomic context and if the 'tx_block' is set do the right thing
by busy waiting until the message is sent. However, the problem with
that is, that for the mbox_send_message() to ensure the right thing is
done, it needs to check that 'tx_done' is set in the case of a blocking
transfer in an atomic context. At that point you may as well add the
flush operator as I think it is more implicit/clear.

Cheers
Jon

-- 
nvpublic
