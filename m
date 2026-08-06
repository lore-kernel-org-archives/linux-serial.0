Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F853AC00;
	Thu,  6 Aug 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000564; cv=none; b=JswL+wKJzFWsCdaqBr3zD6O5f9UMfHb/+2WADL+jsy2JqnqRyfRdFhsJE2LqtVTzPsGzhg3Y6Y//jrUQY11CYuvrtyRV0wOu3C+QI2rtklzplAE23ndUojZvTUTP3SWIDxpaaV2/S/e+jmIVTFJ0ckHWsQiCowmBhkSYFJvbl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000564; c=relaxed/simple;
	bh=qGt1jRf2zxv7dECrNEVbty4KQiOm+MmX82M1yqZaKSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBkcFSXy50xOz70OV7FF1XRnE0+wbpP/P7h0vEG4Cygd+V+S4asQSJVTCx2m3gdzb+7h3m4ngBx1UKyJTXPtJ2QqXqGa46ezXnUdFgROVG9TIN4ppQ3P6suJLyTbzfBEcfjAMQjlpQwgSFTdMMafcOCIzY00689JsoYejQlnRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436268|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00242445-4.05508e-05-0.997535;FP=12011622153188049519|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=lixiaochun@open-hieco.net;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ifEtOCj_1786000226;
Received: from 172.18.23.215(mailfrom:lixiaochun@open-hieco.net fp:SMTPD_---.ifEtOCj_1786000226 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Aug 2026 15:10:27 +0800
Message-ID: <2d73c05e-8e5c-43bd-b6f1-a9a97b8631bd@open-hieco.net>
Date: Thu, 6 Aug 2026 15:10:26 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: core: Fix a NULL pointer dereference in
 uart_parse_earlycon()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260806061011.9007-1-lixiaochun@open-hieco.net>
 <2026080638-waged-tactical-005d@gregkh>
Content-Language: en-US
From: Xiaochun Li <lixiaochun@open-hieco.net>
In-Reply-To: <2026080638-waged-tactical-005d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/2026 2:16 PM, Greg KH wrote:
> On Thu, Aug 06, 2026 at 02:10:11PM +0800, Xiaochun Li wrote:
>> console=uart and console=pl011 can reach the preferred console matching
>> path without an options field when a comma is absent from the command
>> line. In that case uart_parse_earlycon() receives a NULL pointer and
>> immediately passes it to strncmp(), which triggers a NULL pointer
>> dereference during console matching.
>>
>> Address this by returning -EINVAL when the options pointer is missing,
>> ensuring incomplete console arguments are cleanly rejected while
>> preserving the behavior of all valid earlycon-style command lines.
>>
>> Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
>> Signed-off-by: Xiaochun Li <lixiaochun@open-hieco.net>
>> ---
>>   drivers/tty/serial/serial_core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index a530ad372b43..02e770bf8bf6 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -2084,7 +2084,8 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>>   
>>   /**
>>    * uart_parse_earlycon - Parse earlycon options
>> - * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
>> + * @p:	     ptr to 2nd field (ie., just beyond '<name>,'); %NULL if
>> + *	     no console options were supplied
>>    * @iotype:  ptr for decoded iotype (out)
>>    * @addr:    ptr for decoded mapbase/iobase (out)
>>    * @options: ptr for <options> field; %NULL if not present (out)
>> @@ -2104,6 +2105,9 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>>   int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
>>   			resource_size_t *addr, char **options)
>>   {
>> +	if (!p)
>> +		return -EINVAL;
>> +
>>   	if (strncmp(p, "mmio,", 5) == 0) {
>>   		*iotype = UPIO_MEM;
>>   		p += 5;
>> -- 
>> 2.52.0
>>
>>
> 
> How was this tested?

Hi Greg,

The issue can be reproduced with QEMU using the following kernel
command line:

   earlyprintk=ttyS0 console=uart

Steps:
   1. Build v7.2-rc6 with CONFIG_SERIAL_8250=y and
      CONFIG_SERIAL_8250_CONSOLE=y
   2. Boot with QEMU:
      qemu-system-x86_64 -kernel bzImage -append "earlyprintk=ttyS0 console=uart" -nographic
   3. Kernel panics immediately during console_init()

The "console=uart" argument has no comma, so console_setup() in
kernel/printk/printk.c sets options to NULL. When
univ8250_console_match() is called during register_console(), it
passes that NULL directly to uart_parse_earlycon(), which
dereferences it in strncmp().

Panic log below:

[    0.000000] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    0.000000] #PF: supervisor read access in kernel mode
[    0.000000] #PF: error_code(0x0000) - not-present page
[    0.000000] PGD 0 P4D 0
[    0.000000] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc6 #5 PREEMPT(lazy)
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.q4
[    0.000000] RIP: 0010:strncmp+0x1a/0x40
[    0.000000] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 85 d2 74 24 31 c0 eb 0d 84 c9
[    0.000000] RSP: 0000:ffffffff82c03df0 EFLAGS: 00000246
[    0.000000] RAX: 0000000000000000 RBX: ffffffff82c03e20 RCX: ffffffff82c03e20
[    0.000000] RDX: 0000000000000005 RSI: ffffffff82acb7a1 RDI: 0000000000000000
[    0.000000] RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000001
[    0.000000] R10: 00000000ffffffea R11: ffffffff82c5cb20 R12: ffffffff82c03e30
[    0.000000] R13: ffffffff82c03e2c R14: 0000000000000001 R15: 0000000000014770
[    0.000000] FS:  0000000000000000(0000) GS:ffff8882b4460000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 0000000002c30000 CR4: 00000000000000b0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  uart_parse_earlycon+0x27/0x140
[    0.000000]  univ8250_console_match+0x5d/0x130
[    0.000000]  ? __do_once_done+0x36/0xa0
[    0.000000]  try_enable_preferred_console+0x62/0x140
[    0.000000]  register_console+0x11a/0x5d0
[    0.000000]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.000000]  univ8250_console_init+0x1f/0x30
[    0.000000]  console_init+0x31/0x110
[    0.000000]  start_kernel+0x50d/0x8b0
[    0.000000]  x86_64_start_reservations+0x18/0x30
[    0.000000]  x86_64_start_kernel+0x10d/0x120
[    0.000000]  common_startup_64+0x13e/0x158
[    0.000000]  </TASK>
[    0.000000] Modules linked in:
[    0.000000] CR2: 0000000000000000
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] RIP: 0010:strncmp+0x1a/0x40
[    0.000000] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 85 d2 74 24 31 c0 eb 0d 84 c9
[    0.000000] RSP: 0000:ffffffff82c03df0 EFLAGS: 00000246
[    0.000000] RAX: 0000000000000000 RBX: ffffffff82c03e20 RCX: ffffffff82c03e20
[    0.000000] RDX: 0000000000000005 RSI: ffffffff82acb7a1 RDI: 0000000000000000
[    0.000000] RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000001
[    0.000000] R10: 00000000ffffffea R11: ffffffff82c5cb20 R12: ffffffff82c03e30
[    0.000000] R13: ffffffff82c03e2c R14: 0000000000000001 R15: 0000000000014770
[    0.000000] FS:  0000000000000000(0000) GS:ffff8882b4460000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 0000000002c30000 CR4: 00000000000000b0
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


-- 
Best regards,
Xiaochun Li
