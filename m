Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25578632B;
	Fri, 17 Oct 2025 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675144; cv=none; b=h3j7CpgApe8SseSQ4joSc6RPQuuTqpM8tdPXGwFBUTjehG2m38jNgD7iR3m6zte/cAn0IW84kH+svdSgtygTxscySyalZKH7DSX06Nf2axujEeV64I5Yn+oY6QAuDGlg1r1voJzgx1DPifQ5nh7lLm3sVBk9Y/uaFetE8vjKxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675144; c=relaxed/simple;
	bh=1xhS+0G/fq5C2jfg8PLUBZhBH4fQrVEQImqMPY7sgZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qiwwqez3qWY2j3jcnnOY5Y+XkFMxWPoIErr8/xb869pAIDX8cGBAjhs5EoK+dM7OHza3Sfk0I19n78eXq4HTBNTTTYiEPDip5IWSAGl21N8fbufFz7vj0Tr2vK19dw0Bmn8IyVcKlM+kCv5z60e4hw+8FudGbyNBX186FGp5CtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=txmF71fc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="txmF71fc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=21WaAzhmVvUKKBaFCzrkvcQRqL9tINZoUoeJdr3eA0c=; b=txmF71fcWTj/jMFenJPwU0s70u
	H4H3GTw539in/Td3VnQngYuL0g4VQEjlqRoIZuwHqpoysHzdr7ZYcxqNtATA/vG+1Dgks112BrG5m
	ce7s84TVxs+Li6P8sXTIhfERmAQ2gUosJFFKny436MHqHpGnYRALzd8cfV3xP5lEgReDIpoTCK+ox
	aHVvyv/C1Zbn6woAbA5MlgeyOF05NLkYFifSGxAEcSW+cFoZ9QgRVDt3gWpojVcJMpW/iZaXROe6U
	ojcIobdxB7VVlT6KWS5GlOSTXzsfHW+5HtRHb0IqKPmDOr0RutePIZ8hqBKD8E3CF20X3JffCrJB7
	h+QQIkhw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c29-00000006X0i-3ZsM;
	Fri, 17 Oct 2025 04:25:41 +0000
Message-ID: <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
Date: Thu, 16 Oct 2025 21:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger
 usage
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>,
 Tomas Mudrunka <tomas.mudrunka@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251016103609.33897-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251016103609.33897-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/25 3:36 AM, Bagas Sanjaya wrote:
> /proc/sysrq-trigger usage documentation (in "On all" section) states
> that it is not recommended to write extra characters to it to avoid
> undefined behavior, which is contradictive to previous sentence that
> such characters are ignored. Also, in order to actually process them
> (as a string), prepending it with underscore is required.
> 
> Rewrite the description.
> 
> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
> 
>   - Rewrite the whole "On all" section (Jon, Randy)
> 
> [1]: https://lore.kernel.org/linux-doc/20251008112409.33622-1-bagasdotme@gmail.com/
> 
>  Documentation/admin-guide/sysrq.rst | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 9c7aa817adc72d..6157d93e03a1e2 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -75,16 +75,13 @@ On other
>  	submit a patch to be included in this section.
>  
>  On all
> -	Write a single character to /proc/sysrq-trigger.
> -	Only the first character is processed, the rest of the string is
> -	ignored. However, it is not recommended to write any extra characters
> -	as the behavior is undefined and might change in the future versions.
> -	E.g.::

I didn't quite follow Tomas's objection to the patch.
However, if we need to keep most of the paragraph above, I think
that it should at least say something like:

	In this mode, only the first character is processed; the rest of the string
	is silently ignored. To write multiple characters, see the
	alternative mode below.


At any rate, this patch LGTM.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Or there is yet another alternative wording below.

> +	Write a single character to /proc/sysrq-trigger. E.g.::
>  
>  		echo t > /proc/sysrq-trigger
>  
> -	Alternatively, write multiple characters prepended by underscore.
> -	This way, all characters will be processed. E.g.::
> +	If a string (multiple characters) is written instead, only the
> +	first character is processed unless the string is prepended by
> +	an underscore, like::
>  
>  		echo _reisub > /proc/sysrq-trigger
>  
> 
> base-commit: a1af37b935c73049c54cb1412cf0e850212af420e


Alternative rewrite:

On all
	To write a single character to /proc/sysrq-trigger::

		echo command_key > /proc/sysrq-trigger

	E.g::
		echo t > /proc/sysrq-trigger

	Only the first character is processed; any following characters
	are silently ignored.
	However, it is not recommended to write any extra characters
	as the behavior is undefined and might change in the future versions.

	Alternatively, to write multiple characters to /proc/sysrq-trigger,
	prepend then with an underscore.
	This way, all characters will be processed. E.g.::

		echo _reisub > /proc/sysrq-trigger


I am still OK with removing the 2 "However" lines. We don't typically
document or provide warnings for how the code might be changed in the
future. If someone modifies this code and the documentation needs to be
updated, it should be updated at that time.

-- 
~Randy
