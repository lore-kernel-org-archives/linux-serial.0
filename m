Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0579227EA8;
	Wed,  1 Oct 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315345; cv=none; b=oP4CvwZAfqqITeEcYBIoFz8WwJfOuaClLHHM06p6U+8ufo4DhhY5PJvuoLctrISGx+83eBkE1fqp0Cd7Q/lAOs6csMoLWayyGO2l2QWTs9i7TvtUdX5KzXlb0WrIMQhjUa09OpjwKk5HDVPPv+lR54VqnpiAXcqJZRvfjn/yolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315345; c=relaxed/simple;
	bh=7re3SQwr21Xya8agiq0Qq15H2cYKgvLJzyx67vPjV4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfrqK+QtRIGN4Fdzy9kyC2qnzPNeFFmi7jJwBksks8+XbGxpZFBxUr1iWrblaMBrasg48gwuuMgbPwdwNTpn0Z6QGjMRG+r88+IbmnMLufHw6L0loCe/9rRA6Xu6aSQq6HqQNfhVnaG33hmIDTzEVt8oD42N2O/OYN2Smv5VAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a7044589eb311f08b9f7d2eb6caa7cf-20251001
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f31d9bdb-3d07-4c18-a4f2-d303be6dd695,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d09b2bcb3ea6f0765427d9290dfee55b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4a7044589eb311f08b9f7d2eb6caa7cf-20251001
X-User: pengyu@kylinos.cn
Received: from [10.42.20.31] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1071559284; Wed, 01 Oct 2025 18:42:13 +0800
Message-ID: <ef5a5364-94c1-452c-9c97-81f66246088a@kylinos.cn>
Date: Wed, 1 Oct 2025 18:42:10 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty/vt: Fix possible deadlock in input_inject_event
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, legion@kernel.org,
 mingo@kernel.org, myrrhperiwinkle@qtmlabs.xyz, tglx@linutronix.de,
 changlianzhi@uniontech.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
 jiangshanlai@gmail.com, tj@kernel.org
References: <20250928130819.383808-1-pengyu@kylinos.cn>
 <dltckle3ksus7qojkpiirvush5khk52o36yhqnlfpiymrjjwzt@ev46jjxjhi3p>
Content-Language: en-US
From: pengyu <pengyu@kylinos.cn>
In-Reply-To: <dltckle3ksus7qojkpiirvush5khk52o36yhqnlfpiymrjjwzt@ev46jjxjhi3p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/9/29 12:54, Dmitry Torokhov 写道:
> Hi,
> 
> On Sun, Sep 28, 2025 at 09:08:19PM +0800, pengyu wrote:
>> syzkaller testing revealed a potential deadlock involving keyboard
>> handling:
>>
>> CPU0                       CPU1                      CPU2
>> ----                       ----                      ----
>> read_lock(tasklist_lock);  evdev_write
>>                            input_inject_event     write_lock(tasklist_lock);
>>                           lock(&dev->event_lock);
>>                          read_lock(tasklist_lock);
>> <Interrupt>
>> kbd_bh() / kd_sound_helper()
>> input_inject_event
>> lock(&dev->event_lock); // Deadlock risk
>>
>> The deadlock occurs because:
>> 1. Both kbd_bh and kd_sound_helper run in interrupt context
>> 2. tasklist_lock is interrupt-unsafe
>> 3. When evdev_write holds both dev->event_lock and tasklist_lock,
>>     interrupt context attempts to acquire dev->event_lock create deadlock
>>     risks
>>
>> Convert both kbd_bh and kd_sound_helper to use workqueues. This moves
>> input_inject_event execution to process context, where it's safe to
>> acquire locks that may be held by code using interrupt-unsafe locks.
> 
> So if we ignore the input code and instead look at the send_sigio()
> (which input core ends up calling) and do_wait() we see that
> send_sigio() disables interrupts and takes the owner's spinlock
> before taking the tasklist_lock, while do_wait() takes the tasklist_lock
> first, without disabling interrupts. This is root of the issue as far as
> I can tell and no amount of changes to the keyboard handler (which is
> just happens to be in the middle) will not solve for all potential cases
> and code paths.
> 
> I believe either do_exit() or send_sigio() have to be changed to fix
> this properly.
> 
> Thanks.
> 

Hi,

I noticed that besides do_wait, there are many places in the kernel 
where read_lock(tasklist_lock) is used without disabling interrupts. 
Addressing this solely through tasklist_lock may not fully resolve the 
issue.

This involves tasklist_lock, evdev_write, and various input device 
drivers. The only approach I can think of is to move functions like 
input_[inject]_event in the input drivers out of the interrupt context. 
This could affect many code paths, so I plan to start by modifying the 
keyboard code first.

-- 
Thanks,
Yu Peng

