From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 9 Nov 2016 15:40:45 -0800
Message-ID: <CAB=NE6WgZKivDO0LJUf6Eeh3+g0uVmewOsdwKiNyQ+BEQ_To4w@mail.gmail.com>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de> <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de> <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de> <20161108224726.GD13978@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108224726.GD13978@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Johannes Berg <johannes@sipsolutions.net>, Jouni Malinen <j@w1.fi>, Seth Forshee <seth.forshee@canonical.com>, Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Wagner <wagi@monom.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Harald Hoyer <harald@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Herbert, Marc" <marc.herbert@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>, David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>, Ming Lei <ming.lei@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vikram Mulukutla <markivx@codeaurora.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Christian Lamparter <chunkeey@googlemail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Josh Boyer <jwboyer@fed>
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 8, 2016 at 2:47 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Whatever the outcome of this discussion is -- Johannes seemed to *want*
> to further use the UMH by default on *all* async alls... even if the
> driver did not explicitly requested it -- I'm concerned about this given
> all the above and the existing flip/flop on systemd for it. Whatever
> we try to dream up here, please consider all the above as well.

One addition to this: the current API does not always require the UMH
firmware fallback, for most distributions that do not enable
CONFIG_FW_LOADER_USER_HELPER_FALLBACK but do enable
CONFIG_FW_LOADER_USER_HELPER we only require the UMH firmware fallback
*iff* the driver explicitly requests it. For kernels with
CONFIG_FW_LOADER_USER_HELPER_FALLBACK enabled we *always* use the UMH
fallback. By fallback note that this means its used only if the first
direct filesystem request failed. For further details on complexities
of the UMH refer to two ongoing threads [0] [1] about it.

Johannes, you seemed to note you added some uevent classifier for
async requests, I checked and it seems this was with commit
e9045f9178f3e ("firmware class: export nowait to userspace") was this
the change you were referring to ? Even with all these complexities
annotated, do you still believe we need the UMH always for all async
calls ?

[0] https://lkml.kernel.org/r/20161109211741.GI13978@wotan.suse.de
[1] https://lkml.kernel.org/r/20161109220210.GJ13978@wotan.suse.de

  Luis
