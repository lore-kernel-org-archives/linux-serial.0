Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D71802A3;
	Mon, 17 Jun 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618437; cv=none; b=RKhW5I+Mc2ek8DfGCbt86QroWdIWtK9gaLlAvXuj3b2w6E2NNton8D6jFR78PDufZi10QOLMir3l3uvB3x21avcOV0B8/0D+i4JY9yA/iYigCSHyEmjthYQr/n/K4y2LHpl0cwHRTOHfVVyjypYvMvnyN4xjAOQlp7ddocVOKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618437; c=relaxed/simple;
	bh=CMVlDxSdOUy+95XNw5zblVX9VgDs93mSI+wzmAgDr1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JyB+pHx0sVHq+EW3YD0yAq8zUJXOgZ1tiGuqO/OjQ9ZJr5SD8rYAwJnKK4ogD+NZt7ZfPdeCTlpx+fniXes6zcK2FFluon/oxF87il1HlUlDy1vS5HyL4DE24Zm2vZ36skbGTD+WPOALO+FYmuRi4LKio4GSdKiwBZ3E6K2yyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EKQ33z5j; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EKQ33z5j"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45H9lwgp046206;
	Mon, 17 Jun 2024 04:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718617678;
	bh=6EvuFkTe3ohvJlyxpb98f49oOrF2H7bMHIXzcQ0Hi9Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EKQ33z5jEbGFdn+FjRBzGdqyn7iJvKoi1OJAht/68XRcqAB0ZqRJIgyovxs/Fem1F
	 mP+UZb89pDFSlfeWfmuyf2DLVAFFAO73XQWOpXU6Q+2YZcDMsJsURXZg/BtZ99KyZa
	 STwMz+5pIwvMeQJMu76+X75qkoEa/Wf+c6Qf37bM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45H9lwdg030511
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 04:47:58 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 04:47:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 04:47:58 -0500
Received: from [172.24.18.200] (lt5cd2489kgj.dhcp.ti.com [172.24.18.200])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45H9lsh9010450;
	Mon, 17 Jun 2024 04:47:55 -0500
Message-ID: <46e0461e-08e2-4fcd-80dc-f1213d57489b@ti.com>
Date: Mon, 17 Jun 2024 15:17:54 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_omap: Implementation of Errata i2310
To: Greg KH <gregkh@linuxfoundation.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
References: <20240617052253.2188140-1-u-kumar1@ti.com>
 <2024061704-vengeful-exemplify-261a@gregkh>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <2024061704-vengeful-exemplify-261a@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Greg

On 6/17/2024 11:52 AM, Greg KH wrote:
> On Mon, Jun 17, 2024 at 10:52:53AM +0530, Udit Kumar wrote:
>> As per Errata i2310[0], Erroneous timeout can be triggered,
>> if this Erroneous interrupt is not cleared then it may leads
>> to storm of interrupts, therefore apply Errata i2310 solution.
>>
>> [0] https://www.ti.com/lit/pdf/sprz536 page 23
>>
>> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Test logs
>> https://gist.github.com/uditkumarti/7a7ab6994581bbb09cf1a4271c592d8e
>>
>> Change logs
>> Changes in v2:
>> - Added Fixes Tag and typo correction in commit message
>> - Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
>> Link to v1
>> https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/
>>
>>   drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>    this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.


I realized the same due to other patches, this not getting applied 
cleanly on stable (using git am).

Let me know if you are ok,  I will port this to stable kernel, once this 
is merged into Linux tree.


>
> thanks,
>
> greg k-h's patch email bot
