From: Stas Sergeev <stsp-cmBhpYW9OiY@public.gmane.org>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Sat, 04 May 2013 01:50:42 +0400
Message-ID: <51843132.9040304@list.ru>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com> <5183FC83.8090602@list.ru> <20130503171618.GA16686@kroah.com> <51840186.7000608@list.ru> <20130503203419.GA25932@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130503203419.GA25932-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jarkko Huijts <jarkko.huijts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

04.05.2013 00:34, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, May 03, 2013 at 10:27:18PM +0400, Stas Sergeev wrote:
>> 03.05.2013 21:16, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>> Sounds like an application is doing a foolish thing and should stop=
 it.
>> Its not.
>> The app is quering only for _input_ (specifying only read fds
>> to select). But the select() in linux is implemented the way that
>> even when it polls for input, it will still call tty_chars_in_buffer=
()...
> I think that's the line dicipline doing this, not select itself.
Line discipline only provides the .poll method, like this:
---
static unsigned int n_tty_poll(struct tty_struct *tty, struct file *fil=
e,
poll_table *wait)
---
It doesn't look like the poll callback can find out whether it
is polling for input or for output. So it just returns all the flags
it can.
Any suggestions?

>>> There's no guarantee as to how long select or an ioctl will take, a=
nd
>>> now that we have fixed another bug, this device is slower.
>>>
>>> If you change hardware types to use a different usb to serial chip,=
 that
>>> select call might take 4 times as long.  Are we somehow supposed to
>>> change the kernel to "fix" that?
>> Previously, the kernel was not calling to a device at all, so
>> select() was independent of the chip, and it was fast. I was
>> not aware you changed that willingly.
> I don't understand, what do you mean by this?  Some drivers just retu=
rn
> the value of an internally held number, and don't query the device.
>
> The only way the FTDI driver can determine if the hardware buffer on =
the
> chip way out on the end of the USB cable is empty or not, is to query
> it.  So the driver now does so.
It does so only for one char. And the query takes longer than
to just xmit that char. So why do you think this even works as
expected?

>>>>>> I asked the customer to comment out
>>>>>> tty_chars_in_buffer(tty) < WAKEUP_CHARS
>>>>>> line in n_tty.c, and he said that cured his problems,
>>>>>> so I think my guess was right.
>>>>> What exactly is the "problem" being seen?
>>>> No idea.
>>>> Well, I can make a test-case that does 1000000 select() calls
>>>> in a loop and time it. This is probably the best I can do.
>>> That's really not a valid test case, as it's nothing that we ever
>>> optimize a serial driver for.  Throughput is the proper thing to ca=
re
>>> about, right?
>> Sure, but the throughput was not improved by the aforementioned
>> patch, so what was the upside of it?
>>
>>> To actually determine how many characters the device has in its buf=
fer.
>> You are adding only 1 char, but the time to query TEMT is
>> probably longer than to xmit 1 char. So how could it help
>> in some real scenario? When you done quering TEMT, the
>> char is actually already sent, so the effect is quite the reverse.
>>
>> My scenario is:
>> the app calls select() before xmitting every char.
> Every character?  Why?
Because, as I said, this polls for an input, not output...
Ah, wait, it also does TIOCOUTQ ioctl to find out just how
much is buffered. Are you suggesting to stop using TIOCOUTQ
too? Just because it stopped to work fast enough to be of any
use at all?

> Don't call select for every character :)
How about the "we do not break userspace" rule?
And oh yes, it polls just for an input...
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
