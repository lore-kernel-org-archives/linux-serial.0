From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 6 Sep 2016 14:11:17 -0700
Message-ID: <20160906211117.GE15161@tuxbot>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <20160906174630.GB15161@tuxbot>
 <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFw01BW2_etsPJGMRY=3BXdo_+g9+c_vRCW59gRpj9GVsw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>, Dmitry
List-Id: linux-serial@vger.kernel.org

On Tue 06 Sep 11:32 PDT 2016, Linus Torvalds wrote:

> On Tue, Sep 6, 2016 at 10:46 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Linus, I reversed the order of your questions/answers to fit my answer
> > better.
> 
> Nobody has actually answered the "why don't we just tie the firmware
> and module together" question.
> 

The answer to this depends on the details of the suggestion; but
generally there's a much stronger bond between the kernel and the driver
than between the driver and the firmware in my cases.

E.g. we have a single remoteproc driver loading and controlling the
Hexagon DSP found in several Qualcomm platforms, so a single kernel
binary could (practically) load hundreds of variants of the firmware.

Both the kernel binary and the firmware in this example are side-loaded
onto the device during development - independently of each other, as
they are developed by different teams (or maybe even different
companies).

I assume that you're not suggesting to actually tie the module together,
as that would be practically difficult and a waste of resources.

Which leaves us with the suggestion that we should store the kernel
module with the firmware file, which is just infeasible from a few
practical reasons - again mostly related to the development flow and how
the files are contained on the devices.

> Really. If the driver doesn't work without the firmware, then why the
> hell is it separated from it in the first place?
> 

In several cases we have a single remoteproc driver controlling several
different co-processors. Further more with the aspiration of being able
to run the same kernel binary (including modules) on more than one
product this is simply not feasible.

As I said above, beyond development there are hundreds of variants of
these firmware files in products - each weighting in at 10-50MB.

The firmware loading part (remoteproc) doesn't care about these
differences and the functional drivers attaching to the services
provided by the firmware can handle the differences between them.

> The hack is a hack, and it just sounds *stupid*.
> 

This I totally agree with.

Regards,
Bjorn
