Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38811231841;
	Fri, 16 May 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434973; cv=none; b=iFMCv7PEs7RM3sN0nNrEKw157yyQdS8QoWwyBZUJkVbZOltH+5/eLP+iVZuxLFoh54acePl+nim6oUb5V685VeP3h/qqfsPtfZWj19co8WZOd/9YiZteGcKFmtnIyk1+I9+0NyjSSs8AGLvtN/SOEy5q5rv3AyCs090TOJv9TmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434973; c=relaxed/simple;
	bh=S8VqnsRWmVgpbWGtGj+EFiFExcvjj76012BsLEMWG8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjTcEFHmGNUFzuJOGM1WlqsjeKBzNRD1Spy9B1JSCVj0JFcAb3SKY9na8ng3JR7yPEyXE7/jUlSKP5+Ppp+IXz0mUEHDoJceahAN9NrO3y3U71WU1BYzyj6heUr+1dTFLcFHNyFJuDgLrorsoiyfoFDzdhxtVm+FglPBSLNv7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L4d1Vxmv; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L4d1Vxmv"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GMa3UZ419051;
	Fri, 16 May 2025 17:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747434963;
	bh=ApFBcOWG2ieHiTUYXnkfHS3k7Kt6Hoxe9udfT1lGPaU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L4d1VxmvTUJDq2EFONO7jt0pi7rMHt/MtBucl1TBizYEbCt5qBh1Ed/qJQ3pAlUh1
	 WV82mGPqYzhrHz0MC8CDOnqm2ExeiP1iRCVnGLovZIDf7Tu3uSOSYA4ENCVmX8Jjyk
	 tEv7iZVfGPro3+ckEuRsZgNN3UyYxU94e63Pyn0o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GMa3PX202875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 16 May 2025 17:36:03 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 17:36:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 17:36:02 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GMa2EU095804;
	Fri, 16 May 2025 17:36:02 -0500
Message-ID: <5cede33c-664c-488a-aef7-4619368c24d6@ti.com>
Date: Fri, 16 May 2025 17:36:02 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] serial: 8250: Add PRUSS UART driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Bin Liu
	<b-liu@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew
 Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250513215934.933807-1-jm@ti.com>
 <20250513215934.933807-4-jm@ti.com>
 <2025051408-discolor-backwash-5574@gregkh>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <2025051408-discolor-backwash-5574@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Greg,

On 5/14/25 2:36 AM, Greg Kroah-Hartman wrote:
> On Tue, May 13, 2025 at 04:59:30PM -0500, Judith Mendez wrote:
>> From: Bin Liu <b-liu@ti.com>
>>
>> This adds a new serial 8250 driver that supports the UART in PRUSS or
>> PRU_ICSS*.
>>
>> The UART sub-module is based on the industry standard TL16C550 UART
>> controller, which has 16-bytes FIFO and supports 16x and 13x over
>> samplings.
> 
> If it is based on an existing controller, why do we need a new driver
> for this?  Please explain in detail why this code is needed at all, and
> not just a new "quirk" for the existing driver?

This was explained in RFC [0] but the patch description can be improved
so will fix for v2.

[0] https://lore.kernel.org/all/ba88a5c0-a8b8-4e48-9752-76881fa8e94e@ti.com/

Thanks
~ Judith
