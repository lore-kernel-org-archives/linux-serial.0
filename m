Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA139A7E6
	for <linux-serial@vger.kernel.org>; Mon,  9 Mar 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055121; cv=none; b=NCPL0OLc5e9iI1ZqmyDt07ZC5DFI7SQt4oTAJTpAtWBVmkBaDkWVxdrbA04T+kzeRU3YIZYOVLQus+QjPnzxxCQYolMPys4dVz9cp44pIh6pyty0X5IO3VdF4p39fsQTyxKlBgyZSSIdjSkYgF6mPsX9lAQ/MzGI17Qu4OB25Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055121; c=relaxed/simple;
	bh=IRjLvztPU3pns2NMSJ9bWNZJGoR/acteWXfw3oga2wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8SWIL7ZcazZWdO+YizYhotOdkGOiHtHkoROIfvlFenXjEZXhuXKEXj7UNxAsg4vWd2KLomErCfUvIrPhdaNXLrHMzfN5/Qz8W58rzWI0pxePuFEOlX+H4Ni2g2HFnyhwIaxi3pb9FgFTTa32M12tg6tbhXHayE5c0F0DY2FLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2wc2KFY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2wc2KFY"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661f8ea8a2bso3008582a12.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Mar 2026 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773055118; x=1773659918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwXeTAeLG+jgbCz+Of/Rt1Uzv2jgEECrVDzROsqKZyI=;
        b=X2wc2KFYssOWvJTL9y4spLjqq2RadCo+gY4iydZ77hJUtZnsD5hPu5DWnRiMzu3r7e
         jCA5CBn3vgBCwvQFjFa49aHmoXkfijwXRaX2d0Xx1baOEw5z/1LZmggkdNYSpZX5rH5J
         RQqTNDSp4kggmFkb8rJlmcE8WYOMfjK/2GHjIHTvXyJJLgpbe/E+u/iThsa0OiTIkFRG
         cGjdqzs9lpU2mmiJH9pZ7AzwzCxCZFbYLBf4FbriyyTTmjzW1eVqMPuHK4TPFwwxQD81
         ltlMEeZ8Z9/I32y+zC9HP69Icb3s2z8Sn9Pn9oZ6B4DOZkkGQA6d+PGX6oexRr/JdVIv
         JHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773055118; x=1773659918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwXeTAeLG+jgbCz+Of/Rt1Uzv2jgEECrVDzROsqKZyI=;
        b=bPcCHEBZ5Fzy09Zkv4SB1Hgt4TBphJIlvOfMGfIFaYrVMxfDFIJQfiKSflvFyvOc+X
         6SMM9P9BiUOabfSp2hxp3p3BpcBx6ZAcqVuK4rxy0Nabgj+x2EmSImKo0wnthZ8tCNH4
         kb0sN95bpqisH600ArNmXrMKhhWS4bZiOl5Ia1Z+NRrp02QmEsBJA3NgiBHJ/b1b4rQ/
         a5bcFtTzaX04ECBO9nN79D09YhffGoWKNLsBVZgrk7v+BXXa+6hD9Jm4O85k4/mFTakH
         R0GR5hUWhWVH6EKJQzXRIuvDptFjOxpN+xNF7Y2kGHsSqXC1EXCTZdagbUQY8suq/R0F
         Eh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrTzNXy3GP9Ooy4cg8LfPJ4HNggZtiOwHr5nXG8SRMGDEXXjlbUT+yusimp2PE/b2Pbrqv41nWGf+5cMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DBnHTePDRcHmEVCNwMXeN0f09OqMznDihoBumVZmFgKG6cwX
	iGDQWw+/sV52NWwmEAUN/5WKLs9tcBTvuxRKXeMn06O6VEnq7BYSs7RH
X-Gm-Gg: ATEYQzxHoY9/4jQ2G3w8QHfQaJbfZ+FLjgysaZCPPh8ttJZADwQNLfk/S9FFnU9oFEq
	2ia6MaMNh1BzjBTtDVqbj4/Jf+VaaX+U0U8KvFvRsMr8RR6qhqU505PKWrcDwMu9o94M/RyMIda
	aVDutG9kdf1f8EVneJilEgderDZQ2dwnHrCaX66qm1v9HmL3XwY3t5IPiqOWUrHU3N0DLHrrEyN
	Xzx+vKKE9ZGByOV2NRgm8Dk74TSSF46kevO6GPEk9dqzn1kuHkVyXbY+h5dy3RD9JZEgzPqCei8
	w0H//cgiajWYD9RODq7sTQ5hroBqHAYzfm/zFiEQIbRihdwt1RhJva0YJFKdvLD658upIoSeimn
	o/lL8HUguI3Qr0hRAIU0JwTCqWzsuu8UcmXTnYLgGaZ9SMQv8JJ/R/XeujRRc0G5Jj8mSRQy8Bj
	+bhikN1xw=
