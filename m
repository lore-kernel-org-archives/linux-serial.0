Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442C129A8E
	for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716142; cv=none; b=BetYL7KOL6Tbn8bxgYk/vbezQLjsNKRefjszcZlEVfN77U5sTCry1U+LlTxU+HXAEFt42Ymy1mNhzIU/gV8TBgm0xbfERUmWHdNIXp9j9YG53FFZ6AuySyqS+CmRYsQeyhibuz36v3hfAbojaOxJJkhwpiSyxlyuz5cH4u9P7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716142; c=relaxed/simple;
	bh=NRH9jlCuphogwPK1XWJDUDFj413S0dQjbvCphLCWsCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnoNJCc4O1BtDglTkfAW9ZuIULZdKShLfqdsWBiCmgYhljXSrJ3mlAM+aJJiobJeDiBy87uk+jTV4XL7sZQTziGSAil0d0Viv4wzEHm1JoUmU+K3ewWeyrmLh101cic7Sy2t9Ic8jdL4sX/alkHoZb7Rn8MO5cJ05x9BF/nbTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFfjOhoM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFfjOhoM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so5991627a12.2
        for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716139; x=1707320939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XdIyEIUkxiYphCM8+/xlxGph9vhGEv9KcLn14eQmZ8=;
        b=EFfjOhoMRLTJ+lybGwRJjNqccRsbDHrTtQbQMnGqS2sSP8pkh5Gjmk/lcRho3XHDYu
         e3AJQ9PtL8sYHlahlsmh3QBJ+TOPbJ1T7MrR7h6Ig8R4QRHslUVqjj6TUmcyWOnN8WEZ
         IRRh1wrdzaPmO6bs0naxg9PXDmkWQA6WW/Qs9EjCQk9F2cTKwsZsGur9yd1RHL/NMRgZ
         jlYuUfbl4UCP00llsdinwpDULoIgaZmjMpDO84b32VkG9W6LS5QuB1BZTUkWmbQ92hDU
         dfQ23ToSQbdUwBTSOCavgJtIMGZw8ZHYitlu4jwrRX0OPdkMOyuGbUIuPJbPndgF6Okw
         BVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716139; x=1707320939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XdIyEIUkxiYphCM8+/xlxGph9vhGEv9KcLn14eQmZ8=;
        b=BKwEOm3ebvzTYeDg7HCJbjzMD0T6dsWG+8Ki9aqixd7VeHBqsaSOYIqY7vyTnvgYwz
         mP+ueqmudoMnBdo0bjbGe9g2Q38cc/LM+2782lQ+x6he7fTh1Z+MWnjpigkVlUjcoK+I
         NymllAU0Gp6JbEMzW7sFKWvH++PmXwk08wJb1wZN5aJzZcT1uWut1H6okULNBzoDt3Ss
         ic5+4lejQU26Nt+JzUHz5FHcV4lLCPnzbxa2lyUtGJcU79v/EOmJLOkvpc0Y+Qo1Elxa
         pj+ZOtFitwm7nUq1rf4z1qFYQyVD/YrAQERcgSrXqJqsjEc5T25cDS9+sXpH122V+gJg
         Hk8w==
X-Gm-Message-State: AOJu0YyQy0Onw1PQgRfowWRjAgU5HmxqvED05yytPjpPQxpC6ib7mMZ/
	DK8f27ZEMXpgpRMoqTniDdOVpH6xAAezMOfy5wHt5bsHDhfs5H3L
X-Google-Smtp-Source: AGHT+IEaGVQW6CmJuEyHXPTbJhzakyX5D0eGBEPnZf8YmwBWA24D3kf7JCQ/cncJkDmJWovCTz3H8A==
X-Received: by 2002:a05:6402:268f:b0:55f:8d03:411c with SMTP id w15-20020a056402268f00b0055f8d03411cmr1530907edd.24.1706716138874;
        Wed, 31 Jan 2024 07:48:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAlEGPs3uZU+6IJmfZ7kS3b4muVbOpSVuX29ctblXcKLeaf5ggzu6j63VEbeJiBbD9btwGg3ro2LFkGdhjS2mWTF2ajA/u90STejIOzYlGkgDkTmcc4aVklhjMi88MqcdmfLPAdVC6xYsCLa+QEkFycLxerl6mUD2YYrhnLvqhmryTLjUttqZ2A23xqI6Gt2RB8RzDpI1ap5WKHPxbBsJkpmWXvDQ3RtbA50FPSeETp3dchNm9if972DH3yCBYIolS/z007s0OYdALTmtpHum970tBaBJjwxo=
Received: from m2 (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id u16-20020a056402111000b0055f0de1166csm2829803edv.26.2024.01.31.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:48:58 -0800 (PST)
Date: Wed, 31 Jan 2024 17:48:55 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>,
	Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <Zbpr531rSxCsDKck@m2>
References: <20231218093153.192268-1-contact@christina-quast.de>
 <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
 <ZazgFniD3qXGG1cY@michael-VirtualBox>
 <ZbbQNEC8pWlkshgN@m2>
 <ZbnoiUhM7sOt7/a6@fermat.nev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnoiUhM7sOt7/a6@fermat.nev>

On Wed, Jan 31, 2024 at 07:28:25PM +1300, Daniel Beer wrote:
> On Mon, Jan 29, 2024 at 12:07:48AM +0200, Michael Zaidman wrote:
> > I pushed changes into https://github.com/MichaelZaidman/hid-ft260/tree/uart
> > branch and would appreciate your review and feedback before preparing the
> > cumulative patch set.
> > 
> > I addressed the first FIXME. Please correct me if I did not get right what
> > you meant.
> > 
> > I am still doubting regarding the second FIXME. I see only three tty drivers
> > are using the kfifo_avail and kfifo_len to retrieve the write room and number
> > of chars in the buffer, and neither use locking. What was your concern?
> 
> I don't see anything obviously wrong, but I'm probably not the best
> person to be reviewing this -- Christina has spent the most time on it
> recently, and I think the FIXME comments are hers.
>
Thanks, Daniel, for your feedback.
I see, it's my mistake. I should have reached out to both of you.

I added multiple fine-grained commits to simplify the review.
Christina, can you clarify the FIXME issue and review the changes?

Thanks,
Michael

