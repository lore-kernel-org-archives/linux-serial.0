From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 9 Nov 2016 03:21:07 -0800
Message-ID: <CALCETrVtuiKaJ+z3hSLGYs3robuORJv+N5Z19t0XUzUNynqZDA@mail.gmail.com>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de> <20161108224726.GD13978@wotan.suse.de>
 <cdd43459-346f-c8e9-e8fc-25bd81e9f0ea@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cdd43459-346f-c8e9-e8fc-25bd81e9f0ea@bmw-carit.de>
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
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Gilles.Muller@lip6.fr, Takashi Iwai <tiwai@suse.de>, Daniel Wagner <wagi@monom.org>, Ming Lei <ming.lei@canonical.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Tom Gundersen <teg@jklm.no>, Alessandro Rubini <rubini@gnudd.com>, Christian Lamparter <chunkeey@googlemail.com>, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, Jeff Mahoney <jeffm@suse.com>, Kees Cook <keescook@chromium.org>, Jouni
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 9, 2016 at 1:13 AM, Daniel Wagner
<daniel.wagner@bmw-carit.de> wrote:
> [CC: added Harald]
>
> As Harald pointed out over a beer yesterday evening, there is at least
> one more reason why UMH isn't obsolete. The ordering of the firmware loading
> might be of important. Say you want to greet the user with a splash screen
> really early on, the graphic card firmware should be loaded first. Also the
> automotive world has this fancy requirement that rear camera must be on the
> screen within 2 seconds. So controlling the firmware loading order is of
> importance (e.g. also do not overcommit the I/O bandwith not so important
> firmwares). A user space helper is able to prioritize the request
> accordingly the use case.

That seems like a valid problem, but I don't think that UMH adequately
solves it.  Sure, loading firmware in the right order avoids a >2sec
delay due to firmware loading, but what happens when you have a slow
USB device that *doesn't* need firmware plugged in to your car's shiny
USB port when you start the car?

It seems to me that this use case requires explicit control over
device probing and, if that gets added, you get your firmware ordering
for free (just probe the important devices first).

--Andy
