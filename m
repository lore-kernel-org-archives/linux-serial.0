Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBA274B30;
	Wed, 16 Jul 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688216; cv=none; b=m2rJfnYUm8fAHTdfIN9lFPXfK9LKuh9xIYmqfeJuAbWbYvCtP1g0TB67fbuv8ql4s62XyXIc9oQDbOalIV7MMeDc4i50kJTkl7G+o3xzQJwulaPtFDvfYYJc7BmI7j7+YUIL/O631V+XxEznuj15IxXV1+2/zQpRvMxCvzpRBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688216; c=relaxed/simple;
	bh=9nN0kva0mY9DQb5DenPwdNuxS0qpXv2MXqzIS8Rgu2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvTNYYHr0mJyZJmfVuBDIbQxrVejGCDgjxRrgL9vcVThLxTqVSeXN9db16GCa0mI3Ma1NFRTEk8Js86Ld6FnDffLj3f2V2oA8wzxfzUen9PTEthoycqnLoUBzGKeTe913mfC+ZamxoBcOEOYxO1iwhyhT589hdNRYh2QOMl29aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KydT/K+f; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KydT/K+f"
Received: from [IPV6:2601:646:8081:9482:6dc:b955:47cb:dcbb] ([IPv6:2601:646:8081:9482:6dc:b955:47cb:dcbb])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56GHnnt61633817
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 16 Jul 2025 10:50:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56GHnnt61633817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752688210;
	bh=bQLY2XzM/JK8U77oiXwSm5nl5s2y7cLMCH+PlWCqq2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KydT/K+fLzfjBcfN2UZF9/xZfqQfcsu9I6Vdb6HtNwW0n1WlesTFNCeflBGbyRT/N
	 4AVfVELUE2faah05zLpgUwlvpR5d6PlWWUmpl8Djqs48WQN4ZCccbWpiF4rVX+tR5Q
	 W4cxdfvuxLoXNVcZud0tumhyCJ7x8rvl6xntCYdhuOErxNJdVjvn8N5Uqn5h7XcXR4
	 6CI919aBZLtnX6kSic9dI7HqCfMbiRjCoU1JlbvXbf9rG7nXpWw37NZPzTVXHX4IkK
	 Rg8uOw/pXyMOzDa/qOmzjucQoY48lzhhfwz/tfFBH1aUDbKRF6Z/Czhm2H128DU6g5
	 tJhuX+q5G+PvQ==
Message-ID: <f979468c-434a-43e9-8c50-8e92188abc11@zytor.com>
Date: Wed, 16 Jul 2025 10:49:43 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
 <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-07-16 09:17, Oliver Neukum wrote:
> On 16.07.25 17:06, H. Peter Anvin wrote:
> 
>> SEND_ENCAPSULATED_COMMAND at least takes a command string – it was
>> intended, I believe, to be able to send AT commands to a modem while
>> online without using the +++ escape code and all the potential race
>> conditions (and security issues, since it is trivial for a user to
>> generate) associated with that.
> 
> Understood. It still seems dirty to me. If you want to send strings to a
> device
> the proper way is to use a device node and write().
>  

There is definitely something to be said for that; or at least a file
descriptor.  We do have cases in the kernel -- notably opening the pts
corresponding to a ptmx file descriptor -- that do that sort of
"auxiliary open" kind of thing.

The big question is how that interacts with the rest of the ACM driver,
as well as all the lifetime issues you mentioned elsewhere.

	-hpa

