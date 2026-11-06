Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.69.192.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973371;
	b=mygtK8cI4yUy9iDe8+euhj/M6ahayKyUTPE5TO+0UE+b1H4JJzUBLwt0oCvrUT8Vgd0n
	 aBCo0BiRszxePdPsP39BXATbQLU03qV9cPQ54mDR8RSD1iG9VhFPKQxlOnm3iYiREnr8K
	 N62WHbPyh7OrJAcFBTnDpZ1/1k38FVNHSllNdKOnkGA6J/fOCWuvkRZzss0TQaiI7IhuA
	 Tnus8sgtpfQLkEeAdREV8MWwGTjYxfGjX15rRbIV1jv/l4l1OAFbBEcDMMuc0Ey4Sv02f
	 BVOOB/Yvv/Kux+OElvKXUVcv8KE0Zx9/hukuR3DqDRFo6fD5f5R/0kNv8kehAFYradA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CfKa1XwBZFlq7SyePp3TfJX1RCdePP6YhtYiaNnpyL4=;
	b=Nif6prLJc34T/VplXRW3Fsej4IxFEY67qwXovjwn8T4ASUo9vdGjTu4zyy7alHpVaSDH
	 7pFNV0oD8p92QmsyM8yfR/YaLlpPU/pmpuW09zPjP1nxJSYRAsx7N8S+WZLXiEutuMHqY
	 Wac9lZVpfljVvFooq1vq98QO1zo+VQZsZlewd+mDFdcibsFI8tNOXMC/1cEzKzO83A3PH
	 ByWS9CsYm7HJnrWSP/hPBPDOXhFE66mnzKlF3vv7b9wgMDzW090pPJdykqTK0QEZX0yi1
	 GDciACqXXYhBKgKt0KEe1O6K0/BqiHwvJRIdYoxpwusfoHA5JcAv2mFJWIb0+EsX6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tik.uni-stuttgart.de;
	spf=pass smtp.mailfrom=tik.uni-stuttgart.de;
	arc=none smtp.remote-ip=129.69.192.20
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69288606D809;
	Fri,  6 Nov 2026 13:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69288606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tik.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tik.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id AF9B160CB8;
	Fri, 06 Nov 2026 14:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=content-transfer-encoding:content-type:content-type
	:in-reply-to:from:from:content-language:references:subject
	:subject:user-agent:mime-version:date:date:message-id; s=dkim;
	 i=@tik.uni-stuttgart.de; t=1793973357; x=1795712158; bh=fryBXcJ
	85ORbAilafE/Z+igh3xfySNNCLiA+Evg5XQI=; b=RT0hscXwCfK5/m1QtiPgP9A
	2T9uPAlEJiJTIRt9hmHxm4/TMeWQHU7befYbi50lk7B/9jwEopXj7+Sk21BxeiHf
	Ht6hbFYEAuMvsmckbf+PPbn/u7WqRrjicSkQXbFTJyG4RuJ6TeRyx179jeKqRb84
	c6r3Fv3zP6oc4+VHb7Y+7HLp6ScyA7+3Y+cfVD+fJMdoOTK3EBsIscs1s/QZk81g
	LWg6kKOTtpT5ztJAC1XJruapRkNy4PlvdC5DUWGddCxJRHkR9ORvInu3xg+eR8nJ
	0feqyieqlkFQ3pR5tmFD7lVZdJbXf/G74shXfjw9PwXLFsiG3r8+IzPS7T+PqJA=
	=
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id AHiyP6AnOPf2; Fri,  6 Nov 2026 14:55:57 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Message-ID: <b9d9745e-a9d5-4114-bb74-51735cb61e92@tik.uni-stuttgart.de>
Date: Fri, 6 Nov 2026 14:55:57 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] kernel.sysrq sysctl race condition(s) / list corruptions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <ece93045-3df5-4645-8d3e-bc8392c45ed6@tik.uni-stuttgart.de>
 <2026110537-earmark-surgery-163d@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Stefan_B=C3=BChler?= <stefan.buehler@tik.uni-stuttgart.de>
Autocrypt: addr=stefan.buehler@tik.uni-stuttgart.de; keydata=
 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
 rwHRmQ==
