From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Re[2]: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 09:03:51 -0700
Message-ID: <20130408160351.GB12665@kroah.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
 <20130408150351.GA13824@kroah.com>
 <1365433602.618685252@f30.mail.ru>
 <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56654 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3DHQDz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 12:03:55 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so3309789pab.21
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 09:03:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hans =?iso-8859-1?Q?Beck=E9rus?= <hans.beckerus@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Apr 08, 2013 at 05:57:53PM +0200, Hans Beck=E9rus wrote:
> Thanks for the quick response guys.
> Yes, putty is cross-platform, but I am actually running putty on
> Windows ;) It connects over the serial device on my laptop to the
> board running Linux. But Greg, you actually triggered me to check my
> hardware configuration and guess what? I was using the wrong kind of
> cable :) I used a simple male-female converter when I in fact had to
> use a cable that swapped Rx/Tx. My bad! But I have yet one more issue
> now. If I tell Linux to use my ttyUSB0 as console device on the boot
> cmdline, would it actually be able to start it in time?

Start in time for what?

You can use USB to serial devices as console devices just fine.  I
really don't recommend them, but if you have no other way to get a
console, it's better than nothing.

> I am running with a 3.6 kernel btw.

That's a bit out-of-date :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
