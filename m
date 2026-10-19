Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422386;
	b=Q7ubD+pw9jnDbygkls6nhQRXHPie2mrqhmZ/9qPa7fd5OCNIUyneQMJUHiJp1E55Q11g
	 KEexAAOQ7Cu7RTjDs9ycaQHK+Y2ZJTMV4MkOt58C02HHcgERyevkiW8voUeiDIiH3MNVE
	 izaWC9MCSFBcnmvKsGjILnmQ7MfmtTx/1d9ZwHUF4+ofo+w/IF7+4aRPEt7atQk5Dp+61
	 C/EmORpPgcr5JFUw53StUgg2nYeyPNPIfqwC9TRSwU4yEPh5DaT+vMwEgmAA0xu+OKPek
	 qX9vsMY7m5DD6cKD6U5iVwZTOq8XKqyCCma0BCkjXQBONF+guWDxE+xLxd161aOKP0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422386;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YO8KqmgxaCD3TmIbX4cYdGIuCEfbIhOaI+JczxaaXSo=;
	b=mT+rO7R7a+HvxcHbFOX6Hi4lWQJbjxHLvjIrtCXMJIZw2Dk1bFBHD6Ua037OzBlWnSfd
	 AEA4iwmMGdAV8hYONUpehoqu9QN2jSaZaSkkpKz9mg+XmoFHFUBPhSZxUDfu+Q3l+1/op
	 JVAOY0Ij1hjtjBnjpa/klo2+28y6GI/AJxC3O+5PO9ucZq0kHRDQ/AXgeJcHuRzl+Gb5N
	 sMxINg0+lR5SN0A5kXh69DCiu1ub5HDixYwuWTr9TWyub1hNm0A56kgAnLw7pMs/qJRhI
	 U0YX9Jd817eSryWSLkL2M6wxNACN3QZziBCcEJplOV9AR1XT/eo8NG1iTW8zVoIEFww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVPiojde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30960820DD;
	Mon, 19 Oct 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVPiojde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648721F000C4;
	Mon, 19 Oct 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422385;
	bh=YO8KqmgxaCD3TmIbX4cYdGIuCEfbIhOaI+JczxaaXSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oVPiojdeHtcoC7V623YdPgcc12tJyiBtIi3r/06tYcoItdwfVrZ/7HEYZPNq5HMbc
	 Y01CnzRrIMMXaTUgGQGlfBTGFZL+m9ntyWDf3wKSo9lM/ykCKtE9vXVo6u0L0B0EJf
	 XhuzySPzglxiLDCIxSkmzgyHgL7CcoV4c/ODvNRykdtE05oXVV6R3MYxU3WGAEH89R
	 XFXMS0Q1kyfPShub4mPlEVmMAu0W+NNngrvwAX35VvNpnXzJWItKxW6eXPvgGWvhfU
	 F4GHqQPjbEdVfCEjxrSUv2plbCkEeUpbuxKO6CrKF5o6loVt8ELf1UQKmbmqJju8/k
	 UQai2DEDoxm0g==
Message-ID: <d019393d-9c24-4bc5-af4d-10bbb5d9fe90@kernel.org>
Date: Mon, 19 Oct 2026 17:06:21 +0200
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
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
To: Arnd Bergmann <arnd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20261019090017.430425-1-arnd@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261019090017.430425-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 10. 26, 10:56, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
> 
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000.
> 
> The driver defines an I/O port base address of -8 (negative eight),
> which should always get refused by request_region on all architectures
> for being outside of the valid resource range.
> 
> Further, it seems that a patch to setserial would be required in order
> to set PORT_RSA when not using autoconfiguration.
> 
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition.
> 
> Link: http://translate.google.com/translate?hl=en&sl=ja&u=http://www.iodata.jp/products/network/rsadv2s.htm
> Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs
