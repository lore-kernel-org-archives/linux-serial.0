From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: debug tip after earlycon is closed?
Date: Wed, 27 Jul 2016 12:26:27 +0900
Message-ID: <CAK7LNAQ7Ta18KrQnE2b_zZqW8xc_r9vRjQHzXnSF8ssuEy9QKA@mail.gmail.com>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
 <20160727021748.GA9857@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727021748.GA9857@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Sebastian,


2016-07-27 11:17 GMT+09:00 Sebastian Reichel <sre@kernel.org>:
> Hi,
>
> On Wed, Jul 27, 2016 at 10:23:09AM +0900, Masahiro Yamada wrote:
>> When the kernel fails to boot and its log console is silent,
>> I use earlycon and I often find the cause of error with it.
>>
>> But, I have been wondering if there is an easy-to-use
>> debug tip which is available after earlycon is disabled.
>>
>> I noticed the current mainline would not boot on my ARMv8 board.
>> According to the following log, I am guessing something wrong
>> is happening after the "bootconsole [uniphier0] disabled" log.
>>
>> Is there a good practice to see more log?
>
> Documentation/kernel-parameters.txt
>         keep_bootcon    [KNL]
>                         Do not unregister boot console at start. This is only
>                         useful for debugging when something happens in the window
>                         between unregistering the boot console and initializing
>                         the real console.


I did not know this kernel parameter, and it is exactly what I wanted.
Thanks a lot!


-- 
Best Regards
Masahiro Yamada
