Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03C29CE7
	for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242234; cv=none; b=JplOMDmjOBmbH78FvMXih44GTsq6tr+3lMTyc71RRsKyGUfrtA3wGmZLUx9WXYbAkcxa0mgWAZQVgjZVMvZNtRsz8FBXG/Ntd4RIUhddY7lWgRYH02Q98i6AcHX2Q2Ug15i/Utibue2uPUUgqzpHmdbHO3lYoUmmj2YgODHVOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242234; c=relaxed/simple;
	bh=UgejVN/99nwt2N3xq1SPwRkr/wpZolJE3Mk9WmbBWgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+7MoHE88RuxbWiBrqWJMaH+vEtWwqL4+ory/jRds2WPCxJraa6wISzAShuPpisRBCNoM+mohVuS84HU7mMDOcYMTYb4goLPn3TteBFGMEMMObKlnb3Ope6L+P6jGH2w2mzzA4uH26SPZYMO9hv7syR4gY/jRmy66wUBAJhUHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fd0RA/iw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fd0RA/iw"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f74e468baeso14752941fa.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Sep 2024 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726242231; x=1726847031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1zLfAygLCX5nindDhcisFbkr71lDlDKqH7T8AVgiyk=;
        b=fd0RA/iwySWKcdKG0GBkNSN1nCZxkmwLUEDOHY2opUOG0T3sgR8bStoBtqIzviXcdO
         unjr5rtsTTomY6eimjXFd6F1/CrCcAggd0qPavRzNdjJS1Of4dQGgPddQr/jPJg7F1QN
         A4tZXl+abo+TMt8aZliSxl+QOvYyNL5HwTFbbkbHCX4cJbmSIJAJTJ4HJ0DOXgnWgjaL
         qL1S6DzLev0ClICUbSY5OUEQk4SfuZLiVRk046EAtzBIxkeiFTtGnhMb/E0dnJkuW5g1
         kRmwArCUBrt4awCDDz61anRWB11o9Cq/97mCXZYx/ZTwb3TyQV5VFMjPIJRZiw4LdRWT
         Bw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726242231; x=1726847031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1zLfAygLCX5nindDhcisFbkr71lDlDKqH7T8AVgiyk=;
        b=i3lA/muI+vfjlBwXsPY30edtloyniZsKZRSp1glt2lft43ZG/GLSJZ+3ro96zOXjNW
         QG6+sB22YrEmfAdkysAXrzKM8ZdY5K1BfqG7utPRXoakBF9IFFdDrik1xaFGRcPWWSn+
         m7s6ERrSusC0ikm4I3MeNHx95qgiMa84B2UacHUoLLhEwPbb1yNzo+lp81+1zHePGSP3
         SpYjwVcgS3nvAWxv8Vwq1F/1gmTvmHmcrINuVY1wRQhSDa+8nSXyDi8HXfbd8ErD/m/S
         LLhBgNyy4v4YGbU8KKSY9Nz3+xXF/89xDi+s93q8MuqSwQsvOAknUMytGdhw3y/QLrNy
         or2A==
X-Gm-Message-State: AOJu0Yx2lERE/Tkvd1Hw5ijQdHntbvmL1Re+lQ7Nide07dMp3AIwUEph
	wn8RZFf0ZnNXVm3E1qf0FR0zHmnad3CFX39+6BALmLJsf6+DafKctCXCM9wTYgg=
X-Google-Smtp-Source: AGHT+IHjEojEFl9I+KdlNdjvlxdqRp6uQW0BMPVHLr049XIwfxrFRE+znIjnvIhA2A3Ivu37qd1QSQ==
X-Received: by 2002:a05:651c:b0f:b0:2f7:5914:c22e with SMTP id 38308e7fff4ca-2f7918e09e0mr20801991fa.6.1726242230552;
        Fri, 13 Sep 2024 08:43:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm7768944a12.67.2024.09.13.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:43:50 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:43:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org, Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
Message-ID: <ZuRdtFNjFr1_-VEw@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>

On Thu 2024-09-12 11:36:21, Raul E Rangel wrote:
> Revision 3 supports specifying the UART input clock. This allows for
> proper computation of the UART divisor when the baud rate is specified.
> 
> The earlycon code can accept the following format (See `parse_options`
> in `earlycon.c`.):
> * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> 
> This change makes it so the uartclk is passed along if it's defined in
> the SPCR table.
> 
> Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> baud defined:
> [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000000
> [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200,48000000')
> [    0.028272] printk: legacy bootconsole [uart0] enabled
> 
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
