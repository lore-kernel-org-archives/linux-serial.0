Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2823A9B4
	for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794048; cv=none; b=PAkxbybsV7i+rnfML2jVZIbNJ+Py3QtOmNEMG+N1XmQ0N1sIa+7ChCYy//6Q7SID+84KVA6syIc9Dz4aaCKbcEMIhw3DEH/gDlJus8qx2wOjDdFhAVRzqUL0vhJn3Pz+zr4wV2j1jxzDgXecnKnKXgNYKhJVXajhK9Oacb0BNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794048; c=relaxed/simple;
	bh=ZsCJPcdSe7Tw1kb5p8vquVkzMebfiXs4Jd/L8C/W7qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEfpx0Zw2JPSN2nFB5aYVOHGPAOvoyz/zrHFYIUHVh3b/pRPSS3DurB00noq9O1z8pazDqXFJZhTCgXATHG+B4bgKeSWG7tmY1Aaeez/TFj9WTf25wanwoXie8BgTn0KTFJnyeY2tIp376cMOUJ1PT0khIzK/TKp1Hf5PUUbijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FkAfEU3A; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FkAfEU3A"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso719109f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741794044; x=1742398844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SohDC+MqOB5QB3dRD2BBd5gf9MI45ZJLD/i4I7QXdTE=;
        b=FkAfEU3AAD7WkKDxNZ8JyGhXj0iIrCZhRbaC46t4/vdqn+YZBrSneJpnGrNJj3hMWO
         U1XakA4GIOfmDcLdCN3MNG/PSP0rz89/iaQNzosk9+26BFe4iVXC9iEWnuXwQoc4ZWDl
         r2rx1Ncx3ZDgqBpL2S7i7cAN8t8atpAnW2cLhE/Dbse29SGNVr6CF5v3SPilY65pVh5h
         4Cur0ZSV2XvTaSkwjAL82pxjRdlc7PvNyqdz72p2tZyk3kDStBTuHjPX1gCfPMcbkraO
         idsDVFMTNIZ/Lth5ImlsSPis2nu/D77NCBqTTteK4/zHrFUEK8m9LZ0VX4EF9u0IBz37
         BEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794044; x=1742398844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SohDC+MqOB5QB3dRD2BBd5gf9MI45ZJLD/i4I7QXdTE=;
        b=LBC5ErK2qwmaFrbrZMU0HyacjMe1vA+4sRTqWlhbmp1GgHAl8j4iVEa7cUobq2r+/w
         8T6VpVwVfwiko5UIRz2QV+O1vFmCKiKrRGQnGikPS64JfSGR8OJCPLIQDvP70jmJogNJ
         Q/lOLxHrGY/evqXlqvOC1Gf/ZPYB4LyI9ZyE/MQuHUM1GAnoNjjzgLIKnxHBSQLTxAeS
         RboLXFDZ+uiUpLDZ56bcDX9UYJ2MJD1uCSOLLwylXNb5PbjK7cwffeFGs1r5BVFBiRkn
         yziU/ICm7XvG7Q/GJdVqhbPDguTWQbalnKcdJuDC10u7T10WieObCeyU2qnSCIkWPEui
         4MUA==
X-Gm-Message-State: AOJu0Yz+mmprjpxA4eD8IFWkRECZS3fh/7n/+oWcXSpnCfqaTibSjzYz
	CO0fcCtf65/JvlTKCHTlIyXZAPrOXzPZJgY6Ct6zQ7mOfl4sLaEvepf/+FZlTRQ=
X-Gm-Gg: ASbGncvdQTAwau/BWobT+OzhpGBunX8uGh9syszc9FcEvgRxqu6sczOzv/bfGd5j/uU
	wToqXlVy99VL+1WtZacaoCdq0b0ZsNmnwXUTq0lxavZib6Vj9zQoMBYz4jJJn7tDq9oOyN+yQDv
	0UswPI6R3DywCXsrx9MXzB18aPzXT1cUDF0pLZ8BDmQkbEbot8dd91CfqfVbZjMHSq5oHYi5cxs
	m5WRY2+vIQJOwUTHyCFtFPwFw0ZtAV66H25ptNu9FFlYTmxCz+VV0IqtdCUcbGu51MozDSBEsb2
	FYHfOx85bNsOTU6s3uQTstPPK/6dQPT5qaaU/4yRepJXxQ2qAD8XwZDTCA==
X-Google-Smtp-Source: AGHT+IEI4qphOyuM6FRyf8K5fbXrZk7BGS7097WEPNMO96kH01+ahmZ3y3Q+T0Bk2uCXUnkiggKnWw==
X-Received: by 2002:a5d:6d02:0:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-395671d968bmr82842f8f.9.1741794044532;
        Wed, 12 Mar 2025 08:40:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7aefsm21094101f8f.20.2025.03.12.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:40:44 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:40:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 4/4] Documentation/serial-console: Document
 CONFIG_NULL_TTY_DEFAULT_CONSOLE.
Message-ID: <Z9Gq-oIr8wPGLGEy@pathway.suse.cz>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-5-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311033133.1859963-5-adamsimonelli@gmail.com>

On Mon 2025-03-10 23:31:33, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> When the kernel is compiled with CONFIG_NULL_TTY_DEFAULT_CONSOLE and
> no console= options are selected, it defaults to using the ttynull
> device.

There is a missing Signed-off-by.

The change looks fine to me. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I would personally squash this into the patch adding
the CONFIG_NULL_TTY_DEFAULT_CONSOLE configure option.

Best Regards,
Petr

