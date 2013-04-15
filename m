From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/4] TTY: fix DTR being raised on hang up
Date: Mon, 15 Apr 2013 11:11:50 -0400
Message-ID: <1366038710.4124.2.camel@thor.lan>
References: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "David S. Miller" <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2013-04-12 at 10:32 +0200, Johan Hovold wrote:
> These patches fix four custom block_til_ready implementations which
> could raise DTR after first having dropped it at hangup.
> 
> This was fixed in the tty-port implementation by commit e584a02cf ("TTY:
> fix DTR being raised on hang up") in tty-next.
> 
> Note that the crisv10-driver still suffers from this behaviour but is
> broken in other ways as it, for example, does not honour CBAUD or raise
> DTR at non-blocking open.

Thanks for fixing these.

Regards,
Peter Hurley
