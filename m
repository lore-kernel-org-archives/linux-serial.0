Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE2125B0
	for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663954; cv=none; b=ao3faqVT1WNEFxzv4E1p0s0waKEd034jHC2tyrj64S0HAFNQU6xShdNWp/3maS/BNMt5kuu2sd88/VJZVB9YPGDGO9ZgTUya9PgpFljHnLJsc53TaPgnHQuRJIW8uQAYvrpXfs1pLFdiyMf1PMHhjdXeXg0kfdXlZTT8xlhoDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663954; c=relaxed/simple;
	bh=XkHvRIn9l8T02N+1IdFfX69n71P34OHEy6ZzjjC0NSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=gXP6MjUHhKUIkfZYEbrNsdASysf1Ws8PRukWs7ayMZhnUeI/ZNNGxX7YMKrl302bP+bQvP2KRH3UyesqC+KV0bEV1rcyyd/xmijP3pStZNVtR+PO3haXF8yVe+L28jygp9CAG7DX6TuoYW8A+Bpq9Nv7n2ePqaRcpKEc3ew7Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJqm+O3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJqm+O3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708663951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2a79SnguKy7LS5/McK8Bl18qsnHZ6N+ea/bVlJ73jc=;
	b=IJqm+O3NTp/xygN4ssLrnwTwvgcXaUl0om/4sLcAPFdk3zieWRdui8rH7msGKUmniUx9Zm
	PaGmDMzYIKsr4e3U7QeIGG5QA2GCLXawdrvsgpyGSc4Mr0rM7KzdjTEGm9oXvCGLFAHrw9
	OsxSdJaDSR7wAYE7LMFS6j0CRNawWwA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2rAtadi-MYSOKJI2rqrw9A-1; Thu, 22 Feb 2024 23:52:30 -0500
X-MC-Unique: 2rAtadi-MYSOKJI2rqrw9A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4297db4eba1so4446541cf.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 20:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663949; x=1709268749;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2a79SnguKy7LS5/McK8Bl18qsnHZ6N+ea/bVlJ73jc=;
        b=vcQLOjF0jyyJZfF9T5yrevpsY7Sa27v9/kHnQ2p4VEpZQo4eCrudWImdd62UN3ZFi9
         6zoBOjqLmO1js885FrfKCeO0qdI/7qdofk/nUSA5kHfCwxVvxJKdw84MEGCxLrybm+P+
         IMsnMKfLtpITjuiwXvxb6f1k+PY4Xxu2yHynTSZyddviWmDOYTUdtiG98yjjifijDHv2
         BwVXvqlvOIfYxlrtlCuOL/z7QkgsNRp2eTRCmCdYGOSC/m+puTcpVSjsHo+AyI7x0o6M
         5EoKVLxUCv9RngqTAUePRYm5fLlojamh6OzW6k/VgPdkBdYSpE5DatM4nTpjwTZSy67q
         EUsA==
X-Forwarded-Encrypted: i=1; AJvYcCUPKEVLC3NJi1jSQLO0+vgNLi3RThAJRNlvXU6SLmXh7n/wedxCvY9KIr0mUyea7RJIGFl8CLb0JFyr301dkUrUiuLKaGzWldeDnVg8
X-Gm-Message-State: AOJu0YwFqz1tloy6qXivQoZwOhAh+JpQoMdehCIqzLkp+HWGnqOYZlIa
	7+GHoijO7FH3Am+noUARqOlYs7wV3KOPmKrvQvOnOtyNtQZp6mbgSj3Ztz51bLpSz5hh90u8KTS
	3nw7mF79eZjsEEjOm64mLVOIlXvurfKGR7gEqRRBJ9DIE7GMwAJurgXdbQ5FCiA==
X-Received: by 2002:a05:622a:180d:b0:42d:c884:a8fd with SMTP id t13-20020a05622a180d00b0042dc884a8fdmr1352569qtc.21.1708663949068;
        Thu, 22 Feb 2024 20:52:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAYNmpNAPMHq9a3bKc8/5KZU5bBJoUez07kPRCSYkfORJyMPrsrissYELud8isvWNRNSwRuw==
X-Received: by 2002:a05:622a:180d:b0:42d:c884:a8fd with SMTP id t13-20020a05622a180d00b0042dc884a8fdmr1352559qtc.21.1708663948756;
        Thu, 22 Feb 2024 20:52:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:a28e:99bd:8c92:cf80:d1bd])
        by smtp.gmail.com with ESMTPSA id qn5-20020a056214570500b0068fbdafa771sm1585415qvb.5.2024.02.22.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:52:28 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Fri, 23 Feb 2024 01:52:22 -0300
Message-ID: <ZdgkhkOCGtfQbf8i@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <87bk89hhpm.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx> <87bk89hhpm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 21, 2024 at 06:04:21PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 16:41, Thomas Gleixner wrote:
> > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > But as I pointed out above the detection logic is flawed due to the
> > unconditional accumulation. Can you give the uncompiled below a test
> > ride with your scenario?
> 
> Bah. Ignore this. I misread the code completely. No idea where my brain
> was.
> 
> This thing triggers only when there are 100K interrupts and 99.9k of
> them unhandled. The 100k total resets the unhandled counts.
> 
> Though one thing which strikes me odd is that this actually triggers at
> all because it needs 99.9k unhandled out of 100k total. That means on
> average every thread handler invocation handles 1000 hardware interrupts
> in one go. Is that even realistic?

Yeap, it triggers pretty easily if you bring a vm with a serial console, 
and try to use it to work with something very verbose.

It was detected by someone trying to unpack a kernel source tarball.

Maybe this is an issue that only becomes reproducible for this and maybe a 
couple extra drivers, so the solution will only need to be implemented in 
those drivers when (if) this bug reproduces.

This being said, thank you for helping me improve my understandig of this 
piece of code. I will put some effort in trying to find a solution that 
works by changing generic-code only, but would like to understand if the 
current proposal is valid if I am unable to find any.

Thanks!
Leo


> 
> Thanks,
> 
>         tglx
> 
> 