In-Reply-To: <2026110537-earmark-surgery-163d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 11/5/26 4:47 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 05, 2026 at 03:29:54PM +0100, Stefan Bühler wrote:
>> Hi,
>>
>> we have `kernel.sysrq = 0` in /etc/sysctl.d/, and run `sysctl --system`
>> multiple times, possibly concurrently.  This week I found the system in a
>> weird state, and one `sysctl --system` process that couldn't be killed, with
>> a "list_del corruption" in the kernel log pointing to
>> `input_unregister_handle`.
>>
>> This was on a debian stable 6.12.115+deb13.1-amd64, I think the most
>> interesting part of the logs is:
>>
>> ---
>> list_del corruption. prev->next should be ffff8d6e4324d040, but was
>> ffffffff915cf038. (prev=ffffffff915cf038)
>> ------------[ cut here ]------------
>> kernel BUG at lib/list_debug.c:62!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 0 UID: 0 PID: 1454 Comm: sysctl Not tainted 6.12.115+deb13.1-amd64 #1
>> Debian 6.12.115-2
>> ...
>> Call Trace:
>>   <TASK>
>>   input_unregister_handle+0x1b/0x90
>>   sysrq_disconnect+0x33/0x40
>>   input_unregister_handler+0x3d/0xc0
>>   sysrq_toggle_support+0x48/0x70
>> ---
>>
>> I can easily reproduce it by running two copies of this script (even on a
>> single CPU):
>>
>> ---
>> #!/usr/bin/env python3
>>
>> with open("/proc/sys/kernel/sysrq", "w") as sysctl:
>>      while True:
>>          sysctl.write("0\n")
>>          sysctl.seek(0)
>>          sysctl.write("1\n")
>>          sysctl.seek(0)
>> ---
>>
>> I think I can see how `sysrq_toggle_support` has a race condition; I don't
>> understand how that (in my original scenario that only tried setting it to
>> 0) could end in problems, even if it ran sysrq_unregister_handler() multiple
>> times without sysrq_register_handler() between (the code looks like it
>> should leave a clean input_handler, and not do anything bad when passed a
>> clean input_handler).
>>
>> I see how it could run sysrq_register_handler() multiple times without
>> sysrq_unregister_handler() between when using my python script, and how that
>> is going to be a problem - and when I tried it with vanilla
>> 7.4.0~rc1-g05441d697f7f (on a different system), I actually get a "list_add
>> double add":
>>
>> ---
>> list_add double add: new=ffffffffa9bea108, prev=ffffffffa9bea108,
>> next=ffffffffa9c09b20.
>> ------------[ cut here ]------------
>> kernel BUG at lib/list_debug.c:35!
>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> CPU: 0 UID: 0 PID: 1392 Comm: python3 Not tainted 7.4.0-rc1+ #3
>> PREEMPT(lazy)
>> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference
>> Platform, BIOS 6.00 11/12/2020
>> RIP: 0010:__list_add_valid_or_report.cold+0x15/0x33
>> Code: 36 fe ff e9 de 84 7d 00 4c 89 e6 bf 0f 00 00 00 e8 2e ff ff ff 48 89
>> f2 48 89 d9 48 89 fe 48 c7 c7 d0 d4 7b a9 e8 69 36 fe ff <0f> 0b 48 c7 c7 f8
>> d3 7b a9 e8 5b 36 fe ff 0f 0b 48 c7 c7 d0 d3 7b
>> RSP: 0018:ffffd485c2f97a20 EFLAGS: 00010246
>> RAX: 0000000000000058 RBX: ffffffffa9c09b20 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa9a5b680
>> RBP: ffffffffa9bea0a0 R08: 3fffffffffff7fff R09: 0000000000000577
>> R10: ffffd485c2f97840 R11: 0000000000000002 R12: ffffffffaa78ad50
>> R13: ffffffffa9bea108 R14: ffffffffa92f4e00 R15: 0000000000000002
>> FS:  00007f78eb9b9780(0000) GS:ffff8ce9cf828000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000007132b0 CR3: 00000001041a2006 CR4: 0000000000770ef0
>> PKRU: 55555554
>> Call Trace:
>>   <TASK>
>>   input_register_handler+0x89/0x130
>>   sysrq_toggle_support+0x5f/0x70
>>   sysrq_sysctl_handler+0xb0/0xc0
>>   ? __pfx_sysrq_sysctl_handler+0x10/0x10
>> ...
>> ---
>>
>> It seems `input_register_handler` is usually called from module __init, with
>> freshly allocated data, or with a mutex being held - afaict only sysrq is
>> potentially calling it with an already registered handler.
>>
>> `sysrq_toggle_support` probably should use a mutex too.
>>
>>
>> Summary:
>>
>> * my python script (run two instances) triggers a kernel BUG on both
>>    debian stable 6.12.115+deb13.1 and vanilla 7.4.0~rc1-g05441d697f7f
>>    within seconds
>> * 6.12.155 shows a "list_del corruption" in `input_unregister_handle`,
>>    which I can't explain (especially not in the original environment)
>> * 7.4.0~rc1-g05441d697f7f shows "list_add double add" in
>>    `input_register_handler`, which is kinda expected
>> * sometimes a python script segfaults, sometimes it ends up unkillable
>> * I don't think this is accessible from unprivileged userns / containers
> 
> Can you try this patch out:
> 	https://lore.kernel.org/r/20261030123640.263164-1-zhanxusheng1024@gmail.com
> as it seems to describe the issue you are seeing here.
> 
> Or am I mistaken?
I don't see any relation between the linked patch and this bug apart 
from both being about sysrq.

The issue here is that callers of input_register_handler and 
input_unregister_handler must keep track of the state of the handler 
they pass (whether it is registered or not), and, in case this is 
invoked dynamically and possibly concurrently, need a mutex or similar 
synchronization to do so.

The linked patch ensures that "reset_seq" gets copied properly instead 
of being appended to existing data.

cheers,
Stefan
