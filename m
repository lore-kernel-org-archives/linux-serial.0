Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E11362;
	Thu,  1 May 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110864; cv=none; b=MW+LLhoUizzaKpQDubvNRzbYCX4B2XY7Y1YxcD7k/PYyhHVUOnitrOAnu0IC9nTShiQWS5vX+JzVzkRRpRgMD7dTFfCesw9iQmJQPu03pLShILEIDviS4XOV5UCMAozQqCaT5ZHxDrAI3uAUoHK2X1cnBrarYSQEIfwZ8LbwSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110864; c=relaxed/simple;
	bh=rx9dpJQAn32YPiRcOKoaENDMtIstk9odnIzJQtw8S4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mqakXQ2CI1GS1bsP/NW1ERZuyKjk2By21oLKal/Qj2LKYXzmrexzQ0qgAqBEsDm0eVXW0+I23F2GBZCc95R8Cis1A3K5yjKvZuePL10hFy2HOFqOo9hPvcdcW8ESknI10OEplS+D/CqG7RaNbgHbdVP6kLxxZ3HmG9ncCe+GyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WJSE9Ij9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJSE9Ij9"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 541ElYbt3637973
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746110854;
	bh=z0w/UXsVt0Lshm8wHvoGxfcccGwZssXaLpQf3r7A6A0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WJSE9Ij9cQ/revMWAsnAo8a6tiLns6Hox6sYdTj3mK0jyMCBwlWW9u283VwnLbySj
	 cqZRxldIBIUkD7Al8HdDm0TtiPDF7h/BhIz2VqcTxwaEK1eqiUs+DKUlBLTQ//2/HI
	 dJOkoswiZCVjjP3awjpTM7jJFCUEgx+4inA2/+v0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 541ElYFw058719
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 May 2025 09:47:34 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 May 2025 09:47:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 May 2025 09:47:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 541ElYhI104710;
	Thu, 1 May 2025 09:47:34 -0500
Message-ID: <406ae5d2-9a4a-47be-9663-d746d9661f1f@ti.com>
Date: Thu, 1 May 2025 09:47:34 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Introduce PRU UART driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Kevin Hilman <khilman@baylibre.com>, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Hari Nagalla
	<hnagalla@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <2025050103-graduate-anteater-e6f6@gregkh>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <2025050103-graduate-anteater-e6f6@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Greg,

On 5/1/25 12:18 AM, Greg Kroah-Hartman wrote:
> On Wed, Apr 30, 2025 at 07:31:11PM -0500, Judith Mendez wrote:
>> This patch series is sent as an RFC to get some initial comments
>> on the PRU UART driver.
>>
>> The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
>> SoCs have a UART sub-module. This patch series introduces the driver and the
>> corresponding binding documentation for this sub-module.
>>
>> The DTS patches for adding PRU nodes and enabling PRU UART will be added
>> in a later v1 version of the series if accepted.
>>
>> This driver has been previously tested on the following boards:
>> am64x SK, am62x SK, and am335x SK boards.
> 
> Why is this "RFC"?  What needs to be done to make it something that you
> actually feel works properly and should be merged?

Nothing needs to be done IMO, the only reason it was sent as an RFC is
to get initial thoughts/issues that anyone might have with the driver
before sending v1.

If none, I will go ahead and send v1. Thanks for your attention Greg.

~ Judith

