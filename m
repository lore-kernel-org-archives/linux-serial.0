From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Date: Thu, 25 Aug 2016 13:30:51 -0700
Message-ID: <CAKdAkRS+UT2LhC9OBdmzjjbcEX24tHusYuzwiBMEEFysNW6wBQ@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org> <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160825194133.GC3296@wotan.suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hau
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 25, 2016 at 12:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Thu, Aug 25, 2016 at 01:05:44PM +0200, Daniel Vetter wrote:
>> On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:

>> > Can they use initramfs for this ?
>>
>> Apparently that's also uncool with the embedded folks.
>
> What's uncool with embedded folks? To use initramfs for firmware ?
> If so can you explain why ?

Because it is not needed? If you are embedded you have an option of
only compiling drivers and services that you need directly into the
kernel, then initramfs is just an extra piece that complicates your
boot process.

Thanks.

-- 
Dmitry
