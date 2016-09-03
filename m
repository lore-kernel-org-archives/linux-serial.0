From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Sat, 3 Sep 2016 11:10:02 -0700
Message-ID: <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de> <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de> <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws> <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, cocci@systeme.lip6.fr, Jacek Anaszewski <j.anaszewski@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Christian Lamparter <chunkeey@googlemail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, Richard Purdie <rpurdie@rpsys.net>, Wu Fengguang <fengguang.wu@intel.com>, Johannes Berg <johannes@sipsolutions.net>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Michal Marek <mmarek@suse.com>, Hauke Mehrtens <hauke@hauke-m.de>, Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>, Ming Lei <ming.lei@canonical.com>, Daniel Vetter <daniel.v>
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 3, 2016 at 11:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Sep 3, 2016 at 10:49 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> Unfortunately module loading and availability of firmware is very
>> loosely coupled.
>
> The whole "let's add a new magical proc entry to say that all
> filesystems are mounted" is all about the user space coupling them.

I will be first to say that the proposed *implementation* is nowhere
near what should be accepted. I was thinking if we kernel could post
"conditions" (maybe simple stings) that it waits for, and userspace
could unlock these "conditions". One of them might be "firmware
available".

>
> I'm just saying that if user space must know about when firmware is
> ready to be loaded anyway, just do it rigth. Not with some hacky "you
> can now do random things" flag. But by having user space actually say
> "put this module together with this firmware".
>
> If you just put the two pieces together, then the module "will just work".
>
> And quite frankly, that sounds like a much better maintenance practice
> anyway. If some module doesn't work without the firmware, then dammit,
> the two *should* go together. Putting them in two different places
> would be *INSANE*.

Quite often it does until it does not. Most of the touch controllers
work just fine until some event (abrupt cutting of power for example)
where nvram gets corrupted and they come up in bootloader mode. It is
just an example.

Thanks.

-- 
Dmitry
