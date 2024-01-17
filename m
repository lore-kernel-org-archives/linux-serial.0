Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594F250E8
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524214; cv=none; b=g0k11lN8mYkrMG7P9vC5oRppCtZLkZjM1s4HfpLJ/ZiQS3TvVRbdVMA0BPF7LXaTjAzHeYbVDWGbYsjJQCBdQRiewTOU0kt7BEWUyQ7xlTgri406C6FBhOxjaQ9zLvH1UPdYiRWGg98T5fe2PwHidFzMRB2Hbs0/35dKzXSj7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524214; c=relaxed/simple;
	bh=N4EwdcSxODjI8QN4O+6xcd/k09P+1oLsv51qTa6fgvg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vFfNpUdsNOODIOPOKGC9pLjLtVcSGN1jQDdUeE7gsvUxPfje/C/7wwyuuugmVwSO5Gxvh97HfsPT/+J4VmoGQuVtXZ65mN1Posups1OWe8pkZPVV0JqS350pDMLhndsduYVHxq1S1Jgs4373ZH+FS62buiAt/9O/0Anr5C9szKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLhPKT4E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLhPKT4E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso39474975e9.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705524211; x=1706129011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iab4ftx1ZjXF0rF6AlFMHFeyFjWu5xoaOwUNtGpJG8=;
        b=mLhPKT4EORHTshh2PoXk9uvt5FxOcoEi9gOTIhfdki42dw6WvM+zBsQRM/lNUoM+BA
         JepThZHXmLCGSzDvg/PIeQAqZ77O22tufxSSv5qWrDcgckIPFcwu26rERNHRrYn9nCsj
         ACnhVpwB1La54Q4rqTjeSD3Z5peQNiECG7z2A5XEhRDvW/oHsn31h3n3wMEJABbsEZvI
         ZEJWpI+5X2kUyRH8NQEFfDu22/OPBr7gx+0H9VNGz+OKjTi566v/qjclnhP2rY/SZuqP
         /vgGQ/+6AkCiRXqixa56rPGrs9tfOFhyEJhqSD+x7Y3LwdJAXLwppwwFpNi5+nH7myv7
         WcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524211; x=1706129011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iab4ftx1ZjXF0rF6AlFMHFeyFjWu5xoaOwUNtGpJG8=;
        b=gzGa/0y5D/WjmB2NlAMmPcc85nKfR9VW04lmDUso4XJXRZOL/txTg82lQDdIcOK04v
         cQDQ5pFpw1G3CJ8IkWBPWKFGW88PiUWhjD6HEuXaT5Mpr08D2kZGiYWFsBhcb5h6/YL5
         KcQZc+sxiNV/F7wWWGSsSK9V7uBr+viAkTUN/KR4NWGJ2YRm1egbkD22E/4hDnK4R5AO
         NW9EPIchZwd7BTB5fKbPf05PVKfP8r5qeibc8rSNk2OFh00X8mOwi4JBnCAllF8vHk6D
         eHr76vNbhychp3E/jN0dmulSmmK8xRT5wXhgST73YCijpID/61kG/LtOyYiFzKoF7HQz
         gOgQ==
X-Gm-Message-State: AOJu0Yw1kmbcRGlJ13r4zGWPxIQ1WGJx41cyK1uJpg5OCl9DlyLuhX2s
	GRpnGgK3kgVdPzZwMBWBb30=
X-Google-Smtp-Source: AGHT+IHwfTN0rB7QvVjSyZ3js/htN3txjzGDfz+0L/bgkhZKV+w9cpxc0XBTrWCBb+LPx9h5Yd2uuQ==
X-Received: by 2002:a7b:cd8c:0:b0:40e:5afc:19b8 with SMTP id y12-20020a7bcd8c000000b0040e5afc19b8mr2644774wmj.245.1705524210880;
        Wed, 17 Jan 2024 12:43:30 -0800 (PST)
Received: from michael-VirtualBox (89-139-16-170.bb.netvision.net.il. [89.139.16.170])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm23720242wmg.39.2024.01.17.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:43:30 -0800 (PST)
Date: Wed, 17 Jan 2024 22:43:28 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <Zag78CurQQGSLDW3@michael-VirtualBox>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zab4g5PnwcaferE9@fermat.nev>

On Wed, Jan 17, 2024 at 10:43:31AM +1300, Daniel Beer wrote:
> On Tue, Jan 16, 2024 at 11:34:32PM +0200, Michael Zaidman wrote:
> > > +/* The FT260 has a "power saving mode" that causes the device to switch
> > > + * to a 30 kHz oscillator if there's no activity for 5 seconds.
> > > + * Unfortunately this mode can only be disabled by reprogramming
> > > + * internal fuses, which requires an additional programming voltage.
> > > + *
> > > + * One effect of this mode is to cause data loss on a fast UART that
> > > + * transmits after being idle for longer than 5 seconds. We work around
> > > + * this by sending a dummy report at least once per 4 seconds if the
> > > + * UART is in use.
> > > + */
> > 
> > For I2C, we addressed a similar issue in
> > https://lore.kernel.org/all/20221105211151.7094-8-michael.zaidman@gmail.com/

Link to the correct patch
https://lore.kernel.org/all/20221105211151.7094-11-michael.zaidman@gmail.com/

> > commit. But we did it per IO synchronously when the distance between this and
> > the previous IO exceeded 5 seconds. In this way, the chip can still sleep
> > between the IOs. On the contrary, the suggested workaround prevents the chip
> > from entering the power saving mode during active TTY sessions regardless of
> > the traffic intensity on the UART bus.
> > 
> > I cannot reproduce the issue with 1K Tx bursts at 921600 baud rate sent every
> > 10 seconds with the disabled chip wakeup workaround.
> > 
> > Can you guide me on how to reproduce the data loss you observed?
> 
> Hi Michael,
> 
> This was my comment originally. It's been a long time (at least a year),
> but from memory I had an FT260 attached to a UART console on an MCU dev
> kit, which would print messages at 115200.
> 
> If the MCU sat idle for more than 5 seconds and then printed a message,
> the first few characters of the line would be missing in picocom. If the
> MCU kept busy, printing more frequently than once every 5 seconds, the
> problem did not occur.
> 
> Cheers,
> Daniel
> 

Hi Daniel,

Thanks for the clarification. It was not clear from the issue description
in the commit whether it happens on the ft260 Tx or Rx line, and I assumed
it is Tx. Also, the periodic dummy report workaround is not active in the
submitted patch. I reproduced the issue on the Rx line. And confirm the
workaround works as expected when enabled.

May I suggest modifying the description to clarify that the data loss
happens on the Rx line and state that the current dummy report period is
4.8 seconds?

Also, please enable the reschedule_work flag in the ft260_uart_probe
routine to activate the periodic dummy reports.

--Michael

