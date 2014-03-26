From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] [RFC] serial_core: Avoid NULL pointer dereference in uart_close()
Date: Wed, 26 Mar 2014 19:58:10 +0100
Message-ID: <CAMuHMdWZw-_+RVe0RuwfR+smuiDY9HpMq7H9=rseP_XLGytU0A@mail.gmail.com>
References: <1395061859-15295-1-git-send-email-geert@linux-m68k.org>
	<1395061859-15295-2-git-send-email-geert@linux-m68k.org>
	<532CA142.8060705@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <532CA142.8060705@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

Thanks for your comments!

On Fri, Mar 21, 2014 at 9:29 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/17/2014 09:10 AM, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> When unbinding a serial driver that's being used as a serial console,
>> the kernel may crash with a NULL pointer dereference in a uart_*()
>> function
>> called from uart_close () (e.g. uart_flush_buffer() or
>> uart_chars_in_buffer()).
>>
>> To fix this, let uart_close() check for port->count == 0. If this is the
>> case, bail out early. Else tty_port_close_start() will make the port
>> counts inconsistent, printing out warnings like
>>
>>      tty_port_close_start: tty->count = 1 port count = 0.
>>
>> and
>>
>>      tty_port_close_start: count = -1
>
> As you noted in the patch comments below, the tty core always closes
> a failed open.
>
> So the reason for the port->count mismatch is because tty_port_close_start()
> only handles the tty hangup condition -- all other failed opens are assumed
> to carry a port->count.
>
> A similar mismatch will occur if the mutex_lock in uart_open() is
> interrupted.
>
> This means that the port->count mismatch can occur even if port->count != 0;
> so the bug here is that uart_open() and uart_close() don't agree on
> who does what cleanup under what error conditions.
>
> So with respect to the port count mismatches, the conditions need careful
> auditing and fixing, separate from the tty console teardown problem.

Indeed. Currently uart_open() always decrements port->count again
in any error condition, which is clearly wrong.

>> and once uport == NULL, it will also crash.
>
> Ok, but so will basically every serial core function after
> uart_remove_one_port() assigns state->uart_port = NULL
>
> IOW, uart_close() is not the only serial core function that could be
> using state->uart_port after uart_remove_one_port() finishes.
>
>> Also fix the related crash in pr_debug() by checking for a non-NULL uport
>> first.
>
> So my point is that checking for NULL state->uart_port is simply not the
> fix,
> here or anywhere else.
>
> AFAICT, either reference-counting the uart_port structure or RCU
> are the only viable solutions to safe ll driver uart_port removal.

I gave it a quick try, but failed. It seems the driver needs some big surgery
to fix this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
