From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Fri, 2 Sep 2016 21:20:01 -0700
Message-ID: <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org> <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de> <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 2, 2016 at 9:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Sep 2, 2016 at 5:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>>
>> Thoughts ?
>
> I really think this is a horrible hack.
>
> It's basically the kernel giving up, and relying on user space to give
> a single flag, and it's broken nasty crap.  Worse, it's broken nasty
> crap with a user interface, so we'll be stuck with it forever. Please
> no.

I agree that interface is bad, but I do believe we need something like this...

>
> What are the drivers that need this, and why can't those drivers just
> be fixed to not do braindead things?

Like what? Some devices do need to have firmware loaded so we know
their capabilities, so we really can't push the firmware loading into
"open". If your touch controller for some reason decided to crap over
it's nvram and comes in bootloader mode it is nice for it to slurp in
config data or firmware so use does not have to trigger update
manually. And while the controller is in bootloader mode we can't
create input device because we do not know what capabilities to
declare.

These devices we want to probe asynchronously and simply tell firmware
loader to wait for firmware to become available. The problem we do not
know when to give up, since we do not know where the firmware might
be. But userspace knows and can tel us.

Thanks.

-- 
Dmitry
