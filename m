Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31662882AC;
	Thu, 15 May 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298006; cv=none; b=AvOv8SMYnsxlARHv5VDoZcdEqIjmz59FxzWXSRSAwG4X/JDBwfjXkAAUTYoSiCu7sW6/9mTYmQfXdPUMSjK/DDt2rrHXCLIwQ5YYCqXWdGbS36qp1IjCEtV4MoZ/xCcNBADHTvSXSRl3/4F522qpfc2SEVZL6UHGLPJI+yTtgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298006; c=relaxed/simple;
	bh=MYaOkdMz5hv3neikPI2nXVOxPya68wJ9/1C8V/e7NmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkgo5I4UZuLMrZ1DoJV4Nk9+Wyx0VKP2CXMcF9moTBT42aXQnETJ8uaCGoyLjL9ryeb/r4w3O9x7cpSm+zhRyavEtjYOXdMyJnGeCbs1DIZBwn7goEM7tLFIqcpTlOz94VAXgy+Wbjl0DT2pGlCFrG8ryFLtPuApW1U5cn64jzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNrkfwIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNrkfwIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C3EC4CEE7;
	Thu, 15 May 2025 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747298006;
	bh=MYaOkdMz5hv3neikPI2nXVOxPya68wJ9/1C8V/e7NmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XNrkfwIWNmsVE4SxZa66HbhRXvupwMEpAU0Nj80mM4QIUjwBh/k/GPARlIeSBOe3z
	 O4YDHnLHTtATKGdOl3QzG/I0NEldFowwI9CgkGGe8PaGFilUXXZ12hGcj7uOiiI02o
	 vlL4cil1f4zLQOinOmdwD4skB4874qaHNkDAY2QGqW1wykP3h6EI5upg8diYMSHXC2
	 o8SF5kRznXmVLFHMrXxubYMUU35CJTTeMuz0Ys6x6H/Q/IzCO1QS1wEWpd3ZjLwP0l
	 Neq5eKvicPG7UTRobb/bKs+4krFtqahSPWs+WzbA7QEXd7McjtONI0RBd9PwdJ3/P7
	 dz5xilOa2nmVg==
Message-ID: <184449a6-f2db-4307-8351-66b617a3839b@kernel.org>
Date: Thu, 15 May 2025 10:33:23 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: npitre@baylibre.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <62s32907-1954-862o-5p1r-967n6873sp2n@syhkavp.arg>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <62s32907-1954-862o-5p1r-967n6873sp2n@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 05. 25, 22:21, Nicolas Pitre wrote:
>  From 28043dec8352fd857c6878c2ee568620a124b855 Mon Sep 17 00:00:00 2001
> From: Nicolas Pitre <nico@fluxnic.net>
> Date: Wed, 14 May 2025 15:58:22 -0400
> Subject: [PATCH] vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> They are listed amon those cmd values that "treat 'arg' as an integer"
> which is wrong. They should instead fall into the default case. Probably
> nobody ever exercized that code since 2009 but still.

AFAICS in the debian code search, exactly noone (except sanitizers, 
strace, fuzzers, valgrind, ...) uses VT_RESIZEX.

VT_RESIZE is used by kbd's resizecons -- and there it's the sole purpose 
to call this ioctl. I wonder how comes noone using 32bit of resizecons 
on 64bit noticed?

Thinking...

Actually, on x86, it doesn't matter if it takes arg (case VT_RESIZE) or 
compat_ptr() (default label) path as both are given the same user pointer...

It matters on s390x, but noone cares about the 32--64bit mix in there, 
apparently.

> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Fixes: e92166517e3c ("tty: handle VT specific compat ioctls in vt driver")

FWIW, the e-mail's Subject is empty.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 83a3d49535e5..61342e06970a 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -1119,8 +1119,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
>   	case VT_WAITACTIVE:
>   	case VT_RELDISP:
>   	case VT_DISALLOCATE:
> -	case VT_RESIZE:
> -	case VT_RESIZEX:
>   		return vt_ioctl(tty, cmd, arg);
>   
>   	/*


-- 
js
suse labs
