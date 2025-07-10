Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1538274FE8;
	Thu, 10 Jul 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168651; cv=none; b=G2PFDtMDmHIGWgjyqpYnW8jSas+YvFJdq/QIKIlgXW6nQwmyNLL9K2Lgo1VqFXInGw0/rMZc90tdUjJJbma71Ia58s+8WNrDzvs9LTBQzHVyAea6gXZ2/0ZIlr/HN9uYTM6m+i5Os2hF+ypgxNrv412NtrrqtIVgzml1yg3GwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168651; c=relaxed/simple;
	bh=aYGG3JC1rihltD2ay4sWRXTTZkljkpO+fxQvhPU8xek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpzq7o/lCgH0efz1KzEfrNvQ8nfTkxboOxbJ188uFlUqyTw9FqcSfqGoJKxo039w/nT2hJFvizpeYbIaAnH+TTG346oWeCY8Sx8HpuHLao3vmA00QhlRGNDq4eAY4h5FCzKJuxOHqdB//6OdU062B2YN1bicX9MZxtolvfS49Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso210627566b.3;
        Thu, 10 Jul 2025 10:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168648; x=1752773448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5MFFBUYpLJN0PCMiBmsLfiSJha8AQz1cUcW2BMgMck=;
        b=KeqTM4ryosNrFD9DrbomVn7sKl8zRM7ZgDdOu/q3CsElRg3xKThGzVOgx1nDdj172+
         cwidr8ACYhl08nnqjeUrOIGiG5+VMGk95uQrYt2Akp0Q4tbsqVz9AiaOb8e+1WYEp2iG
         yXGw3XU7zw2kQLs1KDhPxJ1a77Ddjs8rbrrHqPqvUinqKH90pcXUrxjPvZaJoC/jYrok
         E5a1tlvQjkaLMLPjkUuqibztYrZSXdhaZkQXZMwcrypMNZcBCAQZPmSRJT6WseQeqOZc
         PCkp1290c5592aAN25hAO33/kQ8+DaWC5Rf95j2CENRXbkwfUnNUs71kSsv8tKN+QwUv
         IXVw==
X-Forwarded-Encrypted: i=1; AJvYcCU1RkIkzxL3qOwL+BZXCQKbOJTyqVaxw6rD6bOtsB022PjA9+7StyvNd1fNiVdhKLr0Lr+V4Mw0HxMKTmnN@vger.kernel.org, AJvYcCXLX+b5NXcDJMXjzfhpyH/JhCwTInkDENoAsuohrRkBgCDxH5q21SjB1kgk49IC0MpkXK4sresNBGz0Ysw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ecibsfW9W83VmcAcrMbGudZHToZJMUFwkMZ6r58bBB631jbx
	CEE7eJx/4Kb14yrUrQ9I1wE2Y6M7YzJxoEqfnVRuufiVcy1QzH3MJp8m
X-Gm-Gg: ASbGnct/PJIP1cQrreXX2BML8kWPY75QnRa3adi0lpoovg8qtsgQMexOhGgNsPajL0O
	CWb0IRRG4TRwtfmmLpAMQFOtNENh5b7mfstyfqz+ZKPp2MfpWGfXTZeXjTs16db0xfstYeWYsG6
	gvrfsonGlk/mUrquFBSMyN1YXfPdaxDasM8cE+Lc0+Jtmrv+VtPnUL3K1MAAS0jQKaf4BNvyn7o
	lpACmV6vv/8PHTXiUnT8z9MSx95k8YED4dVWWIiIlY7R36uTcXCqPrxw4SBFhw5NgLfN3jx6zhB
	DUlyE6eAXxHkOVJpT3DH4FSDpQ9b+SK1OiiX5TZc/kvSTS94o4uL
X-Google-Smtp-Source: AGHT+IE5r6DnY7Tz1x439NPiOFJH4b7xvN0OOgVA3uf34Ibu4HbS6dNTxi9HGTXJM+tj41v+FgbdjQ==
X-Received: by 2002:a17:907:78c:b0:ae0:cae0:cb35 with SMTP id a640c23a62f3a-ae6fbf72e6amr9742666b.37.1752168647780;
        Thu, 10 Jul 2025 10:30:47 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee47a2sm166404766b.58.2025.07.10.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:30:47 -0700 (PDT)
Date: Thu, 10 Jul 2025 10:30:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com, 
	bwicaksono@nvidia.com, rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com, 
	linux-serial@vger.kernel.org, rmikey@meta.com, linux-arm-kernel@lists.infradead.org, 
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <jlhgtwkeezoca34wbqipvsgr4muxov5wmgrswleo2k7zqitzfr@4ngriyb2udra>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
 <aG0kYjl/sphGqd4r@gmail.com>
 <juiog3337iozva23zpf4apdydegj4z7jibqykfvcgnkabemw4w@z5g5hhwrqr2w>
 <20250710133557.GA1093654@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710133557.GA1093654@e132581.arm.com>

Hello Leo,

On Thu, Jul 10, 2025 at 02:35:57PM +0100, Leo Yan wrote:
> >     serial: amba-pl011: Fix boot performance by switching to console_initcall()
> > 
> >     Replace arch_initcall() with console_initcall() for PL011 driver initialization
> >     to resolve severe boot performance issues.
> 
> pl011_init() registers as an AMBA device, so the PL011 driver depends
> on the AMBA bus initialization. The AMBA bus is initialized with:
> 
>     postcore_initcall(amba_init);
> 
> Therefore, the PL011 driver is initialized with arch_initcall(), which
> occurs later than the postcore init.
> 
> My understanding is that console_initcall() is invoked much earlier
> than other initcalls triggered by do_initcalls(). With your change, I
> saw the PL011 driver fails to register on Juno-r2 board, due to AMBA bus
> driver is not ready for a console init.

You are absolutely correct. I confirm that the machine is fast because
pl011 is not working, which is sad and embarassing.

> The atomic path is introduced recently by the commit:
> 
>   2eb2608618ce ("serial: amba-pl011: Implement nbcon console")
> 
> My conclusion is that changing the initcall will not disable the atomic
> path, changing to console_initcall() will cause AMBA device init
> failure, and as a result, the clock operations will not be invoked.
> Thus, I am curious if you have ruled out the issue is caused by the UART
> clock (as I mentioned in another reply).
> 
> BTW, since the atomic path is enabled in the commit 2eb2608618ce, what
> is the result after reverting the commit?

I've reverted commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
console"), and I don't see the CSD locks anymoer. The serial speed is
the same and continue to be slow, but, the CSD lock is not there. Here
is the time spent on the serial flush when reverting the commit above

	[    0.309561] printk: legacy console [ttyAMA0] enabled
	[    8.657938] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])

Thanks
--breno
