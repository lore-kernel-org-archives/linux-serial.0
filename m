Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F9381E98
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746930; cv=none; b=G+GTMIWPkx6Js7os63BIlleq2lsEkndaeZxIa6RcLbVQcNkhst3BIfbMP01NlqvVZNYW7LFSqLtZZ3NxOAw97cOy5oQVTbiEkP0U21dBTZ+9wQYlAAiFICxwpMAQqIwHctafTLaHCPH/euEvIaK9BudtzlfMvU/qfa1yeZ694K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746930; c=relaxed/simple;
	bh=QSznnEnpdQVi9WdrWsn++f0OiYNOnZ2QGWOMD1egIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRPk2IpbUiIJrU7ALkKHrvjBjCOzXUSFSIDWaOGGbTNzGfIb4vp8kfB/KhuUdThxycM5e/3ft461zcSoRFet7+d2dZcpCwOmzrj0qDKqk+sOzLaFlg4llx4oArVTt4SGKV8JrUntliUjNlqz/csxua89xXkTNKHEAnAZG/Lw3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOCt16J9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOCt16J9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so1873819a12.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746927; x=1792351727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suZZR6RHE7rP748UZ3zwlAVii9ohslanZfx2IvpYQCU=;
        b=KOCt16J9n1epj/mW71+bxjcuvn7M0Bgip5Dye622mUZhwURjNWBte2A1+6yP7OTdWF
         +M9ytITOvBMLKn/s1StgUNS2UMLFxGHBilwHwNipP/JjOyd+f23Cg2tOysZl7ivXO9Tc
         74x1zRLd4Bqev/kFTL6poOdqSHDkAiACMfyS9GM4KpdaS7PoC2AvOmGwt4cxRQWeR+qc
         mwUXWwB7V5uWnMm1kNA1TL2uEIyghAnyS3fGE6SmxxgQSsZe6i52No4U/dD7ovzaW28u
         7dPRAvZs21FpM/YsvSrS0UVRa8+LGNfyj0Q/91QJNGYU99RaMmaKKR6zGGQU52J/r5Sc
         Z2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746927; x=1792351727;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suZZR6RHE7rP748UZ3zwlAVii9ohslanZfx2IvpYQCU=;
        b=MZQPYGNF6nhogXllpQpJ5IsN7TcDkA29vLxAhMWklVUZZ4oOtKsRFsnK6SHw9Be6di
         MmbPUYe7fJ4jdNEGiE6yETaSsLPZBt2DbX+Uf3rVVL4sgfwUdsOItSMeXCYw/DfAA33E
         UtbQ11qdofba32quo2e/kPrwxS2Crd4ZzhuzjcJn+5MAz6NEajmD6ywCBaLK0LruUWBe
         yR/APb44y5lw/qcl2vViS668sxiqB8Reds80lTLuE4cNHrxvwuaIhSxlVnlKODrAVLrJ
         2aiy67+j9I/EX7BvDG9TouHxcP7BBrWKVeffuZB76gSZGk9kdLai//4KnvwW2zPQutwE
         Oqgg==
X-Forwarded-Encrypted: i=1; AKwUvBzI4Q/M9Xc9gbyvNOtSb5ErpfTLf8TeF93mAxfSsJTOu+TPmuTJgw0ri0z2ZzrQmvbtRjIC0rZqlffmZnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfFfiZpALrRGH1H8Og633qyp3xLddJBG+QscYjpMqSxALz3XUW
	6n5HQKjexOjZohLUYCTqmL8xM0FYx3y6XA9vuCQSPVC32xCPJ8woLlTluI8WwqZ6
X-Gm-Gg: AYBFou3mJccP+Qp57+N5KRLZIPJ3C5UjB3QC3OLcYZF5cf29CUBTpliWOJ4aqAgu+zS
	F2QZNatvpSew9M73iLBhCCWcAtC3PyOidifrGpN75eHhQMfBCCFrv9J3rzEpO8CuCLabYzo9lSN
	o69njBmG1mGLtTA95+LXYyxyQLkAef+/Ml9hIBXr0fjNW88Ar7j5PbPRkrd27oHSBBbZoSakk6o
	2F8TiXPixU/IM/RS5Ag3SWpAIviiKR0Xp8uAUktaXaiixUduQtJ5lI1S25Ckgtf47IA4swQWgeZ
	BFQVAnebXcuAjoQHsxwsZbCdFLPfwr8FcIprq3Iuj7oP8xqehMjSSIcZSVsHFDNbFjIq8kFpJSu
	b0hgt+YgSdrWjiMZq+ax/0s82DlQxTv/pynsLmspy25jXP2GKuQme1asoF4lDG+v15kZHAgOuFp
	oXslPPczhQwKMyenpEjDhmkwUhIkY5bVN8Ge4cWUc/neviiN2USV6ej9ZCqANdax7OX5TBmxCVo
	cIxlkSVeXck+A0zdSUgrNIBMY0MNjxZuVIBNBGoW1I3oQ1Pib9CA2B9AvIQDf5RFdg8P2JEosB+
	L4ub6pC46Qfz6tFUBnZtvA==
X-Received: by 2002:a17:906:f592:b0:c26:19de:912c with SMTP id a640c23a62f3a-c31aa07ba07mr845018766b.31.1791746926798;
        Sun, 11 Oct 2026 12:28:46 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:6152:f99d:3762:f020? (2a02-a466-68ed-1-6152-f99d-3762-f020.fixed6.kpn.net. [2a02:a466:68ed:1:6152:f99d:3762:f020])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac9ecfsm399541866b.74.2026.10.11.12.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 12:28:46 -0700 (PDT)
Message-ID: <2fe443ce-2d3e-4a1d-aaf0-0aef68da4cf0@gmail.com>
Date: Sun, 11 Oct 2026 21:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL
 check"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 stable@vger.kernel.org
References: <20261010193755.187706-2-ftoth@exalondelft.nl>
 <2026101151-regroup-caterer-b92d@gregkh>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <2026101151-regroup-caterer-b92d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Op 11-10-2026 om 07:35 schreef Greg Kroah-Hartman:
> On Sat, Oct 10, 2026 at 09:37:56PM +0200, Ferry Toth wrote:
>> This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.
>>
>> Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
>> added `up->dma = NULL;` to serial8250_release_dma(), with the stated
>> intent of making sure DMA would not be used again after release.
>>
>> However, up->dma is assigned once at probe time.  serial8250_do_startup()
>> only calls serial8250_request_dma() when up->dma is non-NULL, so after
>> the first close the pointer stays NULL and DMA is never re-acquired.
>>
>> On Intel Tangier (Edison) with HSU DMA this causes a regression: the
>> first port open uses TX DMA, the second and later opens transmit in PIO
>> mode, producing 64-byte FIFO bursts with ~50us gaps between them.
> Ugh, sorry about missing that.  I'll queue this up when I get a chance
> in the next few days, thanks for posting it.
>
> greg k-h

No worries, sorry I found it this late. I have been behind testing 
kernels and only now trying to catch up.

Ferry

