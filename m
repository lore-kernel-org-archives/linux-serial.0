From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 6 Sep 2016 10:46:31 -0700
Message-ID: <20160906174630.GB15161@tuxbot>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fedoraproject.org>, Dmitry
List-Id: linux-serial@vger.kernel.org

On Fri 02 Sep 21:11 PDT 2016, Linus Torvalds wrote:

Linus, I reversed the order of your questions/answers to fit my answer
better.

> On Fri, Sep 2, 2016 at 5:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >
> > Thoughts ?
> What are the drivers that need this, and why can't those drivers just
> be fixed to not do braindead things?
> 

I have several cases where remoteproc drivers are used boot DSPs upon
boot of the device, but the firmware files are way too big for being
stored in initramfs and all consumers of the provided services are
(semi-) probable as the remote processor is booted.

I.e. we need some way to figure out when these files become available so
we can bring these remote processors up.

> It's basically the kernel giving up, and relying on user space to give
> a single flag, and it's broken nasty crap.  Worse, it's broken nasty
> crap with a user interface, so we'll be stuck with it forever. Please
> no.
> 

There are several cases where there granularity of a single flag is not
enough and we do already have a working mechanism for relying on user
space to inform the kernel that firmware is available:
CONFIG_FW_LOADER_USER_HELPER_FALLBACK

Another available solution is, as you say, using kernel modules.  But I
really do not like the deployment issues that comes with kernel modules
during development. (The firmware and remoteproc driver normally does
not have the same flow through a development process)

> 
> I really think this is a horrible hack.
> 

I agree, but that said, I would appreciate a automagical mechanism that
would relieve user space from having to signal to the kernel that the
firmware partition has been mounted.

Regards,
Bjorn
