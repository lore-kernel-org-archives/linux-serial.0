Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0A2566;
	Tue,  4 Jun 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497312; cv=none; b=NSZHDt6MEVRBaroc39orRhXYhYPJ7mgFbFRfFKIKGRZZ4EwUFbsrSbw1qml+73PU3E0QYK+pz15mRK3L3/p2c9d/zDME3lCFgN/b33HSh4UcYVg4GkP6sw+JXh6mZ0k/m1Fpoh8GrwG6QQsH3vU57qlTl2vhiJaOUDbkjj1SyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497312; c=relaxed/simple;
	bh=VMEhza1tCBIRlBFUJ2DApprezBBCi/jSLZpOp5JsPk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnBEyec4zuylLpOBJbYXo3/gAy2EitJycmKrCAzX1Mdr5Z9xHlbWAdQAcp2G3mQFImyWrxTDOdVpzE8ucWh6vJYP+71nr1iDjwSYLX9smKS1rtHp125pOX2ybVgJqJid8pmfVE/iKp5rPJpzXB8eYWkJH9JZbuO15BOKQJ7F0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=akhxL64f; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="akhxL64f"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 97EC9407AA;
	Tue,  4 Jun 2024 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717497308;
	bh=0qN7APW3C08pfmAL54/1it/XbVrqAdruDujLrrCtYAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=akhxL64fVY9d++cOINZECE94pVZLzHVruKcPULHwhiYn+Ek2hK3yuAvHhCyffi/K0
	 nzBMhXn+GcW58tn6Q/QPd94MyY9egC5GcLypLSVvZiZ6tvk790KWFsJ5bg8Tzij17S
	 QQW3ip0VDDafpAupN2FH86IaVcuK4dOSpBJrfnuB1j+JQ+LMN0DpNGVFmryZXKwlhI
	 1HiP1mCCb7UJu63BlpBUMhEbUzA4Pbi5q/Qk1x96pjmheMa80jq5H2baLIsKRQJDhu
	 vsyoCOSJEeY4V7M8kWnsf5A13dyuNBKPWwqD+FV9WmSGAkbeJXXUDY2vNJSZUVq/bI
	 CiOLzYYQ2NvWg==
Message-ID: <bf7ed22b-e75a-470b-ad69-0ea0be958024@canonical.com>
Date: Tue, 4 Jun 2024 18:35:01 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Rob Herring <robh@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com
References: <20240603123710.649549-1-hui.wang@canonical.com>
 <20240603131850.GA148307-robh@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240603131850.GA148307-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/24 21:18, Rob Herring wrote:
> On Mon, Jun 03, 2024 at 08:37:09PM +0800, Hui Wang wrote:
>> In some designs, the chip reset pin is connected to a gpio, this
>> gpio needs to be set correctly before probing the driver, so adding
>> a reset-gpios in the device tree.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
>> index 5dec15b7e7c3..62aff6e034cb 100644
>> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
>> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
>> @@ -28,6 +28,9 @@ properties:
>>     clocks:
>>       maxItems: 1
>>   
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>>     clock-frequency:
>>       description:
>>         When there is no clock provider visible to the platform, this
>> @@ -120,6 +123,7 @@ examples:
>>               compatible = "nxp,sc16is752";
>>               reg = <0x54>;
>>               clocks = <&clk20m>;
>> +            reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> Missing the header for the define.
>
> Test your bindings before sending.

OK, got it.

Thanks.

>
>>               interrupt-parent = <&gpio3>;
>>               interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>>               nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
>> -- 
>> 2.34.1
>>
