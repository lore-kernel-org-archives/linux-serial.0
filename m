From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Wed, 20 Jan 2016 19:03:14 +0100
Message-ID: <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk> <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk> <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk> <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.
 051c9cc0@lxorguk.ukuu.org.uk> <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com> <20160120174610.1c64239a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160120174610.1c64239a-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


Am 20.01.2016 um 18:46 schrieb One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:

>> The problem is that *I* have no control over user space. But I also don't want
>> to say to my users "that is not my problem - get it solved yourself". This does
>> not help them.
> 
> Stuffing things into the kernel because the user space of a given
> platform can't get itself organised isn't helpful to the other billion
> plus Linux devices out there.

The assumption that there is  "the" user space of a given platform is wrong.

> 
>> And, most device drivers are corner cases since they are special solutions
>> for singular platforms.
> 
> Actually that is quite a small percentage - and the corner cases hide in
> drivers not in the core code, which is really important for
> maintainability.
> 
>>>> I'm glad - because it raises some hard questions and while I don't agree
>>>> with some of your starting points (like needing to "open" a uart without
>>>> user space
>> 
>> If have an idea how to turn off the device at boot time, before any user space
>> daemon is running, we can of course ignore that.
> 
> Your early user space is responsible for it. If you can't accept that
> then I don't see any point continuing the conversation.

Exactly. There are two reasons:
* we want to make sure that it works for any user space
* it should be done as early as possible

> 
>>>> But see below as I think your mental model is perhaps wrong
>>>> and this is a point of confusion ?
>> 
>> Maybe you do not accept that I want to keep as low level as reasonable (for me).
> 
> It's always "for me". No the kernel project is not "for me"
> 
>>>> Both of those techniques work in mainline without kernel changes (at
>>>> least on devices where the right gpio sysfs nodes exist
>> 
>> they do not exist...
> 
> For most they do because they are gpio lines so exportable to userspace.
> 
>>>> This I think is actually the really hard and interesting part of the
>>>> problem. The "tell me about open and close" case is simple and can be
>>>> done via tty_port today with minimal extra hooks. There is a small
>>>> question about how you set those hooks from a DT binding
>> 
>> tty has no binding. An UART hardware has. Another reason for me to
>> start with UARTs.
> 
> Every uart is a tty_port, every non uart is a tty_port. There is no
> reason you can't bind to a non uart device. Your current patches create
> bindings for the uart layer.

Yes and no. The &uart { compatible = "something"; } already exists.

> 
>>>> For some hardware that is the only way I know to do this because the
>>>> power hungry uart receiver is physically powered down. I would have to
>>>> check but I *think* that is true even on a modern x86 PC that supports
>>>> wakeups via serial - although it may be well hidden in ACPI and firmware.
>> 
>> Yes, agreed. But the gpio + interrupt solution was not mainlineable as well.
> 
> That I am unsure about - at some point it is going to have to be sorted
> because it is increasingly common (if currently mostly invisible)
> 
>>>> I'm not personally opoosed to the tty slave idea providing it ends up
>>>> attached to the tty_port not just uart.
>> 
>> Well if you can tell us how to handle the data path I have no problems with it
>> to attach to the tty level.
> 
> If your port is closed you have no data path. If you are using uart you
> have no data path because while your patch hooks a helper that some uarts
> use some of the time it's optional and a lot of uarts don't use

I wasn't aware that lots of uart's don't use it. At least one is using it. I would have
to check which percentage is using it and which isn't. Thanks for pointing this
out.

> it, so
> its not even uart generic.

Understood. I wasn't aware of that.

I just was under the false impression that this is the recommended common
and a well designed (object oriented) interface. struct uart_port
being the object and the uart_ops assigned to it, being the list of methods
that can be applied to an uart_port.

http://lxr.free-electrons.com/source/Documentation/serial/driver#L14
http://lxr.free-electrons.com/source/include/linux/serial_core.h#L45
http://lxr.free-electrons.com/source/include/linux/serial_core.h#L235

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
