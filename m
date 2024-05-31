Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E4762D0
	for <linux-serial@vger.kernel.org>; Fri, 31 May 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145351; cv=none; b=Ugdw96UVTxEBDQX1V5cVKMRFyvbM+2BrpZScbkdibE1OHmtf7x4wfrXVgN54OQ8TZv2Eb+lJbfrYSjQZJjvikF/SjqMxAzlytcmTWH7ynTWlwID3bq8qwjfNYJKtTT4sH5+I/KVKP3GDQNmw8YDZ7GjDgo0Pba25WCNp388Hi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145351; c=relaxed/simple;
	bh=62KanOcE+O72wCSIMUaUZhgk+diKcA24R90LuEcsMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep9LmSRmDfBCgsmrktXwFWSxCRCfjcz9h09pHmnTBmA4OZ5ckhvsY9+U7VaB6eqv/LqneDqbI8kJxsgc+uJlEyA7enuZeV1alDELTj6+nSmKDM6NmHenIH4vOn/Alxali9qYpFLfuTheCctgzf1kSaZzA0Ae5ABKyg4Cl2gWrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSYOp1hY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSYOp1hY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a635a74e0deso198334966b.0
        for <linux-serial@vger.kernel.org>; Fri, 31 May 2024 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717145347; x=1717750147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R61gLvoZpfbTvEYlGXcR/R+p1iPV6UeVskki/bZyKX8=;
        b=OSYOp1hYQ+TyrVz/MoyceClTljks3A6YmxqcJkbaiv535QaKtBrjiLbczxLJTXTvlJ
         wyGoPxJy1OcrRkofU/KbNU5FUVPplRkRLD3IjPUB1l20TMp5ku+Kr3FU5+cICYeYQCvw
         vkOzqNcia1ySBIXd1HMx4QIm1JzyvD5nhViveU8zif5ZqVQv7hzIlW+DWnld782CQf4b
         NLLBtY2FgZER4fVPfGl/PqTzbwfWeH2eguQA4HK8zipXRFYPbScBDPevBTnnOcvGEeXV
         f4TW6oYhjbsryb8sKxUmsyDMMfhc99at+191vx2iTPAd+mNvO3cL/acX8W392zUL0TX3
         C/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145347; x=1717750147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R61gLvoZpfbTvEYlGXcR/R+p1iPV6UeVskki/bZyKX8=;
        b=fP1Jyb0TtutTDMuoAbtAt7JZfstSpxBmGK7cOWY4gr+MuiBiQEYdFJKBXfVZZFWN5+
         5drVLLt9AW3ItsnX9ZKmZbb3WB1kmxIm0pNTCClWY91jlxApHHdwPVGHwXr5gGyXDsg2
         9dgwo+eGrZWXe7pY7cWVRi0GvdROYP74w3I1F2recvhWkN1gjwJzTsDOI4hBlchwQ9gR
         uVTvWYDIinmf9yY3D3SRidmWc1gQiY4Fapv1MxPjZbRXTYa/mpU6BOvdonsk3im9o3qC
         kNyJI+06nCbMxcB40FZyZ2TZC/PqUqsO4dUT6WK6kW8PXwTepcz9YPAKR3jZvNhquPUE
         UHig==
X-Forwarded-Encrypted: i=1; AJvYcCXNiEcpc2827e5DhZRKMZC7MMpemLBFRHyXBSGkUz7ppl9ZaLSsyzUd+YxZFCxBzEXMlYEljs8AaqU05m04v2I9JsrREwDI9wUdziC0
X-Gm-Message-State: AOJu0Yw0ZaC3ciFxXvRDRH2qk3zJ9852LdwbGcHtNasxw+pE/2/OdnSX
	RYe8l2MF4GLLHc3Ck6F2ByPw5wGHe5Ibg/1lDvrdPmkVKDjTOD+UiWH2N0qfAy23gHvIeXfv5E7
	k
X-Google-Smtp-Source: AGHT+IE/s4y6yeK+KRr8+VE0KOHDm1VB0SqNoRh4/tUk+yZ+wawe+e3sUvtp5Rq4vsY1itIjopnQog==
X-Received: by 2002:a17:906:234f:b0:a61:c730:ac57 with SMTP id a640c23a62f3a-a6822447511mr78590866b.74.1717145347187;
        Fri, 31 May 2024 01:49:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f02d4asm63613866b.31.2024.05.31.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:49:06 -0700 (PDT)
Date: Fri, 31 May 2024 10:49:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH] printk: Rename console_replay_all() and update context
Message-ID: <ZlmPAZUeKIDFKLdf@pathway.suse.cz>
References: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>

On Thu 2024-05-30 13:15:47, Sreenath Vijayan wrote:
> Rename console_replay_all() to console_try_replay_all() to make
> clear that the implementation is best effort. Also, the function
> should not be called in NMI context as it takes locks, so update
> the comment in code.
> 
> Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
> Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>

Thanks for the fix.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to queue it for 6.11. It is not critical
    to hurry it into 6.10-rcX.
