From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Wed, 11 Mar 2015 12:17:01 +0100
Message-ID: <5500242D.3080605@atmel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>	<20150307103939.GA17964@amd>	<20150307110645.GW3989@piout.net>	<2616799.fRG1k0Q6sR@vostro.rjw.lan> <20150311093848.2b23a027@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150311093848.2b23a027@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, Sylvain Rochet <gradator@gradator.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead>
List-Id: linux-serial@vger.kernel.org

Le 11/03/2015 09:38, Boris Brezillon a =E9crit :
> On Sun, 08 Mar 2015 02:11:45 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>=20
>> On Saturday, March 07, 2015 12:06:45 PM Alexandre Belloni wrote:
>>> On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
>>>>> The Atmel watchdog can't be stopped once it's started. This is ac=
tually=20
>>>>> very useful so we can reset if suspend or resume failed, the only=
=20
>>>>> drawback is that you have to wake up from time to time (e.g. by u=
sing=20
>>>>> the RTC/RTT) to clear the watchdog and then go back to sleep ASAP=
=2E
>>>>
>>>> Yeah. So you do "echo mem > /sys/power/state", and few seconds/min=
utes
>>>> after watchdog kills the system. But you did not ask for dead syst=
em,
>>>> you asked for suspend.
>>>>
>>>> And while that behaviour is useful for you, I don't think it is
>>>> exactly useful behaviour, nor it is the behaviour user would expec=
t.
>>>>
>>>
>>> I think you misunderstood, that is exactly the expected behaviour. =
This
>>> is hardware defined. Once the watchdog is started, nobody can stop =
it.
>>> Trying to change the mode register will result in a reset of the So=
C.
>>>
>>> It is documented in the datasheet and any user wanting another beha=
viour
>>> is out of luck.
>>>
>>> So basically, when using a watchdog, you have to wake up every 15-1=
6s to
>>> restart it.
>>
>> So question is if we need a separate interrupt handler for that, exp=
ecially
>> since it is shared with the PIT timer anyway.
>>
>> Seems to me that the simplest way out of this conundrum would be to =
simply
>> make the timer's interrupt handler kick the watchdog every once a wh=
ile and
>> get rid of the separate watchdog interrupt handler entirely.
>=20
> The watchdog interrupt handler is not here to ping the watchdog, it's
> here to reset the platform if the watchdog hasn't been refreshed
> appropriately.
>=20
> IOW, it's a software watchdog using at91 WDT capabilities to determin=
e
> when it should reboot the system.
> IIRC, we need this on some at91 platforms to fix a HW bug (maybe
> Nicolas can confirm this).

Yes, the HW bug that we address in these functions:
at91sam9260_restart() and at91sam9g45_restart().

We have this issue because of NAND flash lines shared with DDR that are
driven during product reboot on old products (Cf. these functions
comments). This bug would kick-in when doing "software reset"/"watchdog
reset"/"push button reset". Only the "software reset" is handled by the
functions above.

So, yes, this "software watchdog" is there for this purpose IIRC.

Bye,
--=20
Nicolas Ferre
