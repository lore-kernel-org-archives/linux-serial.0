Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E71D6A9
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441418; cv=none; b=uI59uiJAB65KqloaT2h1tWD/V0l/EzNA8yviPRQwvBjeLPZ9ijvydAxZWx7SWoLr2QgaO90TBGT9vKqssuTlyqDoGRdUG1Sy1ybjPoBcQRffpmtnaJA9RVC6NTgheWCcDEouBxoZg7BkkglF2/JNCuT2f0KLseyFP0vuxonimAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441418; c=relaxed/simple;
	bh=o9XFtQOEjYvRP73yfCa2il38wkCetpUtwIgfszmFBPc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mUPm8qiZEp9YE4e1zxpJDaTkCpPBnjFt4Jctp50bH73xFbDred0fKToFTSC7V3ZsAzaRBC3js3xydzfBrwcEXTnnE1xiJejRtDchyA01oER9mBPYBOZPuqQ2XoFJ5M6bHta+TdAs4DdCdZ3jNqzwATEjdOeAk7swO9a2IUmFg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=tLh6qasn; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="tLh6qasn"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595b208a050so6305519eaf.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 13:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1705441415; x=1706046215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfql2FsDnqGWt+YbPZhJbcO0PxGhVQAdILloMiUqdtI=;
        b=tLh6qasnsAvx4fIp1Ej257LkIrj4AJ3x/LPaPThQPk1se9qKz5oQsKITSxWobBFxB3
         Z4Dvq/xN0YC7QBw0xVoo40zJwWzCyOUV3BcLij5MDyZBg3d0skDiADyvPQ0hfbjR4PZA
         tpXMvUU8DRm8IY4/GqujLKCylzYnGMRzeNalRehTJ+WhbJz/GMEH+TSiQkGbFSFn8RUK
         cF9gdgBqCDhElNw8mqIynPTkdtk0CXvqJjW7mp2osap/h0/JJY0c90ObS8vICVAQNi7V
         Bma02tiVRZtZSw1lThkOWLT1X9G5b7/S5vhHpxuxQbIavBnQFF4jhae2S9GVH6Se01be
         0P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441415; x=1706046215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfql2FsDnqGWt+YbPZhJbcO0PxGhVQAdILloMiUqdtI=;
        b=qUHzJrZO4HYv12UarginCrwmXgrBqHToltQPD41xmayvy2A6iRcyO0zE6c+aetAsXH
         mZS2Y80v4/8qOMaZD3GqBBPdvWHsT1Qi93Inen78JtQ/3hdsuOXfHsmnwoux8xUAr4mJ
         /rxKELoDToA/DOnltqMbcPm9SJ3ei/NVLNN19AAyvz/LsDpJsaKi06+pP+BT69wNgTJq
         Ypb3s28/zPfrp3OIC7SJi4NSdZTt786TBOsqVr+ZXTNQIQMFMvZ2DOesQx2a3f0MA96Q
         r4O14/BPH1p4YIacp2MwGN8dXSJYVF0QB3IIN4K49ojVwZSOkU9bqvIz4j8WimKtE3Fo
         0+4g==
X-Gm-Message-State: AOJu0YwZZrOAhiAMs1wAbxfS7LWvDd3Y3pwkULy7IdegOjCCCn0YIHcw
	LUbeMFMfnY2QXiMb3f7+PPwZ3jLBvgJFug==
X-Google-Smtp-Source: AGHT+IF7FZMfOFBU1ce5uKTt/7OUwHJmVSAyBUkXwMdYWyIfvrWJr22qQcaoitzebML+UOVFLp0juQ==
X-Received: by 2002:a05:6359:2884:b0:175:cf0c:a6cf with SMTP id qa4-20020a056359288400b00175cf0ca6cfmr4095786rwb.29.1705441415557;
        Tue, 16 Jan 2024 13:43:35 -0800 (PST)
Received: from localhost ([2407:7000:825d:4900:3d80:aa52:cfc7:4e30])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7864e000000b006d93afd243asm55744pfo.72.2024.01.16.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:43:35 -0800 (PST)
Date: Wed, 17 Jan 2024 10:43:31 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <Zab4g5PnwcaferE9@fermat.nev>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zab2aFMlu6ww2jey@michael-VirtualBox>

On Tue, Jan 16, 2024 at 11:34:32PM +0200, Michael Zaidman wrote:
> > +/* The FT260 has a "power saving mode" that causes the device to switch
> > + * to a 30 kHz oscillator if there's no activity for 5 seconds.
> > + * Unfortunately this mode can only be disabled by reprogramming
> > + * internal fuses, which requires an additional programming voltage.
> > + *
> > + * One effect of this mode is to cause data loss on a fast UART that
> > + * transmits after being idle for longer than 5 seconds. We work around
> > + * this by sending a dummy report at least once per 4 seconds if the
> > + * UART is in use.
> > + */
> 
> For I2C, we addressed a similar issue in
> https://lore.kernel.org/all/20221105211151.7094-8-michael.zaidman@gmail.com/
> commit. But we did it per IO synchronously when the distance between this and
> the previous IO exceeded 5 seconds. In this way, the chip can still sleep
> between the IOs. On the contrary, the suggested workaround prevents the chip
> from entering the power saving mode during active TTY sessions regardless of
> the traffic intensity on the UART bus.
> 
> I cannot reproduce the issue with 1K Tx bursts at 921600 baud rate sent every
> 10 seconds with the disabled chip wakeup workaround.
> 
> Can you guide me on how to reproduce the data loss you observed?

Hi Michael,

This was my comment originally. It's been a long time (at least a year),
but from memory I had an FT260 attached to a UART console on an MCU dev
kit, which would print messages at 115200.

If the MCU sat idle for more than 5 seconds and then printed a message,
the first few characters of the line would be missing in picocom. If the
MCU kept busy, printing more frequently than once every 5 seconds, the
problem did not occur.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
