From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
Date: Fri, 07 Nov 2014 11:04:27 +0100
Message-ID: <545C992B.1070004@elproma.com.pl>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <545B57D7.4070609@elproma.com.pl> <CAMiH66FKJm8hcgtR=-ZzzpCq+PQ8xkixbUnMzRPVd_cM_6VM1w@mail.gmail.com> <201411070903.11645.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:55001 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750957AbaKGKE2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 05:04:28 -0500
In-Reply-To: <201411070903.11645.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Huang Shijie <shijie8@gmail.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


W dniu 2014-11-07 o 09:03, Marek Vasut pisze:
> On Friday, November 07, 2014 at 02:34:31 AM, Huang Shijie wrote:
>> why change them to gpio?

Hardware RTS/CTS lines can be occupied by RX/TX of other AUART port
in order to obtain as much uarts as possible using i.mx283.
Therefore gpios can be used for "hardware" flow control.

>>    If we change them to gpio.  Could the DMA still
>> works fine?
>> did you test the DMA with this patch?
>>
>> Add Marek for this patch too.
> I didn't look too deep into the patch, so here's just my experience:
>
> 1) The AUART block signals and GPIO block signals are not sychronised using the
>     same clock. Therefore, the latency between toggling of the AUART lines and
>     the GPIO-driven pins will not be deterministic and will vary. There might be
>     a way to approximate that, but that's definitelly not a reliable solution.
>
>     This is very bad for example if you drive RS485 DIR line with the RTS pin as
>     a GPIO ; the RTS pin will toggle at non-deterministic time compared to the
>     end of UART transmission. This will trigger bit-loss on the RS485 line and
>     you just don't want that.
>
> 2) Speaking of RS485, there's [1] and [2]. which I believe apply to any combo
>     of UART+GPIO toggling.
>
> So I hate to bring the bad news , but UART+GPIO combo toggling is really a bad
> bad idea.

Unfortunately if hardware is limited there is no choice and UART+GPIO is 
necessary.

Your experience confirms the discussion [3] with Russell King. DMA 
should be disabled and
the patch disables DMA support in mxs_auart_init_gpios() if RTS or CTS 
line is set as gpio.
So I didn't test the patch with the DMA - I've just disabled it.

The question is different. The driver supports the cases for RTS/CTS:
1)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
      DT sets fsl,uart-has-rtscts)
     a) settermios() sets CRTSCTS: DMA enabled, auto RTS/CTS is enabled
     b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS 
controlled by get/set_mctrl()
2)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
      DT doesn't set fsl,uart-has-rtscts)
     a) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enabled
     b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS 
controlled by get/set_mctrl()

and after the patch it is more complex (because of mixed cases):
3) both RTS/CTS assigned to gpios (DT sets or not fsl,uart-has-rtscts):
     the patch cancels fsl,uart-has-rtscts flag to disable DMA support,
     settermios() sets or not CRTSCTS: DMA disabled, RTS/CTS controlled 
by get/set_mctrl(),
     both lines by gpios. In addition:
     a) settermios() doesn't set CRTSCTS: RTS of hardware AUART is also 
controlled but
         the case assumes it is not selected by pinmux in DT
     b) settermios() sets CRTSCTS: auto RTS of hardware AUART is also 
enabled but
         the case assumes it is not selected by pinmux in DT
4) RTS assigned to hardware AUART (pinmux configured by DT, 
fsl,uart-has-rtscts set or not),
     CTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag to 
disable DMA support,
     a) settermios() doesn't set CRTSCTS: DMA disabled, CTS (as gpio) 
read by get_mctrl(),
         RTS of hardware AUART controlled by set_mctrl()
     b) settermios() sets CRTSCTS: DMA disabled, CTS (as gpio) read by 
get_mctrl(),
        auto RTS is enabled
    So case 4) is exactly 3) case with just different pinmux 
configuration and the patch
    threats 3) and 4) as the same case.
5) CTS assigned to hardware AUART (pinmux configured by DT, 
fsl,uart-has-rtscts set or not),
     RTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag to 
disable DMA support,
     a) settermios() doesn't set CRTSCTS: DMA disabled, CTS of hardware 
AUART read by
         get_mctrl(), RTS (as gpio) controlled by set_mctrl(), in 
addition RTS of hardware AUART
         is also controlled but the case assumes it is not selected by 
pinmux in DT
     b) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enabled but
         RTS is controlled by set_mctrl() as gpio because the case 
assumes it is not selected
         by pinmux in DT

It is not nice description but I hadn't idea how to write it more clear.
The mixed cases 4) and 5) are likely not so useful but possible and not 
so expensive
to support.
Now the question: "fsl,uart-has-rtscts" name seems to be misleading now,
do you agree? It rather should include "dma" word in the name. Any 
suggestion?

[3] http://thread.gmane.org/gmane.linux.serial/16069/focus=16077

best regards
Janusz

> HTH
>
> [1] http://comments.gmane.org/gmane.linux.serial/6770
> [2] http://article.gmane.org/gmane.linux.serial/3619/
>
> Best regards,
> Marek Vasut

