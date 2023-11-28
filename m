Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pTF6fo5E"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AF19B6
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1701160347; x=1701419547;
	bh=oG3jq6dWAc3vO5K/NzE5wM3FqgtRaDwunRtObLZbh4g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pTF6fo5EstAkh9veuLArXyynMLhaKZ1etEL/XkVNU8MuqA8Btf7pJvTjnpXIXLat2
	 hQjO3KpPFU2fvq49H/eRWdWmFgxaOtgwACbub5tM5I5Io+8Hh10NEWxGiT98RT5bj/
	 +7sdg5IIV4CYX1zSUqnAoHhDzoRj94ueSfXdqHPdi6Xu1G5wLjRNAzSOHkdZYDaQXk
	 Ver0hAg2+EE4Fcxal0+5NDEvJMxzggXiXkaRiLasTFIxF0BnOQFzQPBksPQ+HBH1R0
	 bACeQu8Za//SJ8Q269H2iCLuPJC/Va3tHyH0LXyvLJtzv7vh86pj4vwYGj77MU+9op
	 Z1yXsr9lFp7Uw==
Date: Tue, 28 Nov 2023 08:32:10 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: mcpratt@pm.me
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <HPbnILrnlwSUYDSVm3nL_lHYYxueg4aCdoUL3rHZTk3qLuY05GzBCibJS7GBFolJi7Mr4egmTPxjWYt3TGbQ8N9ate8rRvdq31z9BL04sVY=@pm.me>
In-Reply-To: <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com>
References: <20231125063552.517-1-mcpratt@pm.me> <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Monday, November 27th, 2023 at 11:07, Andy Shevchenko <andriy.shevchenko=
@linux.intel.com> wrote:


> On Sat, Nov 25, 2023 at 06:36:32AM +0000, Michael Pratt wrote:
>=20
> > Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> > reworked functions for basic 8250 and 16550 type serial devices
> > in order to enable and use the internal FIFO device for buffering,
> > however the default timeout of 10 ms remained, which is proving
> > to be insufficient for low baud rates like 9600, causing data overrun.
> >=20
> > Unforunately, that commit was written and accepted just before commit
> > 31f6bd7fad3b ("serial: Store character timing information to uart_port"=
)
> > which introduced the frame_time member of the uart_port struct
> > in order to store the amount of time it takes to send one UART frame
> > relative to the baud rate and other serial port configuration,
> > and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> > which established function uart_fifo_timeout() in order to
> > calculate a reasonable timeout to wait for all frames
> > in the FIFO device to flush before writing data again
> > using the now stored frame_time value and size of the buffer.
> >=20
> > Fix this by using the new function to calculate the timeout
> > whenever the buffer is larger than 1 byte (unknown port default).
> >=20
> > Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
>=20
>=20
> Do we need a Fixed tag?
>=20
> ...


Hi Andy,

I'm not sure whether this qualifies as a "bug fix" or not,
since the proper way to handle it was introduced after the "bad" commit,
and the "bad" commit happens to still work fine for anyone running the
standard 115200 baud or higher.

For that matter, I'm not even sure if this affects other hardware,
I'm only able to test this on a MIPS SOC, and I wonder if anyone can
reproduce it on something else.

If that level of accuracy doesn't matter for tags, then yes I suppose
it should be tagged as "Fixes".



>=20
> > unsigned int status, tmout =3D 10000;
> >=20
> > - /* Wait up to 10ms for the character(s) to be sent. /
> > + / Wait for a time relative to buffer size and baud */
> > + if (up->port.fifosize > 1)
> > + tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
>=20
>=20
> Why can't we simply use this one?
>=20
> unsigned int status, tmout;
>=20
> tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
>=20
> > for (;;) {
> > status =3D serial_lsr_in(up);


Again, I'm not sure which is better for performance, between adding
a conditional check or doing the math for every case.
The 10 ms timeout has been there since the beginning of the git history,
so clearly it is enough for single-frame transfers at any baud.
The new function uart_fifo_timeout() provides a variable timeout, but start=
ing out
with an arbitrary 20 ms as a minimum, which I think can be traced back
to some hardware-specific workaround... but definitely much more
than what's needed for most cases (115200 baud needs at least ~1.5 ms).

I'd let you all decide, and I can adjust the patch if needed.

--
Thanks for your time
MCP

