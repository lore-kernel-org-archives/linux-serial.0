From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: kmscon: replacing CONFIG_VT
Date: Sat, 19 May 2012 10:48:38 +0200
Message-ID: <CANq1E4SwyzLW61v-nrYu2gBvqbuzUNqTkK2cZzbv1ZZNBmWBBg@mail.gmail.com>
References: <CANq1E4SGoRZaGjNZqPOA6g4COQmXxNr4kFBPMhxAonZqO_aOtQ@mail.gmail.com>
	<20120516171421.5fca49f3@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55117 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596Ab2ESIsk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 May 2012 04:48:40 -0400
Received: by weyu7 with SMTP id u7so2243689wey.19
        for <linux-serial@vger.kernel.org>; Sat, 19 May 2012 01:48:38 -0700 (PDT)
In-Reply-To: <20120516171421.5fca49f3@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Alan

On Wed, May 16, 2012 at 6:14 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> That's just some of my ideas on this topic. Maybe you can give me some
>> hints whether it actually makes sense ;)
>
> For a lot of hardware it may not matter. If it goes bang you boot with a
> debugging kernel (one containing a vt driver)
>
> If your user space goes castors up early then you are going to need input
> facilities anyway (consider the fedora rescue mode in dracut for example)

So you are basically saying that such an drmcon driver isn't needed,
anyway? If we keep backwards compatibility to CONFIG_VT, everyone who
wants a boot-log on the display just needs to enable CONFIG_VT. Sounds
reasonable.

> As far as compatibility goes we have the ttyprintk driver which just
> provides a fake tty which types nothing and whose output goes to the
> console.

I haven't found any applications that fail without /dev/tty, however,
thanks for the hint.

> Alan

Thanks for the answers. So I can concentrate on the user-space parts
and maybe later implement some drmcon'ish driver.

Regards
David
