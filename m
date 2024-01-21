Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B201E4A0
	for <linux-serial@vger.kernel.org>; Sun, 21 Jan 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705828381; cv=none; b=fffYdxuQhai/FxrRoizzbCQIgftw8i61JNgnwW/+Za2C5jJ67XTmBH2oSkW0qBMcS2TGafTlaY9I297aY4OHSr5cGLZnWb8InZbsaUVCH0GF3GYm5oe25258UwIsn1Eu7iaBMVdUtOxv3WoUkbjJOzMlFQjgt+/HwH6q6A0yeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705828381; c=relaxed/simple;
	bh=+Xbwr4+yZ+GFrDc+qIM0mJ/iSSoEtR4XbgRy5Q03mYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVNREvGAM7GLystdyRZo4oYcZ1OPZmzqalgewOoHdq8rjdiXoCN1RbiRcoD5RqV5jwLc9V9HEQ07RDoK4/aXmLa8f1R9xg94UfIaB4XG0SsYnFHnqA32J8/+UczSwrJA/lLAArAnDgcnKB3oATOwRvBjsv0yBrx49ZEoV5+b2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzNmBU/W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzNmBU/W"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d58942c9so2343646f8f.0
        for <linux-serial@vger.kernel.org>; Sun, 21 Jan 2024 01:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705828377; x=1706433177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBRgDi/Q0wscxxf4KQhlNwXoUW1geChaXzYMnAbFhSk=;
        b=RzNmBU/WxFhA9amUwTYuCHvo7YQEKjL46ZSY7iHW9D0T8CVoAW3sZdqL3mRtyWPTvi
         SUsn/9BfrS0bLxoXy1PU0OTISJHmv9Zg6m30iv5XZCGgEig9m9FAjgoRGlPnL8NVmYQ8
         T9dy7vVkuFxy6IfPR3wS+0ZDYDWHDS2x5k0YHxWQ/Fxq45W6GSkWPV0ITk+4EdOxmmZN
         FbyjlOpyaDcbQKZKGbSbK+JvTtiJisSb06xL1Ii2qwH+yojWkJEPpz0LpPCzyoJDphzM
         0M+yEymc59bA7huiPiyt3M+g+Kxngxl8q38IvqngF+4fEXJwiTNWY2vVaNhDUmJ/kutF
         tZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705828377; x=1706433177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBRgDi/Q0wscxxf4KQhlNwXoUW1geChaXzYMnAbFhSk=;
        b=YBESm/eTRfFTsf4NHsoZDq0D3wAZol71xn7AaB6CdWjomZXqEdOg2d25wwjuUNEDwK
         BNo5LwciZSNpXu2DqI7lOML48bJF3dpfSQfF9ms0R1FBJIzKWo8Jgi14QLwlFB7cNjDx
         U86441nQYra4kxAVmpefjQCJBhsd7K8w/z0GalvlwthNBfJ8XMjRbP1RFQvxnuyPoeKs
         C08QMltiRZLOEjaE908Dt4aJCjX8lPBNejpPKtrB4HzQ5RiT+8jn8Qgm+M9cs0XXyRAN
         kEq3wjr3LLlIWvgYHHjQY/Ov/gz197ZSHag1Uq7Hgs1CVafWqVYWAOmn6phYLXGLGx35
         UaRA==
X-Gm-Message-State: AOJu0YwMnMc0FPvmQFILnXTw30yFR4L/n/RuQKhy94hhHI72st0v5IsQ
	jxhEEIOFHC8QuGTMh1alNj8VaUfj56qDsDADbt8kHxiLWe4A02s2
X-Google-Smtp-Source: AGHT+IGrnPhjaJeNXpTLuRHYKCqYhM+1uZs5Tdq3bZ3GCJngOcFpNzv33jsmN5aG1YLMx3//8MWrkQ==
X-Received: by 2002:a05:600c:470a:b0:40e:6650:b883 with SMTP id v10-20020a05600c470a00b0040e6650b883mr1279603wmo.18.1705828377521;
        Sun, 21 Jan 2024 01:12:57 -0800 (PST)
Received: from michael-VirtualBox (genie03-172-158.inter.net.il. [213.8.172.158])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0040e54f15d3dsm38831520wms.31.2024.01.21.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 01:12:57 -0800 (PST)
Date: Sun, 21 Jan 2024 11:12:54 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZazgFniD3qXGG1cY@michael-VirtualBox>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaxFkPY3W/5SFwh6@fermat.nev>

On Sun, Jan 21, 2024 at 11:13:36AM +1300, Daniel Beer wrote:
> On Sat, Jan 20, 2024 at 08:41:28PM +0200, Michael Zaidman wrote:
> > Hi Daniel and Christina,
> > 
> > My concern with the implemented workaround is that sending a dummy report
> > every 4.8 seconds eliminates the chip's power save mode functionality.
> > 
> > I did more testing and figured out that the baud rates 4800 and below work
> > fine with power saving mode and do not require this workaround.
> > 
> > So, I modified the code, making it dependent on the baud rate in this commit:
> > https://github.com/MichaelZaidman/hid-ft260/commit/b5a2ad68c7cebbaaba0aa1675ae376f2895e19aa
> > 
> > 
> > Another improvement is not to activate the wakeup workaround if power
> > saving mode is not enabled in EEPROM.
> > https://github.com/MichaelZaidman/hid-ft260/commit/0a41f3f3a4c664edc3bb90718807f2e62fe6d375
> > 
> > For UART testing, I sent files via picocom opened on ttyUSB0 (ch340 USB
> > dongle device) connected to ft260 UART, receiving and displaying the
> > trafic in screen manager utility.
> > 
> > --Michael
> 
> Hi Michael,
> 
> That sounds like a good idea to me. Are you planning to submit your
> improved version from here?
> 
> I don't have any FT260 hardware with me any more, so there's
> unfortunately not much I can do now to help, aside from answering
> questions.
> 
> Cheers,
> Daniel
> 

Yeah, I mean to do more testing, and then I will submit a new patch set
based on your work.

--Michael

