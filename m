From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Mon, 18 Jan 2016 12:52:36 +0100
Message-ID: <33A6D692-DC52-4E66-8FF9-D295EA29D98A@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk> <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk> <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <569CA8B1.3080706@cogente
 mbedded.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569CA8B1.3080706@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Am 18.01.2016 um 09:56 schrieb Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>:

> Hi,
> 
> H. Nikolaus Schaller wrote:
>> Hi Alan,
>> 
>> Am 17.01.2016 um 20:38 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
>> 
>>>> 3. mechanism to open/close the UART by the peer driver (for power management of the
>>>> UART), even if it there is a user-space tty client for the same UART which might or might
>>>> not be open at any time. Manage that in an optimal way.
>>> Power management doesn't have to go via the uart layer. You can even
>>> manage it via the existing sysfs power interfaces (and some Android
>>> devices do in fact do exactly that either by controlling the uart pm or
>>> using a gpio line). Not pretty either but means people are only peeing
>>> in their own backyard. What goes into the kernel costs *everyone*, what
>>> goes in device user space costs only the perpetrator.
>>> 
>>> It would help to rewind and understand what your needs are not what your
>>> implementation as it stands is. Why can't you just use hciattach like
>>> everyone else ? Improving the PM logic by refining the existing hci
>>> ldisc to be power smart so everyone benefits from any improvement might
>>> be a useful other discussion.
>> I have not counted how often I have explained that, but I am happy to do it
>> again.
>> 
>> * the GTA04 device is an open hackable smartphone platform where power saving is highest priority
>> * the platform includes the kernel, but we don't want to prescribe any specific user space (i.e. we can't assume that a specific daemon exists or can't modify it)
>> * the wi2wi,w2sg0084 chip is a GPS chip (it does not understand HCI protocol, it just sends NMEA records if powered on)
>> * we want to provide NMEA data through /dev/ttyO1 (it uses an OMAP UART) because a tty port is the most common interface for GPS devices (e.g. a bluetooth GPS mouse is also presented as a tty)
>> * we want the chip to automatically power up as soon (but not before) as any gps client opens /dev/ttyO1 (or activates the DTR mctrl)
>> * we want the chip to automatically power down if no process uses /dev/ttyO1 any more
>> 
>> The standard logic of GPS daemons and applications is to receive
>> NMEA records through some serial /dev/tty.
>> 
>> Please tell me how power on/off management can be done without intercepting
>> somewhere in the kernel that /dev/ttyO1 is opened/closed (which is not the same
>> as suspend/resume).
>> 
>> Secondly, the chip has a very special logic that it may end up in the opposite
>> power state than the kernel driver thinks. Especially after boot it simply can not
>> know the state. The chip might be powered up/send records or might not.
>> 
>> A driver can only detect such a discrepancy if it thinks the GPS chip is powered off,
>> but there is still data coming through the UART.
>> 
>> Please tell me how this situation can be detected without monitoring the data stream
>> in the kernel going to /dev/ttyO1 - from the UART behind it - even if /dev/ttyO1 is closed.
>> 
>> This are *our* requirements.
>> 
>> Other people think that our approach helps to solve their driver architecture as well
>> and have added their requirements on top. This is why I attempt to make the API
>> more general than just for our own use-cases.
> In my case, I have an MCU that sits behind UART and provides several low-level functions, that should be exposed via well-known API (Watchdog, NVMEM, HWMON, LEDs, input, etc)
> * MCU is connected via dedicated UART on SoC.
> * port should not be exposed to user space via tty layer (impossible now, as soon as port driver is registered, tty layer will create /dev/tty* device for it)

That is what I want to optionally disable in uart_add_one_port().

> * MCU should be probed as soon as possible without 'open' call from user space that is usually done by 'Xattach' app/daemon

in our proposed solution some uart peer is probed as early as possible. It then tries to attach to the UART. If the UART has not yet been successfully probed, a -EPROBE_DEFER is returned and the MCU probe can be deferred as well. This does not need an open() call from user space to work.

> * it is needed to configure UART speed and have some abstraction layer for data transfer (same as line discipline, but in kernel only)
> 
> As there is no concept as UART BUS (even if it is point to point) there is no way right now to make this happen.
> Just a thought, would it be a good idea to use 'device_type' attribute in device tree to differentiate port type, i.e. whether it should be treated as normal serial port or as UART BUS?
> for example:
> uart1 {
>    device_type = "serial";
>    ...
> };
> uart2 {
>    device_type = "serial_bus";
>    ..
> };

