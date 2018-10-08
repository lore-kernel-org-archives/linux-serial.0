From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH stable v2 2/2] termios, tty/tty_baudrate.c: simplify,
 auto-generate baud table
Date: Mon, 8 Oct 2018 17:46:55 +0200
Message-ID: <20181008154655.GE3332@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-3-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-3-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:20PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Now when all architectures define BOTHER and IBSHIFT, we can
> unconditionally rely on these constants. Furthermore, the code can be
> significantly simplified in a number of places.
> 
> Rather than having two tables and needing to be able to keep them in
> sync at all times, have one auto-generated table. This also lets us
> avoid the fact that architectures that have CBAUDEX == 0 have BOTHER
> in a different location that those that don't.
> 
> The code for masking CBAUDEX as a fallback is never exercised on any
> architecture, because for all architectures, either the baud rate
> table is completely defined for all CBAUD values, or CBAUDEX == 0, so
> we can just remove it.
> 
> Finally, this patch avoids overrunning the baud_table[] for
> architectures with CBAUDEX == 0.

So we need a minimal fix for this only as this patch in particular
should not be backported to stable.

I'm not sure when I'll have time to review this one thoroughly, so
perhaps others can chime in meanwhile.

Johan
