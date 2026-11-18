Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960938;
	b=gkKYxpCMjtKc7I9gkBS9FS+F5cFnARpAE62fFdyi37sKZLvj/gmN69bb5pyaEXQWGMwH
	 GCkc747S1n73c4WnBOMjKD2wx2ELy6JiuoJHR4NzKk7VGEKkjSDPzMyVjXa0QRvjz7UoS
	 fcvJ30iCx8YHY2ukAkZpoQc/l2111sbIzAPoe86ATZ43qLiSkeLz5zY8feQFvCBbda+1L
	 4HEgrjSsuA7CbQyJp7pN0oQjhfpL3r878ihqmnWHaP2+s8HhvTr0Wqz4tx3bV6l/WH30k
	 oUh/hrEVT2HEjKFIU3VAf8PFLdL/ulSZKBy2CjBDbIzpiwwZwF1zCYtPA1sUvq6ScdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960938;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=puz2MD6IzLtgWuVVO4WYgEs0B9YB2hwh+dWrVCbmaMQ=;
	b=cCisXqDjfxjQmZ8G/wyMT4JvPql9LOqKAK1oTX6G9R1sPytWcI4tJam3IWUizPHUU3BF
	 Hr5p/jPO0RPfDkDAXlRMaOsGHofTRw2R2ZBt7IDN8QS11/WfTPoflCcIwYG1ScoGlBoFB
	 3aS+E3uSgagqdpLyw2881ogvJm3xCGuagZpS9MOAa5no7u6dt1y+dGC32+3R+VZeT/uYD
	 CAvOtdDyf5Uf+TgVqVZaCqfijq48Gx6Gack7KxY/i6+sn/IB/IIsY4wytXQ8RMovzCqaO
	 7iRH2sBoCByDmhLrLoM55TMmCbafkzhyBefkK6nFkhtz5pfYXnCNqFcthV2Jjt5F9ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OzTvHFu9;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E575606A31C;
	Wed, 18 Nov 2026 00:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E575606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OzTvHFu9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=puz2MD6IzLtgWuVVO4WYgEs0B9YB2hwh+dWrVCbmaMQ=; b=OzTvHFu9uZdJN3jCGivzn/LJpU
	X4AzDK8a9A28j6YRhoRHhLnSIDhSIzbCp+Z6VAXpoYU56BUJdsv+DlDJ4vWxDvvGSXe+FUmybC7Vb
	JOGNgEbq/hrPVXjyQbSUJPx4BIzn2/0a2XBoBjF/83i4qavxyRvJecJEP5y/cWGKVEzWCCvh2OfS1
	3wymQV28AHBU4rjKsk/I68d+Ogb9Z+ac854zqJaOByS+u9Vy7uTNNSFl1C1+BCk40REYe7F9nhYSN
	dJw4zAujpSPh3HQQrEBfILhJBO1RfLtEcvySVpWuxqJRsaQbg104G0m+zm7vhiTrYypEK+9eI4H1m
	LovuUYjQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTKq-00000007LBS-0KzP;
	Wed, 18 Nov 2026 00:15:36 +0000
Message-ID: <eaecfa26-bb29-45ad-9bed-9c766f3c7b62@infradead.org>
Date: Tue, 17 Nov 2026 16:15:34 -0800
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
Subject: Re: [PATCH v2] vt: modify a constant prefix that looks like a ReST
 target
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20261104182258.3226665-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261104182258.3226665-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping?

On 11/4/26 10:22 AM, Randy Dunlap wrote:
> Use CUR_* (could also be something like CUR_x) instead of just "CUR_"
> because the ending '_' indicates a documentation target name, so
> unconfuse the name.
> Precede it with '%' to indicate that it is a constant.
> 
> Prevents these warnings:
> 
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: Unknown target name: "cur". [docutils]
> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: Unknown target name: "cur". [docutils]
> 
> Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: Precede "CUR_*" with a '%' to indicate constant. (Jiri)
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
>  drivers/tty/vt/vt.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20261102.orig/drivers/tty/vt/vt.c
> +++ linux-next-20261102/drivers/tty/vt/vt.c
> @@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(vc_font_size);
>   * vc_cursor_valid_size - Computes a valid cursor size from the given value
>   * @cursor_size: The size constant of cursor pattern
>   *
> - * The argument given in @cursor_size is one of the CUR_ constants, as stored
> + * The argument given in @cursor_size is one of the %CUR_* constants, as stored
>   * in struct @vc_data.vc_cursor_type. For unknown values, the helper draws the
>   * default cursor or an underline dash.
>   *
> @@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_valid_size);
>   *
>   * The parameter @cell_height is the height of the character cell as
>   * displayed by the console. The argument given in @cursor_size is one
> - * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
> + * of the %CUR_* constants. See vc_cursor_valid_size() for how to get a
>   * valid cursor-size constant.
>   *
>   * Returns:
> @@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_start);
>   *
>   * The parameter @cell_height is the height of the character cell as
>   * displayed by the console. The argument given in @cursor_size is one
> - * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
> + * of the %CUR_* constants. See vc_cursor_valid_size() for how to get a
>   * valid cursor-size constant.
>   *
>   * Returns:
> 

-- 
~Randy

