From: Sudhir Sreedharan <ssreedharan@mvista.com>
Subject: Re: [PATCH] serial/core: Initialize the console pm state
Date: Mon, 6 Oct 2014 15:18:15 +0530
Message-ID: <CAJJ77Wsec5TbeQrKsa2qU9c=SsQdFoSZC5RpXadwdNKYAjDPdw@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
	<CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
	<CAMuHMdWwEoK__-qTdUmzx6vJJSQ1+XdvL3nZukUX_RjM1tDVGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33961 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaJFJsP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2014 05:48:15 -0400
Received: by mail-ob0-f182.google.com with SMTP id uy5so3659068obc.27
        for <linux-serial@vger.kernel.org>; Mon, 06 Oct 2014 02:48:15 -0700 (PDT)
In-Reply-To: <CAMuHMdWwEoK__-qTdUmzx6vJJSQ1+XdvL3nZukUX_RjM1tDVGA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, lkml <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Geert,

On Fri, Oct 3, 2014 at 5:52 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Oct 1, 2014 at 7:27 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
>> <ssreedharan@mvista.com> wrote:
>>> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
>>> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
>>> are reinitialized when uart_change_pm is called from uart_configure_port.
>>>
>>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>>
>> Multiple boot failures on ARM[1] were bisected down to this patch.
>>
>> How was this patch tested, and on which platforms?
>>
>> Also, the changelog states that this should be done only for
>> UART_CAP_SLEEP, but the patch does it for every UART.
>>
>> Greg, I suggest this patch be dropped from tty-next until it has been
>> better described and tested.
>>
>> Kevin
>>
>> [1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-October/005550.html
>
> Perhaps it should call "uart_change_pm(state, UART_PM_STATE_ON)"
> instead, so the driver's .pm() method is called?
>

If  "uart_change_pm(state, UART_PM_STATE_ON);" is called, it will
reinitialize the LCR register, thus changing the configuration of
console port. This will throw garbage characters from the point where
the serial driver initializes till startup is called from userland.

Thanks,
Sudhir
