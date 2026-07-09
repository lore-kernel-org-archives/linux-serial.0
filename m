Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD93C1F47
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633178; cv=none; b=L6Gokeg+qT3txu4w46iJgJeK7h/Dz7PHnzkSNE/l9smaBnfmxn7qD+Kx7O9XfbZJhm7a3nT7+Z21p9uG7kvRFJxUNcCzKG5CSNjsHMZcA8KEAlG8NRVGPzjBoDtUtKc71y8Pb0mg5GYp4pGQTr2Q3I4NfD4Tzca64s4KIa5ecj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633178; c=relaxed/simple;
	bh=6c0ztSh4kFWOBjUZgNEWgv99q/eec7gYqYrL0SYwUQs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it53/WIj1VxGKiz4g9w1XecBOuCJv32MRM4kHWadUHNxUoZstgzde1Gcu+2ZZSMywc15z4pxcwCgcT5mCHNlnBvoeTsQInhCw2koc7XFc9KtXR1GNE+aHBmVQnKoD750+EOZeeKK3009IWQsYeKiOVZ8POr3M0Fv7KYwfs0vJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0TgKSYy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0TgKSYy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso2172625e9.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633175; x=1784237975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAJw6K50J77FfVX7dMPJivwZzxZEyfJ1nEYKMIYAq4Y=;
        b=Z0TgKSYypL5Mq+EE4q3qhSuATvlPSpLxHeJgRop5eDPl0ppaae8vv3q/v533IUk5Tg
         BaDJr9GZOTjONPfVL+btjkTVAGjkJakS9XOEJ1xFiTatOQjN7iAsVKfiXR5ZkIzHN7ix
         CurNlr1O10wmooiKKzs6ucbN6wi4K2NctmIkYff6oaoKdJStADuEqWkELifM/anQ7kR4
         iXmY+A1wpusq0mUd79axVfpeJSTWRfy2CswnEBjEZf3bnpGpjGqmfA+DoDPStjL/lO4s
         141rFR9ABSr/evm71Zfj5XBxlAJytSdnIH65yH561VTgFdaOajxJMGEwynvH+gDxD12s
         7cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633175; x=1784237975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAJw6K50J77FfVX7dMPJivwZzxZEyfJ1nEYKMIYAq4Y=;
        b=iOsnAiVK9SLFgNg/8Bk+KUEnptAlVyOkEHCMssJkmhoOsextd1U5ZkFZIU0hmpxCH/
         j8/hEdFJa7VFlenp7PSXJYvBw2R//MKGbS/suOoyPe9S5Q9C5SinzneltGSiBbmExP/6
         c6xnzK6RVFR1j/PIJViMoIyBVMf9qng4ISwHaWz9oC35OU7bHpDX34DmnVK17wJ1CTQ8
         r3T74cf6hJz1vTbiqQuXiJq0y0BTbSkqsOxT1FysSIPXwLwDWMSoV4EEitcIoNA8xFL8
         UDtCw2dV966nuCUJ8zKqzYDy0y8gFGqoy5uOrMf6Dbn+yPL80pth4tlTRT+t+GoSeqaY
         HwoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAcVk8zPkYZyk2cWnDufAcnYL2T9t5O0dlhLBo/fPbZdXrXpcEi9NHYc/jWOnikfFWRIMwdjiiI/3qzGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkdGVj8Rm/Z/nzEIMFH2lyB1BEPR3PNRKzWov6sqyd4KKs56o
	W40vpvRoV/wrCbAtGWb74xUJxUllQQ/PUtqXJNcIexw9mm4YJzwZKrTm
X-Gm-Gg: AfdE7cmUYOIp+qYlNmoIzo6JcEJWHAZxw86VoKvq/j5Qi93znboLucG4jEd03uIxquJ
	gHqgSsyH2F5qKgwwgxUhYfcAzsuwK/ETGZujnLosXNbehihdgX3ORo7F9cRNHKYCR/6+IMqZQ6m
	ZKJXMCO+JmUuu4b9mhB1AMA5nKmYyYkWCjvCC/YEBZSe2cHihnFv4ROMBJ5Ri6iNlkGXP4hipPF
	+avHeX5EPcr0hQeTdcoHVfyNY01MTxGHMa1rELnC8Go9/HMZrSCBk8lTpTUCrsXkhLuoxT0x6U4
	pnYDh3OW+PQSe0MEb/fEVdpJM8yet9GfAYXttNeebe9J/Wlkz+5nSOGH5kynaOxQQqH7qMYlVdH
	bQXNJNDX0vGBCKJIQHGvMk7TTxeg8ywMsDbnigbDcwcLqQb0264/B6/C4YXzZ35+CYK6Vr6+U2m
	rc/cn5wwfBscKM603lPDClH/mjDZTjyCvd9+HHvih3WEcBHybWabOefnvJSPcVT763s4rSo4ZG5
	A==
X-Received: by 2002:a05:600c:6286:b0:493:e53a:8982 with SMTP id 5b1f17b1804b1-493e68643ebmr86643555e9.23.1783633175375;
        Thu, 09 Jul 2026 14:39:35 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm79377825e9.9.2026.07.09.14.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:39:34 -0700 (PDT)
Message-ID: <6a501516.a1b3dc3f.1e550b.96ea@mx.google.com>
X-Google-Original-Message-ID: <alAVFHKwGQiTUNNr@Ansuel-XPS.>
Date: Thu, 9 Jul 2026 23:39:32 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] serial: 8250: export serial8250_get_baud_rate()
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-3-ansuelsmth@gmail.com>
 <alAT4QMOi8U2ITho@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alAT4QMOi8U2ITho@ashevche-desk.local>

On Fri, Jul 10, 2026 at 12:35:02AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 10:56:50PM +0200, Christian Marangi wrote:
> > Some driver might need to access the current baud rate to correctly
> > configure it.
> > 
> > Export the serial8250_get_baud_rate() function to limit code duplication.
> 
> Why?
> 
> We have _get_divisor() / _set_divisor() for exactly that purpose, no?
> 

I can only see set and I'm not following how that helps with any driver
that needs to get the baud_rate?

-- 
	Ansuel
