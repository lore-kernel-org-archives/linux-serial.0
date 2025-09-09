Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8871DFE12;
	Tue,  9 Sep 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444485; cv=none; b=do38+3ps9Q8Ovf5OLTba4cOBRVgwisN16++wjd2oTnwJVnt/cdf0Svm/mQwT0Amytjl5FYadKDtV1igsV7PGunkGtk35EJgzC02Ht3Uebltgh7wKrlKDb54+QdBhXbQ7ffgWlbRKoltWG42wycQljzKPdpCwpRqpEs174lus+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444485; c=relaxed/simple;
	bh=DoF+NrnglzV4Z2Oq9NdWnbTM+kbtwvRMLb0vYTwUTC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bxGDW7WEe09xYiEsYbe77aWOSImyhLa7AWZpGr80qVwqmvyRPIUBGYii986XI0kx38LvEy3HPr6Fup0iqKiHpFFBVF7Ay53K28j0Bd/3l9+IQDHc3/3Wk56DgzB9HasNGtTCSXxKhBX8eZtPSGA2RFmE6pHNZJIPpejwwplRJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cj7qt2Ro; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cj7qt2Ro"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589J0gH2351161;
	Tue, 9 Sep 2025 14:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444442;
	bh=bnexDaZ/iWKE4+xDrw5lx/tFXjPAwVdaz3PKjYndKpo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Cj7qt2RoGe4+hjzaQG1u1aMM0ZL6lzoVqa1NRl53PIwCPSysak/rGg81Ys6czwghl
	 XCLqw2z9ViXLHOedEvlYA0TuisIOddNObthjsiY1hkH3RCMSlwuI3dUo/rOkPBhNHA
	 1huZCGgSzTlHLkXaYeB8jM87ECMm9SfcDbbXvIw0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589J0gQH570002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 14:00:42 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 14:00:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 14:00:42 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589J0fOT3055784;
	Tue, 9 Sep 2025 14:00:42 -0500
Message-ID: <81915aee-55e7-44c8-9a43-23e77f3ddd6d@ti.com>
Date: Tue, 9 Sep 2025 14:00:41 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source
 type property
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
 <20250904212455.3729029-2-k-willis@ti.com>
 <20250905203829.GA1269545-robh@kernel.org>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250905203829.GA1269545-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/5/25 15:38, Rob Herring wrote:
> On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
>> Allow the wakeup-source property to be either of type boolean or of a
>> phandle array. The phandle array points to the system idle states that the
>> UART can wakeup the system from.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>>   Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> index 1859f71297ff2..851a5291b4be4 100644
>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> @@ -69,7 +69,13 @@ properties:
>>     clock-frequency: true
>>     current-speed: true
>>     overrun-throttle-ms: true
>> -  wakeup-source: true
>> +
>> +  wakeup-source:
>> +    oneOf:
>> +      - type: boolean
>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        description:
>> +          List of phandles to system idle states in which UARTs can wakeup the system.
> 
> You don't need to be defining the type here. Did you find either type
> didn't work?

You're right, this should not be redefined. I'll be dropping this patch 
in the next version. Thanks for reviewing :)

Best,
Kendall
