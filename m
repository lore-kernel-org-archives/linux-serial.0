Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAE290F;
	Thu, 16 Oct 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640712; cv=none; b=gAZFV9wRdGhSbaalKDxY3dyJnXessjnRcXbAw0++LO2IlBDGqB3SlfV01DbAruPKSV1T1olVVI4wAuVj/mgSTJTwsvL10U1UOdVVtU7bd7h9K3L5yD6j0QR8z+C43TvlCgseVoqmgTZgPvNs2HmPmE1sX1lgPo0pxvdWjx4exdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640712; c=relaxed/simple;
	bh=1rASaJG6EY5HKd8Wp0j/bvff1gZOgkW+0jAm7wCZJZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPJjNM+X9ODoBbMOjykMfGaaYXlSS11n2hA1RWpUO9qFqfhBVln8dU2/zg5+o7o0v6sKHukoPOIB2O8DcUwBaUFwt6LLoVCnK5h/Au9OVBDZSKhgeKPno5FtQR0W2PEh+ufY8OhbnmKR7tNjLFSMu0b0kA9kJjRsDRf36D2BzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J7RanfJx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J7RanfJx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z6u2Qohb/FdORfWoAU/xcVQhrvWbKQssHR/jj3k2Qx0=; b=J7RanfJxne1LwZgG7lCJ8um7fG
	XNI6OzlG2YJ3m40XsfXG6a9q6ko4TO6fDVBn+cL6FeYYff8B4wW4SrU9f0gap0sfjM5WnNdU1lYsb
	uceSziZ2RSxtAebv3ozEVlcpePrLTAsK2CDVnC77eneykRJKhoAmd2y4QUD29rw659uwfabwkUQtb
	SkekCuJxRYUOoNborE8mkmuQJu1r2dqXLVkfGL0Dfxemr5yQL7DaBkJEtBq9Jygh3sz7NbQUH/0sv
	4yJ7YfQcKBiJzPHmYwCOBmr3co5vlm1zrD4EhEpDyZGIrRE0kIBOGHxMVLIagu4aAx1BmfUzrJejO
	MHLCnyWw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9T4n-00000005jRQ-3Cgk;
	Thu, 16 Oct 2025 18:51:49 +0000
Message-ID: <add429f4-0c22-4228-8cf7-4dfe21630823@infradead.org>
Date: Thu, 16 Oct 2025 11:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
To: Tomas Mudrunka <tomas.mudrunka@gmail.com>, corbet@lwn.net
Cc: bagasdotme@gmail.com, cengiz@kernel.wtf, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 mail@anselmschueler.com
References: <87wm4xbkim.fsf@trenco.lwn.net>
 <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/25 3:17 AM, Tomas Mudrunka wrote:
> Hi. I am author of that sentence and this is NACK from me.
> 
>> I'm not sure this is right - there is a warning here that additional
>> characters may acquire a meaning in the future, so one should not
>> develop the habit of writing them now.
> 
> As you've said... I don't see anything confusing about that.
> The warning was added for a reason, because there was discussion
> about some people writing extra characters in there, which might
> cause issues down the line if we refactor the code in future.

You have already provided a way to write (enter) multiple characters
to /proc/sysrq-trigger. Are you suggesting that someone may come
along and add yet another way to write multiple characters and that
this paragraph is present in case that happens?


>> After all these years, I think
>> the chances of fundamental sysrq changes are pretty small,
> 
> Actualy it is not that long since the underscore mode was added...
> 
>> but I still don't see why we would take the warning out?
> 
> Exactly. Thank you.
> 

-- 
~Randy

