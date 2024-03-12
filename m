Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC57AE41
	for <linux-serial@vger.kernel.org>; Tue, 12 Mar 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239066; cv=none; b=IvliKPi1qvKRLgnxBczhYud8nPKFfF3Mr83ECqDjvh5wCJI+6T4lB+CYfvCZOSXgfB4WD3LRLt+Qe+xEXqdEKs5W+XeXQ+/sc4iajMK9uZRbeld7FTQvzGDrykpJHFlRGizKlDUFtO864eVST20SiX95yHzLCTTuTbqYGenmzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239066; c=relaxed/simple;
	bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb89ZjsLj67hKE8Up+F4igy5Prv1FuaPF7tq5e5u4HK6wvsy+7Mofl3tSOEj5sHFKunsu0UR9jO3H9OegVeu2nqLqfd+2z27jXb2Lcm5C349mk9LXJMyBQVMEFJg/lvkLLkYofuex8tkBhIy9QnNOrhjSuJr4gQFTL/8tnIcIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLPtZCbX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLPtZCbX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3163408f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 12 Mar 2024 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710239062; x=1710843862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
        b=GLPtZCbXjc7HGIotwyZxSQJEoIuAXnwF7SPlBEaecnTszdy4QamRfz7DAEX4+9pz3c
         iLh0JwCPxOOukqJC6agpASasGuZ3Yjbtn600lql2SEzZxe2noDgTuWxjXwb2CLO4tZtO
         PtD/LEZK68VTcmFLR2KK8NEvRkL90nax3xU4l013PG/+HtJnZsrphsGgqukjpSMIczaA
         kMoi1YiRQs0WxGCRppj+yJ6z+d0Zb/TPepdpETxb0LSKiJmPpFtI2U2kuqIl7shT+BtD
         LpzhpHkCMnwEttusq6L0AB1Nz0VALZy8wTH4CsdPYu4uF3ivctEpkhoNpR6Cw89BkpAq
         2apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239062; x=1710843862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWToFqxwxMP42zLNN1JswkakPz03dZF3hN1TWqvA7VY=;
        b=eLaI+NUxN4Aqwq1HRy4jfBIPakLozrsDMXYMMAZuRwgYBKAaBHFWH8jFDoJxsv2FY2
         p8FbWknl4gS2KuGrj/aoBTaJHcM66StM7Sb0ozzE6AStjl6be5Hb7tDaOhDq8gvottuW
         EmBM80KAbrNBS0rXXMUC1LXXThZysQlAG5CZr1xWNzzf/kF4fqoPPBqCasOMciDjlLcC
         fD014P/mLPH7JB4E+UkYIHX6bopB78La+61u82lz3d49KDRBLDIFr1Znw9VWDqpvOAf0
         +97gmO08Wt9SlteMSlfVHuKmOe5mOmwGIpLc2MbN2VbBlgSLqmD80pvzzTS8iER3tOVP
         5fPw==
X-Forwarded-Encrypted: i=1; AJvYcCVNH2A6XI+bdo1mtTkK92O7OxSVQb+GwMbl2N+9gyf3Hpz+5CXw8aXtwcrn50bcD9lgcx1uzLZvqh0Js3SM44psdQbd8NxtAIEl8MDj
X-Gm-Message-State: AOJu0Yym1vOd4KT8jN1ZqfjTGSk0uChrMi6/mmmISzrOCb9a036Re4Ey
	80QFYZX1lmUMbJFY5euyJZY9Y58xaLx2B3t2qXHXvdbHa5dX6LmHe6ts3XTwPQI=
X-Google-Smtp-Source: AGHT+IEtPsZ31O/nfjwsFgmU1AR9CggAYhpn6AzzX6lCg3bxmADP9OSMaPt2DsKWyzfXRygCg/rVqA==
X-Received: by 2002:a5d:6882:0:b0:33e:767a:c39f with SMTP id h2-20020a5d6882000000b0033e767ac39fmr6499492wru.15.1710239061776;
        Tue, 12 Mar 2024 03:24:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4002000000b0033de2f2a88dsm8586219wrp.103.2024.03.12.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:24:21 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:24:19 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSNOg==?=
 [PATCH] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240312102419.GC202685@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cfa3459ed848cf8f228997b983cf53@h3c.com>

On Tue, Mar 12, 2024 at 10:04:54AM +0000, Liuye wrote:
> >On Tue, Mar 12, 2024 at 08:37:11AM +0000, Liuye wrote:
> >> I know that you said schedule_work is not NMI save, which is the first
> >> issue. Perhaps it can be fixed using irq_work_queue. But even if
> >> irq_work_queue is used to implement it, there will still be a deadlock
> >> problem because slave cpu1 still has not released the running queue
> >> lock of master CPU0.
> >
> >This doesn't sound right to me. Why do you think CPU1 won't release
> >the run queue lock?
>
> In this example, CPU1 is waiting for CPU0 to release dbg_slave_lock.

That shouldn't be a problem. CPU0 will have released that lock by
the time the irq work is dispatched.


Daniel.
