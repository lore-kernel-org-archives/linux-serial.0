From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH stable v2 1/2] arch/alpha, termios: implement BOTHER,
 IBSHIFT and termios2
Date: Mon, 8 Oct 2018 17:38:40 +0200
Message-ID: <20181008153840.GD3332@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-2-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-2-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:19PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Alpha has had c_ispeed and c_ospeed, but still set speeds in c_cflags
> using arbitrary flags. Because BOTHER is not defined, the general
> Linux code doesn't allow setting arbitrary baud rates, and because
> CBAUDEX == 0, we can have an array overrun of the baud_rate[] table in
> drivers/tty/tty_baudrate.c if (c_cflags & CBAUD) == 037.
> 
> Resolve both problems by #defining BOTHER to 037 on Alpha.
> 
> However, userspace still needs to know if setting BOTHER is actually
> safe given legacy kernels (does anyone actually care about that on
> Alpha anymore?), so enable the TCGETS2/TCSETS*2 ioctls on Alpha, even
> though they use the same structure. Define struct termios2 just for
> compatibility; it is the exact same structure as struct termios. In a
> future patchset, this will be cleaned up so the uapi headers are
> usable from libc.

Is this really needed? By defining BOTHER (and IBSHIFT which you forgot
to mention here) you are enabling arbitrary rates also through TCSETS on
alpha, right?

Johan
