Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VK1reAFc"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CD4D7F
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1701337952; x=1701597152;
	bh=gFWZjY2l1exIvazXNe/u4C5YDBm/Kt7NGS/MLKV+rFg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VK1reAFcHtIa0iSYQ0WydDXP2GoJkZ65fKwM9+NDecANinX+WSGlX2deiRaoJaWCi
	 u3eBf3Cli0hVFH/rnAkPsYVxT6efd8ZdNX6pNGanPgT/mmKvgOpbJJn/a7FWZUD2qA
	 7BXNoW1H1rfBpG/Ec8XDJwT37pEfdmjIrLq1LG3Ai0EBhU4B6wqX+iLTccE6BoQ0IA
	 6jWgFICxjppmCjkGZAO6kHgDBJiWvjUN9V6BMvk2TD0jaQ4stqkYQ0KIg2Ibb95uD4
	 sYRszYdQaHk5zg+BUgTKZkx/BBWs5eQQ1E+Oj1B7uQ3LJYI3nUORKMy7TugZd7MVoH
	 fMTqBGqbWq69w==
Date: Thu, 30 Nov 2023 09:52:19 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <K3H2WOa7QgWaXO0vxUfZ5xkrSQTQ0dGkbXyDUIJMyygCRXENxrhHwuh9sL3pKBVVd0fHH_zT-yaWgAYHjHlqsepWxwZt3IGd5zjcrSrzhIk=@pm.me>
In-Reply-To: <26d2d26-7ead-b62-4636-bb34da636cf0@linux.intel.com>
References: <20231125063552.517-1-mcpratt@pm.me> <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com> <HPbnILrnlwSUYDSVm3nL_lHYYxueg4aCdoUL3rHZTk3qLuY05GzBCibJS7GBFolJi7Mr4egmTPxjWYt3TGbQ8N9ate8rRvdq31z9BL04sVY=@pm.me> <26d2d26-7ead-b62-4636-bb34da636cf0@linux.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Ilpo,


On Tuesday, November 28th, 2023 at 07:22, Ilpo J=C3=A4rvinen <ilpo.jarvinen=
@linux.intel.com> wrote:

