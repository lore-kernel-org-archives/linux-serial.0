From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 5 Oct 2016 21:46:33 +0200
Message-ID: <20161005194633.GE3296@wotan.suse.de>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Herbert, Marc" <marc.herbert@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>, Dmitry Torokhov <dmitr>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 05, 2016 at 11:08:06AM -0700, Linus Torvalds wrote:
> On Wed, Oct 5, 2016 at 11:00 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > On Tue, Sep 13, 2016 at 09:38:17PM -0500, Rob Landley wrote:
> >
> >> I did some shuffling around of those code to make initmpfs work, does
> >> anybody know why initramfs extraction _before_ we initialize drivers
> >> would be a bad thing?
> >
> > No, but it seems sensible to me, if its done before do_initcalls()
> > that should resolve the race for initramfs users
> 
> initramfs should already be set up before drivers are.

Actually you are right, the issue would only be for old initrd, for initramfs
we populate that via rootfs_initcall(populate_rootfs), so as long as drivers
in question use an init level beyond rootfs's we're good there.

> Exactly what is it that has trouble right now?

It would seem then that the only current stated race possible should
then be non-initramfs users. One example if very large firmware for
remote-proc, whereby an initramfs is just not practical or desirable.

> The gating issue for initramfs is that technically the filesystem
> setup needs to be done, which means that it currently ends up being
> populated _fairly_ late in the initcall series, but certainly before
> drivers. But since initramfs really only needs very limited filesystem
> functionality, I assume Rob had few problems with just moving it
> earlier.
> 
> Still, what kind of ordering issues did people have? What is it that
> needs to load files even before driver init? Some crazy subsystem?

No, I think this is just about non-initramfs users now, if we disregard
old initrd users. Bjorn, Marc, correct me if I'm wrong, as I think its
so far you both who have seemed to run into race issues and have then
ended up trying to look for hacks to address this race or considered using
the usermode helper (which we're trying to minimize users for). Daniel
seems to note a lot of video drivers use firmware on probe as well so
there's a potential issue for those users if they don't use initramfs.

  Luis
