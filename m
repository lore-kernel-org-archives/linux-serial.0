From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 2/2 v2] serial: Add support for Fintek F81216A LPC to 4 UART
Date: Wed, 8 Oct 2014 17:53:15 +0200
Message-ID: <CAPybu_3xUeYQ=3t-wvdH_b+45e5bNzw4hvc=Fu5y1g=gaOsLTA@mail.gmail.com>
References: <CAPybu_1Ma+7nGaS0e17HpPcM1vk6ANSFN3C8MNR=JxWrBBmMOA@mail.gmail.com>
 <1406834546-23033-1-git-send-email-ricardo.ribalda@gmail.com>
 <20140801132343.45153300@alan.etchedpixels.co.uk> <CAPybu_2U2jjyY_9gji41mUc5F4N+idDVNO=LAr3F5PpJ0JzYSg@mail.gmail.com>
 <20140805103409.33afef2a@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:62556 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbaJHPxg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2014 11:53:36 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so7828333qcx.15
        for <linux-serial@vger.kernel.org>; Wed, 08 Oct 2014 08:53:35 -0700 (PDT)
In-Reply-To: <20140805103409.33afef2a@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Hello Alan

I have merged all the the rs485 iocts in serial_core. So now there is
only two TIOC[GS]RS485  handling code (one in serial_core, and one in
crisv10).


ricardo@neopili:~/curro/qtec/linux-upstream$ git grep TIOCGRS drivers
drivers/tty/serial/crisv10.c:   case TIOCGRS485:
drivers/tty/serial/serial_core.c:       case TIOCGRS485:


ricardo@neopili:~/curro/qtec/linux-upstream$ git diff --stat
69784fa539efa477f39b5a849c27d5e630e0db27
 drivers/tty/serial/8250/8250_core.c   | 41
++---------------------------------------
 drivers/tty/serial/8250/8250_fintek.c |  8 +++++---
 drivers/tty/serial/atmel_serial.c     | 78
+++++++++++++++++++++++-------------------------------------------------------
 drivers/tty/serial/max310x.c          | 72
++++++++++++++++++++++++++----------------------------------------------
 drivers/tty/serial/mcf.c              | 37
+++++++------------------------------
 drivers/tty/serial/omap-serial.c      | 69
+++++++++++++++++++++------------------------------------------------
 drivers/tty/serial/sc16is7xx.c        | 57
++++++++++++---------------------------------------------
 drivers/tty/serial/serial_core.c      | 38
++++++++++++++++++++++++++++++++++++++
 include/linux/serial_8250.h           |  3 ---
 include/linux/serial_core.h           |  3 +++
 10 files changed, 137 insertions(+), 269 deletions(-)

Shall I send it to the list, or you are almost done with your patch?
Of course as a next iteration I can move it to the tty layer, but I
think it looks more elegant this way.

Best regards!


On Tue, Aug 5, 2014 at 11:34 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Fri, 1 Aug 2014 14:28:11 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
>> Hello
>>
>> >> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> >
>> > This half of things looks good to me.
>>
>>
>> Thanks!, What about the other half? Would you accept a two step approach?
>>
>> 1st: add support for 8250_core
>> 2nd: handle rs485 ioctl on serial_core and modify all the other
>> drivers to use that? (to avoid code duplication)
>
> We really want to handle it at the tty layer I think not at serial_core.
> I have a patch for that and I'm playing with it but it's taking longer
> than I hoped.
>
> In the mean time I think your patch #1 is ok except for the trivial
> item that I'd prefer the struct serial_rs485 was further down the struct
> uart_8250_port. It's packed so that the bits you need most are in the
> first cache line or two.
>
> Alan



-- 
Ricardo Ribalda
