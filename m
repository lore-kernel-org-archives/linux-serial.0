From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH/RFC 5/5] serial: sh-sci: Replace SCIx_HAVE_RTSCTS by
 standard UPF_HARD_FLOW
Date: Thu, 24 Mar 2016 10:23:20 -0700
Message-ID: <56F42288.4010006@hurleysoftware.com>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
 <1458222449-12324-6-git-send-email-geert+renesas@glider.be>
 <56EC520F.5010101@hurleysoftware.com>
 <CAMuHMdWFyLAg-=y=6=CBaOUeS-WV0wFXos=jBo-MJQiGB=vXmA@mail.gmail.com>
 <56F2CE4F.2010104@hurleysoftware.com>
 <CAMuHMdVG=-5BG9N3wSK-sn7i7V3fNDxb83N8Q_uHxBe_FSr2zg@mail.gmail.com>
 <56F33133.6060606@hurleysoftware.com>
 <CAMuHMdVX+Tqc1UqbcQTks_cSHzbEd9HjEMZiDHoF0ynbaQjtDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVX+Tqc1UqbcQTks_cSHzbEd9HjEMZiDHoF0ynbaQjtDg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On 03/24/2016 06:21 AM, Geert Uytterhoeven wrote:
> On Thu, Mar 24, 2016 at 1:13 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 03/23/2016 01:00 PM, Geert Uytterhoeven wrote:
>>> On Wed, Mar 23, 2016 at 6:11 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> gpio-based RTS/CTS is mutually exclusive with autoRTS/autoCTS. But I'm not
>>>> seeing any logic in these patches to prevent that.
>>>
>>> Sure. Currently nothing sets SCIx_HAVE_RTSCTS, so this can't happen yet.
>>
>> Anything that enables the gpios which will be in DT and beyond our control
>> needs to exclude autoRTS/autoCTS within the patch that provides the
>> DT functionality.
>>
>>> I went for GPIO-based RTS/CTS first, as we now have a framework for that,
>>> and I can use it as a known-working base.
>>
>> Right. And I'm saying that a condition of gpio-based RTS/CTS support needs to
>> contain the logic that prevents autoRTS/autoCTS, and not rely on orthogonal knobs.
> 
> AutoRTS/autoCTS cannot be enabled yet from DT.
> Hence on DT platforms, the driver uses either gpio-based RTS/CTS, or no RTS/CTS
> at all.

I do understand that the situation is mutually exclusive currently,
and even after the gpio patches. I'm probably just being overly-cautious here.

There have been a couple of situations where a DT configuration was invalid
and some ugly hoops were required to prevent it in the driver; eg., famously
the OMAP dma fubar.

I guess I'd be okay with skipping it as long as I knew someone was going to
make sure it got addressed soonish.


>>>> autoCTS without a way to read CTS input level means that although transmission
>>>> stops, the driver has no way to update port->hw_stopped so the write buffer
>>>> will keep filling up until it's full @ 4k.
>>>
>>> SCIF allows to read CTS input level, regardless of automatic RTS/CTS is
>>> enabled or not.
>>
>> I see that but crucial support for CRTSCTS is missing, AFAICT; namely,
>> a modem status interrupt.
> 
> There's indeed no interrupt support for that, unless you use a GPIO.
> 
>> There's no way to determine when the remote re-enables CTS without polling,
>> and the serial core provides no mechanism for the driver to poll CTS.
> 
> OK, so it's the responsibility of the driver to poll CTS, if there's no CTS
> interrupt support.

Sorry, no, I didn't mean the driver should try to implement some polling
scheme on its own.

> Even when autoCTS is enabled.

For autoCTS when the driver/hardware does not have CTS interrupt support,
set UPSTAT_AUTOCTS in port->status. This will prevent the serial core from
stopping the tty if CTS is not active (since the driver/hardware cannot
restart the tty when CTS is set active).

