Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106738BDAD
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303842; cv=none; b=Rx/WyznEy+wy7BXJqAxk3P0b0LB6Bq8H9MRRuWuPlLo2pRgQUTRWix63ZW9Kt88MBgutEcITcZOR6Ot+Px/q7aZSEMd6FvVPEl8Fmuzy7TNduz/ETk4AHGEl6gpxL72noawD1FsOOC1j89xuDSxPBU275wj1qVog7D9w4B5pzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303842; c=relaxed/simple;
	bh=GFbBe1FKiFwXNqlrC/vrxH7BKrvDogX+HkFJiNJXIbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y+Vp5W0xEPe1UnY/9L5VrIZQE0c/IRrbUQaYdjgzSVGQ9fvPBXibGRUXspC6TnwnAM9HBTbTaYQ64684+farML3xc1XL1fXE9wyS90+B5XkWpV1fHgL4tNmUC+ga+lxbc5a4ZJ2LWUPQaSOxszMs4srbRoVhi1P4+J7XupAgWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rc+7fh/u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc+7fh/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768303840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mZitFPZXaFAwgzzbiC1drztWEtu5YGVE+S8D2GI5aA=;
	b=Rc+7fh/usF5P65kEan79nOZO8qsYdJoKJdpW52yo1iRnNjIZ2fI5CXfgLex+ar/8+YXMOU
	FRxyosdci9xHyPNShU/xn9NDy97/1M5luT4TyA1Jbdm+0F8XOuc3ZXdZtcww/16Zr/Zo3O
	1DfVxy9QzpdCQPXUbUxAfqyIwV/nMgk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--pKq-7wfMlGGuQK7T72duA-1; Tue, 13 Jan 2026 06:30:39 -0500
X-MC-Unique: -pKq-7wfMlGGuQK7T72duA-1
X-Mimecast-MFC-AGG-ID: -pKq-7wfMlGGuQK7T72duA_1768303838
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb0ae16a63so852092985a.3
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 03:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303838; x=1768908638;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mZitFPZXaFAwgzzbiC1drztWEtu5YGVE+S8D2GI5aA=;
        b=QOebTPxzcNpDkYDA1ZhoF1d29nRvNoMNclehYz8BzpHyV2NRDtvguNMxtGcuHgeKMy
         3ktpwAbUBsVKCh8vHGtEJIAvgZ73C5lufLXe4Bw3AAWPhtJpyJZy0F3WIx0E8UzyA7VL
         g5fp54L1Qu1Eowpc9lKDxspk/tvMd2GSSttd6k4uozCHxhLYR2eSjo7yLinzoZ82rHpw
         +SK19pW5Sgc/xF12WVLSiLKYhHzWCo9jcOE8kM1JSM+dtNYNWRacuBXKoLGYY818M5zC
         7TXNczr+mZ2fpu+w/QaTrI4gdgck4BiF3rEMMsx+yhGtYM5QT44Q+WDqdzsI5LmLBOc/
         VAmg==
X-Forwarded-Encrypted: i=1; AJvYcCVokPaAYQifvEcQlv/taHCSqRk9Bx8R4iUaX/Nvy/KLtZ6vwP+dFrePEbYZzMY7/nl8axMcaYmuZoL5kZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DyA2eRxr5rGoJh0p/to0Roje2U5dFu71/PUPQwJut2hR9owE
	vgTguYPM+RZe0S5qVeG43FjQU15C0A28XUI/+OO3h4thJAeGDmJ0vmi+DxyGymBl1JluvDG3Niu
	pJFXD20VwKDK2TqbnQTR5qhnFOjjM+7pZBwFeb4vsypWddnr/hmRaI/rhypDL4YiCaQ==
X-Gm-Gg: AY/fxX6zBDZEkSHhKfJngXWMj3gno2BZt6lQ5V0FwaphEYjhdnMSxcDZxQDNOCQX6/t
	ojRTmQFvl32tOjnTbL73H7HB9QM3K5FUIlpyoxEZw2P9KN24EDWSw8PsxMJyfUILnA9ZLUGgc/0
	g5PDDJ6OONwnLkWuOXcTDNpTSTFdmYwl1VPl2K59hF394ABFXVE9E33gNnvdpSePmG/heNMkDpp
	59i/PeIsnFz1bRdxEBdmlJ7wWHj+qOpao4TZqV8A8RZOdPPuUOWuqYucgnNPBrArQ7VCyqfKyia
	tvIiJ5rPgGbtvubJZa7d3AB+KC6uZqiKHb7UYuqfrfy+Z/wSPwwhoKL6I2RmqGDoFhnloKnVyCr
	+tkpxOFAhZrg9MD6ZqJ2EUkzGpLXVdvhf3k+/kf5eBkUj
X-Received: by 2002:a05:620a:404b:b0:8b2:d2c9:f6a with SMTP id af79cd13be357-8c38940d09emr2936023685a.89.1768303838440;
        Tue, 13 Jan 2026 03:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBP/cb2/Ccnmcjxtit9ZlBPwyv14/S7B3W8jqKWuMSTmdJjyszN2LnYWy4PzHWa3vlkgJkoA==
X-Received: by 2002:a05:620a:404b:b0:8b2:d2c9:f6a with SMTP id af79cd13be357-8c38940d09emr2936018485a.89.1768303837929;
        Tue, 13 Jan 2026 03:30:37 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772682besm154938746d6.50.2026.01.13.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:30:37 -0800 (PST)
Date: Tue, 13 Jan 2026 06:30:35 -0500
From: Brian Masney <bmasney@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 12/16] serial: pic32_uart: update include to use
 pic32.h from platform_data
Message-ID: <aWYs26SLZdk4_386@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
 <20260112-mips-pic32-header-move-v2-12-927d516b1ff9@redhat.com>
 <d5b5942e-74ac-4b9b-b850-2417576d946b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d5b5942e-74ac-4b9b-b850-2417576d946b@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F2eUwKSUqjUopT7RrtcHflwfjiYPU6xTF8ZceqNlVVc_1768303838
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 07:38:27AM +0100, Jiri Slaby wrote:
> On 12. 01. 26, 23:48, Brian Masney wrote:
> > Use the linux/platform_data/pic32.h include instead of
> > asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
> > is in preparation for allowing some drivers to be compiled on other
> > architectures with COMPILE_TEST enabled.
> 
> LGTM. Will you also enable the driver to be compiled?

Yes, probably in a month. I'm going to wait for this series to land in
Linus's tree first though.

Brian

