Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776634;
	b=WMId2LcJcEKWUEStOn9cazNXdraMHrONDnSp3hZgW7wCjcE2ruJHyKfrYnA+PfPHlmTy
	 1YDE0n1PxNcl2HzaMft7XOdgWKZ6DC2GuZ+871APSPP/uBfADvAEuY8itk0RblAHGuk9U
	 U7Y5D23mIMRoeBM3UFKqd/MVc9H6rKno0c+XRV4dGkn88kFDZMHroo1Jsy3dAq80nVaZM
	 Aw5yLgMKe07eoXek4qWpTpWUGOCwDJkjI19er01qbhwkGxCxo3YX/HqB6s7kTBFeOGAGf
	 56pxBuUm2YhAVm2tqPL17Egvf1Ah6eWWRCpLjvZ6NTivMxvYB+HJeYiM3BImQiF5V+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776634;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sNOMEgdafoCQx4Sc3kRlnTsuE6Kpa9XReXoNdL0B8ng=;
	b=fgj3zm0iFsZ9Emcct+BbksHzAFhusqQAH9ukobTHtgkssWQ4G8DrSVw2c/TL/3J6pcNU
	 SKgADn31SUrBeQMRJ885k0sWSqk4J4hW9wNvHU9UiifSnFsLtVhMmx6HgKU+uQ38gxBbh
	 rCBFdXPTgr0tCFdqm0iFJzMggXGpTHkTo4R3mtm29OhYp++2bnB5sQu2MYcKU2uyqQIAA
	 +O7CLcsh8XHzxAtA4Yf6q1/YcEZCuChujAj4AcGvOeIz0TUyoAL4p/zq0pXOw02ock+8w
	 J62Uq4/paw/suEx/wtsI2zPtOsRtuT7TLx7YQBPcwbI4e/XHPCgxoYiKMCAALf103Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cPig/fbo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B1606D813;
	Wed,  4 Nov 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPig/fbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C770C1F000C1;
	Wed,  4 Nov 2026 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776633;
	bh=sNOMEgdafoCQx4Sc3kRlnTsuE6Kpa9XReXoNdL0B8ng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cPig/fboy9vv1iVXg6kF8u9zOwpx/TWe7TiYDdhmuk6ieCoKR+oVRogwVYHDFph2f
	 EUsJBqZO2UCK1SVQ/sRXvGHAEW97Q5jpZgtKrnmsBmvjcL6AIKocV2qZYR3e/Wc0RO
	 2uMdAv1wAYevUezy7Sgi3pp+Se8+Xab/7oNkut2d3OLGg2aB3U7mmAZ2GcNKxbW3z3
	 xiJyWiayNk40QBwKYXnHuQ7LXAkxFSWE3Mhfu77eeSU5+RmFc6UzqrStYQCIoMpmIJ
	 urs2HZO0FZaVFRQVJaBgppPgtzxzz8ToiZ3CtvT1VZe8rT5EdtnAxkLgHmK231SReY
	 6hVnAx7t8JFvA==
Message-ID: <c8648fe5-7eda-4e20-80cf-7ec2e510e677@kernel.org>
Date: Wed, 4 Nov 2026 08:17:09 +0100
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
Subject: Re: [PATCH] vt: modify a constant prefix that looks like a ReST
 target
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20261103203929.2916563-1-rdunlap@infradead.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261103203929.2916563-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03. 11. 26, 21:39, Randy Dunlap wrote:
> Use CUR_* (could also be something like CUR_x) instead of just "CUR_"
> because the ending '_' indicates a documentation target name, so
> unconfuse the name.
> 
> Prevents these warnings:
> 
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: Unknown target name: "cur". [docutils]
> 
> Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
>   drivers/tty/vt/vt.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20261102.orig/drivers/tty/vt/vt.c
> +++ linux-next-20261102/drivers/tty/vt/vt.c
> @@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(vc_font_size);
>    * vc_cursor_valid_size - Computes a valid cursor size from the given value
>    * @cursor_size: The size constant of cursor pattern
>    *
> - * The argument given in @cursor_size is one of the CUR_ constants, as stored
> + * The argument given in @cursor_size is one of the CUR_* constants, as stored

Should it be also prefixed by %?

thanks,
-- 
js
suse labs
