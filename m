Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122921A19;
	Thu, 30 May 2024 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046383; cv=none; b=uB2MjRvk4k2KlYmI+S9AmSBieyK+72e5+h+1mv02jUo77eh9ZgFdk4KuBfNfAPeFuYX+nVVQUlO41nU/P3VsCVh9OEIMq6zKklqE4YaTe63A7oQhaUQaw6k2K33ahgYK+iL83Y8jXk6zdWnwSZPXzVkFDUg+9nCItGL5ZoLVOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046383; c=relaxed/simple;
	bh=rpyQWYN7fUPwxcE/weiN+GT69RvOr0IH6WbgbFE8Qsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liCTEBrvZB7F1Jg0qD0EAsLupvbkpWkaZsjkRB3EBksQi7CG4vjBHl8tp9lh7Kq8WC3k9WxH6NLG6xJqd4n9RZjvcI8Uoao+twlRgvr0VMIMG2udBO8qK6QjlrVmYWsgUyJIjWYekakvYO2+57BOmnrgi2lPRwDAJjON1dcN9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDFzHnkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDFzHnkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A3C2BBFC;
	Thu, 30 May 2024 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717046383;
	bh=rpyQWYN7fUPwxcE/weiN+GT69RvOr0IH6WbgbFE8Qsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDFzHnkOKmVe4tvq6TUzxugxifHCF7Jlc20xIh4vN8hocK2oNVPpb0i55Y6jEFobg
	 vXJIxREjvxTwBYAXzGveL1om/e4WaPULNiQODUGW4qhlCgiTkbQVd73OCw3sLVWXx3
	 eCuNFHjOisizdktUAFIDR8HPZjOEDnaTDShDi6zE=
Date: Thu, 30 May 2024 07:19:47 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Kuzey Arda Bulut <kuzeyb.business@gmail.com>
Cc: security@kernel.org, jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: Subject: [SECURITY] Vulnerability in Linux Kernel
Message-ID: <2024053013-overdrawn-hydrant-d8d3@gregkh>
References: <CAKmisHAUUqQ-7F+7BOymY7_3XBT1FE=gskraKDC1OmySZgS0yA@mail.gmail.com>
 <2024053036-villain-backlight-d92b@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024053036-villain-backlight-d92b@gregkh>

On Thu, May 30, 2024 at 07:19:02AM +0200, gregkh@linuxfoundation.org wrote:
> On Wed, May 29, 2024 at 08:25:18PM +0300, Kuzey Arda Bulut wrote:
> > Dear Linux Kernel Security Team,
> > 
> > I have discovered a null-ptr-deref security vulnerability in tty driver in
> > the Linux kernel. You can find the detailed descriptions of the
> > vulnerability in report.md.
> > 
> > If you have any questions or need further information, please do not
> > hesitate to contact me.
> 
> As the n_gsm is full of known issues by the developers, and the ldisc is
> not allowed to be loaded by a non-root user, this isn't all that serious
> of an issue.  See this thread for a list of problems that I think you
> might have already found here:
> 	https://lore.kernel.org/r/DB9PR10MB5881D2170678C169FB42A423E0082@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
> 
> Note, 2 fixes have landed in 6.10-rc2 for this driver, can you verify if
> these fix the issue you are reporting here?
> 
> And do you have a proposed fix for this issue?

Also, no need to let security@kernel.org know about this as you have
also sent it to public mailing lists, and given the above thread
disussion in public.

thanks,

greg k-h
