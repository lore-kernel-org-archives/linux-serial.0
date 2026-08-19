Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1E31960A;
	Wed, 19 Aug 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103816; cv=none; b=mNsIVG/VdbCt9AOhHDPWvgNmAMYW91PvLg7bVgYN9egy9ABGqFm1h8WmKUUiEeNJMYnI+OoD6uHhsr8Eo9fadMJpmajsmb5oDTkvQpS7uAsF4VwuNNfrFy3GEt9odwL+nMg6IyaxbEz4WPo7ty9e4+PLo0OetGLajiqR0Ae5oQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103816; c=relaxed/simple;
	bh=PV8lG4FJMKuvyJ16ucm3uJm9YzNNl/OxleXQUZUWi78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6dkrGv/5CBaKLgQ3FOmLU7xOa6Ipl/p7WbWvwcoAFSeuIcoiYaqEDfSpdSAx0r0VktoIVd0N+1E4a5YcLMgyTA6HcnN+Rb9Bzd1JIUAQQh6WrWYBhvCX/h35LFKEPVm0VR5xvBCsnAmzx91+urgWxrbYtpaSIxHZiUjIk0yZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d95e5d89b6f11f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:55f77e29-9d17-4a48-abbc-ef70b29984c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:980d19b3f29dda61b86b32130c8b398b,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d95e5d89b6f11f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 896790323; Wed, 19 Aug 2026 09:43:23 +0800
Message-ID: <611763a2-40fa-4d18-ab79-578a259339f5@kylinos.cn>
Date: Wed, 19 Aug 2026 09:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] serial: 8250_mxpcie: fail the probe when a port
 cannot be registered
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Crescent Hsieh
 <crescentcy.hsieh@moxa.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-3-lilinmao@kylinos.cn>
 <aoRbyv7V4mdTG5cy@ashevche-desk.local>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <aoRbyv7V4mdTG5cy@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/18 21:19, Andy Shevchenko 写道:
> On Tue, Aug 18, 2026 at 05:39:17PM +0800, Linmao Li wrote:
>> When serial8250_register_8250_port() fails the loop only breaks out and
>> the probe still returns success.  The entries it did not reach keep the
>> zero devm_kzalloc() left there, and the entry that failed keeps a
>> negative error code.
>>
>> mxpcie8250_remove() then feeds all of them to
>> serial8250_unregister_port(), which checks neither: line 0 unregisters a
>> port this driver does not own, and the negative line indexes
>> serial8250_ports[] out of bounds.
>>
>> Fail the probe instead, unregistering the ports registered so far.
> This is behavioural difference. Before it was "register as much ports as we
> can", now "don't register even a single one". If one of those UARTs worked in
> the previous case for whatever reason, this patch will break that.
You are right, and 8250_pci.c - which this driver was split out of - is
explicit about it: pciserial_init_ports() breaks out of the loop on the
first failure, but returns the ports it did register and records how many
in priv->nr, which is all pciserial_detach_ports() then walks.

So what the split lost is that counter, not the "keep what works"
behaviour. mxpcie8250_remove() walks all num_ports entries, so it hands
serial8250_unregister_port() a line 0 for every entry the loop never
reached - a port this driver does not own - and a negative line for the
one that failed.

v2 keeps the partial registration and restores the counter only.


Thanks,
Linmao

>
