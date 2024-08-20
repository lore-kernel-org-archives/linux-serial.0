Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B018C017
	for <linux-serial@vger.kernel.org>; Tue, 20 Aug 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145314; cv=none; b=gGxDkku4zSMzB1C6LWoEbnQ/FK6PLQwiMVZf3Ob/aLOzekj5O2aG6Q+3avgntdfsPJDwdoWt7gVJV5f0T45CcCcWuq79BvO7w3snxG+o9CZlxTjIgfyK055I9eV4JdNkTRePElRGvJLyf2m4z8sVwY4HHlsubMbdoIrs82/ytww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145314; c=relaxed/simple;
	bh=Gm9LAEBCwoxdgvm4w4KM+SoeLBakruS++b4u4kSpIJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZRdT6rIKj35oC+Fo7b7sfrueHixi+jF4YQjBrcb6NL0T14tk52/g22VY+VLaBhAgYMp1xXqZVRxnuuoe9y9kzr9MmtNCN+F5hVjNZoj3W7xaQpEh5MBC9fUNntw3Z6RQKgpS873tIiSCHqEJGf/HGG3gkCw0nDY2GsDdRWbR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BIjuy841; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BIjuy841"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BEDB1BF206;
	Tue, 20 Aug 2024 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724145304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDqk00g10PQaj4SysCW44rOWpHBNDCwazE0fsXuYmj4=;
	b=BIjuy841QODmdg1BckwRTH/fOV4pkH5ZcrljbNZBuPRP9JY237sNyZWFHmMtcnXSa1GjpC
	3lbfMkFQKWQrOQ9uyTi12497jr4qnB/8WqzB9tFr+L8QHBqpLPBnRVPUM9QtMeV31K2IVT
	3muzMmV66MUK7AVOvf4vYp7RkfsQ1rhEzebKieUqhA2NWZnTRpvPJmxRmSTkfRGuUTriyR
	b/Uwz0fxaNdGNn47OwU2A3TbrnkoRNHJ98oTgVA7r3ImhI7w3dg2I+9/5BdGu91WAalND1
	2kXumTetJ2T5buiZQvxzkda7wgtU+MTrGF3Sp863zsMSI7z7fqpJ+1cG2uUdIg==
Message-ID: <b8faffb0-7ae6-4f20-a8fb-34222535b623@bootlin.com>
Date: Tue, 20 Aug 2024 11:15:03 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
To: Kevin Hilman <khilman@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, tony@atomide.com, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hzfplplfs.fsf@baylibre.com> <2024081318-litigator-slinky-8f0b@gregkh>
 <7ha5hgpchq.fsf@baylibre.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <7ha5hgpchq.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 8/13/24 19:18, Kevin Hilman wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
>> On Fri, Aug 09, 2024 at 12:04:23PM -0700, Kevin Hilman wrote:
>>> Thomas Richard <thomas.richard@bootlin.com> writes:
>>>
>>>> If the console suspend is disabled, the genpd of the console shall not
>>>> be powered-off during suspend.
>>>> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
>>>> suspend, and restore the original value during the resume.
>>>>
>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>
>>> Hmm, this patch got merged upstream (commit 68e6939ea9ec) even after
>>> disagreements about the approach.
>>>
>>> Even worse, it actually causes a crash during suspend on platforms that
>>> don't use PM domains (like AM335x Beaglebone Black.)
>>>
>>> Details on why this crashes below.
>>>
>>> Thomas, could you please submit a revert for this (with a Fixes: tag)
>>> and then follow up with the approach as discussed later in this thread?
>>
>> Did this revert happen yet?
> 
> No.
> 
> Could you revert it since it's caused regressions?  I will follow up
> with Thomas on the right fix for the original issue (as discussed later
> in this thread.)

Hello Kevin,

The series, which implements Théo's proposal, was ready to be sent when
I tried to go back to suspend after a resume. This causes a kernel panic
during the suspend.

There is the issue in both cases (console suspend and no console suspend).

The issue comes from the other uarts (not the one used by the console).
If I disable all other uarts, there is no panic.

It seems the uarts are not resumed correctly.

More investigation is needed.

Regards,

Thomas

