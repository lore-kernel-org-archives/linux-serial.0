Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283A2773F7;
	Tue, 14 Oct 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453733; cv=none; b=A6ztHeq8Uesnc/Ea7HPd8NvqMaNwXeyORxFljyAvAvua7XKmP83M/OZXP0V76ZGVqVJ9VrvjiFtkqkL9Y371qrRNsAjMPFW9Q1mNG0mmJoQK0kBEqM4ugk09VRTwfFfybAqluESv8xuSIreVBcm/6udXHfX3oR67CQaot445JeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453733; c=relaxed/simple;
	bh=oJjRXMYAtYfstJ1Qe7kiRTx+N9SnMeZBjZHi92bWT2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s3p5RR2RomgdnJJD72iRcsiqYxWaxvPy0Vbhg8KTn+1fGDKeHwGbyBpV+lqKYcgsvKOr4alkHmPDsrNi5IdYQMHLaqJZDOhs7wV68hdG87G2UtLsharb9iTdh57lrVvYfPom7n19MrzFU3INsocqbma7hSNJ3/DjU5bHhgrxdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=U0wFU7Gc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="U0wFU7Gc"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8807540B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760453730; bh=2NhCZaS0JRHpCMdnPaecLqGEPTG+OSiP6xNnzI2UmlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U0wFU7Gc5aXlrvnGS2+/0yPHl5lknOISny431eW8j9/31oHjg0V8CqS0veDMbj3Pq
	 zNXqBUbFkT4E2ZHSz905Ed12lmOfNnqTovYrnFJ9IT4ZAgC638UPzc3+NPT/uyd/e2
	 PaqT9D/NKZ+ivU/6gQqcfpSTI8am+lGw03CPbe2aGYUO5vShSnGBRlz38uG06FGaoX
	 PXeiObeHWk5lWK6xyT9xiSodkGzAKghCBhHKeicqVVzd04W8tGlWyyw8+i4YNA1X+A
	 EM2uuZFuEp72eJPB3hOmOZybWELdSZ2zeyFS72/qteF4Em6A2ViztDKvVdUQ1wBiRG
	 OsWb0/j+s9rYQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8807540B1E;
	Tue, 14 Oct 2025 14:55:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Tomas Mudrunka <tomas.mudrunka@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
In-Reply-To: <20251008112409.33622-1-bagasdotme@gmail.com>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
Date: Tue, 14 Oct 2025 08:55:29 -0600
Message-ID: <87wm4xbkim.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> /proc/sysrq-trigger documentation states that only first character is
> processed and the rest is ignored, yet it is not recommended to write
> any extra characters to it. The latter statement is contradictive as
> these characters are also ignored as implied by preceding sentence.
>
> Remove it.
>
> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
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

I'm not sure this is right - there is a warning here that additional
characters may acquire a meaning in the future, so one should not
develop the habit of writing them now.  After all these years, I think
the chances of fundamental sysrq changes are pretty small, but I still
don't see why we would take the warning out?

jon
