From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 6 Sep 2016 15:28:47 -0700
Message-ID: <20160906222847.GF15161@tuxbot>
References: <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <20160906215204.GR3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160906215204.GR3296@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Christian Lamparter <chunkeey@googlemail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.>
List-Id: linux-serial@vger.kernel.org

On Tue 06 Sep 14:52 PDT 2016, Luis R. Rodriguez wrote:

> We already have MODULE_FIRMWARE(), we could have MODULE_FIRMWARE_REQ() or
> something like it to help annotate the the driver was only functional with the
> firmware, punt things to kmod to deal with the requirements.

That implies that a single driver will only use a single version of the
firmware. There are cases where we want a single driver to load firmware
depending on e.g. hardware revisions, or previous firmware version and
there are cases where we want to load firmware based on requested
use-cases.

Regards,
Bjorn
