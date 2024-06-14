Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A677185085;
	Fri, 14 Jun 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353403; cv=none; b=fRKExRE8GU6tlScVO/ubHXAgjW7YTivtMmuH4qHdysJ/c4XOrHKie/myTBPcmLhURsIzrTBGliH7FqFg/9crCjcbuuRjyCZ2wicRpUPTQn8HUTh1XfUaHrc6m+7I5i27nzK9Otm8CgkLLohBvD1gyGoFAPWYOHshhurC10PWR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353403; c=relaxed/simple;
	bh=WuwY6T3tgfTA3Se9YOsZDTG4En+k8D3HJ77FHQiEq6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QmQ/+SXV+cFbmJHA5WfNoIM0oip6d3Svq5K3wFGdnt1CAA1ly248aE3ygMmqSK/EEpugGZUqLc0s+xLDLRqGU9Ew6jmzT4BWA73hy2VZ3J/9uISfoqJlU5VvI4P5yvPRSQ1UqxmvAkgXD+9q10KM/gvLvi/+1E2KEwffJ9bv8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EDcFfkSj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EDcFfkSj"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E8N3G7059213;
	Fri, 14 Jun 2024 03:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718353383;
	bh=dyrikqBIHld8qG+NfybdOhRSOUR8nCN2eY444ubtgGg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EDcFfkSj/GwGC6ZhC62QJ3uFhEbXFqsUpMjz6oo8CB4o7W3LRNVwOIWLeXYh2GYX7
	 qg8nmwfuxSSsjGVraebW8XiRRulqwoKRkg8nk8kxrXE6R7X78ndYdp6mi6iDvj3IG2
	 Cq9RmqLE8qj3Pt1xqsrEQYixtutVdqXxwRqTv6Y8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E8N3LW084603
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 03:23:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 03:23:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 03:23:03 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E8MxPX004736;
	Fri, 14 Jun 2024 03:23:00 -0500
Message-ID: <4220a910-b64a-4212-8d29-a4dbedfba735@ti.com>
Date: Fri, 14 Jun 2024 13:52:59 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Implementation of Errata i2310
To: Greg KH <gregkh@linuxfoundation.org>, Udit Kumar <u-kumar1@ti.com>
CC: <nm@ti.com>, <tony@atomide.com>, <jirislaby@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <ronald.wahl@raritan.com>,
        <thomas.richard@bootlin.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
References: <20240614061314.290840-1-u-kumar1@ti.com>
 <2024061435-reawake-smoking-f639@gregkh>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <2024061435-reawake-smoking-f639@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 14/06/24 12:16, Greg KH wrote:
> On Fri, Jun 14, 2024 at 11:43:14AM +0530, Udit Kumar wrote:
>> As per Errata i2310[0], Erroneous timeout can be triggered,
>> if this Erroneous interrupt is not cleared then it may leads
>> to strom of interrupts, therefore apply Errata i2310 solution.
>>

s/strom/storm

>> [0] https://www.ti.com/lit/pdf/sprz536 page 23
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> Does this need to go to older/stable kernels?  If so, how far back?
> 

Yes, this seems to be an updated workaround to existing errata.
Please add below Fixes tag when you respin

Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")


> thanks,
> 
> greg k-h

-- 
Regards
Vignesh
