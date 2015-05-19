From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3] serial: 8250_uniphier: add UniPhier serial driver
Date: Tue, 19 May 2015 18:10:27 +0900
Message-ID: <CAK7LNAT0DKTkxeuuq2VQW2Rn4MrHTN+CLBXCjicQDb3aSjeQGw@mail.gmail.com>
References: <1431997900-18390-1-git-send-email-yamada.masahiro@socionext.com>
	<CABuKBeJwOp3Km=Vw+xn8cRtH8DC-TNB_m7s8WSdPxzKHdzrdcw@mail.gmail.com>
	<CAK7LNARrjkCcMsVJwe5hdB71QsEQAf51sNf4xYVMkNazdbdxKA@mail.gmail.com>
	<555AFB17.1050703@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555AFB17.1050703@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-serial@vger.kernel.org

2015-05-19 17:57 GMT+09:00 Jiri Slaby <jslaby@suse.cz>:
> On 05/19/2015, 10:54 AM, Masahiro Yamada wrote:
>>>> +#define UNIPHIER_UART_CHAR_FCR 3       /* Character / FIFO Control Register */
>>>> +#define UNIPHIER_UART_LCR_MCR  4       /* Line/Modem Control Register */
>>>> +#define     UNIPHIER_UART_LCR_SHIFT    8
>>>> +#define UNIPHIER_UART_DLR      9       /* Divisor Latch Register */
>>>
>>> Nit pick: Please fix identation. After "define" just put one blank.
>>> I personally prefer that the define values are aligned by tabs, but
>>> that's up tu you.
>>>
>>
>> I intentionally use deeper indentation for *_SHIFT
>> because I want to clearly show  UNIPHIER_UART_LCR_SHIFT
>> belongs to UNIPHIER_UART_LCR_MCR register.
>>
>> I also want to describe them within 80 columns including comments,
>> so I cannot insert extra TABs to align the values.
>
> Hi, what about one space between # and define which is used sometimes?


With more one space after #, '8' goes to the next stop,
so it makes no difference.


Is this a problem?  It almost seems a bike shed...



-- 
Best Regards
Masahiro Yamada
