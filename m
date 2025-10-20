Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249CEA926;
	Mon, 20 Oct 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987530; cv=none; b=fMNTz/31a+xfIpjWZbZQdVEQMnvMkVx21ZCR/TVfMIcV+wwbmxH7WsT/bS6QH28Wy5+ORSyX/m9bBcJSaL825Ss08MfSywnWJt9p58OS5W/c6xaqqXu1ygxk5Rzg7O2GB3i4oAhl9BmFAeQtUA5xVwbjXqXGQ22c5eCZSzM57mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987530; c=relaxed/simple;
	bh=nGxwJURU/oilInwTQUZZ6gbdSgb0KGfYK9QccT8jcwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3wlGzevZJcR3tHuw/cPDNkUwdhIv9H9X1/gZAo5Z4jpUWsRAnV3ZUn+m3hLLG/8uR3IRiqp7/XtMjzVFTj3uj1f7J2SHXW16z5FigvrozsV53Ic4A0hVMjO9uy6HbPFQFRcsoAxGSGeb+LMtn1YpFI3Dw6Zj2NbOCDA3aYczcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AhOHkMnn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhOHkMnn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=q+A06mrhqjgyB7WoXYxFIbVy9xqSyLZ7F6r9ARP4k/M=; b=AhOHkMnnfNzl8Lw+FQh1X92eIy
	EzjfYAk2NjifHZJlB/LMYlWVKgfA926vtS7TbiOk0fw09mZGiwJRw2I3+UQ28Li/eP5OKHw6TXT01
	ujcTWyKeMJBxU9uCx0q+M/hHxuTh7PR/qFi3/E9w5E/W/uOKXL9fGJ3RByO0amiVvJDOMIN5uaUBH
	jc+fQ/RZHdhekYGHE8EG5SRnyWqwvV3UvaBJ0Fsbw1BfPDM/s8lFdjm0UdcGXoge3R9FmAH+q1nPK
	uaWn3nj86pSdRtQMW31RN0Dlyh6aE0HDLHNspaz4fWUofJeasdFL+ZO23zQNDkEObH0vXCCxJQdKL
	2O58DwxQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAvId-0000000EjgW-1UUc;
	Mon, 20 Oct 2025 19:12:07 +0000
Message-ID: <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
Date: Mon, 20 Oct 2025 12:12:06 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger
 usage
To: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251016103609.33897-2-bagasdotme@gmail.com>
 <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
 <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/20/25 4:50 AM, Tomáš Mudruňka wrote:
>> I am still OK with removing the 2 "However" lines. We don't typically
>> document or provide warnings for how the code might be changed in the
>> future. If someone modifies this code and the documentation needs to be
>> updated, it should be updated at that time.
>>
>> --
>> ~Randy
> 
> Problem here is, that you cannot really modify the code without warning
> users in advance. This is the warning.

All code in the kernel is subject to change in the future (anything
that breaks userspace less so than other code).
I don't see thousands of warnings about such future changes.

-- 
~Randy

