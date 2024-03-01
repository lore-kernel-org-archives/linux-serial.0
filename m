Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77C6BFA4
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290778; cv=none; b=q4HlMFPqONGOX8SffAMxd2ln1L1fDg01FRIJ4OCiYNSXZ2JojltRu6/v8q1hRdypWfjPFATweoVOuZFbQu/XqeThNH3A0Lvzww6YATA8Ah64CcDEukAVyJBH6VKl6sT56TbeHcHeapa9vHgUtMni+3gSD0eVLRFvAG646T2oudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290778; c=relaxed/simple;
	bh=FwsfBDQ6oo4G7eqOtvRT/Kp2BDuvxZZ0tWNMz1sTY8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIkqUJXHiyJHAJAsjbKarSe/ukq4X/vLeCxWU/+5ZCBcheTWOaCezM09rGy9gdFHWphW82YCu+5Rjiu++45M7doNhccQ6jBVase6gCT7Yt/F8P+DDyBlZApdROjxQ18tqSTua6im75V4WwaHUbkzzfWWCC+TfC+hFKlKwgJhEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJpBYCdw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJpBYCdw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787b0b1deeaso88239985a.3
        for <linux-serial@vger.kernel.org>; Fri, 01 Mar 2024 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709290776; x=1709895576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heDjbeIBikVTGhhOlss+48ysC6wtU2DLudUIpsZswWE=;
        b=XJpBYCdwEGnGiVKisTL7i8Qs8NhjXP0fcm1eWjYKVey23bXWnmzZ/f2955HBNm8B0E
         I4dWnjFoJOa4Er2K+JyOfmpF7kBsXq75lh0cOZUGXwL2/AiktiBE7qeJ2VEh/YCHMl3i
         D8ROK4Hac/ZnMTgREdYgVSrx3TVW7tI/jbZbt2Ir01HGLdvR2Sl6f4i1cSkynktXX0uh
         1U3be8jU44GH63sS+INQjCKCTqfBVavJSHXcyPVEv9Ntg4yZgF3yjvbVdybYkgMi4lEI
         eYE9ahS9U/0ExB6Y9sxlex+eZ/RndFRjZggF5ggQGRBGQ0bIWgKZAsQ97qG4WQOUpRHQ
         SipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290776; x=1709895576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heDjbeIBikVTGhhOlss+48ysC6wtU2DLudUIpsZswWE=;
        b=LRSlbV/dx4lkxWqYvwyFPiiBQKcztw28bXsMwIns+XQJ1tuNThalawBKnw0VzS4UIQ
         jOkX58Tnxe7ACxP6yDN+V+92ZFsRcIAKhJppUrl+0bcqSsJlGe3jq8HDwqikOAlwPlNf
         DzrecrSB63ITBtBSQiumbfn7benpSkQ4Jn9aAJX2r9KLIKhzXGgDLQ6tNY4NwZJCFQFs
         bYVPZhr1RorXW3AZdHDFMfBjCA5zd1ZyTC6KEZaAUWgMnC4BHrd1ulFN+BbjN+tzUXkx
         V+9ac6WY04/TXQEUazb12wfOEfX01+EBn0bmbTXgTfRrooZn+I8JU3mbtnRs0vQu/Hjj
         MA+g==
X-Forwarded-Encrypted: i=1; AJvYcCV7yJhtG7JGdBrCzbC8H2G4KLqZoqdHTvrCpFiHMP3p3uXxtIt2GueiM1ORgYCLnfGTth8rPX0sZkhcRp6IXBRvqduYRXAc5IbBC0FA
X-Gm-Message-State: AOJu0YxITlkiKVdg0qgMeyEnImkGFEXtp6YtRkoxle8txYqr5I1BfgC0
	L+AF7wKk/LXAmKRcTcYtaCiRrClcRyiHj7tyVTr0A4VLU4OR3Ao6TbXF2x8d5hg=
X-Google-Smtp-Source: AGHT+IHN3RFUf4xIhE9BdFUrbXg7sIULyHbJcthR9TCMfAkix2nb9xh72THwDt/a538zlyKC5tWoUg==
X-Received: by 2002:a0c:fdec:0:b0:68f:3f98:f695 with SMTP id m12-20020a0cfdec000000b0068f3f98f695mr1269673qvu.39.1709290776130;
        Fri, 01 Mar 2024 02:59:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id qm14-20020a056214568e00b0068f92234e2fsm1710852qvb.109.2024.03.01.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:59:35 -0800 (PST)
Date: Fri, 1 Mar 2024 10:59:31 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <20240301105931.GB5795@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>

On Fri, Mar 01, 2024 at 03:30:25AM +0000, Liuye wrote:
> >On Wed, Feb 28, 2024 at 10:56:02AM +0800, LiuYe wrote:
> >> master cpu : After executing the go command, a deadlock occurs.
> >> slave cpu: may be performing thread migration, acquiring the
> >> running queue lock of master CPU.  Then it was interrupted by kdb
> >> NMI and entered the nmi_handler process.  (nmi_handle->
> >> kgdb_nmicallback-> kgdb_cpu_enter while(1){ touch wathcdog}.)
> >
> >I think this description is a little short and doesn't clearly
> >explain the cause. How about:
> >
> >Currently, if kgdboc includes 'kdb', then kgdboc will attempt to use
> >schedule_work() to provoke a keyboard reset when transitioning out of
> >the debugger and back to normal operation. This can cause deadlock
> >because schedule_work() is not NMI-safe.
> >
> >The stack trace below shows an example of the problem. In this case
> >the master cpu is not running from NMI but it has parked the slace
> >CPUs using an NMI and the parked CPUs is holding spinlocks needed by
> >schedule_work().
>
> Due to the brevity of the description, there may be some
> misunderstanding, so a detailed description is provided as follows:

So, there is a small mistake in the example description I provided.
After double checking the code it should start slightly differently:
  "Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
  attempt to use schedule_work() ...".

However other than that I think it is correct.

The important bit of feedback here is that the patch description should
commence with a description of the bug rather than a description of the
symptom. In this case the bug is kgdboc calls a function that is not
safe to call from this calling context.

It is really useful to describe the symptom as part of the patch
description. However if we focus on the symptom without additional
code review then we can end up with the wrong fix. That is what
happened here. It is unsafe to call schedule_work() and checking
the runqueue locks is insufficient to make it safe because we are
still calling a function from an inappropriate calling context..


Daniel.
