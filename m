From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: The console log is doubled if earlycon is enabled
Date: Mon, 30 Nov 2015 11:27:41 +0900
Message-ID: <CAK7LNATW2EtdKYWUOrFgynoyHP9k5gh9dAMzgUM3HwYTN=eNHQ@mail.gmail.com>
References: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
	<CAHp75Ven8H1DYuTYcWRpt4rTxhS=P5r7VJ2ajpK8H7j+rgbMYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ven8H1DYuTYcWRpt4rTxhS=P5r7VJ2ajpK8H7j+rgbMYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

2015-11-29 11:30 GMT+09:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Fri, Nov 27, 2015 at 12:21 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi,
>>
>>
>> If I add "earlycon" to the kernel parameter, the log message
>> on the earlycon is also displayed to the regular console.
>> In other words, the same log messages are displayed twice.
>>
>> I noticed this problem on v4.4-rc1.
>> It has not been fixed in the mainline yet, I think.
>>
>> Anybody who has a clue?
>> (I have not done git-bisect yet.)
>
> Does adding the following line in
> drivers/tty/serial/8250/8250_early.c:: early_serial8250_setup() fix
> the issue?
>
> device->con->flags &= ~CON_PRINTBUFFER;


No. I tried that, but it did not fix the problem.


-- 
Best Regards
Masahiro Yamada
