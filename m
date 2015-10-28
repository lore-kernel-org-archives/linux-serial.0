From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Wed, 28 Oct 2015 17:23:52 +0100
Message-ID: <1446049432.9748.4.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
	 <5630BE5E.6040204@hurleysoftware.com> <5630EF8A.8060904@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5630EF8A.8060904-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-10-28 at 16:53 +0100, Sven Brauch wrote:
> > I would much rather rework URB flow + unthrottle, as I previously
> > outlined in the original thread instead of introducing another
> > buffering layer.
> From my non-kernel-dev point of view, this seems the way to go if the
> strategy in my patch (technical flaws aside) is not acceptable.
> Everything else, i.e. larger buffers or less delay, will certainly be
> a
> welcome improvement but still does not guarantee data delivery.

It just isn't the task of a driver to detect that we are running out of
buffer space. It would be interesting to know how we can tell the upper
layers how much data we can have in flight, but basically that
information should be used by a common algorithm so we don't need to
reinvent the wheel multiple times.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
