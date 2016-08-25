From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Date: Thu, 25 Aug 2016 22:25:49 +0200
Message-ID: <20160825202549.GF3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, =?iso-8859-1?Q?J=F6rg_R=F6del?= <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, zohar@linux.vnet.ibm.com, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 25, 2016 at 10:10:52PM +0200, Daniel Vetter wrote:
> Cutting down since a lot of this is probably better discussed at
> ks/lpc. Aside, if you want to check out Chris Wilson's work on our new
> depency handling, it's called kfence.
> 
> https://lkml.org/lkml/2016/7/17/37

Thanks more reading.. :)

> On Thu, Aug 25, 2016 at 9:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> > So .. I agree, let's avoid the hacks. Patches welcomed.
> >>
> >> Hm, this is a definite change of tack - back when I discussed this
> >> with Greg about 2 ks ago it sounded like "don't do this". The only
> >> thing we need is some way to wait for rootfs before we do the
> >> request_firmware. Everything else we handle already in the kernel.
> >
> > OK so lets just get this userspace event done, and we're set.
> 
> Ah great. As long as that special wait-for-rootfs-pls firmware request
> is still allowed, i915&gfx folks will be happy. We will call it from
> probe though ;-) but all from our own workers.

We should strive for this to be transparent to drivers, ie, this safeguard of
looking for firmware should be something handled by the kernel as otherwise
we're just forcing a race condition given the review in the last thread.

  Luis