[  145.658789] port 2830000.serial:0.0: PM: calling
pm_runtime_force_suspend @ 133, parent: 2830000.serial:0
[  145.668341] port 2830000.serial:0.0: PM: pm_runtime_force_suspend
returned 0 after 0 usecs
[  145.676598] omap8250 2830000.serial: PM: calling omap8250_suspend @
133, parent: bus@100000
[  145.684946] SError Interrupt on CPU0, code 0x00000000bf000000 -- SError
[  145.684951] CPU: 0 UID: 0 PID: 133 Comm: sh Not tainted
6.11.0-rc4-00020-g0b5cbc0defae-dirty #27
[  145.684956] Hardware name: Texas Instruments J7200 EVM (DT)
[  145.684959] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  145.684962] pc : __flush_work+0x1f0/0x2d8
[  145.684968] lr : __flush_work+0x9c/0x2d8
[  145.684971] sp : ffff8000840e39d0
[  145.684973] x29: ffff8000840e39d0 x28: ffff000804450000 x27:
ffff8000835f1000
[  145.684979] x26: 00000021acb0bb98 x25: ffff800083580090 x24:
0000000000c00000
[  145.684983] x23: 0000000000000000 x22: 0000000000000001 x21:
ffff00087f6cbe40
[  145.684988] x20: ffff0008012e80e8 x19: ffff00080013d410 x18:
0000000000000006
[  145.684993] x17: 726170202c333331 x16: 204020646e657073 x15:
0720072007200720
[  145.684997] x14: 0720072007200720 x13: ffff8000830a4660 x12:
000000000000172b
[  145.685002] x11: 0000000000000040 x10: ffff8000830a19e8 x9 :
ffff8000830a19e0
[  145.685006] x8 : ffff000800400028 x7 : 0000000000000000 x6 :
0000000000000000
[  145.685011] x5 : ffff000800400000 x4 : 0000000000000000 x3 :
0000000000000001
[  145.685015] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff00087f6cbe40
[  145.685020] Kernel panic - not syncing: Asynchronous SError Interrupt
[  145.685023] CPU: 0 UID: 0 PID: 133 Comm: sh Not tainted
6.11.0-rc4-00020-g0b5cbc0defae-dirty #27
[  145.685027] Hardware name: Texas Instruments J7200 EVM (DT)
[  145.685029] Call trace:
[  145.685031]  dump_backtrace+0x94/0xec
[  145.685038]  show_stack+0x18/0x24
[  145.685042]  dump_stack_lvl+0x38/0x90
[  145.685049]  dump_stack+0x18/0x24
[  145.685052]  panic+0x38c/0x3c0
[  145.685058]  nmi_panic+0x40/0x8c
[  145.685063]  arm64_serror_panic+0x64/0x70
[  145.685067]  do_serror+0x3c/0x78
[  145.685069]  el1h_64_error_handler+0x30/0x48
[  145.685075]  el1h_64_error+0x64/0x68
[  145.685078]  __flush_work+0x1f0/0x2d8
[  145.685080]  flush_work+0x14/0x20
[  145.685083]  omap8250_suspend+0x84/0x130
[  145.685087]  dpm_run_callback.constprop.0+0x74/0x134
[  145.685092]  device_suspend+0x110/0x400
[  145.685096]  dpm_suspend+0x10c/0x19c
[  145.685100]  dpm_suspend_start+0x70/0x78
[  145.685104]  suspend_devices_and_enter+0x12c/0x634
[  145.685110]  pm_suspend+0x160/0x270
[  145.685115]  state_store+0x80/0xec
[  145.685119]  kobj_attr_store+0x18/0x2c
[  145.685122]  sysfs_kf_write+0x44/0x54
[  145.685129]  kernfs_fop_write_iter+0x120/0x1ec
[  145.685134]  vfs_write+0x238/0x370
[  145.685140]  ksys_write+0x70/0x104
[  145.685143]  __arm64_sys_write+0x1c/0x28
[  145.685147]  invoke_syscall+0x48/0x110
[  145.685155]  el0_svc_common.constprop.0+0x40/0xe0
[  145.685159]  do_el0_svc+0x1c/0x28
[  145.685164]  el0_svc+0x34/0xdc
[  145.685168]  el0t_64_sync_handler+0x100/0x12c
[  145.685173]  el0t_64_sync+0x190/0x194
[  145.685176] SMP: stopping secondary CPUs
[  145.685181] Kernel Offset: disabled
[  145.685183] CPU features: 0x04,00001001,40100000,4200421b
[  145.685186] Memory Limit: none
[  145.953475] ---[ end Kernel panic - not syncing: Asynchronous SError
Interrupt ]---

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

