Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0B132103;
	Wed, 25 Sep 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247915; cv=none; b=E8Q2hyH7IGiP2gHwRPFoP5XONKr3DcWLpzxcG3Ltc2uP9YH3+B8MZwIHfFOBVZYqUAnNA2xJ+HQ/+V3DWdpXpEkaqpDn5kM5V8StuvymaqQe6mfSxszJtZ7MYe9i0tlGi7qUIS/BXeFO1cGbsams/SuBj1EJp2iJ/Bx/dCEHzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247915; c=relaxed/simple;
	bh=aPSRE4NYCT9TKWV6OoV1ZBRSXDwMdPJSA6UtuGxJfEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUstXFvKfsnoQq4O8k1asIXhk9odI/P48n/87HVwCc9Jls3NSGWsN24DGrVixLorJt06fGZs1PS1mNRSau+vk3Q1uxBU3sEXRaA5syrmpKr0mvcHQa1mN5FDjWeUFpsfvwhtHU+blEMcChpArXW71+eprbZNIFFCh7cDmvKYiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so7733018a12.3;
        Wed, 25 Sep 2024 00:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247911; x=1727852711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY+HitzXmGPeKw42ml4AV13uCy/oN2qRncK/eGGEhRs=;
        b=il8xqdopejMNUsPy9LEiz9E/ERUobfYRpwlSSCZAaPcwKT//6oKwumEKjRgKJWF9eb
         KkGR7IQx4awyXhb5vd8X4Ssq3fBS/pnmw12mnOrGYrN26JE4aEJTm9WLOQljn2Xlf4N+
         F4MPUctbK5QYhm64xcVPFbiB/ssWgn+XopMAp9sH//8T9gYa434qOP3eH0DRKOVqtAwT
         2mZl8mvw6MxDgIJpPpUOyGKqkxNwargx6jmRBPde8qDJpchLRk5XJbBtgPlmLLPDvlat
         LO7zmwgKcoLZ4YTq62QV65gRdqIYKpx6Nghjvph1bIS4WW9IKGTmmNHjFgWDugm3rbJj
         UaNw==
X-Forwarded-Encrypted: i=1; AJvYcCUmDkZJll4MyH26Rj0jvNfWaoNI/J9zUyHKammUDkPirclrXELNtNRAFWS4tDt9q38PJed+Z95DyXxfmE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+V8xI5IBpKXZXnv+qyOc3k5y+IzbdY3BEsCJKeVvkPxOeGurB
	5UjwcUWThng3sjA8aFhocNdAr0kHt3i8ysIFoKUSb92oKvjEDbqdcczqgoeraUc=
X-Google-Smtp-Source: AGHT+IE+7ohWss1V/0YPwisXn98gRCcXXFVJc23DGsBU9E1BD9R6s5yR7Q/ZqJq3rIyjClpkuNWi7g==
X-Received: by 2002:a05:6402:241a:b0:5c5:b9bb:c3d2 with SMTP id 4fb4d7f45d1cf-5c72073c9famr1058634a12.26.1727247910833;
        Wed, 25 Sep 2024 00:05:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d78cbsm1571702a12.90.2024.09.25.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 00:05:09 -0700 (PDT)
Message-ID: <681d8d8b-e527-4f01-b3d6-01eb573e72df@kernel.org>
Date: Wed, 25 Sep 2024 09:05:08 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
To: Longlong Xia <xialonglong@kylinos.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 "D. Starke" <daniel.starke@siemens.com>
References: <20240924093519.767036-1-xialonglong@kylinos.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240924093519.767036-1-xialonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc Daniel.

On 24. 09. 24, 11:35, Longlong Xia wrote:
> BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
> Read of size 8 at addr ffff88814941c700 by task poc/3395
> 
> CPU: 0 UID: 0 PID: 3395 Comm: poc Not tainted 6.11.0+ #46
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX
> Desktop Reference Platform, BIOS 6.00 11/12/2020
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6c/0x90
>   print_report+0xce/0x610
>   kasan_complete_mode_report_info+0x5d/0x1e0
>   gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
>   kasan_report+0xbd/0xf0
>   gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
>   __asan_report_load8_noabort+0x14/0x20
>   gsm_cleanup_mux+0x7e5/0x820 [n_gsm]
>   __pfx_gsm_cleanup_mux+0x10/0x10 [n_gsm]
>   __rseq_handle_notify_resume+0x188/0xc50
>   __kasan_check_write+0x14/0x20
>   gsmld_ioctl+0x3c3/0x15b0 [n_gsm]
>   __kasan_check_write+0x14/0x20
>   __pfx_gsmld_ioctl+0x10/0x10 [n_gsm]
>   do_syscall_64+0x88/0x160
>   __kasan_check_write+0x14/0x20
>   ldsem_down_read+0x94/0x4e0
>   __pfx_ldsem_down_read+0x10/0x10
>   __pfx___rseq_handle_notify_resume+0x10/0x10
>   switch_fpu_return+0xed/0x200
>   tty_ioctl+0x660/0x1260

