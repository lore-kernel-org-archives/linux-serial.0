From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH] checkpatch: Add uart_ops to normally const structs
Date: Tue, 7 Apr 2015 09:55:20 +0200
Message-ID: <CALszF6CZTyo8e6Ywx5awbAmgJkCFNZcrkpxqkANS+QF_CxSd-A@mail.gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
	<1428083006.13180.35.camel@perches.com>
	<1428169651.2775.51.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428169651.2775.51.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@shadowen.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Joe,

2015-04-04 19:47 GMT+02:00 Joe Perches <joe@perches.com>:
> Add another struct to the list of normally const struct types
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> On Fri, 2015-04-03 at 10:43 -0700, Joe Perches wrote:
>> On Fri, 2015-04-03 at 19:01 +0200, Maxime Coquelin wrote:
>> > This drivers adds support to the STM32 USART controller, which is a
>> > standard serial driver.
>> trivia:
>> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> []
>> > +static struct uart_ops stm32_uart_ops = {
>> could be const
>> and it could be updated in a separate patch later too.
>
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>

For what it's worth, you can add:
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Regards,
Maxime
