From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Sat, 04 May 2013 07:39:57 -0400
Message-ID: <5184F38D.9090507@hurleysoftware.com>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com> <5183FC83.8090602@list.ru> <20130503171618.GA16686@kroah.com> <51840186.7000608@list.ru> <20130503203419.GA25932@kroah.com> <51843132.9040304@list.ru> <20130504111535.GC16818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130504111535.GC16818@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Stas Sergeev <stsp@list.ru>, Greg KH <gregkh@linuxfoundation.org>, Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-serial@vger.kernel.org

On 05/04/2013 07:15 AM, Johan Hovold wrote:
> On Sat, May 04, 2013 at 01:50:42AM +0400, Stas Sergeev wrote:
>> 04.05.2013 00:34, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Fri, May 03, 2013 at 10:27:18PM +0400, Stas Sergeev wrote:
>>>> 03.05.2013 21:16, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> [...]
>
>>>>> There's no guarantee as to how long select or an ioctl will take,=
 and
>>>>> now that we have fixed another bug, this device is slower.
>>>>>
>>>>> If you change hardware types to use a different usb to serial chi=
p, that
>>>>> select call might take 4 times as long.  Are we somehow supposed =
to
>>>>> change the kernel to "fix" that?
>>>> Previously, the kernel was not calling to a device at all, so
>>>> select() was independent of the chip, and it was fast. I was
>>>> not aware you changed that willingly.
>>> I don't understand, what do you mean by this?  Some drivers just re=
turn
>>> the value of an internally held number, and don't query the device.
>>>
>>> The only way the FTDI driver can determine if the hardware buffer o=
n the
>>> chip way out on the end of the USB cable is empty or not, is to que=
ry
>>> it.  So the driver now does so.
>> It does so only for one char. And the query takes longer than
>> to just xmit that char. So why do you think this even works as
>> expected?
>
> The query takes longer than the transmit at decent baudrates (>=3D38k=
)
> and under the assumption that flow control isn't causing any delays.
>
> But you do have a point, and I have been meaning to look into whether
> the added overhead of checking the hardware buffers could be mitigate=
d
> by adding wait_until_sent support to usb-serial. This way the we woul=
d
> only query the hardware buffers on tty_wait_until_sent (e.g. at close=
)
> and select and TIOCMOUTQ would not suffer. This is also the way thing=
s
> are handled in serial_core.

Agreed. This is the correct solution.

> I'll prepare a series which adds wait_until_sent to usb-serial, but I
> doubt it would be stable material (even if it could get into 3.10).
>
> What do you think Greg, is this overhead to chars_in_buffer reason
> enough to disable it in the stable trees or should we simply fix it i=
n
> 3.11 (or 3.10)? (The overhead is about 3-400 us per call when the por=
t
> fifo is empty, which makes chars_in_buffer about 100 times slower on =
my
> test system.)

A better solution for stable would be to set port->drain_delay. It
won't help tcdrain() but at least the port won't shutdown on live
outbound data.

Regards,
Peter Hurley
