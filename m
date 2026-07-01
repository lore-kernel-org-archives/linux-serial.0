Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC10356744
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922417; cv=none; b=XWAPcbYPl0a68FtO4KzUMaIg5AOHkOE3nsGaFsDQyxs8oZvXgmGLfBJsHOhExt+pW1M7uZgnrQBDBqcqRHB5unTXvkzLlpy0nZPcJTRbk32ffflip5H1mkKn6QsJShoYvotC/q9PTZ5oI0iKTCkXe8N6SAF1r72Usf1Evjq8DRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922417; c=relaxed/simple;
	bh=joHMVJgE4R7g+rijZ593TnegVAahfYzWzD9U5bWRVpk=;
	h=Cc:From:Subject:Date:In-Reply-To:References:Content-Type:To:
	 Message-Id:Mime-Version; b=o90hidLNBq8M22aCiippp8/Mez+ATzjrmIDibRM+wRfKkQGBJozzZdQ1jBCqLm1ULEXi7LvowAycyQMjm6lAVsB/NOe4ACLFXr87fFwuE6KA7vPSBArL6NVYnxwNEEZzgCtc8gzThyy1HywwNt6bw/+XtnHlS+ukPlYqCUeHPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=L7FjZIQF; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="L7FjZIQF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782922410; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IL9X2eVWufMJ3umWFy1m9zXnSbtxbyqhyAKdzjIxpoU=;
 b=L7FjZIQFDRATCasAlh8W+hVZozeQM9qbDujdully2y1/Ber4E+boUmWkfjbbH/w1OPEXII
 2QDNSbSKwqyJbGoAd7kHa4hpZOuhIWj+S561K5LYYEYtzoUCm7JGF5xDAkPUHI+1D/c+60
 6qjwZhiuWNocZSdj7L8j00qvmz0SbeHpN4rFOR6fTTKVXBjf10HzIKsLvikA55ZSfnHxNY
 tP24vfMzn/5mNwASkMsaG5bK8a3BSVM2TCJB5A8w74AtdysdLUxI+DO00T95SHUzZvllZ+
 z9XpBH1gN3TmWMLp0ou405Wl/qQMLEDtEbuit4NLtQFfGd+i5ugg4Cg3Q7wDyw==
Cc: <yang.yicong@picoheart.com>, 
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, 
	"linux-serial" <linux-serial@vger.kernel.org>, 
	"LKML" <linux-kernel@vger.kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, <geshijian@picoheart.com>, 
	<yangyang.8776@picoheart.com>, <yanligen@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available
Date: Thu, 2 Jul 2026 00:13:22 +0800
In-Reply-To: <ce31a5fe-8b6e-62af-038b-4e65cb94493d@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <1ef5a875-2c01-5b4b-7d2b-07e6ea3db2b3@linux.intel.com> <877fc902-7b8d-454c-8346-de1087edcdc4@picoheart.com> <c017f37a-5873-2716-96e7-3deb46eff1a8@linux.intel.com> <b175fd37-e998-40b1-99c3-491e3d6f7e04@picoheart.com> <ce31a5fe-8b6e-62af-038b-4e65cb94493d@linux.intel.com>
Received: from [172.16.13.88] ([39.155.245.242]) by smtp.feishu.cn with ESMTPS; Thu, 02 Jul 2026 00:13:27 +0800
Content-Type: text/plain; charset=UTF-8
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Lms-Return-Path: <lba+26a453ca8+d2c02a+vger.kernel.org+yang.yicong@picoheart.com>
Content-Language: en-US
Message-Id: <29c00135-be80-4836-b25e-8c930ce6f278@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird

