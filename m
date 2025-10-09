Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69608615A;
	Thu,  9 Oct 2025 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976332; cv=none; b=DyLBILrrzVtHiyScm9eH88Yv3YpDwArb1ijbiP7wFSrt9P+XzAsieUF9mcKihvqd6iUfgSLxg/KZdOsNnFiVgJA+0TR7HSznDkT2yESM2moS38QAqqDNixiIlwAXdfH1KrYP2jWEfyQFqHRl8nhm8o2M6iXghffUDmet6TCs5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976332; c=relaxed/simple;
	bh=oBUzBCGdHcKBGvVSdjsLDIxDVH+8Cz1l/MCI7DjjKrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sia155PXUeEL5QbacS1eeu8PIWTr7sKZpJB+BpxVQlNB9+z5DylS0AshVFCGF2xXHVNJM1gsXmoNd6qZfj891CTyvMu47L4bIDoqScP+/A4mraCfboP2aSs2/y/aljFv53oI3eTrIdqRJ7g+LPyrsrj477KWMZXk0s0BrXzd4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4GhgsyA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4GhgsyA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=03eJIUjJueS97yN5grY/zqy0eGrSPsBwtVlizMh56y8=; b=W4GhgsyAGTqgPC7wUoYO6o63lF
	vpLOJhCnsNX60F+dBytfdtBGWiPX4l3wdDCtZwW7pcwEy7znhhy07YWEZwSBSRed1ZMfAmluNz1dM
	l+NoxFQKDb0BvQ2GsMDGj7LFGiuz7cfkZMu6XUoYZCUwdk+2QlCUh3a/FdS447uNWpk5gZ56qPGAi
	mm6aT34/A2iGP7x5j8Fp4N+uVzHBf873z/R5hCpzzTJM3rTsfwT8mvdPK0xqZU5vqZ8h7kSnFVPIz
	CXAStTlyb4cim5USOHB6P3H9waMSBtGm0gkMrsx06F6CxmS6B5TiDYtCDeLWE7xrYN24aWcSOSyPC
	W/ZH25Fw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6gEz-000000052j4-34Xq;
	Thu, 09 Oct 2025 02:18:49 +0000
Message-ID: <6e29c0d3-f8a0-474c-8d75-74f222621049@infradead.org>
Date: Wed, 8 Oct 2025 19:18:49 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>,
 Tomas Mudrunka <tomas.mudrunka@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251008112409.33622-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/25 4:24 AM, Bagas Sanjaya wrote:
> /proc/sysrq-trigger documentation states that only first character is
> processed and the rest is ignored, yet it is not recommended to write
> any extra characters to it. The latter statement is contradictive as
> these characters are also ignored as implied by preceding sentence.
> 
> Remove it.
> 
> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/sysrq.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 9c7aa817adc72d..63ff415ce85d66 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -77,9 +77,7 @@ On other
>  On all
>  	Write a single character to /proc/sysrq-trigger.
>  	Only the first character is processed, the rest of the string is
> -	ignored. However, it is not recommended to write any extra characters
> -	as the behavior is undefined and might change in the future versions.
> -	E.g.::
> +	ignored. E.g.::
>  
>  		echo t > /proc/sysrq-trigger
>  
> 
> base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78

