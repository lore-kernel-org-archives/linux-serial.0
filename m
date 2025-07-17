Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FB19D07E
	for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751927; cv=none; b=uUnTE2egeak8xcZAipoNFVPp2lBQ7qsug4HWUlfGwwH0OBJNa5xmoOWty5rbXcjW6EJyRVG/olHHdb6BAbodcBmV2aZeovV9LAbCjABZ/tMIKq7X9BGl/3I5SWaOKvWWZa5iR6FRUIxpEITcdsSi1Yo/xKeTY5/2KEKQr4opRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751927; c=relaxed/simple;
	bh=NnqdSjL+Rs0PFPzmqEJ8dyDUymEj23QKvWFQ0LII9cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghg3sqKV4SuZX34lvVG+pWzE2FPMOahjwEphIREs8Y/+liZun8SZoxW6TEvCNF2dyKEU0dc2jIRuY0tmWTg5NJmbOqQuonFQ7vN9l7eiGL9L/DeItXrTPX3xUPo1WoTol/5jvdifUIaSl/ClyE4pNmeX9+4nl0M+bIpP8cS8BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MStfA7yq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MStfA7yq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb5ec407b1so140856766b.1
        for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752751923; x=1753356723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nbfA/BUePz5jg5ZXDN13NPJjAM7aHo+l8+nJUpAVbk=;
        b=MStfA7yqjyUiy6FWorOWCGMnWviIL61MbYLr9+S9d2cEU42jgE+c+ZTMbOdh65TyVK
         Lc2NRilJf3B/KlkaN9eZoKtq+AKdH/gei6xAICwkqWaqcE5+1eSnU85ITN4rNfw2qt3F
         Cg80tcjDVhQS+k3XPQGpRpPYseaYHuvmIG77VAUUqKZS8oYa/1QQmQcruoths6xaWwO/
         ArzBSosIfztsxjVaIanBegJRKz7GcqwE5FuGEqQ1k2+M07PURDnAh6kZhiFr7msDjTHp
         cJSxtayH7fYwi3krzmYDI2Skl5+0yJj1sFWfKJCHWcZCjFThZA/+U2Q51z1BhMxBuVzP
         T1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751923; x=1753356723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nbfA/BUePz5jg5ZXDN13NPJjAM7aHo+l8+nJUpAVbk=;
        b=ajrbk5Lz9Yg1StSHT016cdd22rvQKe7IGhor895ccYZIuanmAj/7lKqGheDHI6JzS9
         UYuC9eLM3oMQsrAlMEnsU2nC6JtAKBT4YQtlVOVqRkbo0oZ5QO/XcKRAT56HKXFj9D8z
         Ei4XzzbUxNcoslHnWgNBrMZeUpBGg15GuuSRJVQjV8McB7njSqaHAAA3j/Eu0SAyIbC5
         U+unal+8QCPo6TMXUWWsXLWnmcw3beieKxAB7f0msN3kOP2o47eFLq/276DPQ+Z3tkxg
         r8EEtKfpX215Ga9uCZAdhCbX+i520pGwbsmo4RzB9ZkHsoxWXY5B27xwsVXCzE4Kk+He
         WOfw==
X-Forwarded-Encrypted: i=1; AJvYcCUts5isx25Em0XBKj01Br4y17qrg8LUniC/V8g7oIkrV81onpJr5GM7+S206xO2As7qxqUvAP2ogoPd11Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JeR05OeC74iz7vPyGc2qNYIekmsLYedaxdQaG3Jf3IvFNuha
	evoj19bcp8JDhqMau+7jGbmHH9lojPcRAr7UmX17UBmgB0NfXgSrI07mMnqKklvhivwwOCcf/1Z
	5WUJi
X-Gm-Gg: ASbGnctq8EXqaCvaCrzpTKL70A9fF3oKHvQyyg6x4ZSKbbOw6Kj1lHV24OReMgS7Nnt
	GVkoGwDH84E8E3DWNixcqPre73Jk6wMhNKhkrm2F+ZmtScXEmtbUVEA5l2XH/QnN7WscbouHKPK
	ishgwu0QfGqfDGrXaOh0YHkX0o2xDYRvGjlP/sFULX/3gPzRDwEpdi6cpxgtJsb1bdKLhcqH9j0
	ZcgWJKG5m/WMjjB+Hg9G3b1xl01GLROcTNqumiGWd6sFrTshQIqA7YFy4j3Caj1xusJBwdyseBx
	GcIyggJM1ZVaWDC8qf8g1aUjNHiozQqs+c1/UP62L87a/UJUPHs6QfuvruvNvicJzjzOYxfJpzz
	aiGokefCu9SNWibmCQcLj5mF4D2Rb3p413VpQ9xHDZVes1ExBa+J8v63tQ1fNAjpQdg==
X-Google-Smtp-Source: AGHT+IHPpC07daK6TZIz+cLHthKtlpaXonfdOizJqTxBI8T6DYPMH3DS44MzKOLbMzR4Y0XLAVj+sg==
X-Received: by 2002:a17:907:e2cb:b0:ae0:7db8:4189 with SMTP id a640c23a62f3a-ae9cde02ca4mr620673166b.18.1752751923449;
        Thu, 17 Jul 2025 04:32:03 -0700 (PDT)
Received: from ?IPV6:2001:a61:1347:1201:4432:54ab:26c1:9ebc? ([2001:a61:1347:1201:4432:54ab:26c1:9ebc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee26b4sm1337874566b.45.2025.07.17.04.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:32:02 -0700 (PDT)
Message-ID: <f63f2b91-a217-41fb-bbbb-1810d98838fd@suse.com>
Date: Thu, 17 Jul 2025 13:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: "H. Peter Anvin" <hpa@zytor.com>, Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
 <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
 <927f2d40-1004-4738-a1bc-0000d4d3e179@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <927f2d40-1004-4738-a1bc-0000d4d3e179@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:30, H. Peter Anvin wrote:
  
> ERRORS
> 
>      The tcsendbreak() function shall fail if:
> 
>      [EBADF]
>          The fildes argument is not a valid file descriptor.
>      [EIO]
>          The process group of the writing process is orphaned, the
> calling thread is not blocking SIGTTOU, and the process is not ignoring
> SIGTTOU.
>      [ENOTTY]
>          The file associated with fildes is not a terminal.

I would take this as meaning that we cannot just return -EBUSY or -EWOULDBLOCK.
Hence the generic layer would need to implement some sort of waiting
logic.

> That's why I said if that is what is needed, it really belongs in the
> tty core.  That's where the current internal delay is, after all.

Good. Don't get me wrong. I'd love to do this more efficiently,
but the current API is less than optimal.

	Regards
		Oliver

