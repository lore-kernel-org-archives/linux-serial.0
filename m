From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/5] earlycon hang under some conditions
Date: Tue, 18 Jul 2017 14:17:52 -0700
Message-ID: <CAD=FV=UGWGbYycU8Avb9uLJ3j8mwbW0mGbifZpsMn+6isEwF=Q@mail.gmail.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com> <20170718175149.GA131686@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718175149.GA131686@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Jul 18, 2017 at 10:51 AM, Brian Norris <briannorris@chromium.org> wrote:
> Hi Jeffy,
>
> On Tue, Jul 18, 2017 at 02:02:53PM +0800, Jeffy Chen wrote:
>> I was testing earlycon with 8250 dw serial console. And it hangs in
>> these cases:
>> 1/ kernel hang when calling early write function after free_initmem:
>> a) the earlycon not disabled after the init code(due to keep_bootcon or
>>    not specify a real console to switch to)
>> b) the early write func is marked as __init, for example 8250_early.
>
> FWIW, I tested 8250_early with "keep_bootcon", and this fixes that:
>
> Tested-by: Brian Norris <briannorris@chromium.org>
>
> But then I get double console, if I have both a "real" and "early"
> console.
>
> If I were to *only* have the early console, then I might hit the
> problems you mention:
>
>> 2/ kernel hang when calling early write function after disable unused
>> clks/pm domain:
>> a) the earlycon not disabled after the init code
>> b) the disable unused clks/pm domain kill the requiered clks/pm
>>    domain, since they are not referenced by the earlycon.
>>
>> 3/ kernel hang when calling early write function after the serial
>>    console driver runtime suspended:
>> a) the earlycon not disabled after the init code
>> b) the serial console driver's runtime suspend kills the requiered
>>    clks/pm domain, since they are not referenced by the earlycon.
>>
>> This serial fix 1/ case only.
>
> Problems 2 and 3 look like something that's not really in scope for
> early consoles. There's a reason they are mainly supported for early
> boot, and we try to switch off of them. There isn't really a good way to
> handle all the clock and PM infrastructure without...switching off the
> earlycon and using the real one :)
>
> So, I guess this patchset has value for systems where the clock/PM
> requirements are simple enough, and the earlycon can actually be useful
> beyond early init.

Presumably someone using this would just use the "clk_ignore_unused"
and "pd_ignore_unused" kernel parameters to help them...  In this case
that seems fine to me.  The "early" boot console is early because it
can't rely on all of the generic OS mechanisms to do things super
cleanly, so requiring the user to know that they should add the extra
command line arguments seems sane.

-Doug
