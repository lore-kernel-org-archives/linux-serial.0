From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] pl2303: fixed handling of CS5 setting. 5 databits work
 now
Date: Sun, 3 Nov 2013 18:13:56 +0100
Message-ID: <20131103171356.GD32672@localhost>
References: <CAAMgOiUAwXNYbfAicgq+k0OZfKN8--pgR_-zCVSC2wm90bww0A@mail.gmail.com>
 <20131103170423.GC32672@localhost>
 <CAMgPeKVinmcB7sDaTjU4LCA_AUY3QnxqoENBOmKsbpvk+9tDRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44557 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab3KCROD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Nov 2013 12:14:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMgPeKVinmcB7sDaTjU4LCA_AUY3QnxqoENBOmKsbpvk+9tDRw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Colin Leitner <colin.leitner@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-usb mailing list <linux-usb@vger.kernel.org>

On Sun, Nov 03, 2013 at 06:11:23PM +0100, Johan Hovold wrote:

> >> +       switch (C_CSIZE(tty)) {
> >> +       case CS5:
> >> +               buf[6] = 5;
> >> +               break;
> >> +       case CS6:
> >> +               buf[6] = 6;
> >> +               break;
> >> +       case CS7:
> >> +               buf[6] = 7;
> >> +               break;
> >> +       default:
> >
> > You can drop the default-case as CSIZE is a two-bit mask.

Nevermind. Just leave it there to keep gcc happy.

Thanks,
Johan

> +       case CS8:
> +               buf[6] = 8;
>         }
