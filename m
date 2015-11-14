From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Sat, 14 Nov 2015 15:25:36 +0000
Message-ID: <20151114152536.693d964c@lxorguk.ukuu.org.uk>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
	<1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
	<20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
	<5644F4F2.2080408@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5644F4F2.2080408@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> I specifically asked for it.
> 
> I can think of 2 reasons that userspace wants to know:
> 1. Because the characteristics of the software emulation are unacceptable so
>    the application wants to terminate w/error rather than continue.

But that could equally be true of hardware. In fact your software
emulation is going to behave vastly better than many of the hardware ones.

> 2. Because userspace will use different values for h/w vs. s/w. For example,
>    right now, the emulation will raise/lower RTS prematurely when tx ends if
>    the rts-after-send timer is 0.

That's a bug then. It should be fixed as part of the merge or future
patches - if they are not providing that emulation then they ought to do
so and at least adjust the timing based on the baud rate so you don't
have to spin polling the 16x50 uart to check the last bit fell out of the
register.

I'd have no problem with an API that was about asking what features are
available : both hardware and software - but the software flag seems to
make no sense at all. Software doesn't imply anything about quality or
feature set. If there is something the emulation cannot support then
there should be a flag indicating that feature is not supported, not a
flag saying software (which means nothing - as it may be supported in
future, or may differ by uart etc).

It's also not "easy to drop". If it ever goes in we are stuck with a
pointless impossible to correctly set flag for all eternity.

Please explain the correct setting for this flag when a device driver
uses hardware or software or a mix according to what the silicon is
capable of and what values are requested ? How will an application use the
flag meaningfully. Please explain what will happen if someone discovers a
silicon bug and in a future 4.x release turns an implementation from
hardware to software - will they have to lie about the flag to avoid
breaking their application code - that strikes me as a bad thing.

At the very least the above should be clearly explained in the
documentation and patch covering notes - and if nobody can explain those
then IMHO the flag is broken.

Alan
