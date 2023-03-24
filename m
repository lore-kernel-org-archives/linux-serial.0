Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7708C6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 12:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCXMuX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCXMuW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 08:50:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3478EC3
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 05:50:21 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N95qT-1qa0dG1zGh-016BTG; Fri, 24 Mar 2023 13:49:57 +0100
Message-ID: <b6090d0f-c612-9916-06cf-8d791801e37d@i2se.com>
Date:   Fri, 24 Mar 2023 13:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <ZB2W4bKfuO7tvAaU@francesco-nb.int.toradex.com>
 <989d6a6f-fd4d-3e53-d417-ddf71ccf7af@linux.intel.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <989d6a6f-fd4d-3e53-d417-ddf71ccf7af@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UTGPJEe3V9ioEcmae8BlQwxtxLaM5E16Qxnl7nAdZRYVT9JUy2j
 I6Z0x0NnHh6Km9snhoj17/ZEDc76c4JQWpdIMRt67FgIdJ9WeGtus8nL13LO/wg6e48z9oz
 Wl7IRsdftI79p3vTvjyr9yuMYUqpPk5vXzY01CVi+ADykr6QX52Kw/VwpyGxa/Mh8ZEY8YC
 khotX2Nu0JcGas2IagNoA==
UI-OutboundReport: notjunk:1;M01:P0:36wpV76/2PA=;N9A0E2QyaxxHc/ketHn5umgaQR4
 J/x/47m2i16nPU38E7Y4Gq3osar0RC5KIvLvQCkCpEEdKhiBHR2zeR1BUkeO8w+eaGf2dss6N
 jk/fkDO/8t5dgIJ4PJNJWen4iYrMqkkX5v1V2+h1623oEpqtSG6zRtBZZXcfO5t97NdGD31GE
 jpJiOVhhH9StKf3LDx1XZQtsVvqJbP5OJ1QcgCIQthaXBCsWhkvwBHYj0Ke4Ed+VygYDD0pdr
 DgN5p/IkmAQKr7d+3dIWKmmmMdbPXPPqd+fEQSdcvLuJz1ToMMILtOUqSdrmjsDadJO0gq3cT
 /RSjerSRESygvOvjBZDyCaleOODWibKMSZDgiX0kgw+lRJGX0K+T6irUpl+RR01qgydAdyfIu
 i4Pxj5QbTOW58TwllAtNSbrLIVbILJYZtc7Eymm8RgdGaqXNSwPgq9OkJmVdNolH8ZM4MtGUl
 mIiVs8z0434VyS3stGYBsSodUhI75drNgW1bZJrVMLf8qLVzUB6JOUpEJU7+9Ssb1ynNxETBc
 r10YTt8EzSkuiKB1AAGyc9mK6Zsubl2tFv2dVI5HafWQh5MyFbn4mVMd+yRJSKrW+huc83plr
 W1cI5J+4dD1pDCDHj9gTi7Wf64vMhfymIXuhgSWWuT5/9Oha6+bBfe6HkQ0zj/Fj9X6jJ6Kwb
 6FkXI31iQMBeo2nBUlg4k0ZHUgsviL4/0dKu3qznFw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 24.03.23 um 13:35 schrieb Ilpo Järvinen:
> On Fri, 24 Mar 2023, Francesco Dolcini wrote:
>
>> Hello
>>
>> On Fri, Mar 24, 2023 at 01:47:59PM +0200, Ilpo Järvinen wrote:
>>> On Fri, 24 Mar 2023, Stefan Wahren wrote:
>>>> after switching to Linux 6.1.21 on our Tarragon board (i.MX6ULL SoC), we
>>>> experience the following issues with the debug UART (115200 baud, 8N1, no
>>>> hardware flow control):
>>>>
>>>> - overrun errors if we paste in multiple text lines while system is idle
>>>> - no reaction to single key strokes while system is on higher load
>>>>
>>>> After reverting 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
>>>> the issue disappear.
>>>>
>>>> Maybe it's worth to mention that the Tarragon board uses two additional
>>>> application UARTs with similiar baud rates (9600 - 115200 baud, no hardware
>>>> flow control) for RS485 communication, but there are no overrun errors (with
>>>> and without the mention change).
>>> This has come up earlier, see e.g.:
>>>
>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>> yep, it looks exactly the same issue.
>>
>> We did not verify if this was affecting other UARTs. However, isn't RS485
>> half-duplex?
> While half-duplex is more likely by far due simplicity, RS485 could also
> be full-duplex. It seems imx driver supports for both modes.

The RS485 on Tarragon is half-duplex, but this is implemented in 
external hardware. So from Linux / driver point of view it's a RS232.

To us the current behavior (overrun errors and no reaction under load) 
is not acceptable. I agree that increasing the rx threshold isn't the 
real issue. But i needed a starting point for a discussion.

So any ideas how to investigate this further are welcome.

>
