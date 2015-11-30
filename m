From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: The console log is doubled if earlycon is enabled
Date: Mon, 30 Nov 2015 14:53:49 +0900
Message-ID: <CAK7LNARFa8Q1t6RwwQVhTrtXJxnJBQw8QHnbpfNfHouEiGdK0w@mail.gmail.com>
References: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
	<20151128000451.GB22297@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151128000451.GB22297@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

2015-11-28 9:04 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Fri, Nov 27, 2015 at 07:21:06PM +0900, Masahiro Yamada wrote:
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
> Can you do 'git bisect'?


The same problem happened on v4.3.
(I think I just did not notice the problem before.)

So, the bad commit is not in the last merge window.



I also noticed the double-log happens depending on
how the console is specified.


[1]  Good case: both regular console and earlycon are specified via bootargs.

chosen {
         bootargs = "console=ttyS0,115200 earlycon=uniphier,mmio32,0x54006800";
};


[2] Bad case: regular console is given by stdout-path and earlycon is specified
               with parameters in bootargs.

chosen {
        bootargs = "earlycon=uniphier,mmio32,0x54006800";
        stdout-path = "serial0:115200n8";
};

The early boot log is doubled.


[3] Bad case: regular console is given by stdout-path and
              earlycon is given without parameters in bootargs

chosen {
        bootargs = "earlycon";
        stdout-path = "serial0:115200n8";
};

The early boot log is doubled.




According to the experiment results,
it looks like earlycon does not get along with stdout-path.



-- 
Best Regards
Masahiro Yamada