On 7/1/26 4:45 PM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 1 Jul 2026, Yicong Yang wrote:
>=20
>> On 7/1/26 2:18 AM, Ilpo J=C3=A4rvinen wrote:
>>> On Wed, 1 Jul 2026, Yicong Yang wrote:
>>>> On 6/29/26 11:56 PM, Ilpo J=C3=A4rvinen wrote:
>>>>> On Mon, 29 Jun 2026, Yicong Yang wrote:
>>>>>
>>>>>> The DW uart could get into the cases where a bogus RX timeout
>>>>>> interrupt is asserted but no available data. This could be
>>>>>> workaround by doing a bogus read.
>>>>>>
>>>>>> Currently the driver's using the standard RBR (receive buffer
>>>>>> register) for this bogus read. However the reading of RBR
>>>>>> in this case is allowed to raise a hardware error if vendor
>>>>>> choose to implement in this way (our platform). It's also
>>>>>> allowed to do the bogus read using SRBR (shadow RBR) for
>>>>>> workaround which won't raise the hardware error. So change
>>>>>> to use the SRBR to workaround the issue if it's available.
>>>>>>
>>>>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>>>>>> ---
>>>>>>  drivers/tty/serial/8250/8250_dw.c    | 15 +++++++++++++--
>>>>>>  drivers/tty/serial/8250/8250_dwlib.c |  3 +++
>>>>>>  drivers/tty/serial/8250/8250_dwlib.h |  4 ++++
>>>>>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/=
8250/8250_dw.c
>>>>>> index 84ffba045ffa..fea7dfa30e78 100644
>>>>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>>>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>>>>> @@ -440,8 +440,19 @@ static int dw8250_handle_irq(struct uart_port *=
p)
>>>>>>  	if (!up->dma && rx_timeout) {
>>>>>>  		status =3D serial_lsr_in(up);
>>>>>> =20
>>>>>> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>>>>>> -			serial_port_in(p, UART_RX);
>>>>>> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
>>>>>> +			/*
>>>>>> +			 * Do the bogus read from Shadow RBR (SRBR) if provided.
>>>>>> +			 * Both RBR and SRBR are supported ways to workaround
>>>>>
>>>>> Hi,
>>>>>
>>>>> I've not come across this being mentioned anywhere else than in kerne=
l=20
>>>>> related context, but you seem to imply there something that tells abo=
ut=20
>>>>> "supported ways"?
>>>>>
>>>>
>>>> in fact we got this workaround method that's documented in the synopsy=
s
>>>> dw_uart issue report, so comment "supported" here. quote the related p=
art
>>>> of the workaround below:
>>>>
>>>>   [read USR[3] for the rx fifo status]
>>>>   If the read value is '0' (indicating the RX FIFO is empty), do a dum=
my
>>>>   read of the RBR or shadow RBR (SRBR) register without processing the
>>>>   invalid read data.
>>>>
>>>>   ...Note: Reading the RBR results in a PSLVERR immediately if
>>>>   REG_TIMEOUT_WIDTH parameter is set to '0'. Whereas, reading SRBR doe=
s
>>>>   not result in PSLVERR.
>>>
>>> Okay, thanks.
>>>
>>>>> If there's no such thing, I'm bit hesitant to declare presence of SRB=
R=20
>>>>> guarantees reading it universally solves this issue.
>>>>>
>>>>> BUT, I suppose it does on your HW since you must have hit this code p=
ath,=20
>>>>> and thus PSLVERR, yourself to actually discover this issue so I assum=
e=20
>>>>> you've then also confirmed that this patch solves the issue in your c=
ase=20
>>>>> which isn't entirely without merit either.
>>>>>
>>>>
>>>> actually it's hard to reproduce, only once at boot time in our several
>>>> hundreds reboot test. we locate the code line here by the backtrace of
>>>> the system error. the issue hasn't reproduced yet on the patched kerne=
l
>>>> (hundred reboots so far, but still going on), and I suppose it's corre=
ct
>>>> as provided by the IP designer.
>>>
>>> For testing, you could have logged when this condition is actually hit=
=20
>>> in the first place. I usually do that to increase my own confidence if =
the=20
>>> problem is particularly hard to reproduce.
>>
>> thanks for the kind and useful guidance :) did add a log message in the
>> workaround branch so we'll know if the issue hits.
>>
>>>
>>> I don't know if it always triggers PSLVERR or if that's some % of !(sta=
tus=20
>>> & (UART_LSR_DR | UART_LSR_BI)) cases because RBR read is racy with Rx b=
ut=20
>>> that could also be determined if similar debug is applied without the=
=20
>>> patch, I guess.
>>
>> as the PSLVERR is caused by the reading of RBR so even in the latter cas=
e
>> we should still using the SRBR here if availabe to avoid the PSLVERR as
>> long as we enter this branch, I suppose this should be the safest way.
>=20
> I was not commenting on how to fix it, but about probabilty of hitting=20
> PSLVERR when taking this branch.
>=20
> Rx coming in (it's racing with the driver's code) may make the read not=
=20
> result in PSLVERR even when this branch is taken. It could be this does n=
o=20
> matter and taking this branch in practice always results in PSLVERR if RB=
R=20
> is read, which means even any hit of this branch confirms SRBR does indee=
d=20
> work.
>=20
> But if RBR reads do not always lead to PSLVERR because incoming Rx makes=
=20
> RBR read "safe" it's less clear how many times the branch should be taken=
=20
> before confidently declaring the fix works.
>=20

thanks for the detailed explanation, now I get the point here.

thanks.
