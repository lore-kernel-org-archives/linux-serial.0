From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Re[2]: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 09:29:45 -0700
Message-ID: <20130408162945.GA26133@kroah.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
 <20130408150351.GA13824@kroah.com>
 <1365433602.618685252@f30.mail.ru>
 <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
 <20130408160351.GB12665@kroah.com>
 <CAFyqS9qz+cHLY4zt1Bmuf6ubov57T3dKTP7B2d2g=ta=Qwg98g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:35728 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934779Ab3DHQ37 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 12:29:59 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so2670529dan.38
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 09:29:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFyqS9qz+cHLY4zt1Bmuf6ubov57T3dKTP7B2d2g=ta=Qwg98g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hans =?iso-8859-1?Q?Beck=E9rus?= <hans.beckerus@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org

On Mon, Apr 08, 2013 at 06:20:23PM +0200, Hans Beck=E9rus wrote:
> Sure, dmesg will show me the details, but I would really like to have
> it in real-time ;) Actually when I set console=3DttyUSB0,115200 all I
> get is the prompt :( Nothing comes out from the boot, and it does not
> seem to act as a real console either since any thing that usually pop=
s
> up there are only showing in dmesg now.  Do I need to configure the
> kernel in some specific way to support USB console mode?

You do have:
	CONFIG_USB_SERIAL_CONSOLE
enabled, right?

USB starts as one of the last things in the kernel boot process, so the
best you can ever get is a summary of what happened during the boot, no=
t
the kernel boot messages as they happen because they happen before the
USB device is initialized.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
