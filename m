From: Janne Huttunen <jahuttun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Mon, 3 Nov 2014 23:46:09 +0200
Message-ID: <20141103234609.03842d21@sauron>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
	<20141029085128.GC7841@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141029085128.GC7841@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 29 Oct 2014 09:51:28 +0100
Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Having the driver not reporting overrun (and other) errors will
> obviously not fix the underlying issue with your device, which is
> generating all these errors in the first place.

Ok, I did take a closer look at this (mostly with usbmon) and it seems
to be caused by the hardware. When the application does open the device
and the driver submits the first bulk reads, there's basically three
possibilities what happens next:

1. The chip responds with correct data and everything works fine from
   there until the device is closed.
2. The chip responds with single correct character followed by a few
   hundred or so replies containing only the overrun status (no data)
   which are then converted to a bunch of binary zeroes by the ldisc
   because of the bug I mentioned earlier. After that the chip starts
   responding with proper data again and works until closed.
3. The chip hangs forever without ever responding anything on the
   bulk endpoint.

As a rough estimate I'd say that something like at least one out of
ten opens currently exhibits either behavior 2 or 3. Also it doesn't
seem to have anything to do with any real buffering inside the chip
i.e. if I close a working connection and immediately open it again,
it may hang the chip.

After some poking around, it seems that the chip really doesn't like
the latency timer value of 1 when it is reset. After it gets the data
going it doesn't seem to mind it i.e. I have not seen the chip to
hang or report superfluous overruns during normal operation even with
latency timer value of 1. With timer value 2 I did get something like
300 opens before hitting the issue and with value 3 I have not seen
the device misbehave (yet) in like a thousand or so opens. I do think
that more testing is still needed before saying anything definite,
but larger timer at least seems to mitigate the issue significantly.

BTW, in case nobody else is ever experiencing this issue, please note
that I cannot guarantee in any way that the FT232RL in my device is
actually authentic. If it is counterfeit, it is a different one than
the one that was having the issue with the Windows driver lately. My
device doesn't seem to have that bug, but that is no guarantee that
it is the real deal. And obviously, real or not, it *does* have some
bug that causes it to now misbehave during open().

So, tentatively seems that in order to get rid of the issue with at
least this FT232 variant (whatever it may happen to be), either the
minimum latency timer value should be increased or possibly
alternatively the chip could be reset with higher value and the actual
value set later when the chip has started properly. Although I don't
yet know for sure which latency value would work 100% of the time or
if the alternative idea would actually work at all (I just thought
about trying something like that).

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
