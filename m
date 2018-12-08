From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Sat, 8 Dec 2018 11:39:05 +0530
Message-ID: <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207113245.GA30719@ulmo>
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

On Fri, Dec 7, 2018 at 5:02 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 11:56:25PM -0600, Jassi Brar wrote:
> > On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > > > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > >
> > > > >
> > > > > On 12/11/2018 15:18, Thierry Reding wrote:
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >
> > > > > > The mailbox framework supports blocking transfers via completions for
> > > > > > clients that can sleep. In order to support blocking transfers in cases
> > > > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > > > callback that controller drivers can implement to busy loop until the
> > > > > > transmission has been completed. This will automatically be called when
> > > > > > available and interrupts are disabled for clients that request blocking
> > > > > > transfers.
> > > > > >
> > > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > > ---
> > > > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > > > >  include/linux/mailbox_controller.h | 4 ++++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > > > index 674b35f402f5..0eaf21259874 100644
> > > > > > --- a/drivers/mailbox/mailbox.c
> > > > > > +++ b/drivers/mailbox/mailbox.c
> > > > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > > > >               unsigned long wait;
> > > > > >               int ret;
> > > > > >
> > > > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > > > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > > > +                     if (ret < 0)
> > > > > > +                             tx_tick(chan, ret);
> > > > > > +
> > > > > > +                     return ret;
> > > > > > +             }
> > > > >
> > > > > It seems to me that if mbox_send_message() is called from an atomic
> > > > > context AND tx_block is true, then if 'flush' is not populated this
> > > > > should be an error condition as we do not wish to call
> > > > > wait_for_completion from an atomic context.
> > > > >
> > > > > I understand that there is some debate about adding such flush support,
> > > > > but irrespective of the above change, it seems to me that if the
> > > > > mbox_send_message() can be called from an atomic context (which it
> > > > > appears to), then it should be detecting if someone is trying to do so
> > > > > with 'tx_block' set as this should be an error.
> > > > >
> > > > Layers within kernel space have to trust each other. A badly written
> > > > client can break the consumer in so many ways, we can not catch every
> > > > possibility.
> > > >
> > > > > Furthermore, if the underlying mailbox driver can support sending a
> > > > > message from an atomic context and busy wait until it is done, surely
> > > > > the mailbox framework should provide a means to support this?
> > > > >
> > > > Being able to put the message on bus in atomic context is a feature -
> > > > which we do support. But busy-waiting in a loop is not a feature, and
> > > > we don't want to encourage that.
> > >
> > > I agree that in generally busy-waiting is a bad idea and shouldn't be
> > > encouraged. However, I also think that an exception proves the rule. If
> > > you look at the console drivers in drivers/tty/serial, all of them will
> > > busy loop prior to or after sending a character. This is pretty much
> > > part of the API and as such busy-looping is very much a feature.
> > >
> > > The reason why this is done is because on one hand we have an atomic
> > > context and on the other hand we want to make sure that all characters
> > > actually make it to the console when we print them.
> > >
> > > As an example how this can break, I've taken your suggestion to
> > > implement a producer/consumer mode in the TCU driver where the console
> > > write function will just stash characters into a circular buffer and a
> > > work queue will then use mbox_send_message() to drain the circular
> > > buffer. While this does work on the surface, I was able to concern both
> > > of the issues that I was concerned about: 1) it is easy to overflow the
> > > circular buffer by just dumping enough data at once to the console and
> > > 2) when a crash happens, everything in the kernel stops, including the
> > > consumer workqueue that is supposed to drain the circular buffer and
> > > flush messages to the TCU. The result is that, in my particular case,
> > > the boot log will just stop at a random place in the middle of messages
> > > from much earlier in the boot because the TCU hasn't caught up yet and
> > > there's a lot of characters still in the circular buffer.
> > >
> > > Now, 1) can be mitigated by increasing the circular buffer size. A value
> > > that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT.
> > >
> > Yes please.
>
> As I explained elsewhere, I actually went and implemented this. But
> given the nature of buffering, this ends up making the TCU completely
> useless as a console because in case of a crash, the system will stop
> working with a large number of characters still stuck in the buffer.
> And that's especially bad in case of a crash because those last
> characters that get stuck in the buffer are the most relevant ones
> because they contain the stack dump.
>
I don't question the utility of TCU. I just wonder if mailbox api
should provide a backdoor for atomic busy-wait in order to support a
sub-optimal hw+fw design.

> > > I thought that I could also mitigate 2) by busy looping in the TCU driver,
> > > but it turns out that that doesn't work. The reason is that since we are
> > > in atomic context with all interrupts disabled, the mailbox won't ever
> > > consume any new characters, so the read pointer in the circular buffer
> > > won't increment, leaving me with no condition upon which to loop that
> > > would work.
> > >
> > So you want to be able to rely on an emulated console (running on a
> > totally different subsystem) to dump development-phase early-boot
> > logs? At the cost of legitimizing busy looping in atomic context - one
> > random driver messing up the api for ever. Maybe you could have the
> > ring buffer in some shmem and only pass the number of valid characters
> > in it, to the remote?
>
> First of all, this is not about development-phase early-boot messages.
> We're talking about the system console here. This is what everyone will
> want to be using when developing on this device. Sure at some point you
> may end up with a system that works and you can have the console on the
> network or an attached display or whatever, but even then you may still
> want to attach to the console if you ever run into issues where the
> system doesn't come up.
>
> Secondly, I don't understand why you think this is an emulated console.
>
It is emulated/virtual because Linux doesn't put characters on a
physical bus. The data is simply handed forward to a remote entity.

> Lastly, I don't understand why you think we're messing up the API here.
> The proposal in this series doesn't even change any of the API, but it
> makes it aware of the state of interrupts internally so that it can do
> the right thing depending on the call stack. The other proposal, in v3,
> is more explicit in that it adds new API to flush the mailbox. The new
> API is completely optional and I even offered to document it as being
> discouraged because it involves busy looping. At the same time it does
> solve a real problem and it doesn't impact any existing mailbox drivers
> nor any of their users (because it is completely opt-in).
>
The 'flush' api is going to have no use other than implement
busy-waits. I am afraid people are simply going to take it easy and
copy the busy-waits from the test/verification codes.
"discouraging" seldom works because the developer comes with the
failproof excuse "the h/w doesn't provide any other way". Frankly I
would like to push back on such designs.

 Anyways, let us add the new 'flush' api.

Thanks.
