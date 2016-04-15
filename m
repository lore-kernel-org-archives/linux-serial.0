From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 4/4] serial: doc: .break_ctl() may sleep
Date: Fri, 15 Apr 2016 16:07:39 -0700
Message-ID: <5711743B.3030207@hurleysoftware.com>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
 <1460624891-8389-5-git-send-email-geert+renesas@glider.be>
 <20160415160104.6aed0770@lwn.net> <57116BC2.5070102@hurleysoftware.com>
 <20160415164150.1666b58c@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160415164150.1666b58c@lwn.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/15/2016 03:41 PM, Jonathan Corbet wrote:
> On Fri, 15 Apr 2016 15:31:30 -0700
> Peter Hurley <peter@hurleysoftware.com> wrote:
> 
>> The only caller of the uart driver's break_ctl() method is
>> uart_break_ctl(), which is serial core's proxy tty driver break_ctl()
>> method. uart_break_ctl() claims the struct tty_port::mutex to prevent
>> concurrent tiocmset().
>>
>> Thus, the uart driver's break_ctl() method won't be called in atomic
>> context.
> 
> I'm missing something here.

Yes.

The analysis above is required to show that the API contract asserted by
the proposed change to the documentation is currently true in the code,
which is what I care about.

I don't mind if that's not in the changelog, though.

> I can fully believe that uart_break_ctl()
> won't call break_ctl() in atomic context, but the fact that it holds a
> mutex in no way guarantees that.  If uart_break_ctl() makes that promise
> we should just say so.
> 
> Sorry to be obnoxious, but I'd rather not put confusing stuff into the
> changelog if possible.

Sure, that's fine.

Regards,
Peter Hurley
