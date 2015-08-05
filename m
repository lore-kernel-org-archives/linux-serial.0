From: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Subject: Re: g_serial hangs on write when the cable is disconnected
Date: Wed, 5 Aug 2015 16:40:21 +0100
Message-ID: <CAOMwXhM7TNZAGOUAC=gcwjqTz8y7FGs0FRbJb4SQO+VfbzYJJA@mail.gmail.com>
References: <CAOMwXhNwVKCK1+-q+fAgMc0ebpremXd+S1kUvZ9Ank-5BTMLCA@mail.gmail.com>
	<20150805145627.GA610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805145627.GA610-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 5, 2015 at 3:56 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Aug 05, 2015 at 11:05:56AM +0100, Laszlo Papp wrote:
>> Hi,
>>
>> The code below reproduces the issue. The code is intentionally kept
>> small, so it deliberately does not have error checking, et al.
>>
>> Now, my concern is that it blocks for the write operation if the cable
>> is disconnected. This is not inline with the /dev/ttyS* operation, for
>> instance. They would not block if I disconnected the serial cable.
>>
>> Is this a bug or feature? :-) If it turns out to be a feature, is it
>> better to use O_NONBLOCK if one does not want to use pthreads, etc?
>>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>>
>> int main()
>> {
>>     const char buf[] = "Hello World!\n";
>>     int fd = open("/dev/ttyGS0", O_RDWR | O_NONBLOCK);
>
> This line discipline is very different from the "traditional" tty line
> discipline, so it might not know anything about cable removals.
>
> good luck,
>
> greg k-h
> --

Thank you for your prompt reply.

Wow, I managed to mess it up in my original email! So, this code above
made it working, but without O_NONBLOCK, it was not working. Using
O_NONBLOCK is my current nasty workaround. As you are indicating it,
this does not quite feel right, does it! I am not sure what the right
thing would be to do in order to get write non-blocking for g_serial.
I hope that someone with more knowledge about it than me could help
out!

Thank you in advance.


> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
