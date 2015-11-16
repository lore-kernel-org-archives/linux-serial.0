From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Mon, 16 Nov 2015 14:18:13 -0500
Message-ID: <564A2BF5.8030305@hurleysoftware.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
 <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
 <5644F4F2.2080408@hurleysoftware.com>
 <20151114152536.693d964c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151114152536.693d964c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/14/2015 10:25 AM, One Thousand Gnomes wrote:
>> I specifically asked for it.
>>
>> I can think of 2 reasons that userspace wants to know:
>> 1. Because the characteristics of the software emulation are unacceptable so
>>    the application wants to terminate w/error rather than continue.
> 
> But that could equally be true of hardware.

I had this exact same thought, but concluded that it argues for a way
to select the software implementation even when h/w supports RS485.

> In fact your software
> emulation is going to behave vastly better than many of the hardware ones.
> 
>> 2. Because userspace will use different values for h/w vs. s/w. For example,
>>    right now, the emulation will raise/lower RTS prematurely when tx ends if
>>    the rts-after-send timer is 0.
> 
> That's a bug then. It should be fixed as part of the merge or future
> patches - if they are not providing that emulation then they ought to do
> so and at least adjust the timing based on the baud rate so you don't
> have to spin polling the 16x50 uart to check the last bit fell out of the
> register.

I suppose the timer(s) could be fudged and then TEMT polled (or polled every
char baud cycles). But I don't see how this will behave better than a h/w
implementation; the granularity of the jiffy clock alone will guarantee
sub-optimal turnaround, even at 9600.

> I'd have no problem with an API that was about asking what features are
> available : both hardware and software - but the software flag seems to
> make no sense at all. Software doesn't imply anything about quality or
> feature set. If there is something the emulation cannot support then
> there should be a flag indicating that feature is not supported, not a
> flag saying software (which means nothing - as it may be supported in
> future, or may differ by uart etc).

Fair enough.

> It's also not "easy to drop". If it ever goes in we are stuck with a
> pointless impossible to correctly set flag for all eternity.
> 
> Please explain the correct setting for this flag when a device driver
> uses hardware or software or a mix according to what the silicon is
> capable of and what values are requested ? How will an application use the
> flag meaningfully. Please explain what will happen if someone discovers a
> silicon bug and in a future 4.x release turns an implementation from
> hardware to software - will they have to lie about the flag to avoid
> breaking their application code - that strikes me as a bad thing.

The existing driver behavior is already significantly variant and needs
to be converged, which shouldn't be too difficult. Here's a quick summary:

mcfuart		ignores delay values, delays unsupported
imx		clamps delay values to 0, delays unsupported
atmel		only delay_rts_after_send used; delay_rts_before_send does nothing
8250_fintek	clamps delay values to 1, unclear if h/w delay is msecs
omap-serial*	software emulation (but tx empty polling not reqd)
lpc18xx-uart	clamps delay_rts_before_send to 0, unsupported
		clamps delay_rts_after_send to max h/w value
max310x		returns -ERANGE if either delay value > h/w support (15 msecs)
sc16is7xx*	returns -EINVAL if delay_rts_after_send is set
crisv10*	clamps delay_rts_before_send to 1000 msecs
		ignores delays_rts_after_send (after dma is delayed by 2 * chars)
* implements delay(s) in software

The omap-serial emulation should not have been merged in its current form.

IMO the proper driver behavior should be clamp to h/w limit so an application
can determine the maximum delay supported. If a delay is unsupported, it should
be clamped to 0. The application should check the RS485 settings returned by
TIOCSRS485 to determine how the driver set them.
[ Documentation/serial/serial-rs485.txt should suggest/model this action ]

Are TIOCGRS485 and TIOCSRS485 documented in tty_ioctl man page? (I haven't
updated my man pages in a while)

As far as software vs. hardware and a query api, what I care about is
conveying to userspace whether the implementation will be adequate for purpose,
with the main issue being the true delay from actual EOT to RTS toggle
when delay_after_rts_send == 0.

Since that delay is unbounded with software methods, I thought it made sense to
indicate that with a read-only bit. Naming it something else is fine too;
SER_RS485_NOT_REALTIME_EOT?

A more comprehensive approach might be to add a capabilities word
to struct serial_rs485 which would allow the driver to report what
it supports; eg. realtime turnaround or not, etc. (Not sure if extending
struct serial_rs485 is really possible; the serial core hasn't been
clearing padding on the driver's behalf).

> At the very least the above should be clearly explained in the
> documentation and patch covering notes - and if nobody can explain those
> then IMHO the flag is broken.

Yep.

Regards,
Peter Hurley
