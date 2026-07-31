Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD432D8DB5
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503756; cv=none; b=Ydq2RZDTYwQVbBcbSvFxbins9e5xjrnDdmEUL6P5RDStGWZl4eLPP54nyTS8NBXLvQ8loOYrbGGsXkDO1oFTb8dJTNn7N7/tLTx97dilNrMXGJnThXG3hsKLWSzpzqoxaDmsuA9ta5nKlzPsVdqXXTcPKjlU934cOm5GKnBSgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503756; c=relaxed/simple;
	bh=d7I0OfFSwWSSx4AmcU0UYv4XKanrmpEM+OseCxiJO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMBrSjuabHt1uRRt1nksDNtUJuhq5KIT8xW358JcSfQfxj0tB0Z/YPyzo9y/d2ZU/LR38FKfDpX7RQIFkWgmlQr1l0I98EdeOa4u9cAuFjCRF8lnTRg8xy+8RFM3AF2dna7uvu/U495rmQG1S6reUABTL6G5Nd8U5JDcgbm3kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p96FcwKB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p96FcwKB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so123207566b.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785503753; x=1786108553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/RqXA7Mt1vKjaBPSGjfXVG5xDvHOpBaE00CsbEm2xEc=;
        b=p96FcwKBqPtIdeYGErzu8dJcSoGx7mCCpuO3cJlfM+8n5jcz/Tdx6Xf+bWh/4JEIgG
         7lNTkpTZXkRyBwnPJmTJRNP0MWh+3+SWnr/JK6OzWyJYQfD4t8ySvZkkoNqq+PIjNzOB
         BBNjY4RtYZq4ucTNxiHPDGEvm3Gst8rMHrOhrPiqQyPUAoVarPqKWrZyw03sUKSZMFNO
         jM7TsbKQ/JwuJt6/AdgahTK2xMxbCzLKfVKttGOMAvv6TmecXnTnd6mMLbzweXVrpTp/
         pQ/rxbfckKkeIcEMt7+4NWZ7irylsLq1doIR0lXdXTdbe3HJXEmd0zqNEK1RN9Ydx6iq
         NrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503753; x=1786108553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RqXA7Mt1vKjaBPSGjfXVG5xDvHOpBaE00CsbEm2xEc=;
        b=OU8eBYOz6/6qPTQu95MrMmgNkMBFc3POgiWIjO7fo4z0NvP7RfKkMyi5/fLdO3Hm7I
         GGeqCOMiDzu9K4HGI3x8/1Z0O7+RlyByTJNuAbg3BKvXJ/hw+577hNwdggJI0xxMHig7
         8jDo708kSyNhExUVmZyDt9YZ04Xwpribdt7eWSXUqmtXcosAPMdhHV91ScraeVmCitnE
         ezgWX4H618mTXvGgUx3l8uuyZxHcLsG2kA7mv9xCwvlHaGNdrRlhr97Wu/vN9dgadVYZ
         LwFX/W3vyrXiJiTPF2gu0fVF1bdWthI8TCLevDDh0pGwTRFUFl3iNueq7/CyhCN1OcPw
         hmCw==
X-Forwarded-Encrypted: i=1; AHgh+RpGuTHu675/vhEQEG2kfAxvcKEFJyA5tBzv+d/K4A3sk/z8ssBUXYKVubPTe/4JNd/o/BHdxa5BsxjRUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1usemaWFAOIDFdpeuN1YnM69+TeJdi0mGnpoZzChnQCRQ54Iv
	xhnU0RChB4v0K2oR6pSJnL7GBCeVT7JSkxXsfCdDjG/UABaECDDv3EZq
X-Gm-Gg: AR+sD12eq1+1dybCno6FvfJlSjbX1FTiEg9kdJtn+vR/eRd41IYRtqnPRSHm+h6G9IC
	+N9V84D2ze6V7rGi9N7BPi6MmVfRXqtG2onrFycTJ/uf9qaFZom3pTzUIoDI6BHjhJtOxCr6qY+
	+vA5fXuZyd6ZVYst65YjrXVbx7GC7Yolnf6BolxhHiz0Ojokn0PvcaLXThnvG9k0gFCO8NCCdcV
	WFELl0BNOMRfWOTaO0kmrUxS8Xvg64QT+SbF94SxkltCWZ2KNKNkI68XV+4wAQ7mwCH569WfQFF
	d6fu7eFpb17SFMdGrIdrNu63nhevIJaRkwm9M5Gw4+NM0b2/+UdPHOBFOPGo1QghXmfM7XiG1xw
	QekwpYzfadYSFmS56CMtcb0IDESTvG7k4V/vawPqX420RjcUZ1WrmXWY60StOUIrjX2IDAYPqyN
	4rGle4sq0uzNJOiNvu/y3925JzFdxQbt+v6MHxhhlpzHW5RGCMExd5NwEzKb9J1DHl9N/avF/Tc
	68JAHPHOWUGYf7rBciKT+pYG+rBs5rzxQB7sWes4RZyUl/yPbt8r+ySzSumeZwStF66//XBb6ab
	wGyc+xRAf0ysFaBMVWrri4CsWn8yS7rysaDJZjORPjBO37ELG8nZOMI6Bh9OU8BthJbu6JE=
X-Received: by 2002:a17:906:f58c:b0:c15:ff7b:ad69 with SMTP id a640c23a62f3a-c1fd21c3288mr110230166b.34.1785503753032;
        Fri, 31 Jul 2026 06:15:53 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fdfd6c57bsm89659166b.17.2026.07.31.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:15:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:15:50 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tty: don't oops in tty_unregister_device() when
 no cdev is registered
Message-ID: <amyejjYlqV88zhT2@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-4-kmehltretter@gmail.com>
 <2026073057-moustache-unfixable-5ab1@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073057-moustache-unfixable-5ab1@gregkh>

On Thu, Jul 30, 2026 at 04:29:57PM +0100, Greg Kroah-Hartman wrote:
> Note, LLMs love to write a lot.  Please always rewrite the changelog
> text to be sane and concise.
> 

Understood. I'll clean it up more.

> This looks to be doing 2 different things in one patch, or am I
> confused?
> 

Good point. I'll split it into two for v3, with corresponding Fixes: tags.

Thanks,
Karl
