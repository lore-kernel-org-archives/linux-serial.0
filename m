Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491619408C
	for <linux-serial@vger.kernel.org>; Fri,  7 Jun 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767773; cv=none; b=R4KPlrRyv6SD8jnXkhP5rfCYbaLrQhXaa0uGKPlWNlXPgIcLd0vwEZtq7VTonXvzVo5aew+eLXhhwyHcRIhS0wxWhMltQa8yPpmU7AbMDe9jTKPwsKlbdszKbuhdkW1df3KNSeyQzxAhf1EsravpIrdUQUR0fGAxMQN5O9N/yNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767773; c=relaxed/simple;
	bh=XDkV51WcTaMrjC4Wbmmbxb4AdQznGkO4kCXxMJpBIeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgm3pbviOkNJ7J+OMUp4W29mM5IPUk/EIEjI8YK/Oht6KGuTULpzQ0146NddmA5RrfUCPBnmFuhK64ofUfUCXSyg335ytREKHxhwel+1OcWGM+q5jvCcVTvBDyzG5uZ0avxfyrtjZueeOPXu0asYUsggqb3ab/g7z11mFZheR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=cUAfKM1T; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="cUAfKM1T"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so148131a12.0
        for <linux-serial@vger.kernel.org>; Fri, 07 Jun 2024 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717767771; x=1718372571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zPFep5uRM3UoI4S8G/bti72QLt7VQBXX8fDD9D3x3o=;
        b=cUAfKM1TbxnRYHClUDv4hMEmDEcHhGho94p2oIOSIGyBmHWYzMQcvFvKfbYl4BBWuS
         mYO9kW7jquLPnxe3bAzqwAi8JDlm9If9pDSBiHHDDDq/edo+6p6eguMQJ1Zt9ETs7KC3
         7X66MF5i5Vs/OhGHcAMlRr3PppmV47l32I6J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767771; x=1718372571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zPFep5uRM3UoI4S8G/bti72QLt7VQBXX8fDD9D3x3o=;
        b=CNyYMqsJ5hVuln4og4mXnFdrufYQ7y6ve5OnPLWTObcSwfhSzK1sq81aXOuWLAmZRn
         WrVg4+5wKLFmNKpKArMDpwS2OBn4ukT0UuFhZyCA63FSZfdwoW5et1USFKiKSOrPycn7
         pJ7RNTsOy2t9nwoofYy+PQoB56gPz1TeQpbjbS+/DpAX4A7M8gE2IvyK/qaPwncoL5my
         kv0sgaW1QCTvzKz/0VihnppuL2npZyPgbh0U/k2A2pLKQPEaz4ODa5pCbGfbJMW/Zxdf
         tNyTM3hu2haAEJOPdT1PRleDEi/2OeRclU69f6uvIgozl0PxiZyGYscpt4TwbJABI/7y
         qKPw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBgYQGoWDdQZicJ3ccEv8BS0iACSXCtyW6FDvmqHOrSGuDga4JtzvodMq7Sama2+du/wp3fwlpSEVE0jf30JR11TsODqOIjY0Jnxa
X-Gm-Message-State: AOJu0YyaVXDqoS3rKngYwB0e38QkNDFnJR9/jHjZKfKD5IJveDPjHAFI
	QCEe/UDKXEaHImyL6JTOQWdwcxty0Ic86HhKCRzOge8zVCmP6Hh+boXzaTmSt0e+FZfAMReeSAM
	HQDLlaA==
X-Google-Smtp-Source: AGHT+IHUC6WD99bfCf6H5gFtsRdagJQfNLoMQNXJaUxm8DMCNSxjKMRejZ0fvezls/w/aIl2oklKxA==
X-Received: by 2002:a17:90b:20c:b0:2c2:852a:e664 with SMTP id 98e67ed59e1d1-2c2bcc78b24mr2593406a91.3.1717767771363;
        Fri, 07 Jun 2024 06:42:51 -0700 (PDT)
Received: from [192.168.1.33] ([50.120.71.169])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c2c661f8basm1258488a91.12.2024.06.07.06.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 06:42:50 -0700 (PDT)
Message-ID: <97f83da1-357f-4ac1-9901-bdb33bd0c32e@schmorgal.com>
Date: Fri, 7 Jun 2024 06:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] serial: Fix regression in omap-serial and pxa
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org
References: <20240606195632.173255-1-doug@schmorgal.com>
 <CAOiHx==vwPnwZA0om91_1tPEHfnQQ1GOM6i1xOSmVGkgrfaJeQ@mail.gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <CAOiHx==vwPnwZA0om91_1tPEHfnQQ1GOM6i1xOSmVGkgrfaJeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 6/7/2024 3:10 AM, Jonas Gorski wrote:

> Note that this is technically a new V1 (or V3, depending on how you
> count), since the V2 of the original patchset was what became
> d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()") and you are
> reverting in 1/3.
> 
> Not that this should be cause for a resend, just wanted to mention it.

I'm still pretty new at this, so I honestly wasn't quite sure what to do
in this case, but the reason I called it V2 is because I am considering
V1 to be my original attempt at fixing the pxa driver that had all of
the related discussion. I tried to point that out here with the link 2:

 > > Changes since V1 [2]:

I probably should have made that more clear. You may be right that I
should have just treated it as a brand new V1 series instead.

Thanks for your help on this!
Doug