My proposal for this will be something like (I haven't decided myself on this)

uart2 {
	hide-tty-port;
};

or

uart2 {
	peer-mode;
};

or

uart2 {
	dedicated;
};

but the result is the same and the exact property name and value can be discussed later on.

> 
>>> The 8686 is already working in serial mode  with no kernel hackery on
>>> other boards.
>> You appear to mix the chips we are talking about. We have the w2sg0084 gps
>> chip and a w2cbw003, which is a combo of an 8686 and a CSR BT serial device.
>> 
>> Both chips need somehow to be powered on or off if not used. Ideally automatically
>> at the moment no user space client is using them any more. For the bluetooth side
>> the moment to power off is when a hciattach is killed.
>> 
>> Other 8686 boards appear not to have such critical power restrictions and then they
>> just leave power on.
>> 
>>>> For the GPS chip I am only interested in mctrl and if characters are received. But
>>>> I still want them to arrive at user space through a standard tty interface. So a solution
>>>> that does not interwork and cooperate with the tty layer is not a useable solution for
>>>> my requirements.
>>> Why does it matter how they arrive so long as your user space can
>>> interpret it correctly. Or is your user space some proprietary blob you
>>> can't change ?
>> No, the opposite: it can be any open source application, which by principle
>> could be changed in any way. But we can't because we as the hardware
>> platform+kernel developers have no (and don't want to have) control over
>> the the user space. So we have to fit into the standards of the user space.
>> 
>>> Them arriving by a tty interface is fine - no issue with that providing
>>> it doesn't need to mess up core code.
>> You appear to assume that the tty port is always open and there is
>> a background daemon running.
>> 
>> Here, we need to solve the problem to power down the chip if NO
>> tty port is open any more.
>> 
>> We simply don't see a solution for this outside the kernel and inside without
>> touching the UART code. Although there have been many very skilled
>> developers involved in the past 3 years to get what we need into the
>> mainline kernel. There had been proposals for approx. 3 or 4 different
>> architectures which were all rejected for good reasons and the current
>> one is the one which tries to overcome all known objections and of
>> course raises new questions.
>> 
>>>> The reason appears to sit here:
>>>> 
>>>> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L2725
>>>> 
>>>> This means that as soon as some UART is successfully probed, a new tty
>>>> interface is created for it. So we simply have to optionally disable it. This is
>>>> described by requirement 6.
>>> You can just report EBUSY in your open method. You don't need to touch
>>> the serial core layer. It's quite sufficient to do
>>> 
>>> 	if (busy)
>>> 		return -EBUSY;
>>> 
>>> at the top of your uart open method.
>> Hm. I am not writing a new UART driver or touch them. I am using the existing
>> ones (omap-serial). They all call this uart_add_one_port() in their probe() function.
>> 
>> If I would modify just omap-serial, people would for sure complain that the solution
>> is not generic enough.
>> 
>>>> UART drivers we have and work with any of them. This is why I think
>>>> serial-core and struct uart_port is the right level. Even if it looks like a hack.
>>> Your "looks like" instinct is IMHO bang on - looks like a hack, is a
>>> hack.
>> It is not *my* instinct that says "looks like". It was:
>> 
>> 1. meant to be read as "Even if it looks like a hack to the uninformed reader of the patch"
>> 2. it was said by some reviewer
>> 
>> For me it is not a hack, it is a well thought logical consequence of the requirements
>> combined with the current code architecture as it exists (which often looks like a hack to me)
>> and the goal to make changes as non-intrusive as possible.
>> 
>>> It's also unnecessary as you can hide it in your open method if you
>>> must do that.
>> Creating tty ports is not *my* open method. It is part of the way all system
>> UARTs are initialized. So I can't handle this case in *my* open method, because
>> I have none that is tty_port related.
>> 
>>>> So please wait until I have updated the patch set of our proposal. Then you
>>>> can see that we do not directly touch the tty layer.
>>> The uart layer is part of the tty layer. It's just a glue library to make
>>> writing some tty drivers a bit easier.
>> Yes, and exactly that is helpful to solve this problem. We attach only to the
>> glue layer and everything is done.
>> 
>>> It's tied deeply to the tty_port
>>> implementation. One day it might even cease to exist replaced by more
>>> generic tty_port helpers.
>> Is there a concrete plan to change that? Is anyone working on it now?
>> 
>> If not, I would not worry about this, because it is not specific to the problem
>> we want to solve today (to be precise: since 3 years).
>> 
>> But even if it is changed, there must always be some glue between UARTs
>> and tty_port helpers. So it can't disappear - it can only change in structure..
>> 
>>> The tty layer is also an *abstract* concept. There is no real world tie
>>> between physical collections of shift registers that dribble bits to one
>>> another and tty devices in the kernel. You only need a tty driver for
>>> certain types of user interaction.
>> And we need it to process the GPS data by standard applications and tools.
>> 
>> BR,
>> Nikolaus
>> 
> Best regards,
> Andrey

BR,
Nikolaus
