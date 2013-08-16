From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2 1/3] serial: sirf: drop redundant pinctrl_get_select_default
 as pinctrl core does it
Date: Sat, 17 Aug 2013 06:41:19 +0800
Message-ID: <CAGsJ_4wNx1NYZo3nK11PfnCRuPPT5zXoRGCquzbnMfyn0LGtkw@mail.gmail.com>
References: <1376520736-3838-1-git-send-email-Baohua.Song@csr.com> <CACRpkdYYRVROSO3DWDqpdomBbwPD7wL9GTGr8-xKEiLmm=cgeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40653 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab3HPWll (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 18:41:41 -0400
Received: by mail-qc0-f176.google.com with SMTP id u12so1405432qcx.35
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 15:41:39 -0700 (PDT)
In-Reply-To: <CACRpkdYYRVROSO3DWDqpdomBbwPD7wL9GTGr8-xKEiLmm=cgeA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

2013/8/16 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Aug 15, 2013 at 12:52 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> pinctrl core will get default pinmux, so drop it in the sirfsoc serial driver.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v2: rebase to tty-next
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Hi Linus, this has been applied, so i am not sure your ack can be added:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=a343756e07884e4cecd3a4297de7f121e5bb8829
>
> Yours,
> Linus Walleij

-barry
