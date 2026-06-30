Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2A3E121A
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844944; cv=none; b=vArzRM7higy0o1SeyX5BD0zHGyxUtFoNaZgEr5WqpHxwZ7NM7LWizQSRYP3lVrsv1tXExUIJj10VjDGKrukcmxQxTncjIZ3Zr9inFjcdYiK1OBChg4683c5q7bThaO0F54BcdPjPPeV2K02kX3jPIkzGG7zm/YUEQ7p368pb7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844944; c=relaxed/simple;
	bh=IJU7KD4L0qauoAPuZuUGOAPJgDmKRzFPdG/N2D53G3c=;
	h=Date:Subject:Content-Type:From:Message-Id:Mime-Version:To:
	 References:In-Reply-To:Cc; b=l90WKM9f+YFoW3RLr66kvEfAV/eC3KoHY/Qbf9su9Zsld0EMTUaQYJbNVG7UTChnNKkgovdYN0+zTLSXX7Bszi4TLdRszz1E3BtvA1o1X9TjLTixJr4VL3PsiiH/699P+J+puRnCcvLwvzYb/BRqiey/wwL1Zf6TDnp0P9NG6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=cNQpBxW+; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="cNQpBxW+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782844931; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HrBoMr6wjmi48ox4EpS/DaweNIbWT9YcQ2jRL52a8TQ=;
 b=cNQpBxW+NbiTXalqok3DtJk9iDFExlJIGaa6kQe69ZLnZuBl2vaorr5hdpTjLrJXMjf9AD
 I0MwxdNZNqCH36aAIO8BdUd3OBKUEB66R0usk/4PO6p/I4fd/p6sudnlGx946GPHXyf/pP
 F83QWYpvNwVG4v7awaaM9KLUqEo52oLj5OUhrRKbz4bR3TPG00GOvqNueO0g11EOYcEzHz
 3+/HBfjV+xzMTd+FhgfWSsYgLpAcMU8IfCeABmXxdwLsyO3dlpO3Qmj4bv7kVdrFlDve/w
 rhAhJlcyfUu+6f8G/JzKrYbTSoeuyorkXfUZjc9kEV5RRJf1xr8Ur9aOnUo7Mg==
X-Lms-Return-Path: <lba+26a440e01+60544c+vger.kernel.org+yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
Date: Wed, 1 Jul 2026 02:42:01 +0800
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <b175fd37-e998-40b1-99c3-491e3d6f7e04@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com> <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com> <c017f37a-5873-2716-96e7-3deb46eff1a8@linux.intel.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
In-Reply-To: <c017f37a-5873-2716-96e7-3deb46eff1a8@linux.intel.com>
Received: from [172.16.14.160] ([219.142.31.218]) by smtp.feishu.cn with ESMTPS; Wed, 01 Jul 2026 02:42:08 +0800
Cc: <yang.yicong@picoheart.com>, 
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, 
	"linux-serial" <linux-serial@vger.kernel.org>, 
	"LKML" <linux-kernel@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, <geshijian@picoheart.com>, 
	<yangyang.8776@picoheart.com>, <yanligen@picoheart.com>

On 7/1/26 2:18 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 1 Jul 2026, Yicong Yang wrote:
>> On 6/29/26 11:56 PM, Ilpo J=C3=A4rvinen wrote:
>>> On Mon, 29 Jun 2026, Yicong Yang wrote:
>>>
>>>> The DW uart could get into the cases where a bogus RX timeout
>>>> interrupt is asserted but no available data. This could be
>>>> workaround by doing a bogus read.
>>>>
>>>> Currently the driver's using the standard RBR (receive buffer
>>>> register) for this bogus read. However the reading of RBR
>>>> in this case is allowed to raise a hardware error if vendor
>>>> choose to implement in this way (our platform). It's also
>>>> allowed to do the bogus read using SRBR (shadow RBR) for
>>>> workaround which won't raise the hardware error. So change
>>>> to use the SRBR to workaround the issue if it's available.
>>>>
>>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>>>> ---
>>>>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
>>>>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
>>>>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
>>>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/82=
50/8250_dw.c
>>>> index 84ffba045ffa..fea7dfa30e78 100644
>>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>>> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *p)
>>>>  	if (!up->dma && rx_timeout) {
>>>>  		status =3D serial_lsr_in(up);
>>>> =20
>>>> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>>>> -			serial_port_in(p, UART_RX);
>>>> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
>>>> +			/*
>>>> +			 * Do the bogus read from Shadow RBR (SRBR) if provided.
>>>> +			 * Both RBR and SRBR are supported ways to workaround
>>>
>>> Hi,
>>>
>>> I've not come across this being mentioned anywhere else than in kernel=
=20
>>> related context, but you seem to imply there something that tells about=
=20
>>> "supported ways"?
>>>
>>
>> in fact we got this workaround method that's documented in the synopsys
>> dw_uart issue report, so comment "supported" here. quote the related par=
t
>> of the workaround below:
>>
>>   [read USR[3] for the rx fifo status]
>>   If the read value is '0' (indicating the RX FIFO is empty), do a dummy
>>   read of the RBR or shadow RBR (SRBR) register without processing the
>>   invalid read data.
>>
>>   ...Note: Reading the RBR results in a PSLVERR immediately if
>>   REG_TIMEOUT_WIDTH parameter is set to '0'. Whereas, reading SRBR does
>>   not result in PSLVERR.
>=20
> Okay, thanks.
>=20
>>> If there's no such thing, I'm bit hesitant to declare presence of SRBR=
=20
>>> guarantees reading it universally solves this issue.
>>>
>>> BUT, I suppose it does on your HW since you must have hit this code pat=
h,=20
>>> and thus PSLVERR, yourself to actually discover this issue so I assume=
=20
>>> you've then also confirmed that this patch solves the issue in your cas=
e=20
>>> which isn't entirely without merit either.
>>>
>>
>> actually it's hard to reproduce, only once at boot time in our several
>> hundreds reboot test. we locate the code line here by the backtrace of
>> the system error. the issue hasn't reproduced yet on the patched kernel
>> (hundred reboots so far, but still going on), and I suppose it's correct
>> as provided by the IP designer.
>=20
> For testing, you could have logged when this condition is actually hit=20
> in the first place. I usually do that to increase my own confidence if th=
e=20
> problem is particularly hard to reproduce.

thanks for the kind and useful guidance :) did add a log message in the
workaround branch so we'll know if the issue hits.

>=20
> I don't know if it always triggers PSLVERR or if that's some % of !(statu=
s=20
> & (UART_LSR_DR | UART_LSR_BI)) cases because RBR read is racy with Rx but=
=20
> that could also be determined if similar debug is applied without the=20
> patch, I guess.

as the PSLVERR is caused by the reading of RBR so even in the latter case
we should still using the SRBR here if availabe to avoid the PSLVERR as
long as we enter this branch, I suppose this should be the safest way.

>=20
> But with clearly more boots and it working, that's probably enough as=20
> evidence together with the issue report offering it as a workaround.
>=20

sure, will wait a bit and try to catch the condition.

thanks.
