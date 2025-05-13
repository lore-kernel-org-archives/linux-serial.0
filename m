Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F611748F;
	Tue, 13 May 2025 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094812; cv=none; b=FngrpmsZRc4XomTaR1HejPASBWZ+hZWmG2iA+LcH8+9NWAAOVp1FPENJQWLXntg0bRBd5chCDdEfSle8gkhASjlABhCR/JsaTyuk9ZuucudCxmE9VzFgtqTUF0V68PlHx9HHPEjhb0cqxqXPw740sSEtKkZorqLUv0jyfUnQIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094812; c=relaxed/simple;
	bh=fIQMfL27R2eiZcAc13UNwfxPlTqFgGPG/woEH18BNlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oAO/unS6UYapf5tBxM1mxYKdnRpvMQqYHOM2fT1WwfwOrTI8kwdk3p2/gqp3EbYErfCTR/nfYZ/CUTKbVpYpZ9SWRhh5XJnmJ7AatvH8Trj9N6bSwk7hCxXDsQIRdF61kHri7Z4FyCu17v5sFkYkjeqH7npV+lHHZfZHBw/AsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N613c/VX; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N613c/VX"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54D06iwj2909250
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 19:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747094804;
	bh=4JzKR+c58LONNtEqTsnKpQujX/d+p3CT73LvaneUQYI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N613c/VX5X2i4EFsMDCVpkfH+TatXK44Uw7muS+8v6h+SldvLQB5F1504ddwUgRIH
	 49sHnHuU/ufzbEH4NJJTObuaEgzYX7iR12waUm8NjMPgDn8UHSNy8hhuI9Oa37oWxz
	 t/KYaZxYbG2EpcunmTfImf2w83Wpo8qOVNSeO3so=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54D06iBM012715
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 May 2025 19:06:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 May 2025 19:06:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 May 2025 19:06:44 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54D06hk6030575;
	Mon, 12 May 2025 19:06:43 -0500
Message-ID: <cd88db5d-a792-488a-98c0-678aed8e3559@ti.com>
Date: Mon, 12 May 2025 19:06:43 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] serial: 8250: Add PRUSS UART driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Hari Nagalla
	<hnagalla@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <20250501003113.1609342-3-jm@ti.com> <aBSVeKoR0j4J0ruz@smile.fi.intel.com>
 <22de0384-974d-4170-8181-e43cc90aab9d@ti.com>
 <aB3qWWgWfs6fDTgg@smile.fi.intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aB3qWWgWfs6fDTgg@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andy,

On 5/9/25 6:43 AM, Andy Shevchenko wrote:
> On Thu, May 08, 2025 at 05:09:03PM -0500, Judith Mendez wrote:
>> On 5/2/25 4:50 AM, Andy Shevchenko wrote:
>>> On Wed, Apr 30, 2025 at 07:31:13PM -0500, Judith Mendez wrote:

...
>>>> +	/* Old custom speed handling */
>>>> +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
>>>> +		quot = port->custom_divisor & UART_DIV_MAX;
>>>> +		if (port->custom_divisor & (1 << 16))
>>>> +			*frac = PRUSS_UART_MDR_13X_MODE;
>>>> +		else
>>>> +			*frac = PRUSS_UART_MDR_16X_MODE;
>>>> +
>>>> +		return quot;
>>>> +	}
>>>
>>> Why?! Please, try to avoid adding more drivers with this ugly hack.
>>
>> My understanding is that this is not a hack, for 38400 we need to pass
>> as custom baud. What is the alternative here?
> 
> BOTHER. The 38400 is a hack, you lie to the stakeholders that you are at 38.4,
> while in real life it means anything.
> 
>> I see other drivers are doing this as well, will look into this further
>> but not sure if there is a better solution for this.
> 
> BOTHER is the solution. Not perfect, but the existing one.


Thanks for the hint, I have removed the hack from the driver and will be
sending v1. thanks.

~ Judith


