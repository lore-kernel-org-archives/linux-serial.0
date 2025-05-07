Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216828A419;
	Wed,  7 May 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635509; cv=none; b=XU6366Bqqo98WbQBk7ILsHy6bImBrg7lP8e55CNLfgLNi3Vowo/nO6fBs+GjtUM15AYgTY8QTUFMQiquSYKmyb0qdpa0Y5fV6q6Vu+VHKF0fV7PTsI/iIiNuZ3YNp7+oLZSSiDH2OmzQNXsvyAbnVVd8OlxX9br2vQLo3ZGcIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635509; c=relaxed/simple;
	bh=J7zUAtlGwiwO/WIy81WUiaijUl2DgI8V4ukSV13GD4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xb5X5u0jmHPVNhfZxgzDBT/7G0YREg0vATtx+4/n2r24UqCujqk4UjHsd1FiCWFJf/9LBYlB0Pto2258wC0ZsZoPCqZFq6m8Q0K/aMBhe0av92MqZAK4TDVR7PQ+7QPD7/Drs7FRpHbLPHCKJEhxZ4qWYCk1gZP/FBWuZqxjPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=helrUNnD; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="helrUNnD"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 547GVSR21426205
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 11:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746635488;
	bh=T5HdIX4Eagvu+H1MhZGppYcNn1F0MPYiO0LJscqQoS0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=helrUNnDcX8ZBFLiV/JattiHtRMgbRJucIJHH0ZMZNfxWLQRe0zEf1ENwnqpwWI+1
	 IadWicWNHSemEtS0lmE6D2WY53XePKp6AZPsvfzyXTPQLJLWpE1HmqeceI4l3a5zCt
	 3jVbkTxutRUhSp9iPOAPbkSKh64t2HXrgZh/3M78=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 547GVSEG052668
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 May 2025 11:31:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 11:31:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 11:31:27 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 547GVRia102625;
	Wed, 7 May 2025 11:31:27 -0500
Message-ID: <ba88a5c0-a8b8-4e48-9752-76881fa8e94e@ti.com>
Date: Wed, 7 May 2025 11:31:27 -0500
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
 <aBSSpsT_7UsqN6bl@smile.fi.intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <aBSSpsT_7UsqN6bl@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andy,

On 5/2/25 4:38 AM, Andy Shevchenko wrote:
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
> The first and main question here: Have you checked the existing zillion of
> drivers and become with an idea that none of them not even close to this one
> (based on RTL)?
> 

Thanks for reviewing.

I have looked through the drivers in tty/serial/8250 and I believe there
are no drivers we could leverage, especially since this driver has a
dependency on the PRU drivers for clock and power. This PORT_16550A UART
is in PRU module which is specific to TI, so besides simplifying the
driver a bit further, I don't think we can use another driver.

~ Judith



