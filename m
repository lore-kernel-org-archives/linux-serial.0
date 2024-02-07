Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619717C098
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315136; cv=none; b=ZIhQhZDEehLTgMn+vU4X79DzVGyvaQqkBF20AHVK7k60gbXam2np2o7DaAvbz8NbMWhuehliHcsKjtakeDb0EOiFTwcleAcTC/jocFY9xI7CEOqgyUwQqRjEyCLqiYdCYYdo9+MqCuqEi5VRvDmzcnXcWeVBG1b3cAetVr6bmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315136; c=relaxed/simple;
	bh=A59wshl7eo0HhYdJ5zAWlTa8zrJuvmVtrKRNgl8gKVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZATMKcf/sERHP+XX6xb4DC6lBiRYrXtWpjBko+QfZqGxn77YE8qvNys7TmDRMTZl2V1LaFoxDOq2B4PmW410Tu5jmKnnTpQFucj0/llS7Nsb9ptPCBt0Ki7TdeKIeUPxMIK9BxhR2sCbz6Uxkm0a0VAPu0jssWIS8fqVnBJUh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eg3tc4cS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eg3tc4cS"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so8441271fa.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Feb 2024 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707315132; x=1707919932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sFTZ98VT12qZIsZV6SV4ds83O1z/KNolmGkjNhAwJs=;
        b=eg3tc4cSybinY95doS9el+azgWLNix612LBSSnyOcBUH+RHaZeqXDfV0XiW0WSxuC6
         HkSzYQYMh8FwhnbvkUuq+hXa+Udc9Zj9frVxWmn1Z4kRRFQfsmsZSxZJ7jFC8kUj834t
         Dk2pay9Fx+XKjm7D1N/4IaiPA6FLg+y4MwC1aQvcqg2LA3ghWjJ0yFcr94JLHRSYrF0K
         90CJbVFbuqy92Yc4cWP7op8fpmaTzaCOyx+Ck1BOu96djCG+4LIQtKIddyQ6fxrdnhjZ
         URr8IXlY6llaEuFxl2fXM/QvfGycCkGJorRFEuTHh0QJEbnEp9h2oJSsii6Wc1cckiYs
         C3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315132; x=1707919932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sFTZ98VT12qZIsZV6SV4ds83O1z/KNolmGkjNhAwJs=;
        b=Ie4J5OGqX6vJ0UH7SvC+QBTiMJr2b+SPhziYS0k09pCHUzpubzrL9U5X/dfeeHVuh+
         zOyCZ4IrpipEAPMdy5QTBFKgwtxUniSNX5zo0FNBzLG8Yas5pEcyLdaBDsL9VzGxUT2d
         YxUDKieZqbgZQzbqBLI9k1v39xaG3LZwn2q6HSYEnlvajkgYWCSyeyZasB6mQpegtIQk
         ipcGMwXaXwOEl/3lmPTxqKViIHGwXvC9jv89kIIyJ1EGXBbsvBzAH1Gb7iupvXzKqBBL
         kdPr+s0i4zJ/O0ufnLr3iZo4dRg3vRqAgShkBmNlX+O3YbLuJQN34vNDF+slg22kvI3c
         W7LA==
X-Gm-Message-State: AOJu0Yz4eV1ahNyq9y2XJ/5U+kKIaoz37A6iwq3G9DkP9JeGoSE9pzti
	x6vrdxGPpe7ejfF94aoNlBHibkHZ1vrzwae29tWM9vtj8eMovFIZ7zNNzu0QTWw=
X-Google-Smtp-Source: AGHT+IHPI/6TNW437JT4ZYNkYLwEgb/Bo0cxZJ0dxzcml09oskePxiL679oN3dh/NjYHKsnLv9rE7g==
X-Received: by 2002:a05:651c:3cf:b0:2d0:b1ea:9a78 with SMTP id f15-20020a05651c03cf00b002d0b1ea9a78mr3747559ljp.31.1707315132366;
        Wed, 07 Feb 2024 06:12:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUa53u/wbGwA/AA6SisHFZL8+YT/w/Xh3HdmPn38b3ygOJoGn8QQLuPKveBMDGXxt2xNk+NuqnXgXbwc7Q5NjeJigtPGtgUawvCOlQtFjkVWUbHNLkudj5cvFUqgteTtPZGpItrmFM7Q5wAuTCoe0U6TnBSPz/aet754ersCDiE7oO6/z2N58IBsG8mCEM6z8FrLdKkOz+cnxnF4vXIUAM5E8x+Xvh0JK98IL0oHSbN0jLCunM89GEgSoAOqB7pMtw+YAK4u21jV1ZD8j6a9JSB4Vne1UOkRWTH3VGcDeWFTr/6KYGIpLHsFk6nx5NzEPOb4pRyysY/GBLUpQJWegiNnkE+wFx99AFR2zq1+bc4FD45/q0Ymd3AJYngSmVOJBBBIu/qPnZLYcT8kQsPicQuCfy1xLEQf9hx1opWdSVQV9h6cbQLqgOR7JNAozMrL9nz/EsdxUH+HSZlCCR9t4WMiMwHn3tkkWwE
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id f1-20020aa7d841000000b00560cd4f3098sm697735eds.95.2024.02.07.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:12:11 -0800 (PST)
Date: Wed, 7 Feb 2024 15:12:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 0/2] Add support to dump printk buffer to console via
 sysrq
Message-ID: <ZcOPuTK4gPsDJjg8@alley>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706772349.git.sreenath.vijayan@sony.com>

Hi,

first, I am sorry for joining the game so late. I was sick
and have had a lot of pending tasks after Christmas's holidays
and the sickness.

On Thu 2024-02-01 13:12:39, Sreenath Vijayan wrote:
> Hi,
> 
> This patch series enables one to dump the messages in printk ring
> buffer unless all CPUs are locked up. This is useful to view the
> kernel messages when terminal is unresponsive to enter commands
> like dmesg and syslog services are also disabled, especially on
> embedded targets.

What is the exact scenario for this feature, please?

IMHO, rewinding the entire log on an unresponsive terminal
has a questionable value. Most messages would scroll down
quickly and only the last messages would stay visible.

Also this code would rewind all consoles, including
(slow) serial ones. I wonder if rewind on these consoles
would be useful as well.

That said, I am not completely against this feature.
I just want to be sure that it does what you expect.

Best Regards,
Petr
