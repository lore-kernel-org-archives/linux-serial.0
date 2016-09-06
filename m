From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 6 Sep 2016 23:52:04 +0200
Message-ID: <20160906215204.GR3296@wotan.suse.de>
References: <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Christian Lamparter <chunkeey@googlemail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>, Johannes Berg <johannes@sipsolutions.net>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 03, 2016 at 11:10:02AM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 3, 2016 at 11:01 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Sat, Sep 3, 2016 at 10:49 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >>
> >> Unfortunately module loading and availability of firmware is very
> >> loosely coupled.
> >
> > The whole "let's add a new magical proc entry 

To be fair it was using a generic sysfs entry.

> > to say that all
> > filesystems are mounted" is all about the user space coupling them.
> 
> I was thinking if we kernel could post "conditions" (maybe simple strings)
> that it waits for, and userspace could unlock these "conditions". One of them
> might be "firmware available".

Dmitry, you seem to be suggesting a generic kernel-userspace "registry" for
intertwined dependencies that the kernel needs and only userspace can provide,
is that right?

If so it sounds overly complicated to resolve this. Do we have other uses
outside of kernel_read_file_from_path() you had in mind for this?

> > I'm just saying that if user space must know about when firmware is
> > ready to be loaded anyway, just do it right. Not with some hacky "you
> > can now do random things" flag.

Note, this isn't just about firmware since we now have a generic API to read
files from the kernel, so kernel_read_file_from_path(). Firmware is now just
*one* user case. Also a complexity here is this is not just for modules but
also for built-in drivers as well. And you want the option to update the
files without the driver.

The proposed solution provides a generic broad syfs entry for letting userspace
inform the kernel when files from the filesystems where it would typically read
from (I'm calling them critical filesystems for lack of a better term) can be
accessible. Something more specific requires a bit more thought given this is
not anymore about just firmware, must also address built-in drivers, and allow
for updates.

> >  But by having user space actually say
> > "put this module together with this firmware".

Keep in mind this isn't about just firmware anymore, and we have to consider
built-in drivers as well. But if we were to just consider firmware... for the
sake of following with examples.

How would this registry work?

We already have MODULE_FIRMWARE(), we could have MODULE_FIRMWARE_REQ() or
something like it to help annotate the the driver was only functional with the
firmware, punt things to kmod to deal with the requirements.  kmod would only
load the driver if the firmware is present as well, otherwise it could just
return a new -ENOFIRMWARE and try to defer module loading for a later time, it
would load the driver once and if the firmware becomes available... This all
seems rather hacky.

For built-in drivers.. the vmlinux would have the associated firmware reqs, it
would still need a way to let userspace know when such firmware is ready. What
kernel <-> userspace API would we want to use for this ? Or as you note we
could just prevent such drivers to be built-in. I'd be happy with this, however
I don't think the distributions using non-modular kernels will be.

Now whatever we come up with recall this isn't just about firmware anymore.
Which is why I ended up bundling all these requirements up into one generic
"kernel reads file from filesystem" requirement. I can see the syfs approach
being considered hacky -- but I gladly welcome an actual alternative
suggestion.

> > If you just put the two pieces together, then the module "will just work".
> >
> > And quite frankly, that sounds like a much better maintenance practice
> > anyway. If some module doesn't work without the firmware, then dammit,
> > the two *should* go together. Putting them in two different places
> > would be *INSANE*.
> 
> Quite often it does until it does not. Most of the touch controllers
> work just fine until some event (abrupt cutting of power for example)
> where nvram gets corrupted and they come up in bootloader mode. It is
> just an example.

You want to also opt-in for updates, you don't want to require re-building
a driver for a firmware fix, for instance.

 Luis
