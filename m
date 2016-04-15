From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Fri, 15 Apr 2016 15:31:30 -0700
Message-ID: <57116BC2.5070102@hurleysoftware.com>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
 <1460624891-8389-5-git-send-email-geert+renesas@glider.be>
 <20160415160104.6aed0770@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160415160104.6aed0770@lwn.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/15/2016 03:01 PM, Jonathan Corbet wrote:
> On Thu, 14 Apr 2016 11:08:11 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
>> As mutex_lock() must not be called with interrupts disabled,
>> .break_ctl() may sleep.
> 
> So I've applied the first three to the docs tree, but this one stopped
> me.  The changelog doesn't really say why the patch is correct; what we
> really need to know is that break_ctl() won't be called in atomic
> context.

The only caller of the uart driver's break_ctl() method is
uart_break_ctl(), which is serial core's proxy tty driver break_ctl()
method. uart_break_ctl() claims the struct tty_port::mutex to prevent
concurrent tiocmset().

Thus, the uart driver's break_ctl() method won't be called in atomic
context.

Regards,
Peter Hurley
