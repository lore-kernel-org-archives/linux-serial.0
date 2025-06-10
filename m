Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693A1442E8;
	Tue, 10 Jun 2025 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531406; cv=none; b=Hf/9t0xl03K7ppeq2SWWYqZZum1SwW1d9SpOsskkRtvsXZbiB57kEiETV1A4TOP6lmyf1cErGR7qSZGuKFExXszdI7wzU6RWKAvRPAVaBSljBuNwDQ8NRSSWEXEv/tmK1E1OBJElPLCwC/0x392liPLFEmGKbAUUfrEiL3Eg+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531406; c=relaxed/simple;
	bh=vTv7yXlya3K6c3/J2q6Y2XqhFJ6j2s6q/OfC3+yifd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j64tjkvNmhucXOsY3WxDKkZPPHIULf0I4BRfKaAAmlgdjCmJrjHxHZYjUqnKydOhm4FgmcYIIXBQcU6UHQw1Rv2t20+Tvv+KXVszAB+BQNtCfHzk96e2WqxHKj2FgbDNUtDREmn85nA8X5kqbdThQPNTzuHjWfIJyLII4ju+dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDmVaDZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDmVaDZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B2C4CEEF;
	Tue, 10 Jun 2025 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749531404;
	bh=vTv7yXlya3K6c3/J2q6Y2XqhFJ6j2s6q/OfC3+yifd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDmVaDZc96c9Hk0Xp6dqOz31njxwEg6vXZZK5r6Tb+H0OVz/ogHTn0SA22kQvH5cg
	 w9RscZLHwcM77fxVlh5ixd/G9ktVnQ0tkZ7vGotwQja6135W1E3kRAgn9m36QksgsU
	 BsGVT8jffTEvgaIxLiGyND4jPxiwefWfhAlbG1ho3C8gCq8TSHlc+MyXIuTxRQ5sWL
	 wqJh2i6brTvqxa0eKzcmv/hTbHiUKggJTtxRK09Ahi3ik+jfdamcDcCb27oHERBKOL
	 E+icf6s4sc4+jjZAudQX8WCnHniBCONk+0RLgso6KeXSM/EOv8/QQJkuLYT2huPL9x
	 y3sqrWKadz+dQ==
Message-ID: <076c8792-8e9e-4809-aca3-18f64e79f53d@kernel.org>
Date: Tue, 10 Jun 2025 06:56:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/tty/moxa.c: Fix spelling mistake in comment
To: shanmukh.iyer@gmail.com, hugo@hugovil.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, trivial@kernel.org
References: <20250609083906.2612e881444ee04360715aed@hugovil.com>
 <20250609233452.164722-1-shanmukh.iyer@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250609233452.164722-1-shanmukh.iyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 06. 25, 1:34, shanmukh.iyer@gmail.com wrote:
> From: Shanmukh Iyer <shanmukh.iyer@gmail.com>
> 
> Corrected some spelling and grammar in the comments, such as:
> - Units (baud -> baud rate)
> - Sentence flow
> - typos
> 
> This is part of my first patch to get familiar with
> the kernel's patch contribution workflow.
> 
> Signed-off-by: Shanmukh Iyer <shanmukh.iyer@gmail.com>
> ---

v2 changelog missing here now.

>   drivers/tty/moxa.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index 329b30fac8fc..bf86f24e5655 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -1627,10 +1627,11 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
>    *           long baud          : baud rate (50 - 115200)
>    *
>    *           return:    0       : this port is invalid or baud < 50
> - *                      50 - 115200 : the real baud rate set to the port, if
> - *                                    the argument baud is large than maximun
> - *                                    available baud rate, the real setting
> - *                                    baud rate will be the maximun baud rate.
> + *                      50 - 115200 : the real baud rate is set to the port, if

the new "is" looks superfluous.

> + *                                    the argument baud rate is larger than
> + *                                    the maximum available baud rate, the
> + *                                    real setting baud rate will be the
> + *                                    maximum baud rate.
>    *
>    *
>    *      Function 12:    Configure the port.


-- 
js
suse labs
