From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Wed, 28 Nov 2018 23:23:36 -0600
Message-ID: <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The mailbox framework supports blocking transfers via completions for
> > clients that can sleep. In order to support blocking transfers in cases
> > where the transmission is not permitted to sleep, add a new ->flush()
> > callback that controller drivers can implement to busy loop until the
> > transmission has been completed. This will automatically be called when
> > available and interrupts are disabled for clients that request blocking
> > transfers.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 8 ++++++++
> >  include/linux/mailbox_controller.h | 4 ++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 674b35f402f5..0eaf21259874 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> >               unsigned long wait;
> >               int ret;
> >
> > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > +                     if (ret < 0)
> > +                             tx_tick(chan, ret);
> > +
> > +                     return ret;
> > +             }
>
> It seems to me that if mbox_send_message() is called from an atomic
> context AND tx_block is true, then if 'flush' is not populated this
> should be an error condition as we do not wish to call
> wait_for_completion from an atomic context.
>
> I understand that there is some debate about adding such flush support,
> but irrespective of the above change, it seems to me that if the
> mbox_send_message() can be called from an atomic context (which it
> appears to), then it should be detecting if someone is trying to do so
> with 'tx_block' set as this should be an error.
>
Layers within kernel space have to trust each other. A badly written
client can break the consumer in so many ways, we can not catch every
possibility.

> Furthermore, if the underlying mailbox driver can support sending a
> message from an atomic context and busy wait until it is done, surely
> the mailbox framework should provide a means to support this?
>
Being able to put the message on bus in atomic context is a feature -
which we do support. But busy-waiting in a loop is not a feature, and
we don't want to encourage that.

Cheers!
