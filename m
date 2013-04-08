From: =?ISO-8859-1?Q?Hans_Beck=E9rus?= <hans.beckerus@gmail.com>
Subject: Re: Re[2]: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 17:57:53 +0200
Message-ID: <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
	<20130408150351.GA13824@kroah.com>
	<1365433602.618685252@f30.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:51316 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936752Ab3DHP5y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 11:57:54 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so1061161qcs.12
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 08:57:53 -0700 (PDT)
In-Reply-To: <1365433602.618685252@f30.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Thanks for the quick response guys.
Yes, putty is cross-platform, but I am actually running putty on
Windows ;) It connects over the serial device on my laptop to the
board running Linux. But Greg, you actually triggered me to check my
hardware configuration and guess what? I was using the wrong kind of
cable :) I used a simple male-female converter when I in fact had to
use a cable that swapped Rx/Tx. My bad! But I have yet one more issue
now. If I tell Linux to use my ttyUSB0 as console device on the boot
cmdline, would it actually be able to start it in time?

I am running with a 3.6 kernel btw.

Regards,
Hans


On Mon, Apr 8, 2013 at 5:06 PM, Alexander Shiyan <shc_work@mail.ru> wro=
te:
> Hello.
>
>> On Mon, Apr 08, 2013 at 03:37:42PM +0200, Hans Beck=E9rus wrote:
>> > I have some problems getting a USB serial adapter to work on our
>> > embedded Linux platform.
> ...
>> > But I am not able to connect to it through putty :(
>>
>> putty is a Windows program, how are you talking to it through your L=
inux
>> box?
>
> Putty is a cross-platform. I am using it on Gentoo ;)
>
> ---
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
