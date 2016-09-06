From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 7 Sep 2016 01:14:00 +0200
Message-ID: <20160906231400.GU3296@wotan.suse.de>
References: <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
 <20160906215204.GR3296@wotan.suse.de>
 <20160906222847.GF15161@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160906222847.GF15161@tuxbot>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Christian Lamparter <chunkeey@googlemail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 06, 2016 at 03:28:47PM -0700, Bjorn Andersson wrote:
> On Tue 06 Sep 14:52 PDT 2016, Luis R. Rodriguez wrote:
> 
> > We already have MODULE_FIRMWARE(), we could have MODULE_FIRMWARE_REQ() or
> > something like it to help annotate the the driver was only functional with the
> > firmware, punt things to kmod to deal with the requirements.
> 
> That implies that a single driver will only use a single version of the
> firmware. 

Today firmware requests are done manually by the driver, in the future it should
be possible to specify just an array of firmwares and on that list specify
which firmware is optional, and perhaps if you need at last one. Then you treat
optional firmware upgrades as optional -- and only treat fatal conditions as
such. Today drivers manage all this on their own.  This is something we can
later do as we have the flexible firmware API in place, but for now -- you are
right. There is no clear way to extract the semantics of what firmware
requirements really are in an easy way.

> There are cases where we want a single driver to load firmware
> depending on e.g. hardware revisions,

Dynamic firmware names -- indeed. Good point.

> or previous firmware version and
> there are cases where we want to load firmware based on requested
> use-cases.

True.

  Luis
