From: Stas Sergeev <stsp@list.ru>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Sat, 04 May 2013 16:44:05 +0400
Message-ID: <51850295.6020601@list.ru>
References: <5183D196.2080305@list.ru> <20130503163008.GA30699@kroah.com> <5183F62A.1020801@list.ru> <20130503165231.GA1966@kroah.com> <5183FC83.8090602@list.ru> <20130503171618.GA16686@kroah.com> <51840186.7000608@list.ru> <20130503203419.GA25932@kroah.com> <51843132.9040304@list.ru> <20130504111535.GC16818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp46.i.mail.ru ([94.100.177.106]:54265 "EHLO smtp46.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab3EDLqB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 May 2013 07:46:01 -0400
In-Reply-To: <20130504111535.GC16818@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>

04.05.2013 15:15, Johan Hovold =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
Thanks for taking a look.
Indeed, it seems .wait_until_sent is the best candidate for that
kind of things, and the patch in question would even match its
description be it using .wait_until_sent and not .chars_in_buffer.
Please count on testing your patches here when they are ready.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
