From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Wed, 19 Oct 2011 09:19:54 +0800
Message-ID: <CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com> <20111018181319.GA7015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54392 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1JSBUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Oct 2011 21:20:15 -0400
Received: by bkbzt19 with SMTP id zt19so1439327bkb.19
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2011 18:20:14 -0700 (PDT)
In-Reply-To: <20111018181319.GA7015@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org

2011/10/19 Greg KH <greg@kroah.com>:
> On Tue, Oct 18, 2011 at 11:39:11AM +0800, Barry Song wrote:
>> 2011/10/14 Barry Song <Barry.Song@csr.com>:
>> > From: Rong Wang <Rong.Wang@csr.com>
>> >
>> > SiRFprimaII is the latest generation application processor from CS=
R=E2=80=99s
>> > multi-function SoC product family.
>> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainl=
ine
>> > 3.0.
>> >
>> > There are three dedicated UARTs in system. This patch adds basic d=
river
>> > support for them.
>> >
>> > It has used the newest pinmux subsystem from Linus Walleij.
>>
>> Hi Alan, it means this patch doesn't compile until pinmux tree of
>> Linus Walleij is merged into mainline.
>> Now it is a linux next tree.
>
> So should it go through the pinmux tree? =C2=A0Or do you want to wait=
 for the
> 3.3 kernel release to get this merged?

i think we can go ahead through Linux W's pinmux tree. Linus, would
you like to take care once Alan ack this.

>
> thanks,
>
> greg k-h

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
