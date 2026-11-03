Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743619;
	b=oxWbje9Oveh+5GoFmHX0KB6XKE0h+MohfXXn4xAky/xbNOWrBknlFsh4trXuWDh6X1ZB
	 21vaxvBZO6snQm0/pbsuKag4lfxw8hE63An49CNsEseoSZAHlmwPkMH0/W71KeitL6cOJ
	 UZ17fHbmTe5A0hejumOoy32uilcWpsWu8scw3Z6x+2T3szF0Boyb5/5yXvIKGDzuh9THW
	 EZW8BSAFXXYNg+JT8zcOJzv3R12rDmdssjj7LNX63ub5NC5EdC4cn7q+0wxO1pmlLlOIq
	 nhty/Sn183hx3oAbVZwYQeVTNeTfG6shLRn6L01Tc0VCf2xNyTR0pC0a7qbAegJWGkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lOZWFaFosPV/+qtC8DUJqMFl+nVK4cTga9YvJmW6lvI=;
	b=k7bsFW0vgzE99Co6KYVn8Ka2wCEqyil4agDRB9ENE+JtzqAhtQUAVWYjsgZDE2nbhB2J
	 1CmeGqxDbRkLASUOvMFoDZf9uJsQjgbTdHF/vPxt/LKtHjZ8PmWcG5Tuiqaz4o7fWczTV
	 z1jiN0nN62kEhKKaeAA0IUWioVaI4u+n2+zFJs5G2YEaLCPN+Ayb8HB2QSYenhwXolrdv
	 fK5cBr/ydLZS6/4kTZRpwV86tFfJZSWRZOqUnM0mCTFfskw4y3/INUqBBZFMJfJmUuo0O
	 Tcoun7iRte7OwZIPiGcVFrgp3+2Fej/gGwihbQuXLMppivcLzxf3sgWcPOo05ftzL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S5FKJ/Zk";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D8B606A328
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D8B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S5FKJ/Zk
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91befe703c4so1197296d6.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743618; x=1794348418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOZWFaFosPV/+qtC8DUJqMFl+nVK4cTga9YvJmW6lvI=;
        b=S5FKJ/Zk2aUUUWdSlFZ7AcYRILTpQVfVtwVaymeP145rcwm3SnciwbKmli09tsb3lS
         Z7puXVmTGbAjOUvURvgXuaEmBW/54e1w723WHTbZ5nPWEWghvf11d4tzE9LLARCH/miA
         zFF9psjuSVYMSicCC/leHNtGFn4eoXjGuDNb/7Bbp9WcXB2HtseQHuRT1iGV2jfKvWCC
         K13qUL8SXIgfqAmOua+BLma5zRyXkVly7K+S4qh+dOTK1zyqy/FBr6viYQoZ3ZD5dbHF
         0buBlrvk3/dFvLqTNr4IlxsSl3Mzp7+n4UO3ED61HPHcGfy6QCiTdhdPQ1W5vpdXvKjD
         8LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743618; x=1794348418;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOZWFaFosPV/+qtC8DUJqMFl+nVK4cTga9YvJmW6lvI=;
        b=tydN2eNnl4wbEfwDgPnW1Q9AGT7TW8dSUR0rStXh8PP1UFDXb3+qR2j6MXDhbGdVTs
         XCtEe611u24rq3tuIyRqXRScSjH/kOhnySCCCz4RKQQ9pWd0Nz8zB5Awui22a9l0QPxG
         fBqdUBoOj/RVnfqVE5XmPOpXNOQxQj30zP1aOSno/kDJG65OQNDy+rLY6ewzuhyvqjLb
         8NmrgZ5WnmJM6vrKIc4Qp9a6frJpJXYFgyMXagFsP2sTjUYLPBC1O/khrgOneVv4080L
         lO/5E08/nyMqE4Ef0eQviiy/TeQtyWyjzovihXsCUAzmzWivuYnGf5Al37+fXFqEBuKx
         aSFw==
X-Forwarded-Encrypted: i=1; AKwUvBxG9+NIRoRMLZ67kHiudXmDNkB+mMPChR4gW855+R3pjMt2lx3bHvO6AaXyrNkDzFND0bN4N8ObVm82lhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ExBKNNlZClFadGVkpINioRZseHnF/4gGqjcndnQ35NMsmp4fo
	nTASvLJ+FEY+jsDts0aSZxIxjOXwtF6MFuZ84nuvR1cZqfqQ8iCQwH3DEaR85A==
X-Gm-Gg: AYBFou1KfbEZnDhOe3VGezLJyhr58jPmfAygjsjwHyTXbWbIFd1xJmUy7K5S90u5pLK
	KuVH1UtFVfc7ivdSpwcUmFyf7mOmS8TpmuzY7xLBmyV6ELarZ3sHJ7XGejcuo3wEBl2MER0kWiW
	Fuc1I0mditIQegDhgSddeWhpRkXOoktMrjFEqXM9SGA9UzRDJsTvH1mgDQKOxow2n7JJX+H8grw
	h1o5j2BriqhfXG3CEZvm3hfy0Ah6uHXnr6gIckAm51S+2doXgslBIY2dU2o9pRHwCQRBXVY/H8e
	i/Ymnufh5IkK5X1FXWzdFg9HbRcufJspeaRO5KKmY/kJRaUd9lq+7gXVWmT1VBPbemxwAO2rzTn
	WIv0Taka02ZBh+3LrRLvTcv1iWTs0chfGagTIj3G1bjRLopj30xFlElo/M3TXkfdpeFJxPg9ilV
	75qK530noupear0UXqGDW6G0SJ2mEOuQY8ie6R0nOFZkGFHap85l2HYbTiwRto1cF8eu3BrvO1G
	0fgGTirNC7O/ILZgBK5G4d+JgEqopY+ZvIYAdBby6dzlxY8F3j6fgTGPcPzhaXpqRH6W0J74lFM
	WE8yfgKNAZ2ndKvq3U4dgSCBE5CekMTGFZJOGDT2kpwC2JAJPfXeccA=
X-Received: by 2002:a05:622a:4d8a:b0:535:8509:3138 with SMTP id d75a77b69052e-542b3c732b3mr240064241cf.11.1793743618294;
        Tue, 03 Nov 2026 14:06:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfe98b2sm1903246d6.21.2026.11.03.14.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:06:57 -0800 (PST)
Message-ID: <0d5f8aa1-8d0e-4a28-b7dc-dacbfb1ca1c2@gmail.com>
Date: Tue, 3 Nov 2026 14:06:56 -0800
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
Subject: Re: [PATCH v3 2/3] serial: sb1250-duart: Fix bootconsole handover
 lockup
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
 <alpine.DEB.2.21.2608060359330.55540@angie.orcam.me.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=fainelli@broadcom.com; keydata=
 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
In-Reply-To: <alpine.DEB.2.21.2608060359330.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 03:54, Maciej W. Rozycki wrote:
> Calling sbd_init_port() in the course of setting up the serial device
> causes line parameters to be messed up and the transmitter disabled.
> We've been lucky in that no message is usually produced to the kernel
> log between this call and the later call to uart_set_options() in the
> course of console setup done by sbd_serial_console_init(), or the system
> would hang as the console output handler in CFE tried to access a port
> whose transmitter has been disabled and line parameters messed up.
> 
> It'll change with the next change to the driver, so fix sbd_init_port()
> such that line parameters are set for 115200n8 console operation as with
> the CFE firmware and the transmitter re-enabled after reset.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

