Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559A2517AF;
	Tue,  9 Sep 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453232; cv=none; b=S5D/yKowEkyikI89ib4CG5U4bcoqpfUliqZ9CG8FNmNQbG6UMTPQ6YED7Lavw9zjIQUs2bwprsR4coAy7Q98yYLcIyNSfewX3eNT1ZcsF/HQiQ907b4MdrtekW2Wyi9np64nnoh/BtkaXyGpKEMFMvMjytgsrUhIZCtejr9hDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453232; c=relaxed/simple;
	bh=ztd0PJg3C+b3kWmj9bQ1tSJv6YPxmfQhjNFvXW5kX50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kJ7s9BfDLL1rZXTd11O1KkKy0w3AJybI62kXmaiVk2nKVYHJH3Ie/lz2SXe27rjjh4Su8MrRlD/qrgFE1YUGQBm+sQsWshTX3tok0GoI82gGTjIgqkTbo7wAbJ2U5bH9LBTtZ5g0JakLq2tzdYNWL7l/Z3hR/51NZjRxJLOUP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g2ctUQOa; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2ctUQOa"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589LQoIg373674;
	Tue, 9 Sep 2025 16:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757453210;
	bh=89R5+36RXu8JOVcLNkTbryKwxB+M9BPBpOmVrnsCMBY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g2ctUQOaOI9K7Teuurc3Lw4tnrlDh0jL7TU7ygZt1eWKFRX0oN84gVb5XcL6VZ9A6
	 YH3mWBDYvaHufdjftu+UUYEg0SD9q/uC2scp58ZmrSv1kkjKSz8P2fY7YUYKRfa1DM
	 AFA5hvHs89CH8aD4r1rqVbiYBzmKgJWHtAxZIs00=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589LQovh4069382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 16:26:50 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 16:26:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 16:26:49 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589LQnBZ3339983;
	Tue, 9 Sep 2025 16:26:49 -0500
Message-ID: <c2fad6ac-d296-4155-b101-bd82defd2e6d@ti.com>
Date: Tue, 9 Sep 2025 16:26:49 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250_omap: Add wakeup pinctrl
 state
To: Rob Herring <robh@kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>, <john.ogness@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <yujiaoliang@vivo.com>,
        <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-3-k-willis@ti.com>
 <20250905204148.GA1313142-robh@kernel.org>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250905204148.GA1313142-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rob,
On 9/5/25 15:41, Rob Herring wrote:
> On Thu, Sep 04, 2025 at 04:24:54PM -0500, Kendall Willis wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Pins associated with the 8250 omap unit can be the source of a wakeup in
>> deep sleep states. To be able to wakeup, these pins have to be
>> configured in a special way. To support this configuration add the
>> default and wakeup pinctrl states. Add support for the sleep state as
>> well which is in use by some devicetrees.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>>   .../devicetree/bindings/serial/8250_omap.yaml   | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> index 851a5291b4be4..1c4040a9f9d0b 100644
>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> @@ -77,6 +77,23 @@ properties:
>>           description:
>>             List of phandles to system idle states in which UARTs can wakeup the system.
>>   
>> +  pinctrl-0:
>> +    description: Default pinctrl state
>> +
>> +  pinctrl-1:
>> +    description: Can be "sleep" or "wakeup" pinctrl state
>> +
>> +  pinctrl-names:
>> +    description:
>> +      When present should contain at least "default" describing the default pin
>> +      states. Other states are "sleep" which describes the pinstate when
>> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: sleep
>> +      - const: wakeup
> 
> This doesn't match what 'pinctrl-1' says. Perhaps you want?:
> 
> items:
>    - const: default
>    - enum: [ sleep, wakeup ]

That is my mistake, I should have added another pinctrl-2 which could be 
either "sleep" or "wakeup" state. This would mean that all three states 
could be present at the same time so it should stay as separate items. 
The thought process for the availability of all three states is that if 
the UART is not wakeup capable, it could use the sleep state when 
suspending.

However, the serial 8250 omap driver does not use the sleep pinctrl 
state as of now, so for the next version I think I will remove the sleep 
state since it is not necessary/used as of this moment.

Thanks for reviewing!

Best,
Kendall

> 
>> +
>>   required:
>>     - compatible
>>     - reg
>> -- 
>> 2.34.1
>>

