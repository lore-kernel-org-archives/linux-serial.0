Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E6ECB
	for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705776095; cv=none; b=WJYNnBnIBdpkzpex8nmf7lIUTHyEuyY94ylsqCMq89mInaw22RekHnUnxiXFDaIy/NUVvB0QxzDu5PUu72KU/z/r6dE4jDgRoVaHlglQoOZImJf/4oB6OcPEG2cs9NPCydH5i2f0KxL7ILnENBJ9JpOqXtA7KQSbT24ddA/VMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705776095; c=relaxed/simple;
	bh=pCNXFJDw+kMG4RdJeYoiFOqaK0kVik4ESjZqMgT56g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjX2IVgtgpiAQ7Slsi15pY1lkk8rxxj9AJoVLrFDpev9AONxLQnGElNkRriuortOX4tzItWEkGhQZeMa/tVBET7+8rMhmwzjFaw4A3IQyOuuSXRELNoIMNbFBPUa247UkQn+TXW1TwtUuJTJTprSdExUwRStEBozFki/gqi6reA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwferSuZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwferSuZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ea948fdc6so1670095e9.0
        for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705776092; x=1706380892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83UxKqMAQ1ozIoLl440yCzrvBtkUAuVr6DwjSk+sFFQ=;
        b=AwferSuZrHYNsfQGhEmOMDj0dMnK6KUHqSpxtTHOAQmL/b+HjQrPLAUAq86BPqgmUc
         LNRDLWen9jIniQ0JIJ5kPa0X38Gwi2yuLMRVipRvhODbpog2rUKEJwPRO3H2UercyHVm
         KKlY+i8rjqrMXsr1QWsJ1oCpemGtvtcopIZ6mXN+ueNacC/S6U7K1xjeYWVoB77i+UKK
         3bKctPzmCk3ptIwOPQkQuclk7orKUuuCpzY14mL52v2eJUpwXWBuZM1wTYbb4BVka40n
         EyieWFz0WpsT0fqDT3BzkrbgC8zTtvMWvyUNHljztrffSXPuiIUySJtR5PqEZBPrphX2
         4yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705776092; x=1706380892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83UxKqMAQ1ozIoLl440yCzrvBtkUAuVr6DwjSk+sFFQ=;
        b=Profu0luG5pam4um4KNMR1oXiXxFuPvs+1kiQeaxgFUr+gofCPD5UEMH82y0em3Ki1
         vKYU+8KcnmwFLvS5MwJlpbuBVoGB8WzzOJeVVxa/yOUOy5B5WdwQRDqcCJp0ECB6ncfl
         SfNEbglSaBsulY0mS2t8MSWCxmKgvB/3ezDABALAb44XhD5FR+bSxkunfXJnhMmMdno0
         aGOhc1Ndb4OPNNzvUp4Q2kQ34tfTJ/0alwcMMmCe4CgphONWEEmqxgeZXcVhObu1T0xX
         YBVSB+VhV+CfKsiQL8iv9qwEaRHcQgG3XjHBaNX0eelk93IMNoRzmF3tLwrQHWLLWiU8
         HnQg==
X-Gm-Message-State: AOJu0YyP/ip2Aty5XPUMJrM3MOkwhyJWESQwYko6mflbn0usMcFQz3+N
	H9H1+wqg1oCK8cI6BI8PsfUvkK22WGHpFtqtuOpteb4IwEW4fc1j
X-Google-Smtp-Source: AGHT+IFlvCUC+IhQBqG5QDPmIld+6gi7Zf6ctcgNDttQxzOmlHJs2SYD9z+s069pfl7cHhflX9/YfQ==
X-Received: by 2002:a05:600c:5119:b0:40e:7e28:e5c8 with SMTP id o25-20020a05600c511900b0040e7e28e5c8mr996103wms.6.1705776091984;
        Sat, 20 Jan 2024 10:41:31 -0800 (PST)
