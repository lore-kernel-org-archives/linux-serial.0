Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC65225A5B
	for <linux-serial@vger.kernel.org>; Wed,  5 Nov 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327845; cv=none; b=JTh8G6HLKQLYccMNURYwLjlhWdI6RXa+w8VK6SqopQckSjC7ZiiCRgUPj3GuFskKTVThhC3DkC1APm7gf+AfmaPwjoR1XrJF/j/ugZGeCPicVlQKedAJ/I52na7g8F9TibSOX28AZd19mPIRWscsp+7ZeLBniM4OXZVMqzjQmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327845; c=relaxed/simple;
	bh=E1dOHEET+fuMIcpW2X+DT//mWVo0l6r5A9sIRy7IIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Xr44d5Lp9H/LqP+RD01dfn43GQ5PPzALN/rMNtawksCQIRwLSRPJNawUUfgE1cI/i/Um9kstDapjcaEnMQoyXN0ZYytuo35OEW0Y8olj/fFyNfDJs3SPf3q/KAZ1vwDA6ERCsEKXDLUK1pa+l4ioFZDXyhlDe3h+6rF9PQA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNLlsFmo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNLlsFmo"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3613052a12.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2025 23:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762327841; x=1762932641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=FNLlsFmomleac0MTdyvsazTsZeqkPpYGC5NOEbOajvZ7ZKLfLg/5N1+b6vVEQWIzbq
         wGg1Kkc9s4bklbMYsKHUbGIxXnil5iElofoxsxTmIoQgCXABt44xbKRRXE6VRzIxysn9
         GBZN5ini0+W6srpl4zj2Yf9kqlmvdP2s1E5dCu7i1SQ+QeBMEpahKs24U+HUrBnD1sXn
         tye+jr3Sb0II/9o9bf3naF7h6az2TA6cmxfc/HaL0gPlYCeSKu2eYN9k7AUL35pZIf1z
         Ll8NTyzSMPz75aC54jJyrby+5QvTb3sHMxD3FfDKMJ4+18u0o0GttQXc2b4p7QFy7Mim
         O+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327841; x=1762932641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=JMBjIsL35OKQ8VI2GP32uopjkW2CmkS7MEIgU+5Fur9NfjUbMghABYyHYTdgGKUV1T
         dEVGzbsQuGddmVBBcswMFG54JC9RpJxLi0Uj4ueZVj97vAdQa33Xx5YocqdLmdPVjG5z
         U/RhsUnoE7cLn5a3cIxxkiHFrxVexMPzKkRULhYUrYL89JhfLAqGipxTvIKBjuylw05c
         Gs5zL31IMsBieVpsQ8nfWu7mlFMEIuAif7rzuIORAXztHnPogbdKIkd8cFww9crQA7Lm
         PHVYKZmTty0S1D6MnTYj1LzqBnaOB2DxEflPycrUGOQHTc2TC+d72CqAE6P0nUPrIlj8
         SasA==
X-Forwarded-Encrypted: i=1; AJvYcCWCaTK/Wg/4Ws/tJy8YN04NEIm3lAoDFIO6iIV3M+CavV6qcdEvd3j8u4U5R30MkB2vdYz90gkH8iSjIzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lHMGT/whqcpk1u5NWR5JWW38z7a8Yg0OqyajSwAQsSCZrf2B
	ccEYfg+Bq6wfAcJOZA8sGXc7SKO4fR/7HS456cdojtfNknbvke1lcTYmPRWcoPrefYQ=
X-Gm-Gg: ASbGnctG3yLWWjuZbfpnMQsXZp3D+p6hVo/yXXA2nl96NFykL3zV4QDrS/84L/4gFR3
	58Zj6l4/NsVrg29/nygvGYTpgvechyL7lTVq+JwBX3w7XeJjcZ/UbqGPz+TVsNzEROnYQkwTUQz
	AT+V+/WGsHFA6zRJj4bX/K8HV+Dk0VAm+f1Mf4Vk1LnHpJEZc6OTwu5iTlMkouF7/d0t2uT5S82
	nudI+laTLDEg5rZhRzBW+HYn0at16F1PdcsxeR8rxxjynJ2hxLi+kWil8ylXQRFCG5tNuHejZIe
	F+hz60rt5jUxmkkL71RsZH1rPCcviOBI2KW+0LaJaScjR5cX2JfIy3niKSAeAQI+W5cZhz4H6EK
	TG2khz8O6tWdujeADR5A+QqElOpIWbTjiIqixOEII8ao8SX6JPbn6mKLyUbcqzie/WtR2Gfp4UY
	eIqjgSJDOOpb2AFg==
X-Google-Smtp-Source: AGHT+IF4Z39tdBwbbzTMRpDJUt9P/ptkzqi1eF1iOdtCWCbeCbOmCHd88OE2YgBLVLBryIJTdoazkw==
X-Received: by 2002:a17:907:2d0e:b0:b6d:7742:c20c with SMTP id a640c23a62f3a-b72654e1f17mr170440066b.36.1762327841465;
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm414148866b.69.2025.11.04.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Date: Wed, 5 Nov 2025 08:30:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sherry Sun <sherry.sun@nxp.com>, "esben@geanix.com" <esben@geanix.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>,
	"fj6611ie@aa.jp.fujitsu.com" <fj6611ie@aa.jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Message-ID: <aQr9Hgx-AAP9i1Td@pathway.suse.cz>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87bjlhz8pw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjlhz8pw.fsf@jogness.linutronix.de>

On Wed 2025-11-05 00:25:55, John Ogness wrote:
> Hi Sherry,
> 
> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> >> Thanks for confirming the fix. I will make an official post on LKML
> >> with the patch today. Since the i.MX nbcon-driver is already
> >> mainline, I will CC stable. I will CC you as well.
> >
> > I'll keep an eye on any fixes you send later and verify them if
> > necessary. Hope this fix can be applied to the mainline and the stable
> > tree ASAP.
> 
> Even with this patch [1] I am able to reproduce the problem on one of my
> test boards. I am using the following extra boot arguments:
> 
> no_console_suspend loglevel=8 initcall_debug
> 
> And then:
> 
> # echo 1 > /sys/power/pm_debug_messages
> # echo mem > /sys/power/state
> 
> This generates a lot of output and leads to the same suspend
> failure. This may be due to the out-of-tree nbcon-8250 driver I am
> using, which introduces extra irq_work usage within the driver.

Great catch!

> Could you please try the above boot arguments with your i.MX board?
>
> I am wondering if blocking the queueing of irq_work during suspend
> should be generally implemented rather than just printk avoiding it. It
> also seems to only be a problem for ARM32 so perhaps it needs to be
> addressed at the architecture level.

IMHO, we could not _quietly_ block irq_work during the suspend a
generic way. We would need to warn about it so that the callers are
aware of it. Then the callers would need to explicitly block it
to avoid the warning.

I want to say that explicitly blocking the irq_work in printk() looks
like the right way to go. I think that it would be needed anyway.

Best Regards,
Petr
