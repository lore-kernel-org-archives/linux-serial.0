Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A43408014;
	Fri, 10 Jul 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685859; cv=none; b=k+/xoQVFsU1W5gC1AFG6FcsBrs4dr3644UDdjS8ywZvKqX1QDT8XowJTHN0iNna2u/ISNNTRxnnjrr56W+AywVyuYcuYvO/p/0OLK9Y+5dRaPZP9ufXB8Wq7XEG6XlLO3jFrn8xxPlWEfNg2x3NKhyL64uQtcCQ6ItgrO2y42e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685859; c=relaxed/simple;
	bh=lgYXuPbiW1Rt3KP1LOF2LXxjZbS4LP8xtjVx8DcyCjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH1iUYbStpHenrUynHy9fbyaawAukGqTmLy3ftmVVjuNT8wKUEzWZ+22LXrN0iRbs4U3yviq2Ny2i/NTqaREuyaycSVaGjkgBSjIhlMvU3Kr1uG5hTw83mS0Kvb9uB/waIXPHD6VjCvYPBQyS1I1zomLJcIfoKcXQvatKzMFmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRBoKN12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRBoKN12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0621F00A3A;
	Fri, 10 Jul 2026 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783685857;
	bh=xbchqjng8L5w3T4V3XGFQmYXrGJj6KHjmAyt8gfd4vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kRBoKN12k0bZeP74aM6FRILwfc9kOmTpPc0elFvQpOMXWdk6bf4RgqOhGXcVoRPWA
	 jcy/ZRSaULxD1+IAjJ9B1JaRgKXAHhhnVajoW+K3dLsY449UgQPacKiZpef9oYpySv
	 rvFg79OMp27zOCmVJMmZ38qgd0oM/uEz9EhAevi8=
Date: Fri, 10 Jul 2026 14:17:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong@fnnas.com>
Cc: Jing Wu <realwujing@gmail.com>, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Message-ID: <2026071037-subprime-padding-3ba9@gregkh>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
 <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
 <20260708071138.3698581-1-realwujing@gmail.com>
 <20260708073938.3975921-1-realwujing@gmail.com>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
 <20260708080820.62288-1-realwujing@gmail.com>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.9be37cbd.7a04.4d7e.b20e.d3f90675af6e@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.9be37cbd.7a04.4d7e.b20e.d3f90675af6e@feishu.cn>

On Wed, Jul 08, 2026 at 04:30:21PM +0800, Wang Zhaolong wrote:
> Hi Jing,
> 
> No.
> 
> A changelog entry describes what changed between my v2 and my v3.  It is not
> a claim that nobody else ever wrote a similar line in another patch.
> 
> The functional fix in my series was already in my v1 on May 27.  Whether my
> v1 commit message named the UAF or not does not change the code: holding the
> same mutex across link and unlink closes that window too.  My v1 commit
> message intentionally described the failure mode I had reproduced and
> validated: the unbalanced IRQ enable warning.  I did not want to overstate the
> impact beyond the evidence I had at the time.
> 
> The v3 rename follows Jiri's review comment that hash_mutex is no longer an
> appropriate name.  The __must_hold() and lockdep_assert_held() annotations
> document the locking rule after the mutex was moved to the caller.  They are
> not the functional fix.
> 
> I do not agree that Co-developed-by is appropriate for my patch, and I do not
> authorize adding a Co-developed-by tag for me without my Signed-off-by.
> 
> I am not going to continue this argument.  Maintainers can decide which patch,
> if any, to take.

As I said before, I'm not going to take either until you all can agree.

And yes, a co-developed-by does require a signed-off-by.  Without you
all agreeing, none of this is going to be acceptable, sorry.

Also, all of these really look like they were created/found/whatever by
a LLM, which is not being documented, and for that reason alone I think
I need to reject all of these until that is properly addressed.

thanks,

greg k-h