Received: from michael-VirtualBox (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc346000000b0040d81ca11casm32506388wmj.28.2024.01.20.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 10:41:31 -0800 (PST)
Date: Sat, 20 Jan 2024 20:41:28 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZawT2Onn23CPMeWa@michael-VirtualBox>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zag78CurQQGSLDW3@michael-VirtualBox>

On Wed, Jan 17, 2024 at 10:43:28PM +0200, Michael Zaidman wrote:
> On Wed, Jan 17, 2024 at 10:43:31AM +1300, Daniel Beer wrote:
> > On Tue, Jan 16, 2024 at 11:34:32PM +0200, Michael Zaidman wrote:
> > > > +/* The FT260 has a "power saving mode" that causes the device to switch
> > > > + * to a 30 kHz oscillator if there's no activity for 5 seconds.
> > > > + * Unfortunately this mode can only be disabled by reprogramming
> > > > + * internal fuses, which requires an additional programming voltage.
> > > > + *
> > > > + * One effect of this mode is to cause data loss on a fast UART that
> > > > + * transmits after being idle for longer than 5 seconds. We work around
> > > > + * this by sending a dummy report at least once per 4 seconds if the
> > > > + * UART is in use.
> > > > + */
> > > 
> > > For I2C, we addressed a similar issue in
> > > https://lore.kernel.org/all/20221105211151.7094-8-michael.zaidman@gmail.com/
> 
> Link to the correct patch
> https://lore.kernel.org/all/20221105211151.7094-11-michael.zaidman@gmail.com/
> 
> > > commit. But we did it per IO synchronously when the distance between this and
> > > the previous IO exceeded 5 seconds. In this way, the chip can still sleep
> > > between the IOs. On the contrary, the suggested workaround prevents the chip
> > > from entering the power saving mode during active TTY sessions regardless of
> > > the traffic intensity on the UART bus.
> > > 
> > > I cannot reproduce the issue with 1K Tx bursts at 921600 baud rate sent every
> > > 10 seconds with the disabled chip wakeup workaround.
> > > 
> > > Can you guide me on how to reproduce the data loss you observed?
> > 
> > Hi Michael,
> > 
> > This was my comment originally. It's been a long time (at least a year),
> > but from memory I had an FT260 attached to a UART console on an MCU dev
> > kit, which would print messages at 115200.
> > 
> > If the MCU sat idle for more than 5 seconds and then printed a message,
> > the first few characters of the line would be missing in picocom. If the
> > MCU kept busy, printing more frequently than once every 5 seconds, the
> > problem did not occur.
> > 
> > Cheers,
> > Daniel
> > 
> 
> Hi Daniel,
> 
> Thanks for the clarification. It was not clear from the issue description
> in the commit whether it happens on the ft260 Tx or Rx line, and I assumed
> it is Tx. Also, the periodic dummy report workaround is not active in the
> submitted patch. I reproduced the issue on the Rx line. And confirm the
> workaround works as expected when enabled.
> 
> May I suggest modifying the description to clarify that the data loss
> happens on the Rx line and state that the current dummy report period is
> 4.8 seconds?
> 
> Also, please enable the reschedule_work flag in the ft260_uart_probe
> routine to activate the periodic dummy reports.
> 
> --Michael
>

Hi Daniel and Christina,

My concern with the implemented workaround is that sending a dummy report
every 4.8 seconds eliminates the chip's power save mode functionality.

I did more testing and figured out that the baud rates 4800 and below work
fine with power saving mode and do not require this workaround.

So, I modified the code, making it dependent on the baud rate in this commit:
https://github.com/MichaelZaidman/hid-ft260/commit/b5a2ad68c7cebbaaba0aa1675ae376f2895e19aa


Another improvement is not to activate the wakeup workaround if power
saving mode is not enabled in EEPROM.
https://github.com/MichaelZaidman/hid-ft260/commit/0a41f3f3a4c664edc3bb90718807f2e62fe6d375

For UART testing, I sent files via picocom opened on ttyUSB0 (ch340 USB
dongle device) connected to ft260 UART, receiving and displaying the
trafic in screen manager utility.

--Michael

