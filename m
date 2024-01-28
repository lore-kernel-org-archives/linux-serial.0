Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6A3C461
	for <linux-serial@vger.kernel.org>; Sun, 28 Jan 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479674; cv=none; b=as3PFNgkU/v+hCC6kCQyGM3ZhaB8BlLOMztoihxuY9/gKm2IbhHVrFPfyvMa/ogs+sEEfcNdQJNE0ZTvOO/AQUzkDr7XXYtuPYNVp2d+zwHrSuL0Zh63o8SRCnHiwgQxZW5o/yDpbfq/0wobZzClEB9W1+TV3dc6x9Lk84RcBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479674; c=relaxed/simple;
	bh=rCNDRRXEqZueY57s99vP925GMUoPa5p7zHd3QEVCUHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL/K5rQRI3rFHFNVoEsWVN6Yyrir/QfmouTF0SoRDWSmU5x/T7i4Fx1Onjd1XPju6u/BgX7Xz9RPP+JXJEhDcBRjxDq2CZ5183hIFTcf2Jd0i5lVLDAstcB1qyTjo76xbUk9EgM1lwhikMj3AHewIIHIGm5oDcJu62homQgV/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyOE01ZZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyOE01ZZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ef207c654so7518535e9.1
        for <linux-serial@vger.kernel.org>; Sun, 28 Jan 2024 14:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706479671; x=1707084471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuSooUAImSbXKQ2M8/Cc6NUpzpC9/CKJHufhBTTE2/s=;
        b=VyOE01ZZomTb4TuV7ghC+OyDm5BWxpT6KMqdrY3A2aOCMmEBUz7ldGgQi6ZTue98fJ
         SCQCb4R9iAFvKFu4d7GgWjVoWY7/i54MgHoCAW1SNle6LIPLxe8FAuzExwSWpT2F15nR
         zpSNBuzRq+yu58tM+HmJo0EzbaPYg6OS5/9m7xTESviH6svMajFrul7kupGsbnlzKDC9
         gyJQcF4+N+cNtktD30Zx7Ej1ALJQg2DEdZWoiEvinkEW6ebe9bD8rmSkjFd3puVUySxn
         0AvcJodbwPbhc1L4eHRHGonFlDHgdJv+No6mSaXYe+AyJVg6MqnjOkpRIpx+gwfZHPCb
         k75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706479671; x=1707084471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuSooUAImSbXKQ2M8/Cc6NUpzpC9/CKJHufhBTTE2/s=;
        b=iu5pz4nqPEgroSiFXaUTyMv1VvwjFtG0K+W2WVCLwPyRBmepT1sWwVY5fzzikqzUSD
         zsJ3wd70whx/lQR699FMhXBwco+o3zvFXsNz1dAI5284B9g/jfOPvYpNXgqllaF0BQ27
         aFlYnTvelJ/101A6+dDbL+x2sR+ykjYikfL7rbf6r00NSTyjGynjSy9kkd6GYnId/qx1
         ZUHugkRej2mN1ZNyWPHCCqtkaNHcmqrbhGJgZwwXQPLfRZ+gnMnKtsMimvFCD1JQ3ZIK
         6VGlayIelryskoO82LaUIYtsH14rKUP6F64EmE0uPsuKDK8SWtm0fjtFWzYjgAXdFjQK
         DdkQ==
X-Gm-Message-State: AOJu0YwYvRRhUHf5nT4kh3I8e+iaH6sdnhxMHiWbDhXT6Yeumuz6qITy
	ejPuYLfYClNMOrRnKUXAM824MkPUeNms/Z5jt6VMXRdhXuAPTaCD
X-Google-Smtp-Source: AGHT+IHasUMe5IGXGgYFrJGryk573QpwxXhUajyN0Imm0UEZC1mu2rVxRCm4e+NwYB/la9AqJ2gTBg==
X-Received: by 2002:adf:a2de:0:b0:333:1cfc:27f6 with SMTP id t30-20020adfa2de000000b003331cfc27f6mr3641800wra.30.1706479670887;
        Sun, 28 Jan 2024 14:07:50 -0800 (PST)
Received: from m2 (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id bo2-20020a056000068200b003392295997dsm6439867wrb.25.2024.01.28.14.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:07:50 -0800 (PST)
Date: Mon, 29 Jan 2024 00:07:48 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZbbQNEC8pWlkshgN@m2>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
 <ZazgFniD3qXGG1cY@michael-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZazgFniD3qXGG1cY@michael-VirtualBox>

On Sun, Jan 21, 2024 at 11:12:54AM +0200, Michael Zaidman wrote:
> On Sun, Jan 21, 2024 at 11:13:36AM +1300, Daniel Beer wrote:
> > On Sat, Jan 20, 2024 at 08:41:28PM +0200, Michael Zaidman wrote:
> > > Hi Daniel and Christina,
> > > 
> > > My concern with the implemented workaround is that sending a dummy report
> > > every 4.8 seconds eliminates the chip's power save mode functionality.
> > > 
> > > I did more testing and figured out that the baud rates 4800 and below work
> > > fine with power saving mode and do not require this workaround.
> > > 
> > > So, I modified the code, making it dependent on the baud rate in this commit:
> > > https://github.com/MichaelZaidman/hid-ft260/commit/b5a2ad68c7cebbaaba0aa1675ae376f2895e19aa
> > > 
> > > 
> > > Another improvement is not to activate the wakeup workaround if power
> > > saving mode is not enabled in EEPROM.
> > > https://github.com/MichaelZaidman/hid-ft260/commit/0a41f3f3a4c664edc3bb90718807f2e62fe6d375
> > > 
> > > For UART testing, I sent files via picocom opened on ttyUSB0 (ch340 USB
> > > dongle device) connected to ft260 UART, receiving and displaying the
> > > trafic in screen manager utility.
> > > 
> > > --Michael
> > 
> > Hi Michael,
> > 
> > That sounds like a good idea to me. Are you planning to submit your
> > improved version from here?
> > 
> > I don't have any FT260 hardware with me any more, so there's
> > unfortunately not much I can do now to help, aside from answering
> > questions.
> > 
> > Cheers,
> > Daniel
> > 
> 
> Yeah, I mean to do more testing, and then I will submit a new patch set
> based on your work.
> 
> --Michael
>
Hi Daniel,

I pushed changes into https://github.com/MichaelZaidman/hid-ft260/tree/uart
branch and would appreciate your review and feedback before preparing the
cumulative patch set.

I addressed the first FIXME. Please correct me if I did not get right what
you meant.

I am still doubting regarding the second FIXME. I see only three tty drivers
are using the kfifo_avail and kfifo_len to retrieve the write room and number
of chars in the buffer, and neither use locking. What was your concern?

Thanks,
Michael

