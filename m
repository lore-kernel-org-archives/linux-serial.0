From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Tue, 11 Dec 2018 03:02:20 +0530
Message-ID: <CABb+yY3vhKYM31M+shhZzt_mDX=vRP4_upP2swvFLgyptWw5EQ@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
 <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
 <20181210095229.GA15154@ulmo>
 <CABb+yY2fNYYjh4cY69M5p0Yc-Z-wusDMQhjTgqb1Ag1QEm=T9Q@mail.gmail.com>
 <20181210204522.GA325@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181210204522.GA325@mithrandir>
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

On Tue, Dec 11, 2018 at 2:15 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Dec 11, 2018 at 02:00:48AM +0530, Jassi Brar wrote:
> > On Mon, Dec 10, 2018 at 3:22 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> > > >
> > > > The 'flush' api is going to have no use other than implement
> > > > busy-waits. I am afraid people are simply going to take it easy and
> > > > copy the busy-waits from the test/verification codes.
> > > > "discouraging" seldom works because the developer comes with the
> > > > failproof excuse "the h/w doesn't provide any other way". Frankly I
> > > > would like to push back on such designs.
> > >
> > > I certainly approve of that stance.
> > >
> > > However, I'd like to reiterate that the TCU design does in fact support
> > > "another way". If you look at the mailbox driver implementation (in the
> > > drivers/mailbox/tegra-hsp.c driver), you'll see that it does support an
> > > interrupt driven mode. After you had reviewed Mikko's earliest proposal
> > > that was indeed implementing busy looping exclusively we both set out
> > > to properly implement interrupt support. This took quite a while to do
> > > because of some gaps in the documentation, but we eventually got it to
> > > work properly. And then it was discovered that it was all a waste of
> > > effort because the console driver couldn't make use of it anyway. Well,
> > > I should say "waste of effort" because I'm still happy that the proper
> > > implementation exists and we can use it under the right circumstances.
> > >
> > > So, at least in this particular case, it is not the hardware or firmware
> > > design that's flawed or was taking any shortcuts. It's really just the
> > > particular use-case of the console that doesn't allow us to make use of
> > > the right implementation, which is why we have to resort to the inferior
> > > method of busy-looping.
> > >
> > I am not complaining about the hardware, but the firmware.
> > It is essential we dump logs during early boot but the platform(Linux)
> > doesn't have access to serial port. All the firmware allows is 24bits
> > per transfer!! We could do better.
>
> Hardware UARTs don't usually have much more FIFO space than that either.
>
> > A smarter option could have been Linux simply placing characters in
> > the shmem ring-buffer, while the remote consuming (and then poisoning)
> > the ring buffer upon 'hint' from Linux.
>
> I don't think that would've been much smarter, especially not in this
> case. As we discussed earlier, no matter how large you make the ring-
> buffer you can always run into situations where you overflow it. The
> ring-buffer implementation is also a lot more complicated and error-
> prone.
>
Please think about it again.
The ring buffer becomes the effective h/w fifo. And you don't have to
wait at all for the mailbox register to clear .... you could simply
overwrite it when Linux puts some data in the ring-buffer (the data
written will just be a 'hint' command for remote to go look into the
ring-buffer for new data).

> Plus there is the fact that in this particular case we actually
> don't want buffering because the buffer may hide important information
> in case of a crash.
>
Even if the Linux crashes, whatever data is placed in the ring-buffer
will eventually be printed by the still-alive remote.

Anyways once we have the flush api, I don't really care how broken your f/w is.
