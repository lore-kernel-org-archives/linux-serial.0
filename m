From: Stas Sergeev <stsp@list.ru>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Fri, 03 May 2013 22:27:18 +0400
Message-ID: <51840186.7000608@list.ru>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com> <5183FC83.8090602@list.ru> <20130503171618.GA16686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp18.mail.ru ([94.100.176.155]:33511 "EHLO smtp18.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933739Ab3ECR3H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 May 2013 13:29:07 -0400
In-Reply-To: <20130503171618.GA16686@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>

03.05.2013 21:16, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Sounds like an application is doing a foolish thing and should stop i=
t.
Its not.
The app is quering only for _input_ (specifying only read fds
to select). But the select() in linux is implemented the way that
even when it polls for input, it will still call tty_chars_in_buffer().=
=2E.

> There's no guarantee as to how long select or an ioctl will take, and
> now that we have fixed another bug, this device is slower.
>
> If you change hardware types to use a different usb to serial chip, t=
hat
> select call might take 4 times as long.  Are we somehow supposed to
> change the kernel to "fix" that?
Previously, the kernel was not calling to a device at all, so
select() was independent of the chip, and it was fast. I was
not aware you changed that willingly.

>>>> I asked the customer to comment out
>>>> tty_chars_in_buffer(tty) < WAKEUP_CHARS
>>>> line in n_tty.c, and he said that cured his problems,
>>>> so I think my guess was right.
>>> What exactly is the "problem" being seen?
>> No idea.
>> Well, I can make a test-case that does 1000000 select() calls
>> in a loop and time it. This is probably the best I can do.
> That's really not a valid test case, as it's nothing that we ever
> optimize a serial driver for.  Throughput is the proper thing to care
> about, right?
Sure, but the throughput was not improved by the aforementioned
patch, so what was the upside of it?

> To actually determine how many characters the device has in its buffe=
r.
You are adding only 1 char, but the time to query TEMT is
probably longer than to xmit 1 char. So how could it help
in some real scenario? When you done quering TEMT, the
char is actually already sent, so the effect is quite the reverse.

My scenario is:
the app calls select() before xmitting every char. It seems
it can never fill up the output buffer now, so the throughput
have suffered.
What would you suggest to improve it?
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
