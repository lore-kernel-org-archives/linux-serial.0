From: Sudhir Sreedharan <ssreedharan@mvista.com>
Subject: Re: [PATCH] serial/core: Initialize the console pm state
Date: Mon, 6 Oct 2014 14:57:37 +0530
Message-ID: <CAJJ77WvDaM2MmC_r9Wop68++L0FfaRmq6oiXTp+GdqcaKKwSBw@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
	<CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57609 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaJFJ1h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2014 05:27:37 -0400
Received: by mail-ob0-f173.google.com with SMTP id wp4so3577422obc.4
        for <linux-serial@vger.kernel.org>; Mon, 06 Oct 2014 02:27:37 -0700 (PDT)
In-Reply-To: <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, lkml <linux-kernel@vger.kernel.org>, olof@lixom.net, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On Wed, Oct 1, 2014 at 10:57 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
> <ssreedharan@mvista.com> wrote:
>> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
>> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
>> are reinitialized when uart_change_pm is called from uart_configure_port.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Multiple boot failures on ARM[1] were bisected down to this patch.
>
> How was this patch tested, and on which platforms?



This patch was tested on x86-64(haswell) board, which uses ST16650V2
uart(which has UART_CAP_SLEEP).
While serial driver gets initialized, console port LCR register is
getting reinitalized to 0.
Then boot logs will be seen as garbage characters.

I will re-check why this failed on the boards/archs you mentioned.

Thanks,
Sudhir
