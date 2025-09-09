Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABF3009F7;
	Tue,  9 Sep 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444412; cv=none; b=dwfGL+DFNPokzmU0sa2lE8vS1GANKtVccPDgsF//Jqt8Hd5zClVvCfmwNFvAmZjMAB29i8R4A0z0sta9NgbwYG3kwPXG7aWF6XhmUPY+Y819vKsfksjHa3qMWrhCpQ2iIcxILIN1tz7/nKdLCTEIgjIntZAQaXWxZzczglfRHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444412; c=relaxed/simple;
	bh=9WemSlLO1dtmpDwmWNVwfgCCFJWPVxtuZyUeILGWBJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jdCBUBoW3IU4qiazdaa+HP4Df/a82DcLLWx3FIBCLfztYyDAAk0MVBmXUuxpWFdw//hGPo5me58gHYh7cHdrD41XO8NkeBtOk9PaNVXDMbUqKUkeEkZopJlVRaFEpYcW9fBtSyG7a1Y56GEwaaPrGYlQIy9oqTnUpuYxWNM13VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LwPoka3m; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LwPoka3m"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589IxmM2403086;
	Tue, 9 Sep 2025 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444388;
	bh=nNxultVepIICdAaCN7Fu87Yuy9uxJuNEIWkHoHI96to=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LwPoka3mLAIDNy6i3kq9FkxxXO+khpHp/nL75H3OPin7tI9lVgK9R0uDyRSNQTdHX
	 M5Aws4ahyBMNJWf45K4KZlSI1FRLpthjMUmwCKy5V91sBr9qWs/pee0pLm2oaDIUgi
	 mi+JSD4oEz4L6mszndqSk7VTz/nKNGSGtaufXQ+I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589IxmYh3912931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 13:59:48 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 13:59:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 13:59:47 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589Ixl993048670;
	Tue, 9 Sep 2025 13:59:47 -0500
Message-ID: <724138f4-3c19-4c06-824a-32548d077deb@ti.com>
Date: Tue, 9 Sep 2025 13:59:47 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source
 type property
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Conor Dooley
	<conor@kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
        <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-2-k-willis@ti.com>
 <20250905-saloon-siesta-77da98d7ae02@spud>
 <DCO5EBFY39Q7.1AUMHXZPJF96S@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <DCO5EBFY39Q7.1AUMHXZPJF96S@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/9/25 04:05, Markus Schneider-Pargmann wrote:
> On Fri Sep 5, 2025 at 8:38 PM CEST, Conor Dooley wrote:
>> On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
>>> Allow the wakeup-source property to be either of type boolean or of a
>>> phandle array. The phandle array points to the system idle states that the
>>> UART can wakeup the system from.
>>>
>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>>> ---
>>>   Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> index 1859f71297ff2..851a5291b4be4 100644
>>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>>> @@ -69,7 +69,13 @@ properties:
>>>     clock-frequency: true
>>>     current-speed: true
>>>     overrun-throttle-ms: true
>>> -  wakeup-source: true
>>> +
>>> +  wakeup-source:
>>> +    oneOf:
>>> +      - type: boolean
>>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +        description:
>>> +          List of phandles to system idle states in which UARTs can wakeup the system.
>>
>> Is there a single other instance of the wakeup-source property being
>> used like this?
> 
> This was added to the dt-schema repository:
>    https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/wakeup-source.yaml
> 
> I don't think this needs to be repeated in every binding, so I think you
> can just drop this unless there are specifics for this device.
> 
> Best
> Markus

Okay, I will likely drop this patch in the next version. Thanks for 
reviewing :)

Best,
Kendall
