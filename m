Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6C47ACEE;
	Wed, 29 Jul 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325858; cv=none; b=PjUJvbHIgzntIh8mcGtWEwfffJ4s2qHQgKFGZJ3nap3f6X0vUc+ll3j4+YUGhOkA4ijHaBQhgw+nK/gMu+V48SJIjIywO0r8YXwTdQT0sBOSvt1QtQ1PjgPSv77AlcC61PMyagSD59Edkytzubk1eK1bJatHhy6kM8T2OtvMFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325858; c=relaxed/simple;
	bh=ClpK3HCOZKw8gjXSOEE9pwHNXpq5BE4IpfBh+Hw9Si8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msMOVBc2wkAu+N7lhl75+0uLD2xKByqP8IeFz0+//Dxa52NE9LTRIRUAICt49fDfxgVKXbHKDYHKJS6+83DXEk218J6E3WQIcLbgjcjexAY+hevRtEAFJtdZJ/r1zWl+ORu5/5Nl6+i0wyIt/xKjAlxzlZ9cQ3GPiE523h6IEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixI891Ei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixI891Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA341F000E9;
	Wed, 29 Jul 2026 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785325856;
	bh=Ql8HTZmeaTYy1NbRlFANKEac6co52RDvo10vJCeuwPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ixI891EianjWxol6vQVw2K5ZMHN0ZdxtBWvLwrlGEmNA5ph0ZNS98bGZucJd+QdZN
	 qzLrvNL3YRaJkLWFuXqQJmff8T9JAiREz8uHGa/xmLCgnUUz7GsIGL83QuE+mjTv+L
	 FycpCr/c40alIX27Njx1WyyJx/3a+XoIMJtyAOf8=
Date: Wed, 29 Jul 2026 13:50:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xincheng Wang <22009200607@stu.xidian.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: limit TCSBRKP break duration
Message-ID: <2026072921-curled-moonlike-1207@gregkh>
References: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn>
 <2026072700-causal-remarry-6edf@gregkh>
 <20260729111927.41154-1-22009200607@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729111927.41154-1-22009200607@stu.xidian.edu.cn>

On Wed, Jul 29, 2026 at 07:19:27PM +0800, Xincheng Wang wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> You are right. The RCU stall I observed does not by itself justify
> clamping long break intervals in the tty core, so I will drop that
> patch.
> 
> While looking at this path, I noticed that tty_ioctl() multiplies the
> TCSBRKP argument by 100 and passes the result to send_break(), whose
> duration argument is unsigned int. Values whose product exceeds UINT_MAX
> are silently truncated to an unintended duration.
> 
> Do you think it is worth fixing that separately by rejecting TCSBRKP
> values that cannot fit in the unsigned-int millisecond duration used by
> send_break()?

Wouldn't that break userspace that is currently relying on that
truncation?

thanks,

greg k-h
