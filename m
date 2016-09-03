From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Sat, 3 Sep 2016 11:01:58 -0700
Message-ID: <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20160903174939.GB32345@dtor-ws>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ming Lei <ming.lei@canonical.com>, Jeff Mahoney <jeffm@suse.com>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Christian Lamparter <chunkeey@googlemail.com>, cocci@systeme.lip6.fr, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Alessandro Rubini <rubini@gnudd.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kees Cook <keescook@chromium.org>, Hauke Mehrtens <hauke@hauke-m.de>, nicolas.palix@imag.fr, "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>, Julia Lawall <Julia.Lawall>
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 3, 2016 at 10:49 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Unfortunately module loading and availability of firmware is very
> loosely coupled.

The whole "let's add a new magical proc entry to say that all
filesystems are mounted" is all about the user space coupling them.

I'm just saying that if user space must know about when firmware is
ready to be loaded anyway, just do it rigth. Not with some hacky "you
can now do random things" flag. But by having user space actually say
"put this module together with this firmware".

If you just put the two pieces together, then the module "will just work".

And quite frankly, that sounds like a much better maintenance practice
anyway. If some module doesn't work without the firmware, then dammit,
the two *should* go together. Putting them in two different places
would be *INSANE*.

                    Linus
