Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FF3B6C19;
	Fri,  7 Aug 2026 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786078528; cv=none; b=AXY732g795J43zdgSXUhD51f9TtkYXvDnRTERykQfM56dEvwcdZaJZJfybY0WBXek4oXsMpda8nBazZkhZh3Ufn9VLy46vJmLW01Kn5cZiku8P+7sGZZcoFWNlLQdmjkB4kzzELkc/EZxVFYNtGHQROh86nYu5PmlbkKQpnVkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786078528; c=relaxed/simple;
	bh=AZaZVM6U5Wblexss9C9y018h8IfNafsVnuFUX2CqF78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfFRRm38wDM2q2taRHToLYYCA8Sa9NKu/vpiqrJr80syO+IKzXtwnJsDj5VgNdzvEpyiYnZAulwUEcdHOWN0w/U8T0E+8UNkgwKFdQkLi1TZrieUpaPFWlTZozkClki78vU51TxPx2En7PpEtYP1nk8U24wzORrkAVcaRMyIs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF+B5seu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF+B5seu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8481F000E9;
	Fri,  7 Aug 2026 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786078518;
	bh=DWs1mspI1CnGk99IBw6lOLX2WZCwuPDL161wc/XFOuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AF+B5seudublb+L05VIu1YDWXkkjxP+NCRp6k2SLBEy9Ztt9Z2ev6mNAIZLturuRC
	 keId2a7B5o2+lG7MCGDjAMf16i6b9Gs+hieZ8ShYOr5OofDPDbDS9JGqzOwDNtjCxm
	 xL0n/v7CNlUJtv1AkDL8CtimItzKxo1mHkUhAssBgDBW/uLDmdo640cSDbmoSxuSwW
	 mVr4K3xjYDQnve5HcpNuiDZTRd07cHevbKgM4oaLXBiYz8SrjcfpknbMNAcjb9jQkb
	 uuhgxwHAysW2w8CnqGCg8KjBPyUvCccnLBkFbilXJLniIk4koJpZoxkJYQT45EvDnM
	 T9j7GFE00ywcw==
Message-ID: <e0704a22-6a21-4f8f-b1a7-ae200bdbcfae@kernel.org>
Date: Fri, 7 Aug 2026 06:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 John Ogness <john.ogness@linutronix.de>,
 Peng Zhang <zhangpeng.00@bytedance.com>, Jacques Nilo <jnilo@free.fr>,
 Rong Zhang <rongrong@oss.cipunited.com>, Gerhard Engleder <eg@keba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Lubomir Rintel <lkundrak@v3.sk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
 <20260724183007.188172-3-ansuelsmth@gmail.com>
 <anUQhbuHSDRs04bq@ashevche-desk.local>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <anUQhbuHSDRs04bq@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 08. 26, 0:53, Andy Shevchenko wrote:
> On Fri, Jul 24, 2026 at 08:30:06PM +0200, Christian Marangi wrote:
>> +	/*
>> +	 * Calculate XYD_x and XINCLKDR register by searching
>> +	 * through a table of crystal_clock divisors.
>> +	 */
>> +	nom = baud * XYD_Y;
> 
>> +	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
>> +		clk_div_info = &airoha_clk_div_info[i];
>> +		xindiv_clk = XINDIV_CLOCK / clk_div_info->div;
> 
> 	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info) - 1; i >= 0; i--) {

Due to unsignedness, isn't this a lopp for ever?

> 		xindiv_clk = XINDIV_CLOCK / BIT(i);
> 
> Also variant (but may be a little bit confusing)

But a little bit more correct :).

> 	for (unsigned int i = ARRAY_SIZE(airoha_clk_div_info); i; i--) {
> 		xindiv_clk = XINDIV_CLOCK / BIT(i - 1);
> 

thanks,
-- 
js
suse labs
