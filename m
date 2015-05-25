From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: 8250: remove return statements from void function
Date: Mon, 25 May 2015 10:53:03 +0900
Message-ID: <CAK7LNARZfr4OS0oS_sGr1zG=G+=pwzCPZNGSC+_wi3+pRza=_A@mail.gmail.com>
References: <1431315022-10526-1-git-send-email-yamada.masahiro@socionext.com>
	<20150524194609.GB18445@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150524194609.GB18445@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
List-Id: linux-serial@vger.kernel.org

2015-05-25 4:46 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, May 11, 2015 at 12:30:22PM +0900, Masahiro Yamada wrote:
>> serial8250_set_mctrl() is a void type function.  Returning something
>> does not look nice.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/tty/serial/8250/8250_core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index 4882027..146f56c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -2019,8 +2019,9 @@ EXPORT_SYMBOL_GPL(serial8250_do_set_mctrl);
>>  static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  {
>>       if (port->set_mctrl)
>> -             return port->set_mctrl(port, mctrl);
>> -     return serial8250_do_set_mctrl(port, mctrl);
>> +             port->set_mctrl(port, mctrl);
>> +     else
>> +             serial8250_do_set_mctrl(port, mctrl);
>>  }
>
> You just changed the logic here!


Could you tell me why?

The logic still looks the same to me.




-- 
Best Regards
Masahiro Yamada
