From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH resend] serial_core: Fix pm imbalance on unbind
Date: Fri, 21 Mar 2014 18:41:19 -0400
Message-ID: <532CC00F.3000501@hurleysoftware.com>
References: <1395392905-29569-1-git-send-email-geert@linux-m68k.org>	<532C394A.3050408@hurleysoftware.com> <CAMuHMdUBiUzpvTzkhaguOQoDc8XJH7NvnNe2Z+jL6UeEitpJPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUBiUzpvTzkhaguOQoDc8XJH7NvnNe2Z+jL6UeEitpJPg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On 03/21/2014 09:23 AM, Geert Uytterhoeven wrote:
> Hi Peter,
>
> On Fri, Mar 21, 2014 at 2:06 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> @@ -2681,10 +2683,12 @@ int uart_remove_one_port(struct uart_driver *drv,
>>> struct uart_port *uport)
>>>          }
>>>
>>>          /*
>>> -        * If the port is used as a console, unregister it
>>> +        * If the port is used as a console, unregister it, and power it
>>> down
>>>           */
>>> -       if (uart_console(uport))
>>> +       if (uart_console(uport)) {
>>>                  unregister_console(uport->cons);
>>> +               uart_change_pm(state, UART_PM_STATE_OFF);
>>
>> Won't this power off the port while tty consoles may still be open?
>
> I didn't see that actually happening.

Ok, but I still think this isn't right. See below.

>> I think the right thing here is to unregister_console then set uport->cons =
>> NULL
>>
>> [uport->cons is properly reassigned when/if a port is re-added via
>> uart_add_one_port()).]
>
> But indeed, for concistency/symmetry uport->state and uport->cons
> should be resend, but that's something separate.

I don't see this as being a "looks good" problem; I see this as being
"what's the right way to teardown a uart device that's going away when
a tty console is running on it", and there are too many problems with
uart_remove_one_port() doing:

      state->uart_port = NULL

to keep with that solution.

>> Then, uart_close() will power off the port when all ttys using the port have
>> been closed.
>
> uart_close() won't get that far, so uart_change_pm() won't be called.

And this is the central problem: uart_close() must complete normally
if a tty console is still running on a device.

For example, if uart_shutdown() isn't getting called, then who's freeing
the ring buffer page?


> See also https://lkml.org/lkml/2014/3/10/651, and my workaround for the
> crash https://lkml.org/lkml/2014/3/17/231.

See my comments to the v2 patch there.

Regards,
Peter Hurley
