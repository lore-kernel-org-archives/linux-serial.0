From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Date: Thu, 25 Aug 2016 22:10:52 +0200
Message-ID: <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org> <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160825194133.GC3296@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>
Cc: Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, zohar@linux.vnet.ibm.com, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de, Josh Boyer <jwboyer@fedoraproject.org>
List-Id: linux-serial@vger.kernel.org

Cutting down since a lot of this is probably better discussed at
ks/lpc. Aside, if you want to check out Chris Wilson's work on our new
depency handling, it's called kfence.

https://lkml.org/lkml/2016/7/17/37

On Thu, Aug 25, 2016 at 9:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > So .. I agree, let's avoid the hacks. Patches welcomed.
>>
>> Hm, this is a definite change of tack - back when I discussed this
>> with Greg about 2 ks ago it sounded like "don't do this". The only
>> thing we need is some way to wait for rootfs before we do the
>> request_firmware. Everything else we handle already in the kernel.
>
> OK so lets just get this userspace event done, and we're set.

Ah great. As long as that special wait-for-rootfs-pls firmware request
is still allowed, i915&gfx folks will be happy. We will call it from
probe though ;-) but all from our own workers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
