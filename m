From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: ftdi_sio: no per-byte parity error detection possible?
Date: Sat, 28 Oct 2017 11:49:52 +0200
Message-ID: <20171028094952.GB2850@kroah.com>
References: <25ffaffb-cdab-4df5-f21d-17820e0e3dcc@volatiles.lighting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <25ffaffb-cdab-4df5-f21d-17820e0e3dcc-WxehSq5lv7P58Y2lBU5/X10bvzIJ1INa@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Valentin <benjamin.valentin-WxehSq5lv7P58Y2lBU5/X10bvzIJ1INa@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 27, 2017 at 05:49:34PM +0200, Benjamin Valentin wrote:
> Hi,
> I'm trying to communicate with an embedded device using a serial protocol
> which uses the parity bit to indicate the start of a frame (MARK/SPACE
> parity).
> 
> Sending such frames works well, but when receiving them with a FT232RL USB
> adapter, the parity error detection is very unreliable.
> 
> I created a minimal example to reproduce this [1] with just two of these USB
> adapters. When I use the internal, 16550-compatible UART of the MT7688
> instead, parity errors are detected reliably.

Because there is more "direct control" over the uart data stream here.

> So I decided to dig deeper and indeed in ftdi_sio.c:ftdi_process_packet() I
> found that if a parity error occurs, the error flag is set for all bytes of
> the current transfer (up to 64). This of course breaks my assumption that a
> parity error would mark only the affected byte.

I think that is just the way the device works, sorry.  It is that way
for many, if not most, USB to serial adapters.

So if you really need to know the exact byte that an error occurs on, I
suggest you not use a USB to serial adapter, sorry.

good luck!

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
