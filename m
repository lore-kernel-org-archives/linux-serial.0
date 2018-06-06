From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Wed, 6 Jun 2018 15:42:07 -0600
Message-ID: <20180606214207.GB9999@cisco>
References: <20180605000127.5495-1-tycho@tycho.ws>
 <20180605035936.GA19642@mail.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605035936.GA19642@mail.hallyn.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 04, 2018 at 10:59:36PM -0500, Serge E. Hallyn wrote:
> Quoting Tycho Andersen (tycho@tycho.ws):
> > Unfortunately, I don't have any insightful thoughts about how to test this.
> > Ideas are appreciated :)
> 
> I wonder whether there is something we can do with qemu -serial pipe: ?

Good idea. I couldn't get tty_put_char() to trigger nicely, but I just
hard coded one to occur, so at least now I know that this doesn't
deadlock when called normally.

Another suggestion Serge gave off list was to write a kernel module
that implemented a driver. I'll see about doing that to see if I can
force the original crash.

> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks!

Tycho
