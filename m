Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2523BD02;
	Mon,  3 Nov 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212803; cv=none; b=g4DQWfoxxEFWaQPLQlnuCfME6s07ZRhtdaVMkVI6Swlagpirjv35KEb19XzD/GbJe9LIyhXPvytjzhe/FPqLiI6puLrHx4EJL02J26zUu5ZD/XCBhz2ipOuDXwyoJyZK5VvWUS+6TenNbkFogKfFFUFDpRqyfuAvaCSrO3cbhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212803; c=relaxed/simple;
	bh=Pl6H9vJe7acg1O6MR3J9UUbyidoSPhERCxM1FXyC3PI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnWb7gVLxr7vZIiRk6ukaeazUitrUwLiD6uvA8zkfVgi86PRnXDOF9LWSqLmRa7HgSZnDsECGvGpa0cSFyxH7vN+Nk0MhNdluTaq7eJZmR5BKzJzVPIa07uuBA8vZMNm/uj10VSdVMGOQHnaQfODxu1xd927PCqmfW3nR/+7WLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A4WT2590; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A4WT2590"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8AED740AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762212801; bh=7hPQDATXasc6TszX/hLxGIMFy6caQRz+O9eoOhPx3gQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A4WT2590Lleb50KL0+rBO6gEF+qB7LQt6icP7bKDRUeFvjydw4dbSTh7IhXGdGmKK
	 6yQpp9qiUpeniNy5O89XYhE5ZVyRT46czJpKyRsaokPYfY01iknOSI8gkljfm7z4eG
	 9UurPhH9LkjrGOITX8GKqOikuQUlBEklN5uKiYMYpoSecqQxSJuCnZ1jqNJA6r2Si5
	 xy3UN3iuDWGEaCe9QaloP92godZR6czpJhZdgJoX4sAzPegUtOMh91KEGIjOPFu+Tm
	 Dv0v/jlNJBjjsXml61Ak/athlvDT59w1AltRz0Xc6aVMb9MTd1AbEf3qghPX+XXSsv
	 Ff1DE0VboRV6g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8AED740AED;
	Mon,  3 Nov 2025 23:33:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Tomas Mudrunka <tomas.mudrunka@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v3] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
In-Reply-To: <20251023014102.16777-1-bagasdotme@gmail.com>
References: <20251023014102.16777-1-bagasdotme@gmail.com>
Date: Mon, 03 Nov 2025 16:33:20 -0700
Message-ID: <87jz06bsjj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> /proc/sysrq-trigger usage documentation (in "On all" section) states
> that it is not recommended to write extra characters to it. The sentence
> may imply a contradiction to previous sentence which writes that such
> characters are ignored.
>
> Rewrite the description.
>
> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v2 [1]:
>
>   - Keep /proc/sysrq-trigger future API change note (Tomas)
>
> Anselm: Do you object to the rewrite?

It still seems confusing...

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

You're still saying that following characters are ignored, then give an
example where they are not:

>  		echo _reisub > /proc/sysrq-trigger

So, for me, this still isn't really right.

This, I think, is a holdover from before, but I have to point out that:

>  		echo t > /proc/sysrq-trigger

Does *not* write a single character: it writes "t\n".

jon
