Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D1CA45
	for <linux-serial@vger.kernel.org>; Fri,  8 May 2026 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199386; cv=none; b=G+jr4E2+lh5wI7Kmo1y6ahiWOVgAamxqI81/HknNKIgeOKvjN5jN4/RDbfkoCwcLRvED2LzzmeoFDPawQsSa8UYm5GvHwyGKSOJLd8Uv1sX0at9tO4XDecA+X36Zv1aHEvgbh0QfXkwAl92uW/gK1r9AMTCtTh14ongaF8Ad/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199386; c=relaxed/simple;
	bh=bkE3C6tg8yQD/MmpTE8clDdotljxpl0qucJTb1ZDOl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzQhT09npgVEnFXvagtnM0RF0h+tBVNQnmCjPNB6PgS/PSQ064CdEHLcT8yr/uxeyrRJfLWtEoh7CG9l/23C9zPpec8W2uf44hpSVKHB6GR5fWr9Ounhk5VGw73ALU/YurranbjOvJWHd61SQodBVRiuHGgRIaD00aVav6nIrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SWKnQL3Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SWKnQL3Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eE1ruytXr8RDtPHvxSdNXoDMKLYHcT5TVN3bLj+Oz2g=; b=SWKnQL3QxCldttsBlISTTxrTdb
	a68izfwmfoMMBe9hWnGH96utHpTHgQooKAqJk3kZIY+Dp3FPOfzRe7dTEZX+0hC9nL1T99cTmEzK+
	jfOBw+raxCkPZ7KeYihWXAhzI9xK+Alb8mi0CwDx/IqEo+CBCmso9kP1HANRW1ZiyrQvj0xMW4aRh
	uaSeCGSwrjiiPNW7h61axAMK+U3vPpXyGXGTelhikRcI+d9x+c0LE5dYMwm8MPa4FutWnpBG5mv6e
	rrh0tlPLQ0Ts3+NXsWVxelY+e93xSglBBNWvEOfl8mGgbiHxp1PdtQDZdoeukCCGOfbjfIA6jw66O
	oC4tXF3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL8tE-00000005Cp4-1itA;
	Fri, 08 May 2026 00:16:24 +0000
Message-ID: <c0e32aca-39e8-4d8d-90ef-9029b5f6b3a4@infradead.org>
Date: Thu, 7 May 2026 17:16:23 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs: driver-api/tty/index.rst: copy-editing; improve
 organization
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
 <31fe93b480b4ca157086af3bebb21326d0fbe983.1777943090.git.enelsonmoore@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <31fe93b480b4ca157086af3bebb21326d0fbe983.1777943090.git.enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/4/26 6:20 PM, Ethan Nelson-Moore wrote:
> The TTY driver API intro document contains a number of grammar and
> capitalization issues. Fix them.
> 
> Now that the MOXA Smartio driver documentation is in the serial/
> directory, the "Other Documentation" section only contains TTY line
> disciplines. Rename it to reflect that.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  Documentation/driver-api/tty/index.rst | 46 +++++++++++++-------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
> index 6a08aebbc47c..eb5d602450f8 100644
> --- a/Documentation/driver-api/tty/index.rst
> +++ b/Documentation/driver-api/tty/index.rst

This LGTM.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
