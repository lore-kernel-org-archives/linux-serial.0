Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7CC4332E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D8C20739
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 13:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCTNmQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:42:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41822 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNmQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 09:42:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so7505869wrc.8;
        Fri, 20 Mar 2020 06:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l39RGTWmCTQ0nArlZpVEItjnuVVmdA+cHGh/nCmDAnU=;
        b=pITh0mooz1UFeEF1FT6TXJL+BxCCBCb6+dPBTv4mNpnmP37dG5WWmuNMnroxQeCplv
         NdoIUyZGGPQByRCpjRcyFY7ldUcjglThaEfNZs6olvDTHtBOWa1jElGL5Jh105YFItlC
         who3FMNXVZ9VJrPj0QzVsiL0/a1hYzs6LkB+QQdTsq12BLzJJKfQtVSf1kLNLvXmtHMD
         qAt8f2k+8Wx6Qi3jQYZWhV6uRO3ikSCpZyapmRs3DH9FYsxerXriq4D4MUk9fVmpADx2
         0KRVqMfzT8MYUxQJOtzt25Fqo7+/ecNgOqE1JDpZD4dNSFfr0LtCGTql1+0Gd9rJlTng
         d5gQ==
X-Gm-Message-State: ANhLgQ0fKrHkpbzNsFns4cr3WQw7QXR3xLmuXOwKV7ZAouBTpDS0Y6V3
        PEYp4KJo1eCC9MzyC0N6SlE=
X-Google-Smtp-Source: ADFU+vvC73lIz0uDz36WBP+Pu9RBYjrcK+roem3mnydhCkdhR9Lwk1exa0RBOqZ2zktLm9f1II4ksA==
X-Received: by 2002:a05:6000:d1:: with SMTP id q17mr11358216wrx.409.1584711734282;
        Fri, 20 Mar 2020 06:42:14 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c2sm7797629wma.39.2020.03.20.06.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 06:42:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] vt: vt_ioctl: fix use-after-free in vt_in_use()
To:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20200318222704.GC2334@sol.localdomain>
 <20200318223810.162440-1-ebiggers@kernel.org>
 <20200318223810.162440-3-ebiggers@kernel.org>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e2846610-ae0b-8e50-0fc4-c2cad6b23e9a@suse.com>
Date:   Fri, 20 Mar 2020 14:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318223810.162440-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 03. 20, 23:38, Eric Biggers wrote:
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -43,9 +43,11 @@ bool vt_dont_switch;
>  
>  static inline bool vt_in_use(unsigned int i)
>  {
> -	extern struct tty_driver *console_driver;
> +	const struct vc_data *vc = vc_cons[i].d;
>  
> -	return console_driver->ttys[i] && console_driver->ttys[i]->count;
> +	WARN_CONSOLE_UNLOCKED();
> +
> +	return vc && kref_read(&vc->port.kref) > 1;
>  }
>  
>  static inline bool vt_busy(int i)
> @@ -643,15 +645,16 @@ int vt_ioctl(struct tty_struct *tty,
>  		struct vt_stat __user *vtstat = up;
>  		unsigned short state, mask;
>  
> -		/* Review: FIXME: Console lock ? */
>  		if (put_user(fg_console + 1, &vtstat->v_active))
>  			ret = -EFAULT;
>  		else {
>  			state = 1;	/* /dev/tty0 is always open */
> +			console_lock();

Could you comment on this one and the lock below why you added it here?

To me, it seems, we should rather introduce a vt alloc/dealloc lock
protecting cases like this, not console lock. But not now, some time
later. So a comment would help when/once we/I get into it...

The interface (ie. the ioctls) also look weird and racy. Both of them.
Like the "OK, I give you this number, but it might not be correct by
now." kind of thing.

This let me think, who could use this? The answer is many 8-/. openpt,
systemd, sysvinit, didn't check others.

Perhaps we should provide openvt -- analogy of openpty and deprecate
VT_OPENQRY?

With VT_GETSTATE, the situation is more complicated:
sysvinit uses VT_GETSTATE only if TIOCGDEV is not available, so
VT_GETSTATE is actually unneeded there.

systemd uses it to find the current console (vtstat->v_active) and
systemd-logind uses it for spawning autovt on free consoles. That sort
of makes sense...

>  			for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
>  							++i, mask <<= 1)
>  				if (vt_in_use(i))
>  					state |= mask;
> +			console_unlock();
>  			ret = put_user(state, &vtstat->v_state);
>  		}
>  		break;
> @@ -661,10 +664,11 @@ int vt_ioctl(struct tty_struct *tty,
>  	 * Returns the first available (non-opened) console.
>  	 */
>  	case VT_OPENQRY:
> -		/* FIXME: locking ? - but then this is a stupid API */
> +		console_lock();
>  		for (i = 0; i < MAX_NR_CONSOLES; ++i)
>  			if (!vt_in_use(i))
>  				break;
> +		console_unlock();
>  		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
>  		goto setint;		 
>  
> 

thanks,
-- 
js
suse labs
