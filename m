Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207404;
	b=TnI3DPYWE1O5us7+2qZ5d4ZoVNFSRF7CBy2GROByghrwizj009Rnmtx3/5r1Ki0lFrVr
	 Vg2c5zw5dXfEnkSSeY+EdzZ/SUEzg3EdpEtvDd0Cyk7X3BlrI0n+FMsIWOpejsoj4X5EM
	 fP8wWsSEUs3iBUF5jrTaxMopebVtErl9dAr+uDCH8Ti5G4zNA6IXCaMrHr2yx1nup8F55
	 X/Ek8uQPZAjkinCmrRaFBkQAlrxiWWJq1ksoJ2IDjEEY3anubaBUT24TLFZbDIvO7reYl
	 o2YeJH9jb5xGUXg7rsuevsTOf69FRDacEmrBSxqPUAgaOepuQeZ+2KJ6rgrlt4HzF2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
	b=jvSUi58aGo29W+Nl3nqkSWLPwBBRKeLWdd4Lsvl4vwZJRJtj5TWBpAgtRpBJhBpHvZJQ
	 H4fGM5dhU78gx3gHcmpegWUUsgsQCUn13yJJK4pWjdwcXvM/q02wcVP9NlL32QcqBK2CH
	 i3n9Zk/U5OVEkJ7s15uMlNIRBIoNeVL/5pKZPYCPLCGqcFkrsS/1G6gNHko5chU54wB6N
	 o140Q3SWPpLq7eDZQq+Xln8GvDimFVODNXlS2q0ZvYPYvPJRJpTXFZSHxcXFC5+G1d9FW
	 JPukgSVHF2QdXunIwgkqvZZEdguQoL+pJxBaYGQfqS5ne3sXFwX/9l+kJoJf8QnCr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2+CUOiK;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33448606A31A
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 17:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33448606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2+CUOiK
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535a54bed9so1771919eec.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207403; x=1793812203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
        b=Y2+CUOiK+rdCHsUnimafxxE1iYgLSjGd7A0Bzh16RaF+HJWB7N+oQ1579sakDOI8A9
         RA0RA0HmXAK5PFAp721QH8n7yyLReE9WgWZwNEloKPS016ZZ9zqDgQHhVWp0Ow8WdCIJ
         bKandakugFBx4lNGYX96JfJaXdm/2MLToFJ1I3GCTY7MuPySCg9WXFbuYYsPRuxVMxdb
         nfnFMy5ErGAyAIGG4s6VQUk4pb3Z9VagqaGYuANDVPH/KJ95uAjn0kv6TMdCv5oVl1fm
         2LHV9/I5uAESzr7/HfnyiNJcfUfWWLWfJfKQWM94GoPzh+rtCOWeDAq6eSdFu9Tg7cqp
         eJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207403; x=1793812203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
        b=bKbfgzXsPps6t6fUa+xZtLTwCJjINq++U2/UMV3JSGeshCBEEEIyEn4zLvsei4yB9k
         miMRNKGWz0Cm5K8rf4t5ekuI29sCBIccbMAu5+TSSS2VOeeZ2VB1VrlxbHnN3DM1hwwU
         6Ca7IGWLdu9Y+kx5zHo+FcBkSpoaau9dobLM7+mYKhVRkf5V1aUcIrWPjGxFrXCQ2Btg
         duUAV1gugGXYRa1zypAEBoN8fjn5UJ9JrW+BSgw/9RAquPngmqRedrfBTTsrS/DiY3zZ
         zG+M9i0+IhXd2kktLRMPCWP7TVA208jnL8a7zgqU2OvPwM7SL57Se0fwE5R+/14ra4UO
         XiOw==
X-Forwarded-Encrypted: i=1; AKwUvBwHFijrJLvM52aFEOwehz7llryYcFK4Ln6PC9nTzWK+FmlPbPTe+2LIbjWk1fR0wfKqRShjgl1bOiblwSI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk/N6v0ET++oEEKuE/kMOSVaEgQY7OtF/NxkL/Is4CB0k5sKXh
	zbMTN3jrN0lBGiIIY/73BFGgvV8o2EVzMWLmJwbQsvAose/zWWg56m3d
X-Gm-Gg: AYBFou2fC7cWLuWn+9hXZAd3CnzX6xtliaClD/fuvMs4i71El6+id4powJshknDrmTS
	tvL/p2i/kSNWT4hY1YYS7voBgWcLHDRapCYDoGCyRSmWABSL7NCAf6i9eWuQCjw4f/IKn0m+PfH
	80ABqPy2qRzf4ov0CDrdHd2Ih88l0ClQtNEV1I26mLw8x2HA/W2EuWnsSatiVqPzUZeq5qm34RO
	wKAxFldHL8z5V6P7DFyItkbH+A9VsHugJS/SNpENq5MSMCGeEZykUQ7zhlq8knqns/h7HZtKmF9
	3Y0xbzbHEfsB41/RU6O39jh/3YhYyl3Xydbl53uK125AjhFpudz8ig5eKwOOO0WIzT6pcQ3d7e3
	rFPs1dLEGhjxBEPidIQYxqRycKc/WJYJMYq/l3gIdJiDh761QGZViWuIV/UD+l/TZgPIiYGH/f7
	QHnXK7wSb2pO2d1t14Zh3qqwWgAXfe0DR5cEPFRMkpRmsJLMlctbdYVe+6Z39hJcZIAknMJBh7K
	OWeWhdBbuc8rrBIMLhJ5lUBVtFeIYLGqfrAKoJ8txIStw2cCFKjNwEQZ25m97mLogrLbNUTkkNk
	gacfnARY+zV/bZ5EtGAI4MmUXNCXKyT75be82fZJtx8KoHryA6rT8ctA8SiaJUzPNQx+LKI=
X-Received: by 2002:a05:7300:e9c4:20b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a20427d57mr4718660eec.36.1793207402170;
        Wed, 28 Oct 2026 10:10:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm12474280eec.23.2026.10.28.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:10:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:09:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: serport - defer write wakeups to a worker
Message-ID: <auIsPu4hA0f1SpRX@google.com>
References: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>

Hi James,

On Wed, Oct 28, 2026 at 01:14:19AM -0600, James Hilliard wrote:
> @@ -54,6 +56,11 @@ static int serport_serio_open(struct serio *serio)
>  	guard(spinlock_irqsave)(&serport->lock);

I changed this to scoped_guard() and applied.

>  	set_bit(SERPORT_ACTIVE, &serport->flags);
>  
> +	if (serio->drv->write_wakeup) {
> +		enable_work(&serport->write_wakeup);
> +		set_bit(TTY_DO_WRITE_WAKEUP, &serport->tty->flags);
> +	}
> +
>  	return 0;
>  }

Thanks.

-- 
Dmitry
