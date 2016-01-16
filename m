From: Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sat, 16 Jan 2016 10:34:45 +0300
Message-ID: <744620565.20160116103445@cogentembedded.com>
References: <20150511013540.5709.93626.stgit@notabene.brown>
  <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
  <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
  <20160113191542.GA12086@leverpostej>
  <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
  <20160115110106.GA3262@leverpostej>
  <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
  <569913A1.80606@cogentembedded.com>
  <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
  <56992959.2020204@hurleysoftware.com>
  <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
Reply-To: Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi, Rob.

> On Fri, Jan 15, 2016 at 11:16 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>> On 01/15/2016 08:08 AM, H. Nikolaus Schaller wrote:
>>> Hi Andrey,
>>> ah that is fine to learn about another project that needs some solution (however it will look like).
>>>
>>> Am 15.01.2016 um 16:43 schrieb Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>:
>>>
>>>> Hi Nikolaus,
>>>>
>>>> H. Nikolaus Schaller wrote:

> [...]

>>>> There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).
>>>
>>> Exactly this is what we want to provide as API for the drivers by our patches to serial-core.c.
>>>
>>> We want to allow such a "partner" device to take a line-speed property e.g. from its DT node (or a 9600 constant as for our GPS chip) and ask the UART driver to set the required clocks. Or to get the driver notified that someone has opened the /dev/tty* etc. So make it possible to use some UART from another driver.
>>>
>>> In the long run it should be possible to use the UART even if there is no /dev/tty client or interface in user-space but that is something not perfectly working (there is some initialization race in the tty/serial subsystem we have not yet understood).
>>>
>>> As you see, I have a driver-specific standpoint (and not coming from user space).
>>>
>>> Thanks for sharing this example.
>>
>>
>> I'd like to see the exemplar slave driver be something more complicated than
>> trivial on-off, before hacking in junk into the serial core.
>>
>> As it stands, this gps could be supported on any uart driver that implements
>> mctrl gpios (which is trivial with the serial mctrl gpio helpers).
>>
>> Not that I'm against uart slave device support, just that I don't think hacks
>> is the way to go about it.

> I assume line disciplines seemed a good solution at the time, but they
> seem like a hack to me.
What would be best implementation in following use case:
- there are several microcontrollers/devices that use same protocol on top of UART (<STX>-<DATA>-<CRC>-<ETX>)
- microcontoller could provide several functions to system, e.g. watchdog, HWMON etc., that not require user space interaction
- there are several implementations of firmware that use different commands/events transferred as <DATA> and different <CRC> algorithms installed on several HW variants

If we take picture from Nikolaus's email:
device <--> uart <--> serial-core <-- new hooks ---> device driver <---> protocol interfaces

It would be nice to have a layer such as line discipline between serial core and device driver to use high level API to transfer data via UART.
But current implementation of line disciplines is intended to be used from user space and via tty layer.

>> What I'd like to see is a split of the serial core into a tty driver and a
>> standalone device abstraction. Anything else is just workarounds.

> +1 on that. We need a proper subsystem for in kernel drivers of
> connected UART devices.

Yes, such implementation will help. There is a need for interface like UART BUS that will probe devices without user space.
Serial I/O for input subsystem defines new type of bus and uses dedicated line discipline, but it still unable to start driver by itself and requires call from 'inputattach' to open port, assign line discipline and go to forever wait on 'read'.

> The kernel is where all the work is, not the DT bindings, so we should
> spend our time on the kernel side. There's already a fairly clean
> split between serial core and tty layer, so it should be possible to
> use serial core without too much surgery to all the UART drivers.

> Rob



-- 
Best regards,
Andrey Vostrikov

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
