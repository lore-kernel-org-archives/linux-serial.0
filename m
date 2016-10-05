From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 5 Oct 2016 11:08:06 -0700
Message-ID: <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org> <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de> <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161005180017.GD3296@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Rob Landley <rob@landley.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboy>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 5, 2016 at 11:00 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Sep 13, 2016 at 09:38:17PM -0500, Rob Landley wrote:
>
>> I did some shuffling around of those code to make initmpfs work, does
>> anybody know why initramfs extraction _before_ we initialize drivers
>> would be a bad thing?
>
> No, but it seems sensible to me, if its done before do_initcalls()
> that should resolve the race for initramfs users

initramfs should already be set up before drivers are. Exactly what is
it that has trouble right now?

The gating issue for initramfs is that technically the filesystem
setup needs to be done, which means that it currently ends up being
populated _fairly_ late in the initcall series, but certainly before
drivers. But since initramfs really only needs very limited filesystem
functionality, I assume Rob had few problems with just moving it
earlier.

Still, what kind of ordering issues did people have? What is it that
needs to load files even before driver init? Some crazy subsystem?

                   Linus
