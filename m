Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865854;
	b=hfJOf75OmwcRHInIGHWuwxHLZdXKeq3ZSmFbH0AahW//P00Q0Ix6qWDAEz1U7qfHaIZa
	 cjFq/taNQsjYVsEOhyy/OoUzCLHrk2vNWgp698zcmFDXekyXya1Q6vieiPDI3ZD5DvI0S
	 rIM+T4I8gAnSvFDPeiY5OT5pkfvsTcEFFffXocQaqfE/XV4n8b79VD+7dVo9Cuj5w80ln
	 WXcBcmCZ3a4VE3xsqTZ5+Yv0Ym0kSsz2nEw180/VV+ewoXMZW2dwYIYa7ckm+eCk6EyKw
	 WOH0vn6i1UQQmy6Qs5dcqUSWncYz7eHtuCaIIJgEv9RsPPoK6/G4E8eCGcycb74zITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=qwbrzd7fYBYLMbcYStT4Nw+sPoOjHywyjBxJxGcabSk=;
	b=PZmatCgMTrVzRqQwFh0wEthKLhvh4ntNX5Fj8Gu410V7uE3bT9fOTF28kU/YaWsITpog
	 dlFD/YDnWM++2F87QpAaGnfk5H4AZVHtBtWba2vaShgvck6mWqZxxsrDX3P+tat6D6SVe
	 YfkkVEmIppDuZGeC8gCzFcKQrDEH81h8BEMOM5X3pezM3UEevRk4huiBSRI6D5uUtqy5f
	 ewGH2l0vWm3mi7GfTMj4zs9CJm6ySRdjP9Vkpv+kSYulz37aYhHPM0x31ZYd48EsbbN6Q
	 ixw4QgDX8AyPQmGOaz8mND3tUDYFzEnTpxXOvKxhN+Zlv958UGxxFhLJlyfUwPjZlRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tGNwHDCD;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473C606A333
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 21:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1473C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tGNwHDCD
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a315ed211so290346eec.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794865853; x=1795470653; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwbrzd7fYBYLMbcYStT4Nw+sPoOjHywyjBxJxGcabSk=;
        b=tGNwHDCDLKla2E18ZcotYovPFx9z0XaxN+o43JDW3M7piMhhdeMm8S7/GGjvxD0xzk
         HlEuUaC0AK147O9pAIrHvwLm93QEKBOtcFxzYAJl4P5eM4fPtcNfEf1V5KoZrCnpOtZT
         yp8enqxqbZ0HuEFpYT9XixESnW6taSo6n36rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865853; x=1795470653;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwbrzd7fYBYLMbcYStT4Nw+sPoOjHywyjBxJxGcabSk=;
        b=Xuyk/qORRx6UQjxg7r+VxTVfEBmQalX+66d8BL2k3KE7Pz71F3h3UBZFa2Ec7jcdBt
         TkBHzWtBKHFSjB+5zttX4tsu7CJr/77tlduj0Rmhg104RCcDUvnOtjWdreVdJJDO9MQE
         rZFMPUTvoxbuSHyI7E+NqzIhsud9VRJG29O8F5i3kR+LYNyadwckEOejSip5FL5+q88e
         4kNcGyXAjNy/CuoPdBYZXuCG6Bwwku0+7gGdjpfj704zMs8/OUgIsrvt/YcM2nEZcSPd
         j7aUMddd5urYX+afhqthrwmXmssaBLEBJjQNR0ZgD0ShDu+hA4XGRk4IXPSfv0rLEI5P
         0YIg==
X-Forwarded-Encrypted: i=1; AL+hErFl9KLrR9Ir8uTCW1ohqqsOZ/FrPvGg4B7B33wo2XSfvqMA92G1FWMDQ/QKVrEZJNWhsv5a1cjFhqeNk/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GbUbHKDhCIwGGUmz+CZ134E8lxYWYxjaYLW4luB2rJMUSuszW
	oh2aD5Hz+g3JTq7/JCf+h5P5YRRMgtV1jlybj9PrqWROcKs8ebeAqp6cVaU7Pg1AI2g=
X-Gm-Gg: AYBFou1foj5ePvpbL458Qsb5OxpS+5scm+xlNLwrrl4qZz2zElQ7GLhgFRay+NU96cd
	Ljy3uUMto+9JrMP9DMNqFxoqCWcuUFsAoQN79Cfizr4jwb9YyHU4UYa3k1hLAgKBmlRMczxFgsD
	mBdWi1Aw8jAkMCfWT7gvHC/mMebryJJxHj5oPSVz288baytkbcEdoJGBRSFMvHtcYQy5ge6xa0E
	CA7ewZTf2tdm1aZq3wwWc7MCAV9wQeSAp/dfVdfyGvnFxFmJQk03ePxjgReDNpGFg4KvuUBsEjS
	ueovCtp+dfV/Y38oCl6Buf2O5W0qRe9g5esiVXoe+dIbIyrV3RbXlwqbT3+5FXsVCc9qoXvn9hF
	nHcW4Y5el4s5S6i15aQFeSd7zliAuXPLAZmLmsM2SnbIp5xVBXno5GcgaTECLgFE1Jn8ehaU477
	bSwOxJQi/ocr2tLrQPS6qvRgoiLIQ7xbWCPrMybclEg8TsLG/cTK8XnzX+8dHIFv/lKsjPr+Ziz
	8GC/esXRJduVyRrudlxtA5Xwv+0p3A9aCiy+td0STLwIAnxWeaJ6CbqjymV/pDTUsDQyb6M1Dzj
	q8OTgGaaOTCAhwG69sEWwwS60FZ/Hlmx0Q/Uhxo/0z3qUQzK3uMNvbz3igZepmnpEKItHiFe9BG
	Bc32ax9L0a/I5HMJEujoF7NoeCAUVcd2bd2c/qCUmFTuTTsV8rLoZmKjn2vA5vQgMn8YEDhcC6G
	AA6C7inVwY6IGYNvs0Pow0im9Q5tHSVFB0EeOeB49BMbxim0myg0gKbVpXfaqpoeTSLCdWiSfAz
	oxBWSiezhIzxQ==
X-Received: by 2002:a05:7300:b0af:b0:381:5665:df21 with SMTP id 5a478bee46e88-3815665e29bmr58724eec.6.1794865853121;
        Mon, 16 Nov 2026 13:50:53 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e0fdcc36sm2436124eec.25.2026.11.16.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:50:52 -0800 (PST)
Date: Mon, 16 Nov 2026 13:50:49 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>, Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	kernel-team@meta.com
Subject: Re: [PATCH v2] serial: amba-pl011: touch the watchdogs in
	write_atomic()
In-Reply-To: <20261106-pl011_touch-v2-1-8f4996113320@debian.org>
References: <20261106-pl011_touch-v2-1-8f4996113320@debian.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avt6uX_CAZmu2ior@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

This looks good, thanks! I reproduced the issue and have verified that it
goes away with this patch.

Feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks,

Chris
