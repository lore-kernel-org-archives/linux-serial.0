From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Date: Fri, 2 Sep 2016 20:26:06 +0200
Message-ID: <20160902182606.GN3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1471999507-913-1-git-send-email-mcgrof@kernel.org>
 <1471999507-913-3-git-send-email-mcgrof@kernel.org>
 <20160824081738.GA8991@visitor2.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824081738.GA8991@visitor2.iram.es>
Sender: linux-doc-owner@vger.kernel.org
To: Gabriel Paubert <paubert@iram.es>
Cc: mcgrof@kernel.org, ming.lei@canonical.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr, tiwai@suse.de, Daniel Vetter <daniel.vetter@ffwll.ch>, Alessandro Rubini <rubini@gnudd.com>, stephen.boyd@linaro.org, bjorn.andersson@linaro.org, teg@jklm.no, chunkeey@googlemail.com, cocci@systeme.lip6.fr, jwboyer@fedoraproject.org, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial@vger.kernel.org, jslaby@suse.com, zohar@linux.vnet.ibm.com, arend.vanspriel@broadcom.com, linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>, hauke@hauke-m.de, nicolas.palix@imag.fr, Abhay_Salunke@dell.com, Julia.Lawall@lip6.frbr
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 24, 2016 at 10:17:38AM +0200, Gabriel Paubert wrote:
> On Tue, Aug 23, 2016 at 05:45:04PM -0700, mcgrof@kernel.org wrote:
> 
> [snip]
> > ---
> >  Documentation/firmware_class/README                |  20 ++++
> >  drivers/base/Kconfig                               |   2 +-
> >  .../request_firmware-avoid-init-probe-init.cocci   | 130 +++++++++++++++++++++
> >  3 files changed, 151 insertions(+), 1 deletion(-)
> >  create mode 100644 scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
> > 
> > diff --git a/Documentation/firmware_class/README b/Documentation/firmware_class/README
> > index cafdca8b3b15..056d1cb9d365 100644
> > --- a/Documentation/firmware_class/README
> > +++ b/Documentation/firmware_class/README
> > @@ -93,6 +93,26 @@
> >     user contexts to request firmware asynchronously, but can't be called
> >     in atomic contexts.
> >  
> > +Requirements:
> > +=============
> > +
> > +You should avoid at all costs requesting firmware on both init and probe paths
> > +of your device driver. Reason for this is the complexity needed to ensure a
> > +firmware will be available for a driver early in boot through different
> > +build configurations. Consider built-in drivers needing firmware early, or
> > +consider a driver assuming it will only get firmware after pivot_root().
> > +
> > +Drivers that really need firmware early should use stuff the firmware in
> 
> Minor grammatical nit: s/use//

Fixed, thanks.

  Luis
