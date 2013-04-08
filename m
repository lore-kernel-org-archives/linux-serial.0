From: =?ISO-8859-1?Q?Hans_Beck=E9rus?= <hans.beckerus@gmail.com>
Subject: Re: Re[2]: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 18:20:23 +0200
Message-ID: <CAFyqS9qz+cHLY4zt1Bmuf6ubov57T3dKTP7B2d2g=ta=Qwg98g@mail.gmail.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
	<20130408150351.GA13824@kroah.com>
	<1365433602.618685252@f30.mail.ru>
	<CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
	<20130408160351.GB12665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:59593 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934627Ab3DHQUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 12:20:24 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so2583142qca.18
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 09:20:23 -0700 (PDT)
In-Reply-To: <20130408160351.GB12665@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org

On Mon, Apr 8, 2013 at 6:03 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Apr 08, 2013 at 05:57:53PM +0200, Hans Beck=E9rus wrote:
>> Thanks for the quick response guys.
>> Yes, putty is cross-platform, but I am actually running putty on
>> Windows ;) It connects over the serial device on my laptop to the
>> board running Linux. But Greg, you actually triggered me to check my
>> hardware configuration and guess what? I was using the wrong kind of
>> cable :) I used a simple male-female converter when I in fact had to
>> use a cable that swapped Rx/Tx. My bad! But I have yet one more issu=
e
>> now. If I tell Linux to use my ttyUSB0 as console device on the boot
>> cmdline, would it actually be able to start it in time?
>
> Start in time for what?
>
Start in time for displaying boot progress. Sure, dmesg will show me
the details, but I would really like to have it in real-time ;)
Actually when I set console=3DttyUSB0,115200 all I get is the prompt :(
Nothing comes out from the boot, and it does not seem to act as a real
console either since any thing that usually pops up there are only
showing in dmesg now.
Do I need to configure the kernel in some specific way to support USB
console mode? This is my current cmdline btw:

console=3DttyUSB0,115200 root=3D/dev/ram rw ip=3D:::::eth0:off earlypri=
ntk

Ignore the ip section for now. It is just some old left overs ;)

> You can use USB to serial devices as console devices just fine.  I
> really don't recommend them, but if you have no other way to get a
> console, it's better than nothing.
>
Agree. But in this case a USB serial device is my only option :(

Regards,
Hans


On Mon, Apr 8, 2013 at 6:03 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Apr 08, 2013 at 05:57:53PM +0200, Hans Beck=E9rus wrote:
>> Thanks for the quick response guys.
>> Yes, putty is cross-platform, but I am actually running putty on
>> Windows ;) It connects over the serial device on my laptop to the
>> board running Linux. But Greg, you actually triggered me to check my
>> hardware configuration and guess what? I was using the wrong kind of
>> cable :) I used a simple male-female converter when I in fact had to
>> use a cable that swapped Rx/Tx. My bad! But I have yet one more issu=
e
>> now. If I tell Linux to use my ttyUSB0 as console device on the boot
>> cmdline, would it actually be able to start it in time?
>
> Start in time for what?
>
> You can use USB to serial devices as console devices just fine.  I
> really don't recommend them, but if you have no other way to get a
> console, it's better than nothing.
>
>> I am running with a 3.6 kernel btw.
>
> That's a bit out-of-date :)
>
> thanks,
>
> greg k-h


On Mon, Apr 8, 2013 at 6:03 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Apr 08, 2013 at 05:57:53PM +0200, Hans Beck=E9rus wrote:
>> Thanks for the quick response guys.
>> Yes, putty is cross-platform, but I am actually running putty on
>> Windows ;) It connects over the serial device on my laptop to the
>> board running Linux. But Greg, you actually triggered me to check my
>> hardware configuration and guess what? I was using the wrong kind of
>> cable :) I used a simple male-female converter when I in fact had to
>> use a cable that swapped Rx/Tx. My bad! But I have yet one more issu=
e
>> now. If I tell Linux to use my ttyUSB0 as console device on the boot
>> cmdline, would it actually be able to start it in time?
>
> Start in time for what?
>
> You can use USB to serial devices as console devices just fine.  I
> really don't recommend them, but if you have no other way to get a
> console, it's better than nothing.
>
>> I am running with a 3.6 kernel btw.
>
> That's a bit out-of-date :)
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
