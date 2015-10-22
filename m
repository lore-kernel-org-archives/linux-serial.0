From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] serial: earlycon: allow to specify uartclk in
 earlycon kernel-parameter
Date: Thu, 22 Oct 2015 12:58:31 +0900
Message-ID: <CAK7LNAT-3Obf1QN4CZ2L83Vsf8iTB1OizRBCgvN4KFROy8Xoug@mail.gmail.com>
References: <1445312189-28876-1-git-send-email-yamada.masahiro@socionext.com>
	<1445312189-28876-3-git-send-email-yamada.masahiro@socionext.com>
	<5626491A.8040908@hurleysoftware.com>
	<CAK7LNAQYbg4L9dX4riQ8Zb_NN7pbhx60aXwb4rZJgdTz-pocsQ@mail.gmail.com>
	<562784AB.4040709@hurleysoftware.com>
	<CAK7LNAQaQjyDiL1+vbHNJRh8nnn9p9Jp1Ru4yn+MX5JzChKawg@mail.gmail.com>
	<5627B0DC.6000700@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5627B0DC.6000700@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

2015-10-22 0:35 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Masahiro,
>
> On 10/21/2015 11:31 AM, Masahiro Yamada wrote:
>> If it is always correct to preserve the initialization done by boot-loader,
>> the following code in 8250_early.c does not make sense.
>
> It's not always correct to preserve the initialization by the bootloader.
> For example, on my legacy x86 workstation, the bootloader does not
> initialize the h/w so when I want 8250 earlycon, I must specify the
> baud rate.

So, the input clock on the machine matches the following macro.

#define BASE_BAUD (1843200/16)


For ARM boards, we should depend on a boot loader.
Is this what you mean?

-- 
Best Regards
Masahiro Yamada
