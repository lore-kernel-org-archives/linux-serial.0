From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RESEND 1/2] 8250: pm callback for platform uarts
Date: Fri, 24 Sep 2010 19:15:49 +0200
Message-ID: <AANLkTin=OTRA-cYJyYUn7es6R3cpuZtTLgoggkXgeAnD@mail.gmail.com>
References: <1285344809-16839-1-git-send-email-manuel.lauss@googlemail.com>
	<20100924182258.34a76623@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55850 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0IXRTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2010 13:19:36 -0400
Received: by yxp4 with SMTP id 4so1026683yxp.19
        for <linux-serial@vger.kernel.org>; Fri, 24 Sep 2010 10:19:35 -0700 (PDT)
In-Reply-To: <20100924182258.34a76623@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

Hello,

On Fri, Sep 24, 2010 at 7:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
>> This patch adds a new pm field to the plat_8250_port and uart_port
>> structures and modifies the 8250 pm callback to call the platform
>> method before powering up and after powering down (if the platform
>> is capable of cutting power/clks to the block).
>
> This doesn't entirely make sense. Any hook in uart_port would be one =
to
> apply outside of 8250.c
>
> You also don't want platform specific stuff in the core 8250 code or =
to
> go removing stuff without being very careful about who or what uses i=
t.
>
>
>> + =A0 =A0 if ((p->port.pm) && (state !=3D 0)) =A0 =A0 =A0 /* power d=
own */
>
> Excess brackets

Gone,


>> + =A0 =A0 =A0 =A0 =A0 =A0 p->port.pm(port, state, oldstate);
>> =A0}
>>
>
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250=
=2Eh
>> index 7638dea..ce3af06 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -35,6 +35,8 @@ struct plat_serial8250_port {
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*set_termios)(struct uart_p=
ort *,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct ktermios *new,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct ktermios *old);
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*pm)(struct uart_port *, unsi=
gned int state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned old);
>> =A0};
>
> This bit makes sense - but why can't you simply propogate it to the
> existing uart_8250_port callback when registering ?


I need a hook for platform code to reenable the UART block clocks befor=
e
serial8250_set_sleep() is invoked on resume.  The current code actually
works, it's just that on resume the bootloader disables the clocks for
all UART blocks except the debug one, which leaves all others dead.

So I added the these calls into these platform methods around
serial8250_set_sleep().

Thanks!
      Manuel Lauss
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
