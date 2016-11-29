From: Tom Gundersen <teg@jklm.no>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Tue, 29 Nov 2016 22:10:56 +0100
Message-ID: <CAG-2HqVf=YQk2iLFhpsKFZd3HZTG6XG7xY6B4YeX5-bFrwMJFA@mail.gmail.com>
References: <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de> <20161108224726.GD13978@wotan.suse.de>
 <1479202125.12007.24.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1479202125.12007.24.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Gilles.Muller@lip6.fr, Takashi Iwai <tiwai@suse.de>, Daniel Wagner <daniel.wagner@bmw-carit.de>, Ming Lei <ming.lei@canonical.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>, Christian Lamparter <chunkeey@googlemail.com>, Kees Cook <keescook@chromium.org>, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, Jeff Mahoney <jeffm@suse.com>, Daniel Wagner <wagi@monom.org>, Jouni
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 15, 2016 at 10:28 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> My argument basically goes like this:
>
> First, given good drivers (i.e. using request_firmware_nowait())
> putting firmware even for a built-in driver into initramfs or not
> should be a system integrator decision. If they don't need the device
> that early, it should be possible for them to delay it. Or, perhaps, if
> the firmware is too big, etc. I'm sure we can all come up with more
> examples of why you'd want to do it one way or another.

This is how I understood the the situation, but I never quite bought
it. What is wrong with the kernel saying "you must put your module and
your firmware together"? Sure, people may want to do things
differently, but what is the real blocker?

Fundamentally, it seems to me that if a module needs firmware, it
makes no sense to make the module available before the firmware. I'm
probably missing something though :)

Cheers,

Tom
