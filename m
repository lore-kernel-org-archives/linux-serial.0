From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer
 overrun
Date: Tue, 23 Oct 2018 15:53:51 +0100
Message-ID: <20181023145351.GA28516@kroah.com>
References: <20181022161905.26589-1-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022161905.26589-1-hpa@zytor.com>
Sender: stable-owner@vger.kernel.org
To: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 22, 2018 at 09:19:04AM -0700, H. Peter Anvin (Intel) wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> 
> On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in tty_baudrate.c does
> not do any limit checking on the tty_baudrate[] array, and in fact a
> buffer overrun is possible on both architectures. Add a limit check to
> prevent that situation.
> 
> This will be followed by a much bigger cleanup/simplification patch.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Requested-by: Cc: Johan Hovold <johan@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Eugene Syromiatnikov <esyr@redhat.com>
> Cc: <linux-alpha@vger.kernel.org>
> Cc: <linux-serial@vger.kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/tty/tty_baudrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As I think Al's big termios cleanups are going to be hitting Linus's
tree soon, do you know how these patches interact with that?

This patch seems like it will not, so I'll be glad to queue that up
after my first round of patches get merged to Linus later this week, but
the second one worries me.

thanks,

greg k-h
