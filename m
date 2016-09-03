From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Sat, 3 Sep 2016 10:49:39 -0700
Message-ID: <20160903174939.GB32345@dtor-ws>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ming Lei <ming.lei@canonical.com>, Jeff Mahoney <jeffm@suse.com>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Christian Lamparter <chunkeey@googlemail.com>, cocci@systeme.lip6.fr, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Alessandro Rubini <rubini@gnudd.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kees Cook <keescook@chromium.org>, Hauke Mehrtens <hauke@hauke-m.de>, nicolas.palix@imag.fr, "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>, Julia Lawall <Julia.Lawall>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 02, 2016 at 09:41:18PM -0700, Linus Torvalds wrote:
> On Sep 2, 2016 9:20 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> >
> > Like what? Some devices do need to have firmware loaded so we know
> > their capabilities, so we really can't push the firmware loading into
> > "open".
> 
> So you
> (a) document that

Document that device may come up half-broken? Not sure how that would
help end user.

> (b) make the driver only build as a module

Unfortunately module loading and availability of firmware is very
loosely coupled. Of course, if you only load modules from the same
partition that your firmware is on you can get away with it, but if some
of the modules are in initramfs and firmware is on final root fs then
it still does not work. And populating also initramfs with firmware that
might be used once in a 1000 boots is somewhat wasteful. That is not
talking about systems that do not wish to use modules for one reason or
another, or even more esoteric setups where non-essential for boot
firmware can be mounted later over nfs, etc, etc.

> (c) make sure the module and the firmware go together

I do not think it is always possible. Quite often it is though, at the
expense of increasing kernel/initramfs size.

> 
> End of problem.
> 
> Why make up random interfaces for crazy stuff?

Because we want a solution that works well for all cases, simple and
complex. This includes allowing drivers to be built into the kernel but
allow them waiting for additional data (config/firmware) that may become
available later in the game. We just need to be able to tell them when
it does not make sense to wait anymore as the data they want is not
coming, and do it more reliably then simply declaring 10 or 30 or 300
seconds time out.

Thanks.

-- 
Dmitry
