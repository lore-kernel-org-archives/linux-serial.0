Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795939185A;
	Wed,  3 Jun 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467149; cv=none; b=CgzZk+NwcK0WYiTy0nwlFEOAEOI7oahDsa/wsR+Cq3jVUhQqE9YkndVmGqCglOIBGO8ZNjN+HA/2/4WhzV0jR1lkfmjxnasuJ863siwAIkfcn2ZZ+p1RH8NILX6lUFlZYJxZdmV171jqiO8Pj4dsMPi8ioe6UaJyt1VfS5XSEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467149; c=relaxed/simple;
	bh=lWua7L1jv5UtNvdc6yeGGeYTxb77zzMx5sRkHDfVUgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lC2OE+p1KwDy9TSn+rMz4Bxc8BvC1eGVVVrXlQfvL4hwCcAEvlu8jQCZyLFRQxNXen9pqtvuW2h4DvzPItcRY9NaakKoAvP8u5d/yniEv92V9Qj8arssW3tVHHtznrDnus4dzTsGUt49AvSHZ8TBXwCxd4L3Pe+dX6YP+MPcTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnaPve3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnaPve3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6911F00893;
	Wed,  3 Jun 2026 06:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780467148;
	bh=xblQ9U4dvtYKZ4bHc3qWJV+1Pl6Dr159OoqxR5Vhjfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fnaPve3ubog03IU7GfDdY5x164tyQON11uSlB5+rMmYMAJKs8ynvEM0nYwL/dykl9
	 JV2oGm60IqG0mUDIyxCCqYnK5cGZKXkCsrzbxoKJWl4KwDidRTXa7vxCpU/WewZsNt
	 00PuTtHPFqPNiAgA4bYXVosGn7U/fNMgP8zLVovDpGXUqD7mlBKRhRZAmXLIFx16Jj
	 EeptElYp794Ni8OVMtFcBrLiMpTuhyu5Y8u6nFUxpqJsTQFKtwQS/C8VeKFF4EKALf
	 17vc1d4mn1ETDZgGiLau6HIPoBOpuFWwrVGCfIMG3Jr/F+mYYQ199Liq6SRvmqa028
	 nOsKbw8Lg3Z6g==
Message-ID: <fb50984b-b2c1-4a79-8644-db761f85a7f2@kernel.org>
Date: Wed, 3 Jun 2026 08:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: hold tty reference for keyboard callbacks
To: Morduan Zang <zhangdandan@uniontech.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com,
 Zhan Jun <zhanjun@uniontech.com>
References: <5186FF3C10B2F8A0+20260602061539.1500845-1-zhangdandan@uniontech.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <5186FF3C10B2F8A0+20260602061539.1500845-1-zhangdandan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02. 06. 26, 8:15, Morduan Zang wrote:
> From: Zhan Jun <zhanjun@uniontech.com>
> 
> syzbot reported a use-after-free in stop_tty() when the VT
> keyboard path handles the hold key.
> 
> The keyboard event path reads vc->port.tty under kbd_event_lock,
> but con_shutdown() clears the pointer under console_lock and the tty
> can be released after the final close. The keyboard lock therefore
> does not protect the tty lifetime.
> 
> Let the VT port own a tty reference by using tty_port_tty_set() when
> installing and shutting down the console tty. Use tty_port_tty_get()
> in the keyboard paths before dereferencing vc->port.tty and drop the
> reference after the last use.
> 
> Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1dde0d.bd48a97d.14881d.0005.GAE@google.com/
> Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
> ---
>   drivers/tty/vt/keyboard.c | 17 ++++++++++++-----
>   drivers/tty/vt/vt.c       |  4 ++--
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index dfdea0842149..19f8df9706ee 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -509,9 +509,13 @@ static void fn_show_ptregs(struct vc_data *vc)
>   
>   static void fn_hold(struct vc_data *vc)
>   {
> -	struct tty_struct *tty = vc->port.tty;
> +	struct tty_struct *tty;
> +
> +	if (rep)
> +		return;
>   
> -	if (rep || !tty)
> +	tty = tty_port_tty_get(&vc->port);

We have guards (tty_port_tty) and you should use those.

thanks,
-- 
js
suse labs
