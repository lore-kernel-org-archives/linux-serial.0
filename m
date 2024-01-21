Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5EF364B4
	for <linux-serial@vger.kernel.org>; Sun, 21 Jan 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705836895; cv=none; b=YurMn0ltlYwE5T5ErnQ3Yb0JSsbCu8L2T+Y0ujC8gvhbbhWVoWGuRZDGxvfM1C8v8Quai651MoPMfw3ypb839fyYos3BxEDM00a1h1AWmWdyzMeZjd+eEWPnd2R7xdnAg9fBj3g15wa/NL4tk0zb0iSih/dtenKYVtmVat0BH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705836895; c=relaxed/simple;
	bh=7001/WDSP/ipCvony5yy+geqxc2ISegotECbpugt6cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOWU59dUwxB0J+aS0wwl6rR4WSJm7tIx6AKJjPLzWk6LL+hjVwrwpxb94FtuvMRmuC6Aj0EXsLbM025zvLE/yJINyhq80DJGDU8EpZoFXbU2tCoqiEYO4kYMTNW15hXEzSf5XCnllkBLFV4QiAZhIG3H68gRCl66RCqZLMyYNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40LBYiUk067932;
	Sun, 21 Jan 2024 20:34:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sun, 21 Jan 2024 20:34:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40LBYiw6067928
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 21 Jan 2024 20:34:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <65e403d5-552c-4c29-93ab-cb9913003be5@I-love.SAKURA.ne.jp>
Date: Sun, 21 Jan 2024 20:34:44 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: check for atomic context in con_write()
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <20240121034817.2280-1-hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240121034817.2280-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/21 12:48, Hillf Danton wrote:
> On Sat, 20 Jan 2024 19:34:02 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> syzbot is reporting sleep in atomic context, for gsmld_write() is calling
>> con_write() with spinlock held and IRQs disabled.
> 
> ...
> 
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -2856,7 +2856,7 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
>>  	struct vt_notifier_param param;
>>  	bool rescan;
>>  
>> -	if (in_interrupt())
>> +	if (in_interrupt() || irqs_disabled())
>>  		return count;
>>  
>>  	console_lock();
> 
> Given console_lock(), no sense could be made by calling do_con_write()
> with spin lock held at the first place, regardless irq.

The question was how to detect it. Since in_atomic() is not a reliable method for
detecting that a spin lock is held, this patch instead chose irqs_disabled(), for
gsmld_write() is using spin_lock_irqsave(&gsm->tx_lock, flags).

