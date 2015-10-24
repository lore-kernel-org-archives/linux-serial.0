From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: 8250_early: do not save and restore IER in write callback
Date: Sat, 24 Oct 2015 13:02:11 +0900
Message-ID: <CAK7LNAQa_M13UM2ruLuSGroOnejmJw3Fd2-fDgD2eJxm=F5Y=g@mail.gmail.com>
References: <1445502100-10860-1-git-send-email-yamada.masahiro@socionext.com>
	<562A2C01.4070006@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562A2C01.4070006@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

2015-10-23 21:45 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
> On 10/22/2015 04:21 AM, Masahiro Yamada wrote:
>> The IER has already been masked in early_serial8250_setup(), there is
>> no reason to save and restore it every time early_serial8250_write()
>> is called.
>>
>> Let wait_for_xmitr() melt into serial_putc().
>
> Both of these changes are ok with me, but please split this into
> 2 patches so reverting either one in case of regression is trivial.
>
> Regards,
> Peter Hurley


OK, will do.


-- 
Best Regards
Masahiro Yamada
