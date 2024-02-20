Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E553812
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412584; cv=none; b=fiezZ+yw/sWdEumjRK1d5xlSLSRJGAbDImWRd5cjC5rcxzUyqDZcPNKoYfzQLw2CO1bdFYHDIGDABbMkAfjmYmlUm5NoZ6G0nJnUoGxwHXKf0ZTX58kUKKZGaYY2dPb6Hh2XPTL1FdrojoUWQ1VEcm1tBhHiFTu7cM9I9VXvUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412584; c=relaxed/simple;
	bh=mpI5KR+Emb1mo4BZcd3QKFP8nwXQORYtXdX5y2JYjvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYwBTqmr3xTyW+3aaXHqdGR2zaoNCPfRIOAkjVRxrl9iHhTB9VtKmB1ZCopQH3EmEJaz3zV+sU5F7rcPXbfxq+g81goafFHz5Mp3wqtDPGGs089xty5OrUvFOfjZgX7a3D21rSD05zUb/VWYMgV8v6AFX7KSAHD504Vrc4yB/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AEyppK6+; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AEyppK6+"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 80F5187F82;
	Tue, 20 Feb 2024 08:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708412580;
	bh=EmQoVPWDrsUyoca7hpOdWXDI4T4ngWZEBRtbT7o2Q/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEyppK6+0zulYe/yZQdKjamXknIPyakLLQnGpbVmsplay9MP18AoxQknUGucI7eVG
	 Xhl49z9hLxCLP3/+uaJQq6+JUn7MtGaWGGbFKxMbRN8QpfRf5izOMrfbpEp8YITCHZ
	 ogIctnwj6eB2A6WrKNZiAdC3CEsTiHDtgnKclQe+7wcKLvh3KLqG+/VhZ0mHpzcC08
	 VYpB1WlHS2SU/hp2vatqNVYDF+bg8+TSblE6Xq5xUd386wxSIXotWhUD/XsiDEPCPL
	 71kKUp0MVQ9bunsJDEMxdFD1ILP+dfz7syj6p6sy9osbV/L6Zwb7t8JdcRmR0gMPHr
	 jRXvRLebYLCHg==
Message-ID: <bba053d5-c182-41db-b9d5-fbb239fb9ea7@denx.de>
Date: Tue, 20 Feb 2024 07:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: imx: Fix broken RS485
Content-Language: en-US
To: Rickard X Andersson <Rickard.Andersson@axis.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "rickard314.andersson@gmail.com" <rickard314.andersson@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: kernel <kernel@axis.com>
References: <20240216124601.3752039-1-rickaran@axis.com>
 <e39a6ecd-1250-4889-99aa-31a5a219f6a5@denx.de>
 <AS8PR02MB950598080305172CFBE4B0D381502@AS8PR02MB9505.eurprd02.prod.outlook.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR02MB950598080305172CFBE4B0D381502@AS8PR02MB9505.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/20/24 07:07, Rickard X Andersson wrote:
> On Fri, Feb 16, 2024 at 4:17 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/16/24 13:46, Rickard Andersson wrote:
>>> From: Rickard x Andersson <rickaran@axis.com>
>>>
>>> When about to transmit the function imx_uart_start_tx is called and in
>>> some RS485 configurations this function will call imx_uart_stop_rx. The
>>> problem is that imx_uart_stop_rx will enable loopback and when loopback
>>> is enabled transmitted data will just be looped to RX.
>>>
>>> This patch fixes the above problem by explicitly disabling loopback in
>>> the case described above.
>>>
>>> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
>>
>> Fixes: tag is missing.
> 
> Ok, I will add.
>>
>>> ---
>>>    drivers/tty/serial/imx.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 4aa72d5aeafb..899e331bdfc8 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -683,8 +683,15 @@ static void imx_uart_start_tx(struct uart_port *port)
>>>                        imx_uart_writel(sport, ucr2, UCR2);
>>>
>>>                        if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
>>> -                         !port->rs485_rx_during_tx_gpio)
>>> +                         !port->rs485_rx_during_tx_gpio) {
>>>                                imx_uart_stop_rx(port);
>>> +                             /*
>>> +                              * The function imx_uart_stop_rx right above
>>> +                              * will enable loopback, but since we are just
>>> +                              * about to transmit then disable loopback.
>>> +                              */
>>> +                             imx_uart_disable_loopback_rs485(sport);
>>> +                     }
>>
>> Maybe it would be better to update the stop_rx and add parameter,
>> whether it should/shouldn't enable the loopback ?
> 
> Since *stop_rx is part of struct uart_ops I can not add an input argument to the function.

You could add a wrapper function and make stop_tx call that one.
