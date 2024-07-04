Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F81AC450
	for <linux-serial@vger.kernel.org>; Thu,  4 Jul 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093458; cv=none; b=B5HezFaiMyvCMeUH8E1eyLSqGDMfOrO97KHELN7ZxrPJS87R5d3X0dJkBr0m+XyZvcliXNFF2zmrRNTYxoTdU5dLilLjfOq5bHxXzeLDRmoHMOzyN2dTMDERRIpGtG9lYmoWfqKjPsLIkXZZLSArpcYZadl2VoAk2BR3Abn8+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093458; c=relaxed/simple;
	bh=DsedHeJsS/amdZVpKFJyVeLkOMNQa+PMTWNkWl1ltVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLEBqO3CaKK+LAazQ0fwoBKHYUN+uc99vk/zWay3tXF2NpuAblM8LDXkL+0rQFsAam+WCoeG31FkC2LhB7YMXf7StgfU6m2M3ON4eKTfDg6sGrxAcMBmackF1rNAPHh7ckwJ0o+4FhBjv0eigrc/aahvZkFst1UlFa4twr6LIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XHunqudP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHunqudP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so301959f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2024 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720093453; x=1720698253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lD0PPZ24LDJ5fGIwXYEdiOvdE6uwqRXg1JRtKinTRe4=;
        b=XHunqudP/7g/rGD0xQyyRcYkJVzISGl6QC6/yqNZj6Mes7HDBRk4iRArO52D96CCB4
         uI4N8yKbrSMjcfv4C6pRJzhYyjRcRRNCAiFFfDQJAptIbroKCQMcGNzVWg/5Lbtn0QgE
         w5cU7XLemDMWgfldtunLL9cTuUaL9+qxmkBwL+XZDNeRHO2E+cXpqWrOvJ/kItgMw2U+
         Pb/OpK66PRy29h62V14IuFMbC3egj7lfZ6ZzijBBpjcvG0mta3Bw6xBTBt1fJpFSEG4Y
         F1fnJM7ThJFkCvCRJ5R/utaFT8ySspbpF+dhi6NcWS6HAS7sDZwQTYp/h0DWJdUers/S
         q7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720093453; x=1720698253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD0PPZ24LDJ5fGIwXYEdiOvdE6uwqRXg1JRtKinTRe4=;
        b=J6nPGqNVIk0Cp3DvoZfFuuZ8nduTi6CCPJQBT5UWKlMBMYENU8WQJkbaewy+PnuzVr
         HbVr5MnYGlwwwhgqthB4kAYBq3lAB6vLEpql5eV5q8v8rm84cipJMyfGBOzAXUDvGQz9
         PBtfgT9z1aFcYuu8+FxwajbZy6zI3+sGcI83Zg3O/YYuzFpy4eobtcvruW9QCoi30Z+k
         ZlOe5DNZu8p7PmPF82Loe4dny9nSOMp/iy/DPukJqNRd+LPQ+udF5alrfi9wvaDx2GtS
         q4Uyza+C/oQZyIWwL+cUql8Ux2ij5Nqnw8GEAaKedIBLUHClVJgIX2sVHDGpIm0M9I1c
         7DqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs8FmKiaUUwxTCmLVldtGOtsyXq5qbwXWDAoqEY2dUv1k/QDvgObiJsnvadVZAp4cuiXnIUL/US6SSz4dP4RXdzg0+gHjMIECG/Eq2
X-Gm-Message-State: AOJu0Yxonblubr+fLoddq1iDrWx7h/z/2o/0f06TQ3q66yNrDcuK4cb1
	A6DsdevhMH946e4WKS0S7TUP1T3vns4t5JOiN0M+WxI7sY+O2sZTvUfS0u2Takk=
X-Google-Smtp-Source: AGHT+IGNLj31HSnKP8eMBVVDQWkUG1T6Sz0uQgf58SIcESsrCGl4BgnlWeQWQYBK7LzNx7BMg/xfeA==
X-Received: by 2002:a5d:58f7:0:b0:366:df35:b64f with SMTP id ffacd0b85a97d-3679f6c4ee3mr1144700f8f.4.1720093453629;
        Thu, 04 Jul 2024 04:44:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb33901426sm12164205ad.91.2024.07.04.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:44:13 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:44:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] printk: Add
 match_devname_and_update_preferred_console()
Message-ID: <ZoaLA5IVTnh0E0QI@pathway.suse.cz>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
 <20240703100615.118762-2-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703100615.118762-2-tony.lindgren@linux.intel.com>

On Wed 2024-07-03 13:06:08, Tony Lindgren wrote:
> Let's add match_devname_and_update_preferred_console() for driver
> subsystems to call during init when the console is ready, and it's
> character device name is known. For now, we use it only for the serial
> layer to allow console=DEVNAME:0.0 style hardware based addressing for
> consoles.
> 
> The earlier attempt on doing this caused a regression with the kernel
> command line console order as it added calling __add_preferred_console()
> again later on during init. A better approach was suggested by Petr where
> we add the deferred console to the console_cmdline[] and update it later
> on when the console is ready.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
