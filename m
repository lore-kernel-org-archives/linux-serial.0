Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F8384CCE
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673373; cv=none; b=aDhpo7I2LFA6l7r4paM+Mennd4ll6FFMtOfmDROeS1JqkEKv/V7ApO+GvX6iyjFz+cpZ2jFhiGHWoYwenpDr90n1aQ/2h9I4/GdqDn6nkhE4a1LS1abU9YU2eY9nrKuGLoMDrvJ0VhzgS50ZbVl0XiN0rwpH+qRAlTna0R39FLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673373; c=relaxed/simple;
	bh=vk3L6CjVb4k6Towa7TMZfKZLg9CLHT4UZOFuMeqp7DU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxo/4aSSyj5XlUVce80/in5oFCP4fG6OvhjSlPLM8Ux48LkuYzDjBi6HHwV/c+/U0TDQ1bKIVJxvmeqQFKWZgv9vJ7m0Sq1MDk/FHmEXhY9AJH54K15cWvBZvYWQ2XzKNF1vpjNdeO8dVebeAWIxupKYfK1c9+IipxICtWiQem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks2s3FvX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks2s3FvX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so667095f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673370; x=1784278170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CBpdXNjx5aPhmwL55Ue3+3hjUTkf4aoi2KLiHWPmg7c=;
        b=Ks2s3FvXlQCLv5yPeAROKx1JaAURwRMS1T0sQxL/Pc8SS/heWmaqbX8CwXcCsmUrac
         9FCNwqBCMQcopNmoC5MpTb8Nw0uO2iVtvN0pRqF5oL5upRRh4yjP2RoXZNKwQEDzcsME
         kvfHmxNEDoboU36TlGt/ov/bF0g5PAHsPCdvEdibl9k+jI0As5Ww0MfMCb0ttBIBG6pl
         YOuGmEtx6NyKmcHMn1LZc1RAdALLPrUom5HRDc7FqV/ExggppGfghVik9F/GHqXrpy9v
         WiyyOHe1dfJyT01Ag4b3y9p6zi3sJPLUlSS4RUeFyZDsX//cqf92iS5eosLkCDju1042
         hdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673370; x=1784278170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBpdXNjx5aPhmwL55Ue3+3hjUTkf4aoi2KLiHWPmg7c=;
        b=jDHWp3uuBQvPeqpQLhQ/zaXtFVt6GV6lZ3o+j/NHSZ5AC9n/JX/YYQoNM02GhahiCq
         hE7NlNbtwDIZ7rLTpgjKS7tBlYHsXFeTTaZQ7FdI2T33b2sjZUqImWuFHidlPdbkQ8LS
         vZOeldHmaC6HqyI5ZmfFg2rmDrwH7M5ph4m++NxFM3r5lby/NzD2nr0zVl5ckmNvmDa7
         pRFpH5hfXlLUWP6gv57cYZFMTOXurb4LMn07xPbd8RJi3bxObW85x/j1/BdSOGDafNFJ
         BjrD7ZN8kYL1f7f7glM+IoC4Czd3/b0gMPys0PMZI5f9aoAvkSml0HGSa36+UqJL0Xao
         gjbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtDYwxiKIuR3ZwvBbsja4Sr0OwHXQQpQm94HM49LUayOdbejraX+0eSvLeWvR0wM+Tl1OUKcPyDqXlS18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUx7Tz++kBM1CpYkJMBgeKnhbiRvoe1J/nEitap7dZ8EFxOa3
	fZbMoZ1l/0bqPXyTl9Ep2pMEEvH1b5XzJdCOpwM5Dnu1DTBe+VYJC/m/
X-Gm-Gg: AfdE7cnJ+JGb/vWx5nfQEPVY7X4ZHPgiIq93sOetpwSFRZOjAvwYeDI3sVrnxoHAqWa
	jq3Jl5fEHry46APs7MV5XkyAvWT9nYjNqggVx9pcqwomdACxEVpKHcHmqGKRMIfc+029fv/rMsV
	Esbmxnslr9pViTXTAC0eecFY58awreEceno5S0JBokkUpHz0b+SMTd6BjYjAUNshdFjqEyuucgk
	qeXomcWJttVebYiXbyi3iX1W+CDNxbfX6rINXgaWNcNIvP/kHk33BmE/3c5/9uanCM0pvEpWLUw
	45z6NqsZxkWdcNS5X18yJdJan/jGLxJQ+MPytN+hKqyXTNu0oc2fK8mV3AP3Bvo6pqoopSan8h2
	tKQyFbNEiJ1uDn7WNp777BDKUPg5hutFxAXxlkpKfGfY9L+JRqmEO9bBRAL2uQtVul1bxQcq88o
	gzQR1f13RDDrhBqhzEqG7P+IjHIwQAe1WGJAXIEj2IQfA7Mzb60uKRckwxCzFPMsk=
X-Received: by 2002:a5d:64c9:0:b0:47d:ee9d:90ce with SMTP id ffacd0b85a97d-47df074d3d5mr12379184f8f.4.1783673370055;
        Fri, 10 Jul 2026 01:49:30 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm57234697f8f.33.2026.07.10.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:49:29 -0700 (PDT)
Message-ID: <6a50b219.359f6b3d.bc30a.da0b@mx.google.com>
X-Google-Original-Message-ID: <alCyF_UEneO7czwe@Ansuel-XPS.>
Date: Fri, 10 Jul 2026 10:49:27 +0200
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
 <6a501516.a1b3dc3f.1e550b.96ea@mx.google.com>
 <alCrYPnk-0FmDnqw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alCrYPnk-0FmDnqw@ashevche-desk.local>

On Fri, Jul 10, 2026 at 11:20:48AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 11:39:32PM +0200, Christian Marangi wrote:
> > On Fri, Jul 10, 2026 at 12:35:02AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 09, 2026 at 10:56:50PM +0200, Christian Marangi wrote:
> > > > Some driver might need to access the current baud rate to correctly
> > > > configure it.
> > > > 
> > > > Export the serial8250_get_baud_rate() function to limit code duplication.
> > > 
> > > Why?
> > > 
> > > We have _get_divisor() / _set_divisor() for exactly that purpose, no?
> > 
> > I can only see set and I'm not following how that helps with any driver
> > that needs to get the baud_rate?
> 
> You operate on the divisor settings instead of baud rate. Otherwise, can
> you elaborate why no other (out of dozens!) driver needs this? What do
> you try to achieve with the baud rate settings exactly?
> 

Ok it wasn't easy to find but you were referring to the .set_divisor and
.get_divisor. Now it's clear. Yes I guess I can use them instead of
exporting this function.

Sorry for the noise and thanks for the suggestion! 

-- 
	Ansuel
