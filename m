From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Fri, 15 Apr 2016 16:41:50 -0600
Message-ID: <20160415164150.1666b58c@lwn.net>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
	<1460624891-8389-5-git-send-email-geert+renesas@glider.be>
	<20160415160104.6aed0770@lwn.net>
	<57116BC2.5070102@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <57116BC2.5070102@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 15 Apr 2016 15:31:30 -0700
Peter Hurley <peter@hurleysoftware.com> wrote:

> The only caller of the uart driver's break_ctl() method is
> uart_break_ctl(), which is serial core's proxy tty driver break_ctl()
> method. uart_break_ctl() claims the struct tty_port::mutex to prevent
> concurrent tiocmset().
> 
> Thus, the uart driver's break_ctl() method won't be called in atomic
> context.

I'm missing something here.  I can fully believe that uart_break_ctl()
won't call break_ctl() in atomic context, but the fact that it holds a
mutex in no way guarantees that.  If uart_break_ctl() makes that promise
we should just say so.

Sorry to be obnoxious, but I'd rather not put confusing stuff into the
changelog if possible.

jon
