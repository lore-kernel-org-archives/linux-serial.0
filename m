Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE621DFD8B;
	Tue, 21 Oct 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066304; cv=none; b=M+Mvpyt6N7R3tYRSQNMPFlEogZ57J+44KcqArGCrRE/ro58mW/Rbkk4c8l7tju5/TA4CVnJ24eRHwjl8pP+0sVmKDMlVt7yL/U8pQG6RgWnqUeOVb1hXKNotd2wJ9QVJl2Iti7UScwwaBI7ZGi6dGxgkodxG/ajLaCp15A0byp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066304; c=relaxed/simple;
	bh=+kwjXs839N2xZLvTKn1xWQBqDurYxN4cpyyYVCuhJQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ9wBmbrs+HdNudk+Ys9h68jn8YIWdYW9SmAotMM0HoEDUp/DX8AS4GHgjYBh9zxc2zzVMA+mQSGChCqKkvGqdBSdjtwVN4S8YPN60FPmvq1jbtMofGjScjDeArlgkthTV3OJjXQDVEzqV8CWasA1rt7ebHoZKoTzklkQTP75BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yLc8NOn6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yLc8NOn6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mY4olOqNwciXe7P6w4zygG2fd6hYPFXexwywwvO9rNg=; b=yLc8NOn6zLdKsEf7KabiGkt9X/
	7vuHgpZD5UlV3y7zbIFj0smh5mqG9oNn6JDdf64xbA4LRVPkVHG+ywm0dc+yan9RFHcc4sORYhdiN
	BoqaP6hlHeKbKpTyQpMAw3AEcb4pFid0F5rFr2aOBNWxOh72xUCdqEWbm5pCGpU+O2l+z6t87CK0h
	1apmLiU/y2neZ/vi1SiPJDo+AdBA4FzY7RFjCq4PHb+G9b0KHHKcTZCCveiJS6WDjxBkBPr9zAGNb
	ECjpc2sie/SdFHLezJ9g7ylS8sTM74HdsB2c5194DDF0SRnJ0UeLGQwg74gjLVyaiBT8vQyq2Gj+b
	jKWjJY5Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBFn9-00000000Bc3-2NeN;
	Tue, 21 Oct 2025 17:04:59 +0000
Message-ID: <1b0acbf2-8ce4-4c8d-a088-1f271233e60a@infradead.org>
Date: Tue, 21 Oct 2025 10:04:59 -0700
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
 <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
 <CAH2-hc+M-CyXL1HtHkD9o_Q_8PP_OkYLvjqhdBiCnHVBQspedQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAH2-hc+M-CyXL1HtHkD9o_Q_8PP_OkYLvjqhdBiCnHVBQspedQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/21/25 1:37 AM, Tomáš Mudruňka wrote:
> In that case, can we use some short form? Something like
> "extra characters are ignored for now, which might change in future".
> 
> Thing is that i wanted to add handling of extra characters, but
> maintainer said it cannot be done because people might currently rely
> on characters being ignored as written in documentation.

Sure, OK with me.
Thanks.

-- 
~Randy

