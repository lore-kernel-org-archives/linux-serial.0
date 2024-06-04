Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AD2566;
	Tue,  4 Jun 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497348; cv=none; b=lAQFfZGUBs8r9ho6X4MLrEaTADiAU8EcHMhB6cmIDed5s62hjOiLkUw2B/lickw92ngf/DKVKnelEZfsM0JCAjwiMCJBh8uRjro6J3rpPst7Ein5NBe01n9ng1S/qI0koVSeLA8TOvHAfyMNrVN44jZ17geUOtnEyBWhSUtRzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497348; c=relaxed/simple;
	bh=dw1mggA0KBzkSvRSXpTn3acuoJ0fc1ceGrGYL5EWTtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzl+a8WC3yQk2+S91HPEyOKWknV8s/zawv9Vhn5j0E9cAuA2eMClgBb4+F1A0f02w8dzE9RXgtihCpxDyoT421dqiS9cHIypYZXq2jJBltxP8b9lMlIgmrIK9V9NJLcpZpnmmmp/yDGeDza453tYiZb0c29X93lVSb8H552gTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ucUGq05L; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ucUGq05L"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BF4FF407AA;
	Tue,  4 Jun 2024 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717497345;
	bh=/9Elc/NiTVMZIzbBF+qGZh1g+8mwSv2gJbu9f4G/yys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ucUGq05LoB3qV4UoRU0sCjgTJfi+1zjd82yuxIlgAV39EYTA1GevYwZGfpZ/TSNd3
	 /AgTtpZhyBoY7WOpK7Fph/ZowQWY2VCBpJh7XVexlH+/4DUTBuBLhbuV2P/Fwx1zuK
	 gdZyEMCuNiYpqRyGWQPaOKToja5/V/3cREIL7U6UnO530uBoZPrHSh4maDOM8DE1Ya
	 aVbWFMspLQljZ0zxn6Y7HJORoDYUQ+kaNkSQs0+d7kXn7FghGgRn5tS61f3s38D6QH
	 DTLqPb924x11wiBJoRNGmJKf27Ob8+bstSOM8Bsrs+OJJ5ifSXRvyteffgQCUyY4F9
	 7LCyN+DmvhGYw==
Message-ID: <ecc5ba5b-991b-455a-96c6-3be482405a2c@canonical.com>
Date: Tue, 4 Jun 2024 18:35:37 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com
References: <20240603123710.649549-1-hui.wang@canonical.com>
 <9f41e66a-3545-4b23-b34e-608fd36fb2ea@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <9f41e66a-3545-4b23-b34e-608fd36fb2ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 14:54, Krzysztof Kozlowski wrote:
> On 03/06/2024 14:37, Hui Wang wrote:
>> In some designs, the chip reset pin is connected to a gpio, this
>> gpio needs to be set correctly before probing the driver, so adding
>> a reset-gpios in the device tree.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
>
> Best regards,
> Krzysztof
>
Got it. thanks.