For !autoCTS when the driver/hardware does not have CTS interrupt support,
get_mctrl() must always report CTS active. [Another potential solution is
to disable CRTSCTS in the driver's set_termios method: this would be
preferable but I'm not sure all userspace will be ok with this.]


>> So again, the driver has no way to trigger stopping/restarting tx when CTS
>> changes without autoCTS. (A modem status interrupt for dCTS should call
>> uart_handle_cts_change() to perform this operation).
> 
> But if the hardware has autoCTS, we should use it, right?

Yes, but I consider that a refinement over basic CTS/RTS handling, and
so not an actual driver requirement.

> Hence "... without autoCTS" is never true if the hardware has autoCTS?

Well, a driver can only support s/w assisted h/w flow control*, even though
the h/w is capable of autoCTS.

* enabling/disabling tx on dCTS interrupt


> BTW, this means that drivers using mctrl_gpio_init_noauto(), but not
> implementing autoCTS(), and not polling CTS are broken?
> 
> drivers/tty/serial/clps711x.c looks fishy:

This looks broken.

If CRTSCTS is set and CTS is pinned to a gpio, tx will continue even when
the CTS gpio is inactive.

Also, if the CTS gpio is inactive when the tty is opened or the termios is
changed, tx will be stuck off.


> it doesn't poll CTS, but always sets TIOCM_CTS, probably to work around this?

This driver is not always setting TIOCM_CTS; that's just the default if CTS
is not pinned to a gpio.


>>>> autoRTS without a way to override RTS output complicates throttling.
>>>
>>> SCIF allows to override RTS output.
>>
>> Not the way I read the TRM: 16.3.11 Serial Port Register, bit 7 states
>> "When the RTS pin is actually used as a port outputting
>> the RTSDT bit value, the MCE bit in SCFCR should be
>> cleared to 0."
>>
>> IOW, autoRTS/autoCTS needs to be disabled to get the RTS override value
>> outputting at the pin.
> 
> That's also my understanding: to manually control the RTS pin, you have to
> disable automatic flow control (or use pinmux to change the pin to a GPIO).
> 
> [*]
> 
>>>>>   2. If the user didn't set CRTSCTS, the RTS output pin should be controlled by
>>>>>      the serial core, through .set_mctrl(),
>>>>
>>>> Not quite.
>>>>
>>>> _Regardless of CRTSCTS setting_, the RTS output pin should be controlled
>>>> through .set_mctrl() method. The serial core takes CRTSCTS into account on
>>>> behalf of the driver when necessary.
>>>
>>> What does this mean exactly?
>>> AFAIU, there are three states:
>>>   - Force RTS asserted,
> 
> (let's call this state 1)
> 
>>>   - Force RTS deasserted,
> 
> (state 2)
> 
>>>   - Use hardware-controlled automatic RTS,
> 
> (state 3)
> 
>>> while .set_mctrl() just provides the boolean TIOCM_RTS flag?
>>
>> Since there is no userspace knob for autoRTS, drivers that enable autoRTS
>> with CRTSCTS should force RTS to inactive for set_mctrl(!TIOCM_RTS) and cause
>> RTS to return to normal operation (autoRTS, if enabled, or RTS active otherwise)
>> for set_mctrl(TIOCM_RTS).
> 
> OK, makes sense. That's also what I was guessing. So when autoRTS is enabled,
> we have either state 2 or state 3.

Yes.


> Now, why would you want to override RTS output,

A couple of reasons:

1. userspace terminal control will expect to be able to use
   TIOCMSET/TIOCMBIC/TIOCMBIS to stop/resume input by dropping RTS when
   using CRTSCTS.
2. userspace drivers for uart-interfaced devices use TIOCMSET on RTS for things
   like device wakeup.
3. in-tree drivers use tiocmset() directly for the same thing.


> and is [*] above an issue?

Yes. The driver must disable autoRTS in set_mctrl() if TIOCM_RTS is clear and
restore the autoRTS/RTS state if TIOCM_RTS is set.
The omap8250 driver does this (omap8250_set_mctrl()).

IMPORTANT NOTE: do _not_ use UPSTAT_AUTORTS to track your autoRTS state, like
the omap8250 driver does.

If you do, you need to provide throttle/unthrottle methods to stop and resume
remote input; however, I don't think the methods currently used by these
drivers is appropriate or safe (by letting the rx fifo fill up).

> Is it because you want autoCTS, but not autoRTS?

No, but that does happen.


> Thanks for your answers, and sorry for still having that many questions...

Not your fault. I should really document this.

Regards,
Peter Hurley