Could you decode the above to line numbers using 
./scripts/decode_stacktrace.sh?

And then trim the unnecessary entries like:

>   __pfx___handle_mm_fault+0x10/0x10
>   __pfx_tty_ioctl+0x10/0x10
>   __count_memcg_events+0xf5/0x3d0
>   fdget+0x2de/0x4f0
>   __x64_sys_ioctl+0x132/0x1b0
>   x64_sys_call+0x1205/0x20d0
>   do_syscall_64+0x7c/0x160
>   clear_bhb_loop+0x15/0x70
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e

up to here.

BTW do you use ORC or is this with unreliable FRAME_POINTERs? I am 
asking because the stack traces contain a full load of ballast. Like 
do_syscall_64() after tty_ioctl().

> Allocated by task 808:

Also drop this:
>   kasan_save_stack+0x28/0x50
>   kasan_save_track+0x14/0x30
>   kasan_save_alloc_info+0x36/0x40
>   __kasan_kmalloc+0xb1/0xc0
>   __kmalloc_noprof+0x1f6/0x4b0

up to here ^^^.

>   gsm_data_alloc.constprop.0+0x2e/0x1a0 [n_gsm]
>   gsm_send+0x2f/0x5d0 [n_gsm]
>   gsm_queue+0x522/0x730 [n_gsm]
>   gsm1_receive+0x58b/0xb70 [n_gsm]
>   gsmld_receive_buf+0x173/0x2a0 [n_gsm]
>   tty_ldisc_receive_buf+0x115/0x1e0
>   tty_port_default_receive_buf+0x66/0xa0
>   flush_to_ldisc+0x1b0/0x7c0
>   process_scheduled_works+0x2bc/0x10c0
>   worker_thread+0x3d4/0x970
>   kthread+0x2b6/0x390
>   ret_from_fork+0x39/0x80
>   ret_from_fork_asm+0x1a/0x30
> 
> Freed by task 3377:

And here:

>   kasan_save_stack+0x28/0x50
>   kasan_save_track+0x14/0x30
>   kasan_save_free_info+0x3a/0x50
>   __kasan_slab_free+0x54/0x70

^^^

>   kfree+0x126/0x420
>   gsm_cleanup_mux+0x3ae/0x820 [n_gsm]
>   gsmld_ioctl+0x3c3/0x15b0 [n_gsm]
>   tty_ioctl+0x660/0x1260

this:

>   __x64_sys_ioctl+0x132/0x1b0
>   x64_sys_call+0x1205/0x20d0
>   do_syscall_64+0x7c/0x160
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e

^^^

> [Analysis]
> gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
> can be freed by multi threads through ioctl,which leads
> to the occurrence of uaf. Protect it by gsm tx lock.

LGTM. But Daniel might have a different opinion...

> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>   drivers/tty/n_gsm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5d37a0984916..1ed68a6aba4e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3125,6 +3125,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
>   	int i;
>   	struct gsm_dlci *dlci;
>   	struct gsm_msg *txq, *ntxq;
> +	unsigned long flags;
>   
>   	gsm->dead = true;
>   	mutex_lock(&gsm->mutex);
> @@ -3157,12 +3158,15 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
>   	mutex_unlock(&gsm->mutex);
>   	/* Now wipe the queues */
>   	tty_ldisc_flush(gsm->tty);
> +
> +	spin_lock_irqsave(&gsm->tx_lock, flags);

Perhaps use guard(spinlock_irqsave) instead?

>   	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
>   		kfree(txq);
>   	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
>   	list_for_each_entry_safe(txq, ntxq, &gsm->tx_data_list, list)
>   		kfree(txq);
>   	INIT_LIST_HEAD(&gsm->tx_data_list);
> +	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>   }
>   
>   /**

-- 
js
suse labs

