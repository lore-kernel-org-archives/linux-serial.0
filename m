Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACC1ACEDC;
	Fri, 16 May 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434812; cv=none; b=V1DfgTC8XAUErDgTGnlyeo25Fn8i1eD9vc1VoGQrzkYX+YIeyJPVUa5/5SwWj3O76WusLSdaSNX2uONJI8mmYcoLfp7IxQNFKeGWTQKbB6MKv2pWPXmJCJ9zcAbvgj1vTpuLC/YGOea/dnAjsbogJLzXy3CwNyta3vPoihKRMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434812; c=relaxed/simple;
	bh=sBSxtxLLdqehJrvz84S5CJ1cYF6ysBF6zqBFj+BR+sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CH40sozJntwvWWLfW4uM4Oe0FcFFaTM+jVeokaYauPp5wMGrklLBFIFqmC09y8gB/EBHIgHuwbRfYms/dB+2+uw/iic3HuOn90gXpqRxlKTki9kRxlHbnW/6oLij0edk18jbsCb+3L0+LhX0tB+iFWijFTznMnf1/2gE3vvRfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QJhrTkSq; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QJhrTkSq"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GMXILt418764;
	Fri, 16 May 2025 17:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747434799;
	bh=ciUcMocgfF2Sg88n3LV1vyv2J5+DjoDSa+DiepLm+Vs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QJhrTkSqB/gMOB68unIrWuVebnxtm6Icu8tvF/JGjQ8yX/TJgh0MMUUkr4XEpWjC/
	 04LN0pSPksEWdp0AJGsFDjwr87OMj0Xl+D7WRRhGdQd1wZyj0mOelom8CP75xrE6t2
	 aW6yIiDaaWIUB9mBGjxAv8Okpm8Er/i4AUWk3AOw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GMXIDa201975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 16 May 2025 17:33:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 17:33:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 17:33:17 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GMXHhF086916;
	Fri, 16 May 2025 17:33:17 -0500
Message-ID: <29e4e325-dac9-4454-9d5f-9521cc3d1865@ti.com>
Date: Fri, 16 May 2025 17:33:17 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dt-bindings: soc: ti: pruss: Add documentation for
 PRU UART support
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250513215934.933807-1-jm@ti.com>
 <20250513215934.933807-3-jm@ti.com>
 <3f989f5c-312c-4fac-8cc0-f387de84925a@kernel.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <3f989f5c-312c-4fac-8cc0-f387de84925a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 5/14/25 7:35 AM, Krzysztof Kozlowski wrote:
> On 13/05/2025 23:59, Judith Mendez wrote:
>> Add documentation for PRU UART node which is for PRU serial UART
>> based-off the industry standard TL16C550 asynchronous communications
>> element.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
> 
> Nothing in cover letter explains dependency and this the most important
> part of cover letter. Otherwise how maintainers are supposed to guess
> what they can take and what cannot?
> 
> Squash the patch with previous in such case.

Sure can do.

> 
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index 927b3200e29e..54397297cbf5 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -324,6 +324,13 @@ patternProperties:
>>       $ref: /schemas/net/ti,davinci-mdio.yaml#
>>       type: object
>>   
>> +  serial@[a-f0-9]+$:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

Will fix this and first patch as well.

Thanks

~ Judith

