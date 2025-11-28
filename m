Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D312FCBE5
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333069; cv=none; b=XBu3edV7922oSHNtW9VvWra3Fg9b+w1HzacJPTq9YLfxYuh14IKzv2AXqJZMyREBg5/hwZxJHSg7xhsk+zDNKNYg2CEVjZ3zKVPYtcKSGsOdLwwfSuqT6cA/Sxa3GhXwgpIjmxjSImPeAa5TDhK/iycjTFffe2gQuNzcnxJ/BTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333069; c=relaxed/simple;
	bh=TwBcNoVqSgknpNfbD7fwLbp/M5x4UMMPS42lm/a/IcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpNppvyqs7LlwHHDX3T7QQWCNeuyyb0vKPS50lyThMCbT16AOU/Rstes2SPfI3Q0JHLvQuy6+D2uBz6FVNszHK0BjDPiY+ZcSzMSL6j8ZpM021/z0Lf77ZYNfzHl4Ym+Y3kfhI0qVwS+8IeJsRbgSxl4m21YBrB5M7vNoLMTz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TwfnshAf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TwfnshAf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso18407945e9.3
        for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764333065; x=1764937865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcb229vvLyBxSU063HYeCn4lxqy1srWBTS640feRync=;
        b=TwfnshAfQc7A6TyvZWuPh/ZvHy0kJismgvlQNRQRMVaN1un+B/YquO0QiY7Bnhh/JJ
         fcbfWFObboojfp0nLya2KF8ZEktzzaHgM/29ltelcyKAlJSONg5S24L1vFtyqWCpge2x
         jKC8CuoYmPeF2QugGB+9bwg/XDffxUBKR+SDyXVy+NKeymV6cs3QzyVso517HHPFBHrL
         MQHD8mlMtyPpkeStxjzKBUDhhb+GuiOfcsg+66RyaYc8vZ2RtPGxlgtknGDScPt/8PHz
         Xe4pOHEYn/8vZapPHrhkQVF3max/j9WpMa8ORLubQNRMcWR4wgo/lRqId0xnfuForD+3
         BXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764333065; x=1764937865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcb229vvLyBxSU063HYeCn4lxqy1srWBTS640feRync=;
        b=krxjO5JXgnLIB47PGdbkZS2zVx4fsU+y9qnAMgFHMkteW8Emx0IxqZ2tfqNp9BnMeQ
         rWfeDDgeBqv8FaPWq9iNOO6R34CpPOIWsIIAfnVt1LA9Grb9DV9LH1NPC0ZbYh2DM4Nf
         o83JqpW4z0lzlIaYEVASf6OYwDxgYPgqV43IFMZtes4NO+UCtVlgLVgyOq1a2lX220I9
         alI69cgDfNjnqGA0nPaPQtob+zHRH+5+hCGgNNQ9zP3tzt2HvkrvmpbLluqHIuR9APH2
         Elm2cnJ4Sm0GmCcJ8nKAw/3JB6NZjoF0exwJTVV+jCYNvJoKXCTrG/XhPj6uzTW9NKW4
         w/gA==
X-Forwarded-Encrypted: i=1; AJvYcCW4A0AOIIZCgnKwc/US7w/o0N4k1MajbEcblmofQpzmcBnqI9z/6v9dHwzPhM5lxU6rx2dj7bLVtQ3kzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpKNtmVx1xy10w2XW6d37983+ZrcipCdGeMy/gusPUZZNag1h
	81gcUcLnDU9dljmaWfwGoqri1OmW3sYy6lN56eXHRJDCoPx1pFmiknzHZSlaCijQiuY=
X-Gm-Gg: ASbGncuB6I3xAQuXqktJgN40kV0UG4rfJtN//HYdpClLZNdarZFmNaeGQ0Lni8yxluP
	clZVhjtfHIOiTOk3X9Cfub82fg/lXeVbp0Ie2AJwQs76ATRg/22hkaU9sbu8iFekOUyzDZzx3jv
	d8zaMaSthLc6CErITl9C6zii5vCAkhf1CHxORqYRyHtI6SKS1YXXW3rOd91rViblzoMQrj4WwFk
	xQuplhLcnglDUgTOxJtS35wqYqSWhXg6lR5gm17aNlCI7nrcFN2+Djr6ANb7ckaLnykTDljZlmG
	b9I/KTjZBsf3FPz5qa2A/TGdYXZYWGsHfG28hd1rt2rz+RuH+X0dfeOGtytBFe21uUsZQJ7yUgc
	8pduO/hZERdEo6gzo4NKMQLdalCZZS8CqLwPwoyfOMuCNsqjPYKYLrGd/fK1SgrYby56sJjjsat
	zuaND2xlJUq9OgsA==
X-Google-Smtp-Source: AGHT+IHRcq2FJ5WThogfhlAWqk7vaz8fGAovTB+lQ9cVsK0w612w7DjIt7QhCUcTVHzHz5dbtHK8GA==
X-Received: by 2002:a05:600c:450f:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-477c1124ecfmr270011685e9.27.1764333064798;
        Fri, 28 Nov 2025 04:31:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3e4sm9837124f8f.25.2025.11.28.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:31:04 -0800 (PST)
Date: Fri, 28 Nov 2025 13:31:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aSmWBYRmH_BNM4kg@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <aShr0DZRmpDnL0nz@pathway.suse.cz>
 <aSlw2AHo_AWzjH-s@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlw2AHo_AWzjH-s@aspen.lan>

On Fri 2025-11-28 09:52:24, Daniel Thompson wrote:
> On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> > On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > > The first part can be found here[1]. The proposed changes do not
> > > change the functionality of printk, but were suggestions made by
> > > Petr Mladek. I already have more patches for a part 3 ,but I would like
> > > to see these ones merged first.
> > >
> > > I did the testing with VMs, checking suspend and resume cycles, and it worked
> > > as expected.
> > >
> > > Thanks for reviewing!
> >
> > > Marcos Paulo de Souza (4):
> > >       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
> > >       arch: um: kmsg_dump: Use console_is_usable
> > >       printk: Use console_is_usable on console_unblank
> >
> > These three patches were simple, straightforward, and ready for linux
> > next.
> >
> > I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
> > I am going to push them for 6.19.
> 
> I pointed the kgdb test suite at this branch (as I did for the earlier
> part of the patchset, although I think I forgot to post about it).
> 
> The console coverage is fairly modest (I think just 8250 and PL011
> drivers, with and without earlycon) and the suite exercises features
> rather than crash resilience. Nevertheless and FWIW, the tests didn't
> pick up any regressions. Yay!

Great news! Thanks a lot for doing the test and sharing results.

Best Regards,
Petr
