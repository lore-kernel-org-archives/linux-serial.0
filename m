From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Wed, 30 Nov 2016 09:18:29 +0100
Message-ID: <1480493909.9990.31.camel@sipsolutions.net>
References: <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de> <20160903002014.GP3296@wotan.suse.de>
 <6332a54e-74c6-eafd-368e-71e87a3fa34e@landley.net>
 <20161005180017.GD3296@wotan.suse.de>
 <CA+55aFzrRekSrEczdtGb3RuOeJttJ7i7dQJxiTOXz8V+kr=hdA@mail.gmail.com>
 <20161005194633.GE3296@wotan.suse.de>
 <20161108224726.GD13978@wotan.suse.de>
 <1479202125.12007.24.camel@sipsolutions.net>
 <CAG-2HqVf=YQk2iLFhpsKFZd3HZTG6XG7xY6B4YeX5-bFrwMJFA@mail.gmail.com>
 <20161129213739.GJ1402@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20161129213739.GJ1402@wotan.suse.de>
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
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Tom Gundersen <teg@jklm.no>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Gilles.Muller@lip6.fr, Takashi Iwai <tiwai@suse.de>, Daniel Wagner <daniel.wagner@bmw-carit.de>, Ming Lei <ming.lei@canonical.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>, Christian Lamparter <chunkeey@googlemail.com>, Kees Cook <keescook@chromium.org>, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, Jeff Mahoney <jeffm@suse.com>, Daniel Wagner <wagi@monom.org>, Jouni
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-11-29 at 22:37 +0100, Luis R. Rodriguez wrote:
> On Tue, Nov 29, 2016 at 10:10:56PM +0100, Tom Gundersen wrote:
> > 
> > On Tue, Nov 15, 2016 at 10:28 AM, Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > > 
> > > My argument basically goes like this:
> > > 
> > > First, given good drivers (i.e. using request_firmware_nowait())
> > > putting firmware even for a built-in driver into initramfs or not
> > > should be a system integrator decision. If they don't need the
> > > device
> > > that early, it should be possible for them to delay it. Or,
> > > perhaps, if
> > > the firmware is too big, etc. I'm sure we can all come up with
> > > more
> > > examples of why you'd want to do it one way or another.
> > 
> > This is how I understood the the situation, but I never quite
> > bought
> > it. What is wrong with the kernel saying "you must put your module
> > and
> > your firmware together"? Sure, people may want to do things
> > differently, but what is the real blocker?
> 
> 0) Firmware upgrades are possible
> 1) Some firmware is optional
> 2) Firmware licenses may often not be GPLv2 compatible
> 3) Some firmwares may be stupid large (remote-proc) as such
>    neither built-in firmware nor using the firmware in initramfs
>    is reasonable.

4) "firmware" may be on a separate flash partition because it's really
   calibration data required by the (wifi) chip/driver
   (to allow kernel updates without having to taylor the kernel image
   to each and every device!!

johannes
