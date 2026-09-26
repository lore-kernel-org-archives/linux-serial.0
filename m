Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D91E492D;
	Sat, 26 Sep 2026 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382778; cv=none; b=eJaSe/gU9MAmbjMRMYan8C9oDJKvmGxLJEcA7OVTGJq3efB33r5Ghj9Pq8+TZvkkgDcbCVHc2lRbyhqxDnpsu3k51J2qgEHeQDFFZ+/q7te9ypHf1AZoXgopdw/Au4LYn1jH9mUClCw+pXbXftRrSFMoJkFKLinwN2MO3SLfD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382778; c=relaxed/simple;
	bh=IYAU/79dGofQylupwjb6P+yrKCCES3qfOsqibcugnRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJ5HZYkSyKPVFtp+a2UvOL6eqa+ckFYiL8lWPEjWvq0YtnkpKBYsDfRB12+FTzQ0v639rKXBgLPpPQ118dn9Ou+hFc+xSbUfhAeBvtAF10quU1B1Nb+LLi9uj/8HpZEyQpGFuhJcjps3/a+vpQkloOAYMdyZzUTDmiaxWO5cm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4llhjOTl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4llhjOTl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zLJNeTA1Uv6NYenS6Oz+iqjgR/6nW3LkPlRDEazPsrI=; b=4llhjOTlhoBwPQfjoWbxZIC/sN
	lO23o2Kt4n5k+dLv2jhIHM2UlwJbHarLKLlvvGIukMlnUgyX9S4iKu37Fqd1mrSrYrY7uJuMAUKP5
	igifX5qmiaqcQz6WKyrJeRmHHTsjE+5K0Y13N5943OAvUdGUIIXIPwycTOLeDvAY90AuJecShxnfI
	YQULfELsyxIpdPV4q8OlICa8k1FjQcLDqCH5TDnGYC2BkiuUlwWkhpWZRFHWwPxxG6cXsaRp8WOeq
	iLOkVptf8SP+YE/E5+/4O1xXsuwzisZbtVG+Aoka+AcQcJNI4wfWApNc5pk7GK1GKtK4IV9Io4cvK
	O7UhlTAQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGLT-0000000EjvH-3r0e;
	Sat, 26 Sep 2026 00:32:51 +0000
Message-ID: <01ca174d-f92e-4182-bd4f-f052e444eef9@infradead.org>
Date: Fri, 25 Sep 2026 17:32:51 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: add break_wait kernel-doc
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260925094222.18303-1-johan@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260925094222.18303-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/26 2:42 AM, Johan Hovold wrote:
> Add the missing kernel-doc description for the new break_wait field in
> struct tty_struct.
> 
> Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/20d75a7a-2e7a-484f-a267-c21db82dd922@infradead.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

FWIW. Too late, I suppose:

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/tty.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index ad4e4a835f90..833bb7b97ceb 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -168,6 +168,7 @@ struct tty_operations;
>   * @write_wait: concurrent writers are waiting in this queue until they are
>   *		allowed to write
>   * @read_wait: readers wait for data in this queue
> + * @break_wait: wait queue for timed breaks
>   * @hangup_work: normally a work to perform a hangup (do_tty_hangup()); while
>   *		 freeing the tty, (re)used to release_one_tty()
>   * @disc_data: pointer to @ldisc's private data (e.g. to &struct n_tty_data)

-- 
~Randy
