Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65302AD17
	for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241758; cv=none; b=t0dRuC+Yw7CWGznpSXcqtx0dfZft1VuHcuHoXpfUuSthEUCbQfUnAQnknZGi6jCOd+yfYdXaOvhqkb4S+Gzuf4kvF9dYt5DardiVgGgMuTbHzW2on6bAOsqh8ck2zCGuMbObal9O5wDS0kMe5rG81HAxQWDAbH+TNuyNkj4Wofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241758; c=relaxed/simple;
	bh=JVb8KMCM6jHWePJ+WwVGJto+gZZqwG8xSOjy87G2/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOjKeRr33XZkjoh/r9roL1W/7w3aH4//hc1iE3IGzb4WdtWuhnc2CYc6TlTJZjRxZO1iF54YSBTf9BlmY2nVuiCjNQg56kgS8wKwYaneHIBP26BZXbXxb0cawlOc2eeZ3kqEbs95wrMw+CdqgYR1CZqieg5T1CeUKQW3AcyuAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHugccHc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHugccHc"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f74e468baeso14652861fa.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726241754; x=1726846554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0JwKHRK3rl76CWQbkuUTWFIQpTK2A2oPr0BJFkbSag=;
        b=WHugccHc98Vp3frffJstD5/mOGg3TvLh4yx+6AmbAcDzYUaySi8qBLkfwIsbmWSa67
         3FHzeuhZFiXZTbxEXp/NYadjeqBmoYty5kEN2+ARkTMXVtjSE4u1BAENuULmgJXodRIY
         PBtM0vxFVKxXmkewgu0iLAkg0i3MqrdXksY0msVddLhcm3oWmOGRcj5BaMwKWCkkPu0a
         GYTohFea1yP3CnMqnWM8hydAkC0S3+WjtGcN9G/wXcV1prh+nhBvDl8mqFJc4HVRX+Cr
         2PjLZiwIhdjHcBWwNWRWqlgCNR4tWKaX5d09iwVGXlI0W+T4KrtJx+t8mQh4tE/v3L0x
         XEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241754; x=1726846554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0JwKHRK3rl76CWQbkuUTWFIQpTK2A2oPr0BJFkbSag=;
        b=fFdLhfjl2ADmP55Bn+NsE+xMtHz2dpddwt11wSK0CCrLNUOzRoiLSn2tYkqfaXqdgm
         tuaEhEmvY7x6ZMtKtP8dQNu6otW4HrqJOGwZBDZi1Ojv3dH8U6Duzjxxt9jkQ5O3hdmh
         G9+jqVtcHlbA2hu2YQ+xUlcXFntVKB72TKfxuJZRjUHDJ/XEtwnS7QBEtzzfqAflhsc4
         fS8utU/3gTJizGvvHQQXv2HZprPMdmbH+uSEoraLFLGnikYjr2CuKKJya+/Fc6bHy4m+
         UOTlfucM7hIL2Mxho8cJu8N4fM5DJjQ+8S92M8cfY4MYzx1aGvRP4OdJJFZ/Xc+71ako
         SDlQ==
X-Gm-Message-State: AOJu0Yw3MgeD5a8tdCgmSGFoENZ1543W9vFuNH6k6356tQFha58FPO6C
	ZLUL5GCDYLPK/gCpYWTUXzHKW10p4E6XdlSHjcorDKOM2ZV95Sga9JopdnuwFxI=
X-Google-Smtp-Source: AGHT+IGbQHDlO6Jy/xYSGiEtD0fGy9IlDo0xDLy8oCci62lxHIoe3G+0a1csHKqWGa38NhoeVuaDHw==
X-Received: by 2002:a05:6512:1092:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-5367fec5715mr1865133e87.14.1726241753647;
        Fri, 13 Sep 2024 08:35:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c6117asm881339766b.98.2024.09.13.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:35:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:35:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] earlycon: Print a notice when uartclk is unknown
Message-ID: <ZuRb130167L8bW40@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>

On Thu 2024-09-12 11:36:20, Raul E Rangel wrote:
> When trying to construct an earlycon=uart parameter it's hard to debug
> why it's not working.  In my specific case it was because the default
> uartclk earlycon assumes doesn't match my hardware. This change adds a
> notice so that the user is made aware of that this assumption is being
> made. This should hopefully lead to them adding a <uartclk> option to
> their earlycon parameter.
> 
> Booting with `console=uart,mmio32,0xfedc9000,115200n8`:
> [    0.000000] earlycon: uart: Unknown uartclk, assuming 1843200hz
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8')
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
