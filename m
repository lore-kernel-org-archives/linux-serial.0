From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
Date: Wed, 22 Aug 2012 18:34:38 +1200
Message-ID: <1345617278.7491.4.camel@gitbox>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
	 <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
	 <20120821231255.71a7515a@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120821231255.71a7515a-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vt8500-wm8505-linux-kernel-/JYPxA39Uh6Zox4op4iWzw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2012-08-21 at 23:12 +0100, Alan Cox wrote:
> On Wed, 22 Aug 2012 08:47:32 +1200
> Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org> wrote:
> 
> > Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> > ---
> >  drivers/tty/serial/vt8500_serial.c |   37 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> Can we have a comment attached to a change this size. In particular one
> describing why it gone from 4 to 6 ports, and why the port id twiddling.
> 
> Is there a reason you can't use the device tree port id ?
> 
> What are the regression risks for existing users expecting the pdev->id
> binding ?
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Sorry Alan,

The original patch was very simple, but I revisited it to fix other
issues and forgot to add the relevant comments.

Port size is changed to fix a problem - WM8505 actually had 6 uart's
defined in platform data but the vt8500_ports variable was only 4.

I have added devicetree port id support as well.

No regression risks as the entire platform is being converted to
devicetree and existing code dropped in this patchset.

Patchv4 3/9 to follow.

Regards

Tony Prisk

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
