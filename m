Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491C364EAB
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649472; cv=none; b=BylfYCClzJHFW2qgD1rc7bs8UR4huJRM5c719UwMl8nyuR1UBg55mRcVlO1pctN8qMkgGUfDI60kcrLm4aYpYxzXPRJB99aCIKmblPXvBgfOPr+W8rCEwnh9xH0uWift2FmsWQ5fHlDghxWFhdqypgNqid4WKgDBZSF6ZKSUgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649472; c=relaxed/simple;
	bh=ku3EiAH3x4OVjufIjYElveaMxB3fpLtJ+dAtiRC04qw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i6k7GNCXiApYDbJGQgtqxlW5241UHnFn5NQCiX0XaJaDwKzYmkzhlICS5BmWHLFRKRqZyldQoS6m9b9ac9hv1qYUmSICWCNLpvqA4tutn3KeZpQJ9chgU/68iwbNB1eMc7X6kuBG8cUlISXmrP+W3ZcYNd6K4suSY2vf1gkIdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WGABpmXv; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WGABpmXv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EDDlVQzlYhQYefKmW1nXsGs3ejisQ2KsAvTFXQ/kg+o=;
	b=WGABpmXvwPEmS2wJqtbm3hARc0xDmAY067358flgqoFQE+Z2b2MTue9lGt5RwVc2AegFIwgsn
	SlMnfpZAjMMB7i7dzW7Vz3zI7G+JzE97+X/30+ZQeH2vLRpr3jMMbS1GdjeCd04CRZpB1P3bolh
	tSzbmtGu/R8zU5Wuk8YCndM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hv28V0L3Wz1prl2;
	Tue, 29 Sep 2026 10:25:30 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 9971E40537;
	Tue, 29 Sep 2026 10:37:40 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 29 Sep 2026 10:37:39 +0800
Subject: Re: [PATCH -next,v3] serial: core: fix NULL/dangling port_dev on
 failed re-register
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <lujialin4@huawei.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <tony@atomide.com>,
	<linux-serial@vger.kernel.org>
References: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
 <arrgcE9hdhv_-GBi@ashevche-desk.local>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <aad02451-3115-66ff-95ea-c727de50d3e1@huawei.com>
Date: Tue, 29 Sep 2026 10:37:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <arrgcE9hdhv_-GBi@ashevche-desk.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100018.china.huawei.com (7.152.184.13)


On 2026/9/29 5:47, Andy Shevchenko wrote:
> On Mon, Sep 28, 2026 at 07:34:56PM +0800, Gaosheng Cui wrote:
>
>> serial8250_unregister_port() removes a port and then re-registers it
>> against the legacy serial8250 device when that device is still
>> present, ignoring the return value of uart_add_one_port(). When the
>> re-register fails, the error path of serial_core_register_port()
>> removes the port device but leaves port->port_dev dangling (or NULL
>> if the port device allocation itself failed). serial8250 matches
>> ports on ->dev, so such half-registered slots still reach
>> serial_core_unregister_port() on the next unbind:
>>
>>    Oops: general protection fault ... SMP KASAN PTI
>>    KASAN: null-ptr-deref in range [0x40-0x47]
>>    RIP: serial_core_unregister_port+0xe5/0xa00
>>      serial8250_unregister_port+0x103
>>      serial8250_remove+0x61
>>      device_release_driver_internal+0x38c
>>      unbind_store+0xd1
>>      kernfs_fop_write_iter+0x329
>>      vfs_write+0x5d0
>>      ksys_write+0xf7
>>      do_syscall_64+0xdd
>>      entry_SYSCALL_64_after_hwframe+0x77
> Submitting Patches is clear about bloated backtraces in the commit message.
>
>> Fix the error path to clear port->port_dev, and bail out of
>> serial_core_unregister_port() when port_dev is NULL. Read
>> port->port_dev under port_mutex, like all of its writers.
>> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
>> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
> Assisted-by: LLM
>
>> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>

Thanks, I have submitted the V4 patch.

