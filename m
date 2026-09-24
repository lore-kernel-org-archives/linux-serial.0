Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E64825CE
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256525; cv=none; b=KTSK1t0pI8GqzwSF0oO/yA9WtQQFqviZ1CNeYk7O7ZMqzhlErl/5C/+PIxZtH7qX89MWf5OD6PO0jdRVRIUvYbGwPaTJdQJkKeCyzBgjHNkHRybdFU5vcDDbru6uk9x613NJcR4ZoDsBWca0XyZCHoE5857q8N1JuCInD1nlp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256525; c=relaxed/simple;
	bh=HYmv9NdwPTCfKgKO/g9OjyOifgLkrGvkiAbziJYb62c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IPNj/Q6QayCDhUE50/fWHzd1M180gznyKqNWhzYsPxz4Jlym31nznLH8SWjxpjqaZqt2OYPMO+osS1eol4unS9ppO4bU+auXCMq+O4YxtcG8p0Y3/+CiPSu4exy8KR5axF9KolR0HggzyUyk6kqHKgzNxUTNSL6LeYmqNX4qvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QkIx58IY; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QkIx58IY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zm+baVi15wC085k0s5aKtDrXCNN5x8cmV6j8OYC/bxU=;
	b=QkIx58IYQxn6qCD+/Kh74kdYryJfKiN0+ZfIMYruYBht8Wi2Fu118luCD12VEfds38JUyODOb
	k1K+QmgNMIYDfOB2aXOKzFHph/Rdf3K4KdHYSdCrGCa9455Wsv2xtk461dPSVi9kLyvWLxBpYCs
	XVSkeKp6GvuiBWdwM3joTMU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hrDqp4zCMznTVd;
	Thu, 24 Sep 2026 21:16:22 +0800 (CST)
Received: from whupemk100018.china.huawei.com (unknown [7.152.184.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B3BB40586;
	Thu, 24 Sep 2026 21:28:26 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 whupemk100018.china.huawei.com (7.152.184.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 21:28:25 +0800
Subject: Re: [PATCH -next] serial: core: fix NULL/dangling port_dev on failed
 re-register
To: Greg KH <gregkh@linuxfoundation.org>, <sashiko-bot@kernel.org>
CC: <lujialin4@huawei.com>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <kmehltretter@gmail.com>,
	<john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tony@atomide.com>, <linux-serial@vger.kernel.org>
References: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
 <2026092332-divisible-hypocrite-d223@gregkh>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <d3cb66b5-5b2a-ee57-8eb6-4e66d7e575be@huawei.com>
Date: Thu, 24 Sep 2026 21:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026092332-divisible-hypocrite-d223@gregkh>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100018.china.huawei.com (7.152.184.13)

Thanks for the review, I have submitted v2 of the patch.

I have tested on x86_64 linux-next (7.2.0-rc7) with KASAN, failslab and
fault injection debugfs enabled;

It takes two unbind rounds to reproduce since
serial8250_unregister_port() first unregisters and then re-registers
the port: the fault injection must hit the re-registration to plant
the stale port_dev, and only the next unbind dereferences it. The
reproducer is a small userspace program that loops over sysfs
bind/unbind of serial8250 and scans /proc/self/fail-nth from 1 to
6000, making the Nth slab allocation on the re-register path fail
with -ENOMEM:

   bind; fail_nth=N; unbind; fail_nth=0; bind; unbind

For fail-nth to reach this path, failslab's ignore-gfp-wait needs
to be cleared first, otherwise GFP_KERNEL allocations are skipped
before the fail-nth check and nothing gets injected.

Without the patch the scan hits the oops quoted in the commit
message. With the patch the full 6000-iteration scan completes
without any crash, the FAULT_INJECTION debug output in dmesg
confirms the injections were actually hitting the path, and the
ports keep working afterwards since a failed re-register is simply
retried on the next bind/unbind round.

Thanks,

On 2026/9/23 20:52, Greg KH wrote:
> On Mon, Sep 14, 2026 at 09:51:54PM +0800, Gaosheng Cui wrote:
>> From: Cui GaoSheng <cuigaosheng1@huawei.com>
>>
>> serial8250_unregister_port() removes a port and then re-registers it
>> against the legacy serial8250 device when that device is still
>> present, ignoring the return value of uart_add_one_port(). When the
>> re-register fails, the error path of serial_core_register_port()
>> removes the port device but leaves port->port_dev dangling. A port
>> that was never successfully registered (e.g. serial_core_port_device_add()
>> failed) also reaches the unregister path with port->port_dev unset.
>> serial8250 matches ports on ->dev, so such half-registered slots
>> still reach serial_core_unregister_port() on the next unbind:
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
>>
>> Fix the error path to clear port->port_dev and restore the state slot
>> (guarded by line range) to the "not registered" state, and bail out of
>> serial_core_unregister_port() when port_dev is NULL (either dangling
>> from a failed re-register or never set).
>>
>> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
>> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
>> ---
> Did you forget the Assited-by: tag?
>
>
>>   drivers/tty/serial/serial_core.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 95774b0f1484..62d93c5964e2 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3358,6 +3358,17 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>>   
>>   err_unregister_port_dev:
>>   	serial_base_port_device_remove(port->port_dev);
>> +	/*
>> +	 * serial_base_port_device_remove() dropped the last reference to the
>> +	 * port device, so leave no dangling ->port_dev behind. Restore the
>> +	 * state slot to the same "not registered" state that
>> +	 * serial_core_remove_one_port() produces on the normal path; the
>> +	 * line range guard also covers the -EINVAL exit of
>> +	 * serial_core_add_one_port() where line >= drv->nr.
>> +	 */
>> +	port->port_dev = NULL;
>> +	if (port->line < drv->nr && drv->state[port->line].uart_port == port)
>> +		drv->state[port->line].uart_port = NULL;
>
> How was this tested?
>
>
>>   
>>   err_unregister_ctrl_dev:
>>   	serial_base_ctrl_device_remove(new_ctrl_dev);
>> @@ -3373,11 +3384,23 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
>>   {
>>   	struct device *phys_dev = port->dev;
>>   	struct serial_port_device *port_dev = port->port_dev;
>> -	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
>> +	struct serial_ctrl_device *ctrl_dev;
>>   	int ctrl_id = port->ctrl_id;
>>   
>> +	/*
>> +	 * A port may be unregistered even though it was never successfully
>> +	 * registered (e.g. an allocation failure aborted serial_core_register_port()
>> +	 * part-way). Drivers like serial8250 remove ports matching on ->dev, so
>> +	 * those half-registered ports still reach us with port_dev == NULL. Do not
>> +	 * dereference it.
>> +	 */
>> +	if (!port_dev)
>> +		return;
> What keeps port_dev from not changing right after you read it?
>
> thanks,
>
> greg k-h
>
> .
