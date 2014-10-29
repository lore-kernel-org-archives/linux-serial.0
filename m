From: Janne Huttunen <jahuttun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Wed, 29 Oct 2014 11:38:28 +0200
Message-ID: <CAHdUje-sNj75B86HyXOtezrbqNPSUhRFaaNGjV53bM0i9E4RwQ@mail.gmail.com>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
	<20141029085128.GC7841@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141029085128.GC7841@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 29, 2014 at 10:51 AM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Having the driver not reporting overrun (and other) errors will
> obviously not fix the underlying issue with your device, which is
> generating all these errors in the first place.

Yes, although that might be related to the other fault I have been
seeing where the program reports receiving no data whatsoever. I'll
have to take a look at that too when I have the time.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
