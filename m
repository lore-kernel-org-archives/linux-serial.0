Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12011727
	for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705788820; cv=none; b=ZtnlJ6iGOfZMng7WsyARARuLXTOdAsjdiEbRY0A9raQqgt8WCV4OQmNPZcNnznJKpwgZEP2bWYEoxD0WMYqjoYXOlfmLfWzjUcR8XummDTp2vY2aQGpYJ9/QerxOUNeDfnmMJMlVr8Y7pVihGa6zSWomCQV3LtKa1F5I45VyMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705788820; c=relaxed/simple;
	bh=ZHMR+5XerLJCoZTOTxNeT7Vw7g2HRHT67HjoyFsAUCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA5016nr2zQUYjEBNP4THJ4L5MnCNnQ0039okBk+v8ciofV2FoFhUSWgSqf/U0vsZHNw7hOsyz+zKSgm2GlgWuB8Wbh6BSRez0keqnZQQAkyZy0j9WFp8GHKMKzvaa6KNE8w683m69+37X0bJUdwJTHGMxzlWQO6/DCMRoazYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=f78BHlfw; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="f78BHlfw"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc36e501e1so1741434a34.1
        for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1705788817; x=1706393617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCsMBCsiSGEYdhWb4pKTfS9o7hsobCZRdvnKYXL6FjA=;
        b=f78BHlfwx4ciE74zWu07k4oNpMo6WNAR8oLeC+R6lPcUuI9CyZmNQhCN0wTmuCrRLP
         goQUw28XAAv3omcpOcR46MyMtmZMsF3P8VlQLv77+wvDIhnvdvTpPeyfmcJbcXdg+rt5
         hDLKiFRecxLnPwI/2fF/c+ad/z2KV7aLM44OhhypsPUM4d5lbF7Baz9trasnyPsgTnUr
         Zx6z5iRyukY73AE/o48QkNOvFS5T03MrcN3LZKXodtQFPjRdarWCDl3YMvyyd1EtQdbC
         HWEu6nLxzHFaUuoW4INr+GqdY39YMreWGAg5L5ARHZgkT8qxh7/prUwTA5liiOKQmZ8a
         KM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705788817; x=1706393617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCsMBCsiSGEYdhWb4pKTfS9o7hsobCZRdvnKYXL6FjA=;
        b=dpOFM2bVYKCebUKMTVetSCscXOhY6G1QPF9xDZOk6jfE21halpuOVvc8iZCGWx1UqV
         kuYYGHa7Uzt23za7gZbEzLmwOKkPeUMD6OHjfiUiNUpwjSVJikF9bLhSfvFDHcIN+NeF
         9mC68Hm1mahpA2TsCDvmoVRDy7ZeW4nh4KUTcfTW8DHdTFngu2sB0qQNdsMTNtq6qlvX
         r+yhI+KXEgidZY72vsHs0HywEa7ohvISSYtL2risqhp0MlmIqmWnvFdGPoWvTjp1eTpm
         Fef3DMojNbUrqnbRU5gOQKuSOu6QKv2rqOEmWlx2eXfsL+OJ2pnaKpoRAILswPsxhbiS
         kkWw==
X-Gm-Message-State: AOJu0YwDtmrt5rTdr8fQJvKQ9OLCsS3xNuem5vr2Ojlc5FvuGccYr7Eb
	QpNjMPof/1ld4R1Nfy6LIkdh0CTOXfAYzUASIX2og/jko4l+3yVm0HlnCSyH0jY=
X-Google-Smtp-Source: AGHT+IHclezDHr5Po7oPsdqD6Ci0Fveyq1eU80XMMb5dx1Y0zDdehL41aKdHTQ08xtK1nVChqZAbHQ==
X-Received: by 2002:a05:6830:1301:b0:6dc:386:a263 with SMTP id p1-20020a056830130100b006dc0386a263mr2795586otq.51.1705788817626;
        Sat, 20 Jan 2024 14:13:37 -0800 (PST)
Received: from localhost ([204.239.251.6])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78114000000b006dbd787aa8csm456086pfi.67.2024.01.20.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 14:13:37 -0800 (PST)
Date: Sun, 21 Jan 2024 11:13:36 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZaxFkPY3W/5SFwh6@fermat.nev>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZawT2Onn23CPMeWa@michael-VirtualBox>

On Sat, Jan 20, 2024 at 08:41:28PM +0200, Michael Zaidman wrote:
> Hi Daniel and Christina,
> 
> My concern with the implemented workaround is that sending a dummy report
> every 4.8 seconds eliminates the chip's power save mode functionality.
> 
> I did more testing and figured out that the baud rates 4800 and below work
> fine with power saving mode and do not require this workaround.
> 
> So, I modified the code, making it dependent on the baud rate in this commit:
> https://github.com/MichaelZaidman/hid-ft260/commit/b5a2ad68c7cebbaaba0aa1675ae376f2895e19aa
> 
> 
> Another improvement is not to activate the wakeup workaround if power
> saving mode is not enabled in EEPROM.
> https://github.com/MichaelZaidman/hid-ft260/commit/0a41f3f3a4c664edc3bb90718807f2e62fe6d375
> 
> For UART testing, I sent files via picocom opened on ttyUSB0 (ch340 USB
> dongle device) connected to ft260 UART, receiving and displaying the
> trafic in screen manager utility.
> 
> --Michael

Hi Michael,

That sounds like a good idea to me. Are you planning to submit your
improved version from here?

I don't have any FT260 hardware with me any more, so there's
unfortunately not much I can do now to help, aside from answering
questions.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
