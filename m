Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CD314B87
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420625; cv=none; b=KldAlY+KrVCrxX3Q9qjcXxmYh79iIhoQgwtPUBOVloXPFFxrZFJEkwhgl1HhPfZTdyXovHmSc3t1V1Zb09h2+OtoEUdJHGbsky66lWHyFJmlpWLj9CMXT9iq2ELNpWyOLCcZ+xSkrsVplDdTCYk/jhhQWUMN65fOnyLw6FWQG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420625; c=relaxed/simple;
	bh=iF0jtrJlUrNHpWgOjOkf75eJXLoQ3RvCmYCuoX+XzEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrCxV7/DXWcMhCzxNglBq3+LrOFzf9xVWnlPcLSAljmd15PwYGZB02bewE7isnidasRi6IwEHpeTbL3zXdeqOgYmQ0HU0X8tDLFHcj6yRRkO3vM8Vqwo8L1Nzq0VcCkFdBnrac7u5JCEtPo3RW511qarWlO4urh9CeOWSWOeygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQoY7TkY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQoY7TkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RIapV1jNyyZRIdn1KJNs6Oqxeyn0EIFbQQYGbVwf34=;
	b=EQoY7TkYymGN96fReH0jSVx+AAcw6ztjJq1A6KL1uDzeT6QVR9Tq83boTTCVQkWmLVmPRM
	NcjuDOUpHPKhLk5h88zIi9E+GUZ2d7jvTCToR7uptrSJyT6gLwu/7f0brvr0MBJMQcpl7s
	ju152vH4chc4x6SvUSMiJ39B5ZJmDgc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-bE_sXz5rO72E9cDi9W88zg-1; Mon, 26 Jan 2026 04:43:42 -0500
X-MC-Unique: bE_sXz5rO72E9cDi9W88zg-1
X-Mimecast-MFC-AGG-ID: bE_sXz5rO72E9cDi9W88zg_1769420621
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so4582439f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 01:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420621; x=1770025421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RIapV1jNyyZRIdn1KJNs6Oqxeyn0EIFbQQYGbVwf34=;
        b=gkOAqOwf135tIt6PcII4SqmbhVA6Kh8MJhrYcSgF7HWcifyHOobJJiGeoMG7DINqg7
         4l0SGhvxCq10Tl1QClbMqDDHEpN8q67TqXabay9ewv2jffZrZz3IMuw0Z6cPnjhjGICF
         c7s0ApoA4LEa7x/4hkdfMJTreRkGnDfUQyiJIe/Qnj6QYOomPprFJ2Th83kDhswixJlt
         OdS2yZigVtBixr+Ag6DrbdeHojuunhRZRonAZIeYTOIb/HQ2IR19OBGmyrKscHMHvUQe
         AMQ4nP9GxEr25wt/RzgkVMG/dOpCjrZCdVotXBjSEu2COcXBkpeKOHqhX4/eBcMFXOy0
         ERSg==
X-Forwarded-Encrypted: i=1; AJvYcCXikNbvH6xaTN0r4J7t8pV6qMrLa7bAO/vp4wnOGoezj7MC665bzPFpLLMVKh9FxDWT4BhRNWh/bSKJP9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAewtDqHOkp+it2luFHchKFonpdeho6RwHMF6Sx6795eCWnZHt
	wb4DyS+mDg4jHHgfK8dCB71oMvdic7CPZMlWuzzTFZOHmL0L2Y+Lz9yxGbMUptuFBVFKApCFuCz
	bfCEXFELNIBJSuTyJunI/ke8aH4iPfOoaUFOOJuKNYiZTpnlNbzwmEn+D+UFHiPao8Q==
X-Gm-Gg: AZuq6aICM7sM+TUfRWExn2ZdGv9yttj0HWeIg/47xtVESWphiX+1ucpTDCmBWBrRw3J
	7FO+m37c2f/bTbes9Pr0SROls+N8ZH3dl+Zn5eGPaTm/09YqyRY6PZHMwBTSpL9FUaZtk+PWy5i
	4F0GSZLx/LDEiJIjTgO3dYxI0eHT6qKxbwwnKUECoM4IghtntxebEPceW/IJX9PXP3Zag3+IWYe
	LmipLjtWwp/kZ5wyS/8lPQtv3jCkAAT3UGkSZeRDj0nwRh1q0PrIWA84CvPqpzuqjHxA1KkglS+
	/clLXyOIPbecWIdpwrofmAVuTOARR/Mhnjy4IZaISADuEvbqPfUJthC4YVBfXrty0v8Z+96+WXa
	psqbEaM19Sqdn5kL2hB02uq/2DSDJfAtvCHXYlN6lcBVjnhE7Qw==
X-Received: by 2002:a05:6000:40dd:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-435ca138f4cmr6111227f8f.45.1769420620893;
        Mon, 26 Jan 2026 01:43:40 -0800 (PST)
X-Received: by 2002:a05:6000:40dd:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-435ca138f4cmr6111188f8f.45.1769420620482;
        Mon, 26 Jan 2026 01:43:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm27537474f8f.38.2026.01.26.01.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 01:43:40 -0800 (PST)
Message-ID: <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
Date: Mon, 26 Jan 2026 10:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: Add enable module parameter
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
 Calixte Pernot <calixte.pernot@grenoble-inp.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012613-cotton-jellied-b67a@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AmRKsa4_D4s6ixLvQNBQG9af2eeao75RCRObym0zvoM_1769420621
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>> This allows to build the kernel with CONFIG_VT enabled, and choose
>> on the kernel command line to enable it or not.
> 
> This says what is happening, but not why?
> 
>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> 
> Why are we using a 1990's technology for a new feature?  What is this
> going to allow to have happen?  Who needs/wants this?  Who will use it?
> For what?

The goal is to ease the transition to disable CONFIG_VT.

So if this is merged, you can boot without VT on any Linux distribution, 
without rebuilding the kernel.

This option will also allow a distribution to disable VT by default, but 
users that really wants this can enable it on the kernel command line, 
without rebuilding the kernel.

It will also avoid hacky solution in userspace like this:
https://overhead.neocities.org/blog/systemd-logind-seat/#very-hacky-solutions


> 
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/tty/Kconfig | 13 +++++++++++++
>>   drivers/tty/vt/vt.c |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>> index 149f3d53b7608..2b94c2710687a 100644
>> --- a/drivers/tty/Kconfig
>> +++ b/drivers/tty/Kconfig
>> @@ -41,6 +41,19 @@ config VT
>>   	  If unsure, say Y, or else you won't be able to do much with your new
>>   	  shiny Linux system :-)
>>   
>> +config VT_ENABLE
>> +	depends on VT
>> +	default y
>> +	bool "enable VT terminal" if EXPERT
> 
> So no one will ever really use this config option?
> 
> And you are doing 2 things in this patch, not just one, unlike what the
> changelog said :(

I can split that in two if you prefer.

Adding a module parameter, and adding a Kconfig option, to choose the 
default for this module parameter.

> 
> thanks,
> 
> greg k-h
> 

-- 

Jocelyn

