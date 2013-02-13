From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 13 Feb 2013 23:04:33 +0000
Message-ID: <CACxGe6sw2GaJzLjVJi-Kd=AvkVn6LY5mJdktE8=bz-=Xy+d2zQ@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk>
 <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
 <20130206163811.GI17833@n2100.arm.linux.org.uk>
 <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com>
 <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com>
 <20130209224138.GI17833@n2100.arm.linux.org.uk>
 <20130213210459.D8F693E3557@localhost>
 <20130213225221.GE17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130213225221.GE17833@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Patch Tracking <patches@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, jslaby@suse.cz, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 13, 2013 at 10:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 13, 2013 at 09:04:59PM +0000, Grant Likely wrote:
>> On Sat, 9 Feb 2013 22:41:38 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > On Sat, Feb 09, 2013 at 10:31:05PM +0000, Grant Likely wrote:
>> > > If it is a probe function, then yes the __init annotations need to be
>> > > removed or the driver needs to use platform_driver_probe(). This has
>> > > been the model as long as I can remember. As long as a driver has a
>> > > .probe hook, the driver core can call it at any time. Deferred probe
>> > > has only exposed the issue.
>> > >
>> > > If you want to discard the .probe() hook, then the probe() pointer
>> > > needs to be cleared from the driver structure before discarding the
>> > > sections. Otherwise the driver core can still call it which is what
>> > > happens in deferred probe and can happen if a device gets unbound from
>> > > a driver and then re-attached.
>> >
>> > You're talking about something completely different on the assumption
>> > that what is being talked about is the probe hook.  It isn't.  It's
>> > a path for the console initialization which has _always_ been __init
>> > marked since the dawn of time, because modules are not supposed to
>> > be calling that path.
>>
>> Sorry, you're right. Hitting reply too quickly I guess.
>>
>> However, the point still stands that anything that can be called from
>> a .probe() path cannot be in an __init section with the current driver
>> model. A driver can even be unbound from a device and reattached at
>> runtime. That would also cause problems.
>
> However, it reveals much bigger problems - that is, if you defer the
> probe of the console, what happens when we need to open the console...
>
> Although you can say that, there's _much_ bigger problems here if you
> delay console initialization - you'll effectively end up calling init
> with no system console in place, which means you'll see no output from
> init until the deferred probe sorts itself out.
>
> Yes, it's an unintended side effect of deferred probing, but nevertheless
> one which needs to be resolved such that the console _is_ initialized
> before it's required, which happens _before_ the init section is
> discarded.

I've replied with a suggested solution to Haojian's patch to driver
core. If he can test it and post a proper patch, then I'll ack it.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
