Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1001F9413;
	Fri,  2 May 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223681; cv=none; b=Gm5Nn+Xl9S31bdS14izVtDvaonzfTs8RHvCe4gLaH9OoF58CxBws6Rh90xOOMUCo4krBWBWQ1q79Georx/Lktrh8VsuHttU4RafI+DhkqaUHnoz+KL6qvDVedyPyLqzAkEWASSopmtUC7mcy9/0nuPmGqekIYLK3GR2gz9cJrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223681; c=relaxed/simple;
	bh=0r2MhikgXvAfIvHic5TWQipkRdPnZ37DGufsd81WXTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KQQnGLjZQuSg1AO8QSemPiUAmh7vOjo95+vzUHyIGs+W6i9726XAxLN1cl1tqlBZVUIHUzGtY7gcdbFyFX8nMWX9Jv4q4GVOl8C8SdLfvbHOxHaj7ImCrzVnciJLSlhXLG1p8G7KWfzM39nAOGX9vvJKQoU9zQe9SU3DUY+WRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TQ1thFbA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TQ1thFbA"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 542M7rmO500747
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 May 2025 17:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746223673;
	bh=RNSe6rza5kHgXd/IlOOzcpPi8hOTfCpY5td7kC0qwbA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TQ1thFbAcqfEm6alAcqVHpO/+TszzXXq8WuRhSMAEWmtIETFtTREas0YwghO13htE
	 thtgL3TKYQCtN4KJQ+WKcSuatFGBdeP88BXy50u6iFgyymMMmOAOC2Xg8nwsQoc5uk
	 vG2L/FU+bBOElX7BCUQ7r+noFi+49VTKcdN6aECo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 542M7rpI056639
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 17:07:53 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 17:07:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 17:07:53 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 542M7rCL011092;
	Fri, 2 May 2025 17:07:53 -0500
Message-ID: <a7141387-1b3c-422a-963e-d94fe8eaacf3@ti.com>
Date: Fri, 2 May 2025 17:07:53 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Introduce PRU UART driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Hari Nagalla
	<hnagalla@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
 <2025050103-graduate-anteater-e6f6@gregkh>
 <406ae5d2-9a4a-47be-9663-d746d9661f1f@ti.com>
 <aBSVld3HKL_M1agq@smile.fi.intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aBSVld3HKL_M1agq@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andy,

On 5/2/25 4:51 AM, Andy Shevchenko wrote:
> On Thu, May 01, 2025 at 09:47:34AM -0500, Judith Mendez wrote:
>> On 5/1/25 12:18 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Apr 30, 2025 at 07:31:11PM -0500, Judith Mendez wrote:
>>>> This patch series is sent as an RFC to get some initial comments
>>>> on the PRU UART driver.
>>>>
>>>> The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
>>>> SoCs have a UART sub-module. This patch series introduces the driver and the
>>>> corresponding binding documentation for this sub-module.
>>>>
>>>> The DTS patches for adding PRU nodes and enabling PRU UART will be added
>>>> in a later v1 version of the series if accepted.
>>>>
>>>> This driver has been previously tested on the following boards:
>>>> am64x SK, am62x SK, and am335x SK boards.
>>>
>>> Why is this "RFC"?  What needs to be done to make it something that you
>>> actually feel works properly and should be merged?
>>
>> Nothing needs to be done IMO, the only reason it was sent as an RFC is
>> to get initial thoughts/issues that anyone might have with the driver
>> before sending v1.
>>
>> If none, I will go ahead and send v1. Thanks for your attention Greg.
> 
> I have tons of comments, please read my replies before sending a v1.

Thanks for your comments, I need a day or so to review and then respond
to your comments and Andrews.

Judith

> 

