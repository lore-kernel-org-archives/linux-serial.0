Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518759B41
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421748; cv=none; b=nY7keUlkxho/lhmm2wQhB4WouDM7t5VohOoaIkqozeJIqf4dfj3Onz+m3WaUCTiGUSZYLdS+ol+/k1g5uKzyCXlUbhFg5mUq3Q5DGJerSZRoSC7tfKdC+jrDQ0RQJDYbC8rpo3cs6LYK6GAF+3KREFImVvm93aXdEriBA2RJvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421748; c=relaxed/simple;
	bh=HuGBk+VPgEID69QznlFXQmSvh5MqMLeobrOeLZ+BbV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhXdtoK3j4R2KEKxAcVBMd1FZ6rrcFjMIzVUrrGpjfqzCbB1bqliV6/mKsAYNdtAlSveQTNP1XLgZ7hsZSGXSkK3H4608A7IHPMC5E9GfV6I05DMEhWEUOb2el73Ts44h5FFxT1bFTwcPaO/US0vR1qsjPmE+7JOPjjDBNgWvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iGhbyCRZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iGhbyCRZ"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B0DD387DE0;
	Tue, 20 Feb 2024 10:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708421741;
	bh=TxzJPGD+rl7Frf61S6X9alInbRplM/b+kmGbpAOqOmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iGhbyCRZPEWwx5ZylxrpHEv8bANXv6lIkyLtg3wcYZeLwibGtjD+YewA2ZK6ngvQU
	 MqkeC67wo7NyqY96hr0LpcgwyKtUc5n2f1oLTIWwHfzCPHq8ZzVBOBWpuDHWHHoteb
	 NuqodxlFENYqAHNkBqGdPgva2mv7PD1UMG0c6y714OrIihYClQ3n9fH1W3MH37A3bS
	 jWrj5EUQE86mMwtW75t1Mg171JHWbdeVS3FAnJ9yqzvvpskawUEPhYCsACQ3QcbOb3
	 LaOp0ULbIhd6F5ulVZzAAIQ0tPJAIfGWVZWBodC4mwNMwLGiM70P+v1OZy+2NS36ch
	 5BheoIp29qJIg==
Message-ID: <1b5a9c2d-3653-43d2-a0f2-53dcb57476b9@denx.de>
Date: Tue, 20 Feb 2024 09:43:10 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: imx: Fix broken RS485
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
 <bba053d5-c182-41db-b9d5-fbb239fb9ea7@denx.de>
 <AS8PR02MB95056A7F8A964A8A09B31BC481502@AS8PR02MB9505.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR02MB95056A7F8A964A8A09B31BC481502@AS8PR02MB9505.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/20/24 09:39, Rickard X Andersson wrote:
> 
>>>> Maybe it would be better to update the stop_rx and add parameter,
>>>> whether it should/shouldn't enable the loopback ?
>>>
>>> Since *stop_rx is part of struct uart_ops I can not add an input argument to the function.
>>
>> You could add a wrapper function and make stop_tx call that one.
> 
> Ok, yes that is possible. Do you want me to do that change?

Better wait a few days before sending V3, so that others can chime in. 
And yes, I think it would be better.
