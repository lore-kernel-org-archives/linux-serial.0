From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 4/6] serial: 8250/uniphier: fix modular build
Date: Fri, 12 Feb 2016 19:38:42 +0900
Message-ID: <CAK7LNATEhZuqkMaEONu7tDBzWnTqS527c0N0vuOKRJuPeeQSDA@mail.gmail.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
	<1455205297-1021302-5-git-send-email-arnd@arndb.de>
	<CAK7LNAR8fJWPubucjw28gAPpF-4yvVMWZZ0F3j6VN4whGF9Yhw@mail.gmail.com>
	<3557175.oOjJgCHd2P@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3557175.oOjJgCHd2P@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,


2016-02-12 19:07 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 12 February 2016 18:37:08 Masahiro Yamada wrote:
>> >  };
>> >
>> > -#ifdef CONFIG_SERIAL_8250_CONSOLE
>> > +#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
>> >  static int __init uniphier_early_console_setup(struct earlycon_device *device,
>> >                                                const char *options)
>> >  {
>> > --
>> > 2.7.0
>> >
>>
>> I noticed commit 2eaa790989e03900298ad24f77f1086dbbc1aebd
>> revived this link error, but I am not happy with seeing
>> this patch again and again.
>>
>>
>> Can you check this patch?
>> https://patchwork.kernel.org/patch/8289231/
>>
>>
>>
>
> Yes, I think your patch is nicer than mine. Let's see what the others
> think, then I can resend my remaining patches on top of yours.

OK, thanks!

I noticed some typos, so I've posted v2.
(no change in code-diff).



-- 
Best Regards
Masahiro Yamada
