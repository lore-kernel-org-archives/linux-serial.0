Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8F2E264F;
	Tue,  8 Jul 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988373; cv=none; b=qwUmYOjBeMbQ2rvRTrCuJ+CLbQKPhS9ZAWi1BrDbsFDpAnUse075P1mBszLnXqya9d/PjhvDbxWhFY6km1JVLiYt5TXSf2qqo0zmsEIc08SszWocj+Q5Z3UvPBVXuczLHPyMAGLOW2dDtQNJVvYGduxBBU76Z994M27zB0pyEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988373; c=relaxed/simple;
	bh=lgrXqSqbxoeGeRvWuWlQVmxP6BCslEUZzm+rZzF6qPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSBL89rPH+RF3obOIfouMJhHuUYTkzPvDLgOWMiRMhRhKIYT64j6wITYmgbRWjGCJXr1VS8jP9xq3TJytTE6KcXatI6NakNaaaeDZh+UsYUBfxszEsrSTr4cB+MIsA4WUGxRxMwfN6SuGWXeVz5fNq+5MxKHSDhcqFS2uWZ0OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipk0OTa4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipk0OTa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DC3C4CEED;
	Tue,  8 Jul 2025 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751988373;
	bh=lgrXqSqbxoeGeRvWuWlQVmxP6BCslEUZzm+rZzF6qPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipk0OTa4Kn27YHreY87gI6/ifFpt6kzq6a0Se2YxDli10ay9myMV6ezEIJDkznmVM
	 hzRcpkUxqwRR3pcY+23Jhw5b+Q1tXh0hGr07nDcmQ51HTMJB++Aw8Smm85ttFQHYq6
	 4iD07Z8CKYzSu1XBujxoWt94K6G/FtKHwdDEgzAI=
Date: Tue, 8 Jul 2025 17:26:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Aidan Stewart <astewart@tektelic.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: core: fix OF node leak
Message-ID: <2025070801-jelly-lyrically-0f65@gregkh>
References: <20250708085817.16070-1-johan@kernel.org>
 <2bd769b7f66bca4e97dba57276f5a29acdabb655.camel@tektelic.com>
 <aG03-g3gVMgErPIA@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG03-g3gVMgErPIA@hovoldconsulting.com>

On Tue, Jul 08, 2025 at 05:23:38PM +0200, Johan Hovold wrote:
> On Tue, Jul 08, 2025 at 01:37:45PM +0000, Aidan Stewart wrote:
> > On Tue, 2025-07-08 at 10:58 +0200, Johan Hovold wrote:
> 
> > > Make sure to drop the OF node reference taken when initialising the
> > > control and port devices when the devices are later released.
> > > 
> > > Fixes: d36f0e9a0002 ("serial: core: restore of_node information in
> > > sysfs")
> > > Cc: Aidan Stewart <astewart@tektelic.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> > Thanks for the fix. I think this also needs to go into -stable, as the
> > previous changes have already landed there (6.12.36 and 6.15.5).
> 
> I left out the stable tag on purpose since this leak should not cause
> trouble as, for example, these devices are typically registered at boot
> and never deregistered.
> 
> It fixes an issue introduced in rc4 so it should preferably still go
> into 6.16-final, though.

Ok, will get this merged, thanks!

greg k-h
