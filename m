Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42982045AD;
	Thu, 23 Oct 2025 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194571; cv=none; b=hMho2SGRBvF7omLWcUpy9HJEySjjnPEoPSBDw8CZMpFcvnGfIvcC6xl+Ifk1/GSfyKCEJF4ldgSDEuyjg9FkHY2jnxd0Hww//5OJKl88ghT+M9LYUPI/lvP1QHcLxIuu5QXv9jQqCbEZzKg3DeRvUD866C0TTigUxYfKf8hgYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194571; c=relaxed/simple;
	bh=LLI/m94NAR7aY/9k1+edBTBUsgLrdEfFEUNQuHu19K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrEvfaIsl2amF4vs4BSpeFbkwxIURmvA3mCCGo1RfU4CNPh04So2EYNX9UpPj3dE94QKvuTqT8wbCUcLNLgQNrD8pEw1DynNNAoVaXkQAnl35wrzDOltlbKkTZF47i14lqjT7ruuRyU/AdBWnQHuW08mxylzJsxmFY1EW5QFnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zQ6NCU8m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zQ6NCU8m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RpWBfPqrZlyAStgOMdtOzTPtxq9A4wxOTkfIQ194GqQ=; b=zQ6NCU8mZI8gwynnsFZ8F5f+lL
	PlgJjhKvoasic/hlcHXi1CzvnD2mZcgnUnQ9MRvTkW2Cpp+MPl43r6YT2WNgqJDukw8PdkRlHbwiu
	M7Q/3EetlIS/Qv7iB0d6BERCIOlUXTA10WGtBB9a4nQhFzNXr77dIPHR9xNe07DI8hPn6pqyHTZgS
	J9CciB7otzzfFyIgf7skP5sf0OOo4DVdbxemRWAdXMqDoNlIuZHgqYoJ5UAtimF6ZBEYVgjxc7GdV
	cXa1nc7JuJx4bOhcFtfoxlhlWKku2cpAUxTqibCOgiueKm/cKJRujCH+kR0JA6m0TsGR+mno0+LBs
	ZpA0eNpA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBn9y-000000053ix-2VK8;
	Thu, 23 Oct 2025 04:42:46 +0000
Message-ID: <e86ccc1d-c1b7-409d-a003-2c4e21b1cd62@infradead.org>
Date: Wed, 22 Oct 2025 21:42:46 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: sysrq: Rewrite /proc/sysrq-trigger
 usage
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>,
 Tomas Mudrunka <tomas.mudrunka@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251023014102.16777-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251023014102.16777-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 6:41 PM, Bagas Sanjaya wrote:
> /proc/sysrq-trigger usage documentation (in "On all" section) states
> that it is not recommended to write extra characters to it. The sentence
> may imply a contradiction to previous sentence which writes that such
> characters are ignored.
> 
> Rewrite the description.
> 
> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v2 [1]:
> 
>   - Keep /proc/sysrq-trigger future API change note (Tomas)
> 
> Anselm: Do you object to the rewrite?
> 
> [1]: https://lore.kernel.org/linux-doc/20251016103609.33897-2-bagasdotme@gmail.com/
> 
>  Documentation/admin-guide/sysrq.rst | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 9c7aa817adc72d..a88266b171aa17 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -75,16 +75,15 @@ On other
>  	submit a patch to be included in this section.
>  
>  On all
> -	Write a single character to /proc/sysrq-trigger.
> -	Only the first character is processed, the rest of the string is
> -	ignored. However, it is not recommended to write any extra characters
> -	as the behavior is undefined and might change in the future versions.
> -	E.g.::
> +	Write a single character to /proc/sysrq-trigger. E.g.::
>  
>  		echo t > /proc/sysrq-trigger
>  
> -	Alternatively, write multiple characters prepended by underscore.
> -	This way, all characters will be processed. E.g.::
> +	Only the first character is processed; any following characters are
> +	ignored for now, which might change in the future.
> +
> +	Alternatively, to write multiple characters, prepend them with an
> +	underscore so that these all will be processed. E.g.::
>  
>  		echo _reisub > /proc/sysrq-trigger
>  
> 
> base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8

-- 
~Randy
