From: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Tue, 21 Jul 2015 23:43:34 +0200
Message-ID: <55AEBD06.6020402@svenbrauch.de>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OPF9DCABSKUnCVE9E62pi92kUgGw8fVCm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437486195.3823.13.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Toby Gray <toby.gray-BiNz9QiKYoNBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OPF9DCABSKUnCVE9E62pi92kUgGw8fVCm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your comments.

On 21/07/15 15:43, Oliver Neukum wrote:
> But others won't and we'd preserve stale data in preference over fresh
> data.
If that is important for your device, you should be using an isochronous
endpoint, not bulk, no?
Also note that the driver currently does this anyways. It loses a few kB
of data, and _then_ it throttles the producer and forces it to wait.

On 21/07/15 11:18, Johan Hovold wrote:
> In general if data isn't being consumed fast enough we eventually need
> to drop it (unless we can throttle the producer).
Yes, maybe this is the first thing which should be cleared up: Is
"throttle the producer" always preferable over "lose data"? I'd say yes
for bulk transfers, no for isochronous. It is in principle easy enough
to throttle the producer, that is what e.g. my patch does. Whether a
different approach may be more appropriate than the "don't resubmit the
urbs" thing is then of course open to debate.

As far as I can see, throttling the producer is the only way to
guarantee data delivery. So if we want that (and I certainly want it for
my application, I don't know about the general case), I think all
changes to the tty buffers or throttling mechanisms are "just"
performance optimization, since no such modification will ever guarantee
delivery if the producer is not throttled in time.
And, this I want to mention again, if your producer is timing-sensitive
you would not be using bulk anyways. The USB controller could just
decide that your device cannot send data for the next five seconds, and
it will have to handle that case as well. Thus I see no reason to not
throttle the producer if necessary.

On 21/07/15 18:45, Peter Hurley wrote:
> 1. Instrument acm_read_bulk_callback with tty_buffer_space_avail()
> to track the (approx) fill level of the tty buffers. I would
> use ftrace/trace_printk() to record this.
I already did this while debugging. For a while, the buffer is almost
empty (fluctuates by a few kB), then it rapidly drops to zero bytes
free. Only after a few urbs where submitted (or rather, not submitted)
into the full buffer, the throttle flag gets set.

Thank you for your offer to help figuring out what exactly goes wrong
with the throttling mechanism. If it turns out we should actually look
for a fix there, I'll be happy to make use of it.

Best,
Sven


--OPF9DCABSKUnCVE9E62pi92kUgGw8fVCm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVrr0GAAoJEGjKjjjEuz9LOlYP/2z9MsQPH6XgHSVIyUemSN6W
2Cxq1Am4m7zcrSEGXg92MsiE8qNYn870cCaoNrTnWmKCpPGV1QF5Z7HEGqvteLVD
nT9eTgu2mGe7Ln9fBAp7yqKyXpddzlQmh9j7hrCaH8j/F5oFvVN9VQeZAb3OijEn
LnmIamGQFypVp15KWiyeNz5+Q0MuxcyGDBo3XIYGR24V41VBx/qAg5PLZyLXOz2P
h5dM92rz0VAkouORWb07AYqr9fl4ZAPDp3p/1gt62iAsIj7O3mqAnh6h6lBxU9bf
nruJb0ZednX7mPYCau66OG9RpQr4+xbkvDEaZKQAXWNTWmZHPwEA+m7GdbZ+ub08
dpfslmQV7aCarRyEiYYTflMHhN30AjJaqF4ZhOp9ubvQITlm4C+I/VTXCYa5GXXB
4fXCF2GCaIVQKn+VI1C6V6y2MVS9ZijIGHmgjNqPUWFZC6bILKG41JjKQCBDfxld
7Js2MucfK5iDzBs3v7Nfx6xXu3BLYDEUm7OgWU5+dNAW7r8r8CYgF2IyMqA+ASOm
XBTt/VlUgpSzxgcvOJP7VEPV6ETyac9HDhwPv++WfLnVgcQPL5s8WmIDIXAtVgIV
HhwfJj/kRvoSHKf2ZNP/gkvqu32iWzq1BoZx9t8eI7LDOzFGZCOIx181T83laq2w
vsvh6kNkuGY0H/DX3HOQ
=M0w7
-----END PGP SIGNATURE-----

--OPF9DCABSKUnCVE9E62pi92kUgGw8fVCm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
