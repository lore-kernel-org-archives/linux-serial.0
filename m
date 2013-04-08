From: Hans Beckerus <hans.beckerus@gmail.com>
Subject: Re: USB serial support / Prolific PL2303 Driver
Date: Mon, 08 Apr 2013 19:35:49 +0200
Message-ID: <5162FFF5.6040403@gmail.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com> <20130408150351.GA13824@kroah.com> <1365433602.618685252@f30.mail.ru> <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com> <20130408160351.GB12665@kroah.com> <CAFyqS9qz+cHLY4zt1Bmuf6ubov57T3dKTP7B2d2g=ta=Qwg98g@mail.gmail.com> <20130408162945.GA26133@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:44585 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775Ab3DHRfy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 13:35:54 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so6008470lbd.30
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 10:35:52 -0700 (PDT)
In-Reply-To: <20130408162945.GA26133@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org

On 2013-04-08 6:29, Greg KH wrote:
> On Mon, Apr 08, 2013 at 06:20:23PM +0200, Hans Beck=E9rus wrote:
>> Sure, dmesg will show me the details, but I would really like to hav=
e
>> it in real-time ;) Actually when I set console=3DttyUSB0,115200 all =
I
>> get is the prompt :( Nothing comes out from the boot, and it does no=
t
>> seem to act as a real console either since any thing that usually po=
ps
>> up there are only showing in dmesg now.  Do I need to configure the
>> kernel in some specific way to support USB console mode?
> You do have:
> 	CONFIG_USB_SERIAL_CONSOLE
> enabled, right?
Hmm. Coming to think about it, no ;)
Will try it first thing tomorrow! Thanks.
> USB starts as one of the last things in the kernel boot process, so t=
he
> best you can ever get is a summary of what happened during the boot, =
not
> the kernel boot messages as they happen because they happen before th=
e
> USB device is initialized.
Sure. That is an acceptable limitation. However, I wonder if this will=20
be different once we get U-Boot USB console support on this platform?
Question though is if Linux  ever will be able to benefit from a first=20
stage driver already being kicked-off by U-Boot.

Hans

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
