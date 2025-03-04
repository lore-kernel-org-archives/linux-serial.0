Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A411F37D1;
	Tue,  4 Mar 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089088; cv=none; b=mJEvQ3LoFe9SqvXwlmJK6wBFKvAqCZFCqiXGZy2D/L5Ydb8Aj9AGndjEjlERHBgo4uCBn9kzPBD0l1PtNW3ccaWpf+6FLdJ6liPpB1mqIbGyMxyXDw7v1HhfGSfJyKHs3CPpX/X/bhOvrdxWbl13kFDGjN79KsZf7rnHqB7ZlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089088; c=relaxed/simple;
	bh=2EjWhAZbB8dUPiw0Ue+ZvoaXFP6YywEurgiLtelZNzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG1ONamCB1EarEgIn2rZ6Rhg8ZLjkjUbDKBHEKcF35OjwOqC783OmTpSb4qZqgALgdfZlRjbKAIIjpGMn8XrZ0nSoz9xbcwb+Q3cVwcKQnNDHaZ3asU/3j0AcNl8NI46Q1o/v9eh+XexerVSiChUV7UGrO/ccdAh+guSanOiSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akczvY4S; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akczvY4S"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e89959f631so43349996d6.3;
        Tue, 04 Mar 2025 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089086; x=1741693886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OF6/E4alOrfhHZdSKNPX4eXV8A321bAOk8ILgmJMhj4=;
        b=akczvY4SUmJnEGLdV+Zj7giHbV5pjkbZMZP9j+vakkULP0D64+6x0FXFc+Uz5bifxB
         /oYHezY0X6itrXcgqEYd02YOBBAHJAEjIBw6F+Za6uapu5gHTvn5ypsW3HBE+qV1FVbX
         bMsI0Rb7gjQXbeGehEeh/9CO591181KUX/mKvcv+IhwqqLJLNYobnZW7oFlnRvXjET93
         5PTzVe8TqkYb0uxfmDKsaoieyn28mH8I01EGEJJBnGw7ZqWIXuDyEruoEx6OKXHVDcQK
         uYVa0CNY2jIj46j86QLDPXEXE/GJVV9fcYdqZcJruYZCGFn5dTNrnjUecnO4x9C+46GG
         CZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089086; x=1741693886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF6/E4alOrfhHZdSKNPX4eXV8A321bAOk8ILgmJMhj4=;
        b=TQTfS6MkBYNtksasDhKIrnsbI4SSyjcJ4FDWgLrfZb3A9yaMR86laOLwyd+PEs9cIC
         r6Ik4LiYIlltFQbeqgbxcGn8L2b5JE76OE/aiAWWAtAoWkFcnSqDD93kV5RYxGUzwDSK
         ilzF2E5sopo9x8UopU6md0badfT4hQ6pkqlMwgxKH0xzLiVeVeGJ+gG8iL7XLYCFRdye
         ZrkvAX/1YujcoQ0BxBErjDTxhVq7bhYg56UUvq/+0aiLYKOb78qVvLHMSip4/IrdSPw7
         WPhr2Nz4p68kH7pFOtbAJHwIT0VF66pdaUPiNWGOjmnPCuKKIvbnYQoW+5MGn3oG1enD
         ZPrA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bQYOEyPQMhGPS7+usLARflpp5x37NgP7pccpLbbwu9UCqeukA+2/TNKke93hA25p9+tWY28cXjyLQdMF@vger.kernel.org, AJvYcCW1zlP4gp9vuUOtLYq8yvkh9DEaiNQGtiwvo4mmoxQez/kw3AlqM6vf7q6MrFrUQySzjG7q3gOcov8Tqao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rjkzo1OV60AEgj7oi75iLTx2n19KMEpesTxLZXoCMISsB91t
	oobYiw22ieN0olthhPuJdghknxjICpzCmDN5pvhGwdE6c/7ZgPIC
X-Gm-Gg: ASbGnct2+u1TIHvR2CEp7rGa+LWDN7DO1cQLE8dyHIGoyUJN5jFRImv9p7FHWdlacmL
	KfqHhCMrprsbKlVEhP6a9lxAKoxZiWftzGPK3gBE70Ensxdx5bstlWZrY1y3X0CPQ0j1IbQDYR3
	774ch9MUt7EVsqXe1TigkcgF2gKgfmaad2/EAIo5fmfwTTLB7OhbAAVCGk//ZZ0UoNf5rOYE4Fb
	TJwhNrF+L0KwVgk6t+razub05qqPhQGufEIqcKC1c1gg69doHHgVgnJNB4MsOVFWX2LwtgVjF3Z
	37hUTUthcAsD0t7539xC
X-Google-Smtp-Source: AGHT+IEAbMT1TYNjt4RckdbjKvrPBVcpvNKU6efsYiT6EOgPRt/pMNKA7vCaFBBmL/nLL2nAV8B2lQ==
X-Received: by 2002:a05:6214:20aa:b0:6e6:6426:8c61 with SMTP id 6a1803df08f44-6e8a0d95d02mr235238496d6.43.1741089086098;
        Tue, 04 Mar 2025 03:51:26 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976ccbe4sm65524246d6.78.2025.03.04.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:51:25 -0800 (PST)
Date: Tue, 4 Mar 2025 19:50:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI ID for Sophgo SG2044 UART
Message-ID: <zcldbfffydtok3gjjosfr2bzpatdl4vqjkuri5pfmrwbrk4krj@rivhifnbeoaz>
References: <20250304070212.350155-1-inochiama@gmail.com>
 <Z8blz3pAOV9by5tB@smile.fi.intel.com>
 <Z8boqRiECAvAqy04@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8boqRiECAvAqy04@smile.fi.intel.com>

On Tue, Mar 04, 2025 at 01:48:57PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 04, 2025 at 01:36:47PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 04, 2025 at 03:02:09PM +0800, Inochi Amaoto wrote:
> > > The UART on Sophgo SG2044 can be enumerated via ACPI.
> > > Add ACPI ID for it.
> > 
> > This is fake ACPI ID. Please work with a vendor to issue the proper one.
> > Vendor ACPI ID registry has no records on Sophgo:
> > https://uefi.org/ACPI_ID_List?acpi_search=SophGo
> > 
> > NAK.
> 
> FWIW, the I2C thread has more insights and details:
> https://lore.kernel.org/r/20250304070212.350155-3-inochiama@gmail.com
> 

Thanks for your info, I have seen the feedback.

Regards,
Inochi