> On Tue, 28 Nov 2023, mcpratt@pm.me wrote:
>
> > On Monday, November 27th, 2023 at 11:07, Andy Shevchenko andriy.shevche=
nko@linux.intel.com wrote:
> >
> > > On Sat, Nov 25, 2023 at 06:36:32AM +0000, Michael Pratt wrote:
> > >
> > > > Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver"=
)
> > > > reworked functions for basic 8250 and 16550 type serial devices
> > > > in order to enable and use the internal FIFO device for buffering,
> > > > however the default timeout of 10 ms remained, which is proving
> > > > to be insufficient for low baud rates like 9600, causing data overr=
un.
> > > >
> > > > Unforunately, that commit was written and accepted just before comm=
it
> > > > 31f6bd7fad3b ("serial: Store character timing information to uart_p=
ort")
> > > > which introduced the frame_time member of the uart_port struct
> > > > in order to store the amount of time it takes to send one UART fram=
e
> > > > relative to the baud rate and other serial port configuration,
> > > > and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> > > > which established function uart_fifo_timeout() in order to
> > > > calculate a reasonable timeout to wait for all frames
> > > > in the FIFO device to flush before writing data again
> > > > using the now stored frame_time value and size of the buffer.
> > > >
> > > > Fix this by using the new function to calculate the timeout
> > > > whenever the buffer is larger than 1 byte (unknown port default).
> > > >
> > > > Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> > >
> > > Do we need a Fixed tag?
> > >
> > > ...
> >
> > Hi Andy,
> >
> > I'm not sure whether this qualifies as a "bug fix" or not,
> > since the proper way to handle it was introduced after the "bad" commit=
,
> > and the "bad" commit happens to still work fine for anyone running the
> > standard 115200 baud or higher.
>
>
> Sometimes the proper way is then backported too to stables, but it needs
> to be checked how complicated that seems.
>
> So basically you'd need 31f6bd7fad3b and at least a part of f9008285bb69?

Correct, since frame_time is from 31f6bd7fad3b and the function is from f90=
08285bb69,
we would need both.


> > > > unsigned int status, tmout =3D 10000;
> > > >
> > > > - /* Wait up to 10ms for the character(s) to be sent. /
> > > > + / Wait for a time relative to buffer size and baud */
> > > > + if (up->port.fifosize > 1)
> > > > + tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
> > >
> > > Why can't we simply use this one?
> > >
> > > unsigned int status, tmout;
> > >
> > > tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
>
>
> I wonder if fifosize is always >=3D 1?


From the snippets in 8250_port.c that I have looked at,
I think it's safe to assume that it is >=3D 1 as long as it is defined,
and there are several spots that check whether or not it has been defined y=
et.

If not defined it takes the value from the constant fifo_size which is defi=
ned
for each port type to be at least 1, except for one, PORT_8250_CIR,
which most likely will never use this function anyway,
it causes many steps to be skipped in serial8250_register_8250_port().


> > > > for (;;) {
> > > > status =3D serial_lsr_in(up);
> >
> > Again, I'm not sure which is better for performance, between adding
> > a conditional check or doing the math for every case.
> > The 10 ms timeout has been there since the beginning of the git history=
,
> > so clearly it is enough for single-frame transfers at any baud.
> > The new function uart_fifo_timeout() provides a variable timeout, but s=
tarting out
> > with an arbitrary 20 ms as a minimum, which I think can be traced back
> > to some hardware-specific workaround...
>
>
> Would you happen to have a pointer for that 20 msecs is for HW
> workaround information bit
>
> I'd kind of want to lower it and base the extra delay on frame time
> rather than, like you say, on arbitrary number.
>
> --
> i.


When I said "some hardware-specific workaround" that was just a guess.

I decided to take a deep dive into the rabbit hole to find the source:

With the pre-git-history git repo from archive.org, I have traced the=20
first instance of the comment ".02 seconds of slop" to Linux 2.1.15.

However, it is not the first instance of adding an arbitrary `HZ/50`
to a delay to make "something" work, that would be in Linux 1.3.88
for the file net/ipv4/tcp_input.c for use in tcp_send_delayed_ack().

In the 90's, each version came in the form of a single bulk patch of patche=
s,
so I went hunting for the original patch.

27 years ago, Theodore T'so sent this patch to Linus and the mailing list:
(almost as old as me...)
(I can't find this one on lkml.org !!!)
https://lkml.iu.edu/hypermail/linux/kernel/9612.0/0501.html

Unfortunately, there's not much comment about the "slop",
but some talk of POSIX conformance and timing becoming stricter,
especially the comment which is still in master:

  * Note: we have to use pretty tight timings here to satisfy
  * the NIST-PCTS.

and

  Wait for the characters to drain based on
  info->timeout. At low baud rates (50bps), it may take a
  long time for the FIFO to completely drain out!

This makes me believe that it was added just for extra room in the timeout
to make sure that an _exact_ value for a timeout would not be too close
to a real-life absolute minimum that could cause data loss.

I noted that the `HZ/50` also appears in the same patch for defining char_t=
ime,
the timeout adds the extra time, and then char_time uses the timeout withou=
t it.

I went looking for the most recent change to char_time and found your commi=
t 31f6bd7fad3b
(so I really went full circle this time...)
And since port->timeout has been fully replaced and the calculations separa=
ted,
there's no issue with removing the extra time from char_time but not the ti=
meout.

However, it's clear from the inline comments that these lines were added
at a time when HZ was a constant, whereas now in modern Linux it can be var=
iable,
like in the cases in version 2.1.15:

$ git grep 'HZ/50'
drivers/char/serial.c:=09=09info->timeout +=3D HZ/50;=09=09/* Add .02 secon=
ds of slop */
drivers/char/serial.c:=09=09char_time =3D (info->timeout - HZ/50) / info->x=
mit_fifo_size;
drivers/net/shaper.h:#define SHAPER_BURST=09(HZ/50)=09=09/* Good for >128K =
then */
include/net/route.h:#define RT_REDIRECT_LOAD=09=09(HZ/50) /* 20 msec */
net/ipv4/tcp_input.c:=09=09if (tp->ato < HZ/50)
net/ipv4/tcp_input.c:=09=09=09tp->ato =3D HZ/50;
net/ipv4/tcp_timer.c:=09=09when=3DHZ/50;


And in master there are still a few of these...

$ git grep 'seconds of slop'
drivers/tty/amiserial.c:=09info->timeout +=3D HZ/50;=09=09/* Add .02 second=
s of slop */
drivers/tty/mxser.c:=09info->timeout =3D timeout + HZ / 50; /* Add .02 seco=
nds of slop */
drivers/tty/synclink_gt.c:=09info->timeout +=3D HZ/50;=09=09/* Add .02 seco=
nds of slop */
include/linux/serial_core.h:=09/* Add .02 seconds of slop */

but less of these...

$ git grep 'HZ/50' net drivers/net include/net
drivers/net/ethernet/dec/tulip/interrupt.c:=09=09=09=09mod_timer(&tp->timer=
, RUN_AT(HZ/50));
drivers/net/ethernet/dec/tulip/interrupt.c:=09=09=09mod_timer(&tp->timer, R=
UN_AT(HZ/50));
drivers/net/wireless/virtual/mac80211_hwsim.c:=09ieee80211_queue_delayed_wo=
rk(hw, &hwsim->roc_start, HZ/50);


On a side note: in file drivers/tty/amiserial.c
The "NIST-PCTS" comment is there,
and char_time is defined using port->timeout and the `HZ/50` still.
This is harder to find because the function name differs from serial_core.c=
:
uart_wait_until_sent() was originally also named rs_wait_until_sent()
and that was also changed before the mainline git history started...

So in summary, I do believe the `HZ/50` or similar should be replaced
in all of the cases in drivers/tty, maybe `frame_time * (fifosize + 1)`
for FIFO, and in the other cases, it might be safe to remove altogether,
as long as very low baud rates are tested. But also, it might not be a bad =
idea
for someone to take a look at the usage of `HZ` throughout the kernel,
since it is no longer constant and these lines that were originally meant t=
o be
an equivalence to seconds still seem to be lingering around in some areas..=
.

And if you do decide to change/remove it, you can try to CC Theodore
and maybe he can explain it to us himself. :D

--
All the best,
MCP
