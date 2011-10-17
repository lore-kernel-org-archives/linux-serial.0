From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: OMAP2+:UART driver help
Date: Mon, 17 Oct 2011 11:13:26 +0530
Message-ID: <CAAL8m4zbWxJk4X9N-=pX6fQLv+1zrE_949o3rwLNrd+sTtKraA@mail.gmail.com>
References: <51A4F524D105AA4C93787F33E2C90E62EE59C2@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42131 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1JQFnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Oct 2011 01:43:47 -0400
Received: by bkbzt19 with SMTP id zt19so3283782bkb.19
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2011 22:43:46 -0700 (PDT)
In-Reply-To: <51A4F524D105AA4C93787F33E2C90E62EE59C2@greysvr02.GreyInnovation.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Chiha <paul.chiha@greyinnovation.com>
Cc: linux-serial@vger.kernel.org

Hi Paul,

On Mon, Oct 17, 2011 at 10:18 AM, Paul Chiha
<paul.chiha@greyinnovation.com> wrote:
> Hi,
>
> I'm a newbie and would like some help with serial drivers in the kern=
el.
>
> I've got an OMAP35x EVM (with UARTs 1/2-3 on board), and I would like=
 to
> write
> my own driver which uses UART 3. =A0I'm not sure of the best way to d=
o
> this.

Most use cases tend to use omap-serial itself with a client driver,
for any client peripheral over uart.

> I don't know how to use the existing ttyO2 device and omap-serial dri=
ver
> for my
> own purpose. =A0Basically I want to write a driver which sits between=
 the
> application and the omap-serial driver, but only for UART 3. =A0Is th=
ere a
> simple
> mechanism to do this, or do I need to replace omap_serial with my own=
?

I don't know why you want to do that rather use the existing uart drive=
r,
for any console usage you can pass console parameter from bootargs
and works well, for any use case from user space application can open
UART3(ttyO2) configure it using termios ops and use it.

How is your use case very different from these?

If you have a device connected over UART and want to controlled
then, you may consider intermediate layer as ldisc layer.
ex: TI Bluetooth driver "drivers/misc/ti-st/st_core.c"


> Also,
> is there an existing driver that does something similar to what I wan=
t
> that I
> can base my driver on?

I dont see any such driver other omap-serial which supports omap-uarts,
but AFAIK you cannot add stuffs in that driver for a particular use cas=
e.

--
Thanks,
Govindraj.R

>
> Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