X-Received: by 2002:a05:6402:398e:b0:65c:22a9:93d with SMTP id 4fb4d7f45d1cf-6619d4c7697mr4378355a12.19.1773055118074;
        Mon, 09 Mar 2026 04:18:38 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5540::49b:47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3c66d3fsm3123479a12.2.2026.03.09.04.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:18:37 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	duoming@zju.edu.cn,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dsterba@suse.com,
	kuba@kernel.org,
	alexander.deucher@amd.com,
	akpm@linux-foundation.org,
	pkshih@realtek.com,
	tglx@kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during device removal
Date: Mon,  9 Mar 2026 19:18:18 +0800
Message-ID: <20260309111827.550-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218152330.GI26902@suse.cz>
References: <20260208062538.29608-1-duoming@zju.edu.cn> <2026020828-unretired-mannish-8465@gregkh> <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn> <2026020859-caretaker-duckbill-0fb3@gregkh> <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet> <20260209102117.GZ26902@suse.cz> <a77224d3-04d8-4a62-bb48-06fee922013c@kernel.org> <20260218152330.GI26902@suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, David

On Wed, 18 Feb 2026 16:23:30 +0100, David Sterba wrote:
> On Tue, Feb 17, 2026 at 09:03:25AM +0100, Jiri Slaby wrote:
> > Hi,
> > 
> > On 09. 02. 26, 11:21, David Sterba wrote:
> > > On Sun, Feb 08, 2026 at 06:25:38PM +0100, Jiri Kosina wrote:
> > >> On Sun, 8 Feb 2026, Greg KH wrote:
> > >>
> > >>>> I don't have the real hardware. In order to reproduce the bug, I simulate
> > >>>> the IPWireless PCMCIA card in the qemu by allocating and configuring the
> > >>>> necessary resources(I/O ports, memory regions, interrupts and so on) to
> > >>>> correspond with the hardware expected by the driver in the initialization
> > >>>> code of the virtual device.
> > >>>
> > >>> I wonder if this device even is still around, given that pcmcia is all
> > >>> but dead for a very long time.
> > >>
> > >> I doubt that this device is still around anywhere where reasonably new
> > >> kernels (including LTS) would matter.
> > >>
> > >> I don't think I've seen this device (which was back then donated to me by
> > >> T-Mobile CZ in order to get it supported in Linux, and I am not sure how
> > >> much global adoption it got afterwards) for, let's say, past 15 years :)
> > >>
> > >> I think (let's see what David, ho took the maintainership over for me
> > >> afterwards, has to say) we'd better deprecate and drop the whole thing,
> > >> rather than trying to pretend that it's still actively being taken care
> > >> of.
> > > 
> > > https://lore.kernel.org/all/20230223172403.GW10580@suse.cz/ last time
> > > the question of keeping the driver was asked (2023). Back then I was
> > > able to find the cards on second hand market but now I can't on a local
> > > market and there's exactly one hit on global eBay.
> > > 
> > > Local linux related or telco support forums seem to mention the driver
> > > until 2011 (root.cz, abclinuxu.cz, t-mobile.cz). It does not prove
> > > nobody is using it but I think the chances are quite low to justify
> > > keeping the driver.  It is simple enough to be built as an external
> > > module eventually, I can help with that in case somebody really needs
> > > that.
> > 
> > So, would you want to submit the removal? Or anyone else, if you don't 
> > want to lose time with this? (I can do that, if noone wants to.)
> 
> Let me do it after rc1 so I can finish the journey of this driver which
> was my first nontrivial contribution to linux kernel.

I found a memory leak in the driver:

- https://lore.kernel.org/linux-serial/20260306034058.386747-1-dqfext@gmail.com/T/

The bug has been present since the first version of this driver, but it
seems no one has noticed it until now. So I believe the driver has not
been actively used.

Regards,
Qingfang
