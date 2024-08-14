Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236913D893
	for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616947; cv=none; b=Dd1y5fGW8NYv4BQK8Jdhuaki+r/4NPl7vt6nGBjq598YZn5IcLegIzVmLNcqsUcsEJ/EhFz4qw1kwTV8qcCBbg6RnRhmxReJ3bIIk5zaERDpHWfmK4TW6QPRIxQRg49vy/3jhLy4JLyZ34rKZSckhckDh/BfwMm+H/LaG39pQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616947; c=relaxed/simple;
	bh=O+RcdJC0mkogWcz6CVCMl+sgWIBIY7cgxSBRyr8mlgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tByHrMUKMPmQujwC3RQpz+1/h+euT21uho7xavQP7Cyz0A2LBXer/zq5+D68Yof0gcTrnCs+/7CZGrNol8S4mIiWGQIB+SipNkYDlW2yGabQy6m8nPSeo6uZtsEYG5K/aq+QlJE9w7e2JQffp2zzuY7zQzaeNW53jsD0vzHkWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fDHnUQyT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fDHnUQyT"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5cdf7edddc5so3391949eaf.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723616945; x=1724221745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KY6hpFmE+89V3sOq3p1bZOHhGBKbqrZb35ld0D29Jd4=;
        b=fDHnUQyTnN/mT77Iuoh6vWaShTGAH2WHKJXJ93dThbcbvgC0ypE0S64MY8koSaDPr9
         nDKdjA0+BrRG5FZfSwJcyYnxAjBE4gc5cAhljgY0CufhriV1qaoJ9XOHnsZZ5JxA3qev
         ZZHDL3+SYk6roMtXEbpY+YWZ2e5U/7M1k5Mz+GXSHLKFS+2RyRMC/GlBf5n7Emm5pi22
         B8FpTkBMtSFFT4iteyZgqAyvFtk8Lgx89TY1xCBHJlnMTMq8Ldif0GJa0XJ4jRELnHBS
         aZavFvXiaRI1jMgfXlFr/r94d2xpP5hRhDWveftzFlXEStg+HOPdtVsIKVzZiJmCj0VS
         5NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616945; x=1724221745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY6hpFmE+89V3sOq3p1bZOHhGBKbqrZb35ld0D29Jd4=;
        b=h43Bb2ja1itbEN6mJlKy69RnJASWQuTImgJVN7JWcnpp9yLBtxDL1nYQ3nPWqDcsU+
         e3TVGFBSX64T0y9gpfWrP7DwoZz4jdDjHjIJY7i6a+h5nR5cqkcIHWJ0lwDRecnjXVUl
         ijqFvwQtuy8mDmczIuodOX3FVaXOAQRWGoZt+d+a+m3ri+wTfQ+ekkOEcERYKXLCHvvG
         6+ijYeNyR5ta2dhgwbMi6OlnXqO/rICusWGMN+2oP7tnl6q2HSXacaNToUrsCq8pgxri
         CeHck0rAfEPQ04304wACumkzU49MFE+sh3Oxi4tK1wUqNHpJSZIVVt/fXlv5PtaxJYsS
         mZyA==
X-Forwarded-Encrypted: i=1; AJvYcCUchmEe35RkTnlwSXOyJi39X3yiXEXiBOkWEX3cYfWtkZHPNN6jG5oU/xjNxDDl8c+B0SQcJePn6UxylH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxyJVvRZhA+kv5EQwF/1cq0jz7F+2XyannJRCnC2BPbf9DHpD
	UOmIdNht9BzXdW6V97wXgy1iR1u2LgUK23Nte3Qc+tkQYLvZW0itUtvBMAN1D+o=
X-Google-Smtp-Source: AGHT+IF+40D3XWt34BX3LLvwc+430IjHsHfjuTgtZEU/S7BfUSMyXvXQDDgpmF0Zy7P5FIoiqWBeLQ==
X-Received: by 2002:a05:6359:4c0c:b0:1aa:a27c:aead with SMTP id e5c5f4694b2df-1b1aab16a30mr167968755d.3.1723616944812;
        Tue, 13 Aug 2024 23:29:04 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710f65cddd7sm5117935b3a.72.2024.08.13.23.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:29:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:58:59 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/7] serial: 8250_platform: refactor and clean up a bit
Message-ID: <ZrxOq2177rnZXZ1b@sunil-laptop>
References: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>

On Mon, Aug 12, 2024 at 06:47:02PM +0300, Andy Shevchenko wrote:
> Recent patch against this driver has been added without my review.
> It was technically my fault, however I was on long vacation.
> So, instead of blaming anyone, this small series to tidy up the things
> as I think would look and be maintainable better.
> 
> Andy Shevchenko (7):
>   serial: 8250_platform: Remove duplicate mapping
>   serial: 8250_platform: Don't shadow error from
>     serial8250_register_8250_port()
>   serial: 8250_platform: Use same check for ACPI in the whole driver
>   serial: 8250_platform: Tidy up ACPI ID table
>   serial: 8250_platform: Switch to use platform_get_mem_or_io()
>   serial: 8250_platform: Refactor serial8250_probe()
>   serial: 8250_platform: Unify comment style
> 
>  drivers/tty/serial/8250/8250_platform.c | 107 +++++++++++++-----------
>  1 file changed, 58 insertions(+), 49 deletions(-)
> 
Nice!. Thank you very much!.

For the series:

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil
