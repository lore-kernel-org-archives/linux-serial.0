From: Rob Landley <rob@landley.net>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 13 Sep 2016 21:38:17 -0500
Message-ID: <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160903002014.GP3296@wotan.suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de, Josh Boyer <jwboyer@fedoraproject.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jslaby@suse.com, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Wu Fengguang <fengguang.wu@intel.com>, rpurdie@rpsys.net, Jeff Mahoney <jeffm@suse.com>, j.anaszewski@samsung.com, Abhay_Salunke@dell.com, Julia Lawall <Julia.Lawall@lip6.fr>, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr, Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>
List-Id: linux-serial@vger.kernel.org

On 09/02/2016 07:20 PM, Luis R. Rodriguez wrote:
> kernel_read_file_from_path() can try to read a file from
> the system's filesystem. This is typically done for firmware
> for instance, which lives in /lib/firmware. One issue with
> this is that the kernel cannot know for sure when the real
> final /lib/firmare/ is ready, and even if you use initramfs
> drivers are currently initialized *first* prior to the initramfs
> kicking off.

Why?

> During init we run through all init calls first
> (do_initcalls()) and finally the initramfs is processed via
> prepare_namespace():

What's the downside of moving initramfs cpio extraction earlier in the boot?

I did some shuffling around of those code to make initmpfs work, does
anybody know why initramfs extraction _before_ we initialize drivers
would be a bad thing? (The cpio is in memory, either linked into the
kernel or from the bootloader. No drivers are needed to extract it,
that's sort of the point.)

The only things I can think of are memory churn (large contiguous
physical page allocations), or if a driver somehow got us access to more
physical memory?

Rob
