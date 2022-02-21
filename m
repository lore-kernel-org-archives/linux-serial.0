Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1940AC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 08:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiBUI0y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:26:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbiBUI0y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 03:26:54 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F50D4;
        Mon, 21 Feb 2022 00:26:29 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 21 Feb
 2022 16:26:27 +0800
Message-ID: <7f056798-8784-2fa9-3ae0-d9ba62449f3c@amlogic.com>
Date:   Mon, 21 Feb 2022 16:26:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-4-yu.tu@amlogic.com>
 <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
 <1jbl062i4o.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jbl062i4o.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022/1/21 5:48, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Tue 18 Jan 2022 at 10:39, Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> On 18. 01. 22, 4:09, Yu Tu wrote:
>>> Using the common Clock code to describe the UART baud rate clock
>>> makes it easier for the UART driver to be compatible with the
>>> baud rate requirements of the UART IP on different meson chips.
>> ...
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>> ...
>>> @@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
>>>    	.cons		= MESON_SERIAL_CONSOLE,
>>>    };
>>>    -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>>> -						 const char *id)
>>> -{
>>> -	struct clk *clk = NULL;
>>> -	int ret;
>>> -
>>> -	clk = devm_clk_get(dev, id);
>>> -	if (IS_ERR(clk))
>>> -		return clk;
>>> -
>>> -	ret = clk_prepare_enable(clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "couldn't enable clk\n");
>>> -		return ERR_PTR(ret);
>>> -	}
>>> -
>>> -	devm_add_action_or_reset(dev,
>>> -			(void(*)(void *))clk_disable_unprepare,
>>> -			clk);
>>> -
>>> -	return clk;
>>> -}
>>> +static struct clk_div_table xtal_div_table[] = {
>>
>> This can be const, right?
>>
>>> +	{0, 3},
>>> +	{1, 1},
>>> +	{2, 2},
>>> +	{3, 2},
>>
>> Not sure if you didn't remove too much whitespace. I think it should be
>> like: "{ 0, 3 },". But I actually don't care, it's a minor thing.
> 
> Seconds
> It worth fixing in the next version
> 
I will correct in a version.
>>
>> I cannot comment on the rest (clk and OF part) as my knowledge is pretty
>> limited there. Leaving up to others.
>>
>> thanks,
> 
