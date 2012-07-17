From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 11/11] MAINTAINERS: add fblog entry
Date: Tue, 17 Jul 2012 14:57:03 +0200
Message-ID: <CAMuHMdXFfMv-DV-89nueyDJ5AvFN3AXR_6ysWOfCMDFL46s-Cg@mail.gmail.com>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	<1341784614-2797-12-git-send-email-dh.herrmann@googlemail.com>
	<CAMuHMdX_aC1hzKf1eRqoSsQ4oALBev8p77v7++aoB2KrkOUaEw@mail.gmail.com>
	<CANq1E4RyFpqxH=uG+dDA1=kfc3r8rCoEesZ31op9rCLjxyk6mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56863 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2GQM5F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jul 2012 08:57:05 -0400
In-Reply-To: <CANq1E4RyFpqxH=uG+dDA1=kfc3r8rCoEesZ31op9rCLjxyk6mQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org

On Mon, Jul 9, 2012 at 8:38 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ae8fe46..249b02a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2854,6 +2854,12 @@ F:       drivers/video/
>>>  F:     include/video/
>>>  F:     include/linux/fb.h
>>>
>>> +FRAMEBUFFER LOG DRIVER
>>> +M:     David Herrmann <dh.herrmann@googlemail.com>
>>> +L:     linux-serial@vger.kernel.org
>>
>> Why linux-serial, and not linux-fbdev?
>
> I thought fbcon was maintained on linux-serial as it is very related

It has always been maintained on linux-fbdev.

> to the vt/tty layer. If linux-fbdev is the better place, I can move
> this. I CC'ed both lists, anyway.
> I have actually no idea where it fits in best.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
