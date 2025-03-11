Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD125D550
	for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704085; cv=none; b=a6IoHJzClZwRLZWnZvC6k/99SZtsVUcnZjBlq24gJ2EV8JCLucdjZbCVmps/Eaza1IMfXqnWgJyxP+RILEVY1Attj4NWBxYX5y4ud3Kg41Go0kwJbGow+iRgI+PZ82QYJqAGvK2lD9uvh+ncBH95uOH5r9YyBdKiXMi/0dF9rU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704085; c=relaxed/simple;
	bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5jhUllySHD+6wfl1yz6FejH6qQVX8jm8h6suQ8cKIIeGd2Nuk505JWD5ECsvGL6NwXVSJ3QaOvjUcBT9Iq/0T/qHF/OBVjHGsnr8jEJWrWhB4HRYwsIbyMZhYzV0Rr2AJPklU8hv1vI6O6i4eeJgloLEYiNlPrDJSs75u5//4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebsx0eSt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebsx0eSt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso2757539f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741704082; x=1742308882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=ebsx0eStJiZ5pRpBn1LGcNEhc9/ufzisag743zx7HByV9d6QSHMUqiwjqKgjpXT7oL
         2vU8+xXY9ImNkzAqhc+EvhfqYqXs/uWL2Taa6GmFvD3NYqbxPKKX1EoOzb1udEsEZeIV
         YJMzBGzfn2T/V8bTe6+UFGBu37NvTG5FEH+jse8qcaaAHoyMpnUgjuYM2e4fIXJ49Tif
         Ri8NcB5Eh5UfFSrSmJvTQbmlPNGjjZKPN9/+jzoXRz+g6N4StRy0oD6tgbLofE5XvswW
         GqO8Q6qMMwJur3txS14MNAJbQbBRMFnv8s11YyW0GvnX0T4BWus+07cA2MnUkpj/u27U
         sK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704082; x=1742308882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=nZDjtOXAy5+Vq/7pIeMh/8AFT8KgPJKIqC9jaO1JRAzI2GPcoyQHON8whIgSxbbiLx
         6vbQg3tIdWIwes36zDP+cZwkGWUqK7G6z2EWIGa7VP1TRj35O+RTxy8kLOhjBz8Crmkg
         uwi1PUSbCL1IQE4UR/eCVtKiandloKxX8D8sW4zCoALJ0ye9RaZLGmup0DOj0IcnE5LP
         gVKJSsHNyxI+nYWWWqv8977gWTobU1/x/VQ0ubf4abKbbf82lyFHd9pISXBL5OJ8yoB6
         D4vOcB9AzVq37GYJxM3HkSdbrUHn2vu+yY8aI06O3ZdjNlpRvBSaxsjHi5XCTUQ0LFLU
         +6sg==
X-Forwarded-Encrypted: i=1; AJvYcCV/eJzKRaRtqEEE5TxHVnepDIWTjFnQXJMJIWxKlOAMvTUk8OBASxF7AaU27yJ5b8lB1d7VB7h1HTF96Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3jwkkyXlULz3e71GGjHbo1fECdX6TtKG315O20d3shB741su
	Ef4QKZ0iQNCEDB+ya4bVibdCE4256x7KzZ3+IOZ/4ALGukzOEOB0yiG9N6Fo/uM=
X-Gm-Gg: ASbGncsI9IDnaovv+IiSiWeYLwFjWT8GD4OfzslZFisSYCgB5ToakvuRXYBFVvMy8pM
	33FaXXvchRVbp+dT41kDnDMrDr2qBLywgoEQBouIJAAtb/ESahlvGGbrZtGgv0NxcfDYHQ0ohek
	Hu/fwv0xBEZC3RF8EnRicrCrW2jE0MFFqhnyBF2sUWiqWLFqncgK6zl2OU7SW6dZTlZMyO/uWld
	0DMSGBn0b16UaZtgNP0+myVXse1OeORWhYyulsEpHukHuvDyeGqL5X6/hgMJ74ndghI4JxV113j
	DtAjmzXQc/qeQZ4Hot2fz4XLsDAGnGB5lzmGQYIAHSacNXvwm3twIxie5xxdSmyv52O+zdxBJcE
	=
X-Google-Smtp-Source: AGHT+IHedVj4RUj6sW41ewt21ZWFTQVrQn0/iCeA7D/35qQUSXCzs/EtRBqy+mOCc1u29u+Bx4/luQ==
X-Received: by 2002:a5d:584b:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3926c78f6b5mr4736641f8f.54.1741704082203;
        Tue, 11 Mar 2025 07:41:22 -0700 (PDT)
Received: from [192.168.3.33] (110.39.160.45.gramnet.com.br. [45.160.39.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18675615f8f.53.2025.03.11.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:41:21 -0700 (PDT)
Message-ID: <9a8b7634b123e82c3eaf278a5944feafd91279cc.camel@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biederman	
 <ebiederm@xmission.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Todd E Brandt
 <todd.e.brandt@linux.intel.com>, Jiri Slaby	 <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org
Date: Tue, 11 Mar 2025 11:41:14 -0300
In-Reply-To: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
	 <Z9AShs1dEO0jrgjL@pathway.suse.cz> <Z9AvKmM4Li57-E2E@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 13:40 +0100, Petr Mladek wrote:
> On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> > On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > > Hello, I've being working on some patches that help to clarify
> > > the suspend/resume
> > > of printk machinery. The last patch on this patchset address one
> > > issue regarding
> > > suspended consoles and blanking.
> > >=20
> > > This is a part one patchset that I would like to see merged
> > > before I send more patches
> > > that will rework the suspend flag (a global suspend flag istead
> > > of per console) and
> > > the removal of CON_ENABLED flag later on (I've created a function
> > > that will forcibly)
> > > register the console instead of using this flag.
> > >=20
> > > Please review!
> > >=20
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >=20
> > Looks good to me. I could fix the typos when pushing.
> >=20
> > Well, there is one more thing. It seems that the simple graphic
> > logger
> > was merged for 6.14-rc1. And the console_stop()/console_start() API
> > is used also in drivers/gpu/drm/clients/drm_log.c.
> >=20
> > It is actually the code which motivated this rename, as already
> > pointed out by John, see
> > https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> >=20
> > Well, I am going to update these two locations when pushing this
> > as well. Let's just get this change done.
>=20
> And I did as mentioned above.
>=20
> JFYI, the patcheset has been committed into printk/linux.git,
> branch for-6.15-console-suspend-api-cleanup.

Thanks to all reviewers and to you Petr for taking the patches and
adjusting the typos!

>=20
> Best Regards,
> Petr

