From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Thu, 6 Dec 2018 23:56:25 -0600
Message-ID: <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129152312.GB23750@ulmo>
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

On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > >
> > > On 12/11/2018 15:18, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > The mailbox framework supports blocking transfers via completions for
> > > > clients that can sleep. In order to support blocking transfers in cases
> > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > callback that controller drivers can implement to busy loop until the
> > > > transmission has been completed. This will automatically be called when
> > > > available and interrupts are disabled for clients that request blocking
> > > > transfers.
> > > >
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > >  include/linux/mailbox_controller.h | 4 ++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > index 674b35f402f5..0eaf21259874 100644
> > > > --- a/drivers/mailbox/mailbox.c
> > > > +++ b/drivers/mailbox/mailbox.c
> > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > >               unsigned long wait;
> > > >               int ret;
> > > >
> > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > +                     if (ret < 0)
> > > > +                             tx_tick(chan, ret);
> > > > +
> > > > +                     return ret;
> > > > +             }
> > >
> > > It seems to me that if mbox_send_message() is called from an atomic
> > > context AND tx_block is true, then if 'flush' is not populated this
> > > should be an error condition as we do not wish to call
> > > wait_for_completion from an atomic context.
> > >
> > > I understand that there is some debate about adding such flush support,
> > > but irrespective of the above change, it seems to me that if the
> > > mbox_send_message() can be called from an atomic context (which it
> > > appears to), then it should be detecting if someone is trying to do so
> > > with 'tx_block' set as this should be an error.
> > >
> > Layers within kernel space have to trust each other. A badly written
> > client can break the consumer in so many ways, we can not catch every
> > possibility.
> >
> > > Furthermore, if the underlying mailbox driver can support sending a
> > > message from an atomic context and busy wait until it is done, surely
> > > the mailbox framework should provide a means to support this?
> > >
> > Being able to put the message on bus in atomic context is a feature -
> > which we do support. But busy-waiting in a loop is not a feature, and
> > we don't want to encourage that.
>
> I agree that in generally busy-waiting is a bad idea and shouldn't be
> encouraged. However, I also think that an exception proves the rule. If
> you look at the console drivers in drivers/tty/serial, all of them will
> busy loop prior to or after sending a character. This is pretty much
> part of the API and as such busy-looping is very much a feature.
>
> The reason why this is done is because on one hand we have an atomic
> context and on the other hand we want to make sure that all characters
> actually make it to the console when we print them.
>
> As an example how this can break, I've taken your suggestion to
> implement a producer/consumer mode in the TCU driver where the console
> write function will just stash characters into a circular buffer and a
> work queue will then use mbox_send_message() to drain the circular
> buffer. While this does work on the surface, I was able to concern both
> of the issues that I was concerned about: 1) it is easy to overflow the
> circular buffer by just dumping enough data at once to the console and
> 2) when a crash happens, everything in the kernel stops, including the
> consumer workqueue that is supposed to drain the circular buffer and
> flush messages to the TCU. The result is that, in my particular case,
> the boot log will just stop at a random place in the middle of messages
> from much earlier in the boot because the TCU hasn't caught up yet and
> there's a lot of characters still in the circular buffer.
>
> Now, 1) can be mitigated by increasing the circular buffer size. A value
> that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT.
>
Yes please.

> I thought that I could also mitigate 2) by busy looping in the TCU driver,
> but it turns out that that doesn't work. The reason is that since we are
> in atomic context with all interrupts disabled, the mailbox won't ever
> consume any new characters, so the read pointer in the circular buffer
> won't increment, leaving me with no condition upon which to loop that
> would work.
>
So you want to be able to rely on an emulated console (running on a
totally different subsystem) to dump development-phase early-boot
logs? At the cost of legitimizing busy looping in atomic context - one
random driver messing up the api for ever. Maybe you could have the
ring buffer in some shmem and only pass the number of valid characters
in it, to the remote?

>
>         http://patchwork.ozlabs.org/project/linux-tegra/list/?series=78477
>
> The difference to the earlier versions is that the flushing is now
> explicit. I think this combines the best of both worlds. On one hand it
> makes the mechanism completely opt-in, so nothing gets hidden in the
> regular functions. On the other hand, it allows clients to make use of
> this functionality very explicitly. A client that doesn't call the
> mbox_flush() function will just not busy-loop. But clients that need to
> make sure messages are flushed in atomic contexts can now do that. Does
> that sound like a more acceptable solution to you? We could even go and
> add documentation to mbox_flush() that it should only be used under
> special circumstances.
>
> If you still think that's a bad idea, do you have any other suggestions
> on how to move forward?
>
It would help if other maintainers chime in if a subsystem should
support busy-wait in atomic context for a one-off driver.

Regards.
