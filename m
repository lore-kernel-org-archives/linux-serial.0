Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB73CEBA9
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121621; cv=none; b=KkneWWfGG6plqrz16loeOMQNyfB+g8B9NVjKIns30vleGoquXpLwNHS7FFfYgGU9p15QlOspJMTVVLrOH5USwzAfpAdA5u9kYjFRJkE15D/XW8MQMruepeUC6w382y+pLTvnGLBfCuG1j6AN14BTiA6eyRMC1TupH8h2jEGvCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121621; c=relaxed/simple;
	bh=sXtsjC3Cg+AuWn4pFUN/14YzNiJzLmYcsExmKmcPbSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYUbe81EoBbILTAwWdc4Iuzsd/5/RsYSW+AzO+x5A9NlHZHmjjSYTk1zIMf96mncZaOcZjsZ6BN+6CiWRwPiyHh6dIYkyjXWV0mpLPmFw0FLRotJui8jPRswJqlIWNKqSdGvMYEbaj/inzKWlzP7jtcI2lObN4r3mp9gRinDJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49557167508so6676455e9.1
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 23:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787121619; x=1787726419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBqWma/qo71aJ3ooE0LRAPm0QRfejCf5pbI9noV+BqQ=;
        b=D8bp7hCRmOqAPu28eN4yNwuyGdYhpcuAYSsLOknOq98/Mgr7SrITbYnFc+9MAI8RqK
         8qBKN9Yxi8beUTEp+TosspBjV2iNySAzmKDgIsoniIds1FkclQ8p9k9ToyUT53dIaOZ/
         v5bRvIlpXvl9fm0ALksh6akWMyf67uNcSIktxuMdM20VXO8HPCX5IFkzH/S1vo98ukGa
         RmpikfzHa0IniB+nH+rwqV+GXAOBcboyot3uGgtUOpC9LaqAqcQNdQV2u3/cybMJ8oBV
         G9Sfpfa+MIQLRUa6WWaylleN7Lv9GIkFs5YO0p1GSYKiE9DzXtvA5KHjfj/Afwm8o9le
         fyJw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0nTGPf1ejldzJnJpWkGb5fV+RdsWf69bFDg7gta3Uy4zoH1EhGVnL4XvX/6ReyL83HJhPURMVLk7Y7bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fzBpabzpfTfU5uGNfK5jbzBxeGf6WNMgwfnbksoBmE+dKIQm
	9USEA7wv3oSFMwF9j+1Dg8K+o9H6FbFJntdTGhM4/PvIW28TBESAlB49
X-Gm-Gg: AR+sD12cR0+1tTMybvz55aEGCHZtMHrW2blzySpkRdfPHDH6MIwB8xNmVYQWVvj5O/R
	uaadHZEj6UtkBMyQ/XdYINFzL7Sacjwm771lA8DAPIw91+GrZu8LEG2ACh6AILhPbuZmSB84Epj
	KnWJbYf2A577LRgbvgFzqbuh7HH4bmC/14QT34zrAv95gOM9HSXa0qjnsBwNUOX6oR7/ZqI22PM
	W/bdOPgkJ7Q8N+Yq9PeBEvRz+Z08kD7aHAE5Qcm6wMtBrmEJ6RMmXkdRRv4Ie2GO2fH9Wbcr8lh
	V4NpPxANkIOlWc322jidkzCeifzoDMEwz9sgqZWY5kwSEZwg4x9URHVkoJluyydVdzlc4T7AVau
	8c0milkO/XLp5tJyJBDGDAh8PPd0GAPtaK8NJ+FZd6IKxIN1t4haWZ9+BA61t8GvO0Fdkz1rANJ
	ELqCUMzQOLQR7OH6n2l9v2oYjP2Y6M0fqfWcYrG+my3EMozk7Fo5oSV915zaT4r7subRz+igqQM
	IhalzoeizjgXghof/aT/A==
X-Received: by 2002:a05:600c:4f52:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-499aa1fdfb3mr32762455e9.13.1787121618614;
        Tue, 18 Aug 2026 23:40:18 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aaef1665sm32946355e9.5.2026.08.18.23.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 23:40:18 -0700 (PDT)
Message-ID: <ecc5ada8-c878-4123-acd7-64af3219b181@linux.com>
Date: Wed, 19 Aug 2026 07:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260818185200.10243-1-tanure@linux.com>
 <2026081923-magical-enlisted-64ff@gregkh>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <2026081923-magical-enlisted-64ff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 06:57, Greg Kroah-Hartman wrote:
> On Tue, Aug 18, 2026 at 07:52:00PM +0100, Lucas Tanure wrote:
>> The 8250 driver creates a fixed set of port slots at boot and
>> registers a ttyS device for each one, even when the slot describes no
>> hardware. On device tree platforms those slots are empty, but they
>> still take the ttyS0..ttyS3 names.
>>
>> New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
>> both drivers built in, as in arm64 defconfig, the real port fails to bind:
> 
> Then fix that bug, don't break everyone else's systems because of it.
> 
Hi,

Understood. I thought preventing 8250 from probing on devices that don't 
use it would be a good idea, and fix my bug. Thanks for the feedback.

I will tak to Amlogic list the ttyS name collision introduced for the 
new Amlogic SoCs in e71aab9d6132.

Thanks,
Lucas
> greg k-h

