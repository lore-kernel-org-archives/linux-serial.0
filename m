From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Wed, 28 Oct 2015 12:04:40 +0100
Message-ID: <1446030280.15140.10.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562F9C08.6050105-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-10-27 at 16:45 +0100, Sven Brauch wrote:
> Hey Oliver,
> 
> On 27/10/15 16:07, Oliver Neukum wrote:
> > the theory that the lack of support for put_char() is a
> > major contributor to character loss in cdc-acm can be tested.
> > Sven, could you test the attached patch? It implements
> > the support.
> Thanks a lot for caring about this. I applied the patch to a plain linux
> 4.2 tree, but unfortunately I couldn't see any improvements. Applying

That is unfortunate. So your problem is with not enough buffers.

> the patch I originally sent to the list for comparison still fixed the
> issue.

Peter, what to do about this? I think there are issues with Sven's
original patch. In particular I can't see how it can guarantee
progress. Is there a way to just really increase tty buffers,
e.g. quadruple them?

Sven, could we run a few more tests before we look at your patch
again? It really has issues, but it does help and nothing else
does. If necessary I will merge an improved version of your patch.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
