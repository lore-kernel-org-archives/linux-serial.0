Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466404AB1B0
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595555; cv=none; b=B0O15Ks8RoeagTUtJaoTHfW47nL+B5Lhcl27ArSnhF0k/6I6nysC/dTtJ5uwtenJzN891KM36ck1XaVehrQ6Nherbrt2qTwgdjmL6eRv8YfOO5qKhL66BvOWvmteGATwkSc40iFjjOxAy6s5lwZU2O3nv2UQowRhAS3xaNlGibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595555; c=relaxed/simple;
	bh=1l2qX7icuRlQWo7BAQ35G6OOotWvDj9S9DnHbTdlW3A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S847wDWFDJI6Wc/M+6ZD9m/i4F8q1xzISzeU++7ZPKvbV+HI/6pc9lXuBnPWMkp+t2ehuqv/Y9mdeRFJu01f1WbRlEmSipz+toe2Fwllmisv5ozURf5FVuEDasMZp179VFzD62E6sgHEaMjWJvySayYH4oWWOer9mwmo/Mz9Cx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pPM7i6qd; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pPM7i6qd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1wJquQpoud15qCftOoH8cqhC5EXJo3eNUPM580iS8U8=;
	b=pPM7i6qdx/JaaSniAJpGoUuDQ0Zt9it76YiWVPxygKyjkABoeeDAK8wJwkVnGSuXXuv4Blykc
	8ChduR1uxdBYC2YdgjJLMJ0mUm4AlDA4u9kWCLrsTwuqze1+PlcnebRGDma2jT8XhIVMTSLAwnm
	n0KuaKNRXHcTkdKWsOcHlLQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4htfCv6l9nznTVd;
	Mon, 28 Sep 2026 19:27:07 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 691AC40586;
	Mon, 28 Sep 2026 19:39:09 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 28 Sep 2026 19:39:08 +0800
Subject: Re: [PATCH -next,v2] serial: core: fix NULL/dangling port_dev on
 failed re-register
To: Greg KH <gregkh@linuxfoundation.org>
CC: <lujialin4@huawei.com>, <gongruiqi1@huawei.com>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tony@atomide.com>, <linux-serial@vger.kernel.org>
References: <20260924131147.1952634-1-cuigaosheng1@huawei.com>
 <2026092416-outhouse-overexert-fd98@gregkh>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <76f2f350-e0f9-d8ef-8a4a-19c89843a2b4@huawei.com>
Date: Mon, 28 Sep 2026 19:39:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026092416-outhouse-overexert-fd98@gregkh>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100018.china.huawei.com (7.152.184.13)

Sorry for the slow response, I was on holiday.

On 2026/9/24 22:40, Greg KH wrote:
> On Thu, Sep 24, 2026 at 09:11:47PM +0800, Gaosheng Cui wrote:
>> From: Cui GaoSheng <cuigaosheng1@huawei.com>
>>
>> serial8250_unregister_port() removes a port and then re-registers it
>> against the legacy serial8250 device when that device is still
>> present, ignoring the return value of uart_add_one_port(). When the
>> re-register fails, the error path of serial_core_register_port()
>> removes the port device but leaves port->port_dev dangling (or NULL
>> if the port device allocation itself failed). serial8250 matches
>> ports on ->dev, so such half-registered slots still reach
>> serial_core_unregister_port() on the next unbind:
> So this is abusing bind/unbind and not anything that normally happens in
> a system, right?

Yes, this was found by syzkaller, and the bind/unbind plus fail-nth fault injection
is just how it drives the error path, so it is not a normal workload.

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
>>
>> Fix the error path to clear port->port_dev, and bail out of
>> serial_core_unregister_port() when port_dev is NULL. Read
>> port->port_dev under port_mutex, like all of its writers.
>>
>> Reject registering a port that is already registered: a duplicate
>> attempt would otherwise mark the live port dead and orphan its
>> serial core port device before failing in serial_core_add_one_port(),
>> and the port could then no longer be unregistered.
> How can registering a port that is already registered ever actually
> happen?

