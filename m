Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B0482FA
	for <linux-serial@vger.kernel.org>; Sun,  2 Jun 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349086; cv=none; b=ttiLf/kVOI2uW4nTAP4EJii1X7T7t/bkhH1T8gQKXZHmfO3YDhcFdnLshq1+HbEBZgNW0RQpG6Jocm+CjRDOEskjVLPN2WzET1h7SqTw/o+uUrD4/IXf1LGwmbXfECYwnezCcWBVoMTTdkIAKr5ouy5RKDfS0PmTnAyY2Xk+ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349086; c=relaxed/simple;
	bh=muz927yJM16BZxh/BL+W9mX+sGHOfAbmJHMlwUNiwXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ejzcAGu4YCFuRnnSo56lh3Wl8Sy6OdxKn39h9K3u2itZvxkqDagnERI1nys7q8G5H/pfePbOICqtuAr2dJIq6ZQS/cIhP02+nrw1tj3pdVyViNPAv/pFY9zuG5+aygRyQeiVYN7BdY+RsgQSfy4Hc4P6biFDS5Dy+bmcc3vgR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=L4qcsdsl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="L4qcsdsl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c21571e99bso88228a91.2
        for <linux-serial@vger.kernel.org>; Sun, 02 Jun 2024 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717349085; x=1717953885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTPfyrOmWBS5A0+ebNXn8hbxa4DDcW+Ed+xhz/Wjq4w=;
        b=L4qcsdslgPrpvKZsgU0tgT+jik1F12cNR0u5uSSHvUWhk+EalhwxXGqsjoOgqJg3ZC
         AhWLQi5IwSysRsDl9PqQsUG7p1q+Cwx/MEc3fP0+50zGgEmzshkTh4RqS6C1jlVlvwdJ
         b2tOU5Tm0AL2cyX+nvZ9mTZkKMuo15TkRyYDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717349085; x=1717953885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTPfyrOmWBS5A0+ebNXn8hbxa4DDcW+Ed+xhz/Wjq4w=;
        b=xBWeJwWIPtYl2FDCfcT8f6LCBEGdbPT/ieyjM3wBjr01l9NeUHGH+CbCIiOR+aA2lP
         SZGAAHhTaQiWxDcfJZZ2Zs+SswYeZVVfm9/1Y3seMaBo/OYcgrBhKk+phtyx+vkE76Kz
         rm6GrLNdqkxAQqAMP54hc87IXWvC1Ag89wVH2YnP2ZDrI96S+Wr4kGxZJdKflHuUMhIA
         UT5381ZZA9Av1+feqTP5OsccOCPJcZksYdLd9hB8c9jOaRLpLDUOCApgShxwtSmrXLEr
         ym/P9eiYWaY580RjG019I5UPHXhCi2IUOb7EsRjxbwe7dtKC2rFirqjG5liPsen6mrfu
         Xh/A==
X-Forwarded-Encrypted: i=1; AJvYcCVzbClyn9OkyVocIs8r3E8CulS6mpYIrXrnR+zTYH6kOm0yvl6g1hr2adtbyhcHIIYMWv9J2fG08EQb+YerEtILYv+11s6U0BUnQ7P/
X-Gm-Message-State: AOJu0YyB3fMs4RdI4AqCuJ3Geeydoeo/tI0HTxxTo35iPjdJlfGnwkyn
	AzrnX7V0rLKkpIcpK5Eol2YCxl9nd68RcwzGQFqOpFYqBonwOIB+v7B5t8r7EVY=
X-Google-Smtp-Source: AGHT+IFZLhVhqD30rzzAy5ZjZr/ktIuoOU0wCPp+7wsm9fNNiXRSYDU/cckjGo1iCdali7+8+bJ8jg==
X-Received: by 2002:a05:6a21:197:b0:1af:a5e8:d184 with SMTP id adf61e73a8af0-1b26f3668d1mr8439177637.5.1717349084798;
        Sun, 02 Jun 2024 10:24:44 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c232d25b3dsm331013a91.0.2024.06.02.10.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 10:24:44 -0700 (PDT)
Message-ID: <f7d2289a-2992-470b-97e3-187386ec3f5d@schmorgal.com>
Date: Sun, 2 Jun 2024 10:24:41 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
From: Doug Brown <doug@schmorgal.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org
References: <20240519193109.122466-1-doug@schmorgal.com>
 <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
 <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
 <20d56279-2598-4a3e-9984-729199d8e67d@schmorgal.com>
Content-Language: en-US
In-Reply-To: <20d56279-2598-4a3e-9984-729199d8e67d@schmorgal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonas,

>> On Mon, 20 May 2024 at 08:41, Jiri Slaby <jirislaby@kernel.org> wrote:
>>>
>>> Perhaps, it should be reverted and the affected driver should just pass
>>> UART_TX_NOSTOP instead?
>>>
>>>>        uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
>>>>                true,
>>>>                serial_out(up, UART_TX, ch),
Does the bcm63xx_uart driver work correctly if 7bfb915a597a is reverted 
and UART_TX_NOSTOP is used instead?

I was able to further confirm on hardware (BeagleBoard) that omap-serial 
is also broken after 7bfb915a597a. I'm trying to figure out how to 
safely revert it while also allowing bcm63xx to continue to work properly.

Thanks,
Doug
