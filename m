From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Wed, 29 Oct 2014 07:53:19 -0400
Message-ID: <5450D52F.7040304@hurleysoftware.com>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com> <20141029085128.GC7841@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141029085128.GC7841@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Janne Huttunen <jahuttun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/29/2014 04:51 AM, Johan Hovold wrote:
> [ +CC: Peter, linux-serial ]
> 
> On Wed, Oct 29, 2014 at 10:07:26AM +0200, Janne Huttunen wrote:
>> I own a device that implements a data logging interface using the
>> FT232 USB-serial -chip. Very often it happens that connecting the
>> associated software with the device requires multiple attempts.
>> There seems to be two kinds of issues; either the program reports
>> that it did not receive any data or it reports reading lots of
>> data, but it was all invalid. I haven't yet looked at the former,
>> but I did spend some time investigating the latter.
>>
>> Simple strace of the program startup showed that when connecting
>> fails, the program gets a lot (hundreds) of binary zeros while
>> reading the device.

So you're only getting status and not data.

> I used usbmon to capture the traffic between
>> the host and the device and the zeros are not strictly speaking
>> coming from the device. However when this problem happens the
>> device seems to report quite lot of overruns for a while, which
>> was a clue. After a somewhat successful attempt to understand
>> the operation of the tty code in Linux, I have a theory.
>>
>> The usbserial driver sets the TTY_DRIVER_REAL_RAW flag. Based on
>> the comment in tty_driver.h this implies that the driver is not
>> supposed to report any statuses (including overruns) to ldisc
>> if they are ignored by the application (like they are in this
>> case). It's just that AFAICS the ftdi_sio subdriver (and many
>> others) doesn't seem quite honor this, but seems to report any
>> status unconditionally. Also AFAICS this then means that every
>> overrun will get converted into single binary zero delivered to
>> the application(?). If so, this probably isn't what is supposed
>> to happen and would explain the flood of extraneous zeros the
>> application was seeing when the connecting failed.
>>
>> I haven't had yet the time to test this theory, but at least it
>> seems plausible to me. Any thoughts, anybody?
> 
> You are correct. The usb-serial drivers, and at least some serial
> drivers, fail to implement TTY_DRIVER_REAL_RAW correctly in that they
> do not honour ((IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR || !INPCK)).

These settings are a constant source of bugs in serial drivers.
We really need to abstract the way these settings are processed;
even the 8250 driver is getting this wrong.

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
