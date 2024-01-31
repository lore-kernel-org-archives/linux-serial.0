Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABC3EA98
	for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682513; cv=none; b=D5R4UY9NhM/WpS6xXkPvhP7X9b/d5qTAGGkkO/nI1Xt2DgVdnHakMdLQH1Qii4DBL/29gi4akVZkkzGVirW3aQGkUKH3HG5QXF7Ru+Jh+iAMUXb5Mzy+f9aSo8NSSbN3A2sYewc5e42NLvyJofTTm9u1AFcnGjPsmj9tvRIpxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682513; c=relaxed/simple;
	bh=oOxStrfxPFoHMy41Rf8hhLtBDJpQvZe3zSQEQfuK0Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu+2c8/NbHnhaEqxbgLfPutVZSbqQ4gJVI1zBirK1teQG9PxMh5wy0jv+FOqSExeIoawNuJgIUWURk4Ux3d61xmXiXh6zKOwAKPuuJQWjYd8+4QdUcLUAm+VlSbRFFOGX7+zpRCFqyOxoJ6w+E9+hvs81hyLIXPkV9NRHiwCTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=UfTeAyg2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="UfTeAyg2"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2903099b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 30 Jan 2024 22:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1706682510; x=1707287310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV+uSb1asv08PVn4YHkdmJwgL1YFwNhGiKKvBtmIrh4=;
        b=UfTeAyg2I7u7j2vFWBZtaxpw1D+l5lcpChuK/ChfHhpfI3nWEZv0ivBSXnLuUPBIw4
         xAfSA0gMsGknt3GhR2qPh+nd8hu7p8smuUzqdkrCU0rfcijkwyf07R2i+ov8kzI9NaWZ
         YWV2Z6RWdKEeIDywxf285/doJPXR1Fiyh3Dlt4YLOemwyPPXtGcvGvVczeV2UnD98iOL
         SIO5xIlMwsZYl2VsWcCKPX5pgO37ZBLFfynV2Lqw6S9w4uA7e9l0JKGoNs2+1lKtwwq8
         c85YTJ3RlaVxbfMStDFfLPa3J9LHt4EHM8nAkUo1Mgy8xsPJjlZIdlCE5F7A7JAAXwCD
         pnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706682510; x=1707287310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV+uSb1asv08PVn4YHkdmJwgL1YFwNhGiKKvBtmIrh4=;
        b=pqrpUGpFVxu+lFKHQs4d7P+we2ZmeTpcwK3Y5WP3tx9SY3YdAiLdC5bHFl3Y5myOO3
         +/0bjxOhvYMDyLGzmByrgCsjMv/fL+ZZ/7y47lPNdjorWWYB2Crqyq9StvsaPaXKubpS
         qV7VBCyjonddo+pPMpvHH6ot6B2FCwa9Y8rnBcEeydqD60W3GOEHqGVHVedl+4PIZwS3
         P554WzsaLacTjqFYqfo0LEMOgVpmoryLiPcUrjjstcC0E4oGm+j3nFxoq4OhYGt5lp9T
         EGa5W1ype4axtG2yR3lCbm5tuBmg6NZCdThTizWlyqj/1anH0D2JXJeXdkcvyGRnBw/e
         q4Mw==
X-Gm-Message-State: AOJu0YzY+REPIX29gJdbNAKzsaX+e/iisPEYPm7apR4u2WIx0RoM6BXa
	KVVncHBCVIc98imk6yOpV+w+ixO9QAR7/Yi6OIUeXoc8v0fzXlHAYtKcHAXPh8k=
X-Google-Smtp-Source: AGHT+IGwf4EENcb4ArU58Bb05I5SRXUDSjOe2oBJEfNDotC77+TZ9KCehqOG4Nen2U0l/m7IPAd++g==
X-Received: by 2002:a05:6808:611:b0:3be:b5f6:f354 with SMTP id y17-20020a056808061100b003beb5f6f354mr851267oih.13.1706682510242;
        Tue, 30 Jan 2024 22:28:30 -0800 (PST)
Received: from localhost ([2407:7000:825d:4900:3d80:aa52:cfc7:4e30])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm9375234pfl.122.2024.01.30.22.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:28:29 -0800 (PST)
Date: Wed, 31 Jan 2024 19:28:25 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZbnoiUhM7sOt7/a6@fermat.nev>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
 <ZazgFniD3qXGG1cY@michael-VirtualBox>
 <ZbbQNEC8pWlkshgN@m2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbQNEC8pWlkshgN@m2>

On Mon, Jan 29, 2024 at 12:07:48AM +0200, Michael Zaidman wrote:
> I pushed changes into https://github.com/MichaelZaidman/hid-ft260/tree/uart
> branch and would appreciate your review and feedback before preparing the
> cumulative patch set.
> 
> I addressed the first FIXME. Please correct me if I did not get right what
> you meant.
> 
> I am still doubting regarding the second FIXME. I see only three tty drivers
> are using the kfifo_avail and kfifo_len to retrieve the write room and number
> of chars in the buffer, and neither use locking. What was your concern?

Hi Michael,

I don't see anything obviously wrong, but I'm probably not the best
person to be reviewing this -- Christina has spent the most time on it
recently, and I think the FIXME comments are hers.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