It can't, nothing in-tree registers the same port twice, the check was hardening
for a hypothetical driver bug from the v1 discussion, not for anything reachable.

>
>> No state slot restore is needed on the error path:
>> serial_core_add_one_port() has no failure exit after linking
>> state->uart_port, so a failed registration never links the state
>> slot in the first place.
>>
>> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
>> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
>> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
>> ---
>> Changes in v2:
>> - Drop the state slot restore from the registration error path.
>> - Move the port->port_dev read and the !port_dev bail in
>>    serial_core_unregister_port() under port_mutex.
>> - Reject registering a port that is already registered.
>>   drivers/tty/serial/serial_core.c | 37 +++++++++++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 95774b0f1484..5651313a2468 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3318,10 +3318,20 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
>>   int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>>   {
>>   	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
>> -	int ret;
>> +	int i, ret;
>>   
>>   	guard(mutex)(&port_mutex);
>>   
>> +	/*
>> +	 * Reject registration of a port that is already registered. Bail
>> +	 * out before taking any steps (UPF_DEAD, serial core devices) so
>> +	 * that a duplicate attempt cannot disturb the live registration.
>> +	 */
>> +	for (i = 0; i < drv->nr; i++) {
>> +		if (drv->state[i].uart_port == port)
>> +			return -EINVAL;
>> +	}
> Again, what normal code path attempts to register a port that is already
> registered?

It can't, nothing in-tree registers the same port twice, the check was hardening
for a hypothetical driver bug from the v1 discussion, not for anything reachable.

>> +
>>   	/*
>>   	 * Prevent serial_port_runtime_resume() from trying to use the port
>>   	 * until serial_core_add_one_port() has completed
>> @@ -3358,6 +3368,14 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>>   
>>   err_unregister_port_dev:
>>   	serial_base_port_device_remove(port->port_dev);
>> +	/*
>> +	 * serial_base_port_device_remove() dropped the last reference to
>> +	 * the port device, so leave no dangling ->port_dev behind. No
>> +	 * state slot restore is needed: serial_core_add_one_port() has no
>> +	 * failure exit after linking state->uart_port, so a failed
>> +	 * registration never links the state slot.
>> +	 */
> Is this comment really needed?  LLMs love to do this, please don't.

It isn't, we can drop the comments.

>> +	port->port_dev = NULL;
>>   
>>   err_unregister_ctrl_dev:
>>   	serial_base_ctrl_device_remove(new_ctrl_dev);
>> @@ -3372,12 +3390,25 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>>   void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
>>   {
>>   	struct device *phys_dev = port->dev;
>> -	struct serial_port_device *port_dev = port->port_dev;
>> -	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
>> +	struct serial_port_device *port_dev;
>> +	struct serial_ctrl_device *ctrl_dev;
>>   	int ctrl_id = port->ctrl_id;
>>   
>>   	guard(mutex)(&port_mutex);
>>   
>> +	/*
>> +	 * A port may be unregistered even though it was never successfully
>> +	 * registered (e.g. an allocation failure aborted serial_core_register_port()
>> +	 * part-way).
> Ok, that might happen, but if it does, unregister isn't called, the port
> is just "dead".

It's true for normal drivers, but serial8250 removes ports by ->dev,
not by registration success, and re-registers them on every unbind
while ignoring the return value. A failed re-register therefore
still gets matched and removed by the next unbind - that is the
oops in the commit message. The leftover is a dangling pointer,
not a dead port; the fix is what makes it "just dead".

>> Drivers like serial8250 remove ports matching on ->dev, so
>> +	 * those half-registered ports still reach us with port_dev == NULL. Read
>> +	 * ->port_dev under port_mutex like all of its writers.
> How are you removing a port that failed to be added?
>
> I'm all for fixing real issues, but not fake ones.

This was found by syzkaller with fail-nth fault injection, so the
trigger is a fuzzer path, not a normal workload, but the oops is
from a real run.

I've sent a v3 with just the minimal fix, worth fixing, or too
theoretical to bother?

Thanks.

> thanks,
>
> greg k-h
>
> .
