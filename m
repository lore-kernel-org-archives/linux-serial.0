Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D62E11B5;
	Tue,  8 Jul 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988226; cv=none; b=iVm8HbvqT1EW8KHF8AotmXLLHF7Xw0ZvHEHtAyNjvj43Je8j4we8IIsCSueF5k2TgcK7A6Q/1QFocgKjMVb2rTPexM4Yh8EsNHRTAecqLIEEwAXE14NhqtwpWGFdDkMxzLMEQngsb0/eNNbFAaTOs23pLZ21vf+W2Y99+qC+h5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988226; c=relaxed/simple;
	bh=DHMgSvr3ucJqg5KG0Cd+fOSL+dhmKBGGzPCyEsmap0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBaG/XNnERuEJedR2gNh2HXvlw9HiLl47Pe/8LvRchSuOVKG+q65tVHDnuOpU7OctDv3D9SfgaE1ETPzncg/2+ZyY7xKCkhRpE6nvXK4JjRnd+ATKLWOI2biWlN7ss+ycOUYexZGC/FkgFIeFAAvrHOqmi/01BF5q4dWYp4oXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBuHu5GN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBuHu5GN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CEBC4CEED;
	Tue,  8 Jul 2025 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751988226;
	bh=DHMgSvr3ucJqg5KG0Cd+fOSL+dhmKBGGzPCyEsmap0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBuHu5GN42W7PpnRNBi0Wk4s/xbiwoAuPovbqjpyzSFV0SfxpjTaE5M2GktALUaFm
	 hB2Q15WlUsA1Mfx6fHJbr98nTdGqrJ+nKe2v0VbgIotoAOjp4Rr/EfB7z61TgW4ntF
	 +Wv7mH9jd78TEOGh6yuRaQXg+1VzvSTLnNiYor9zV2d1xiYBppCV2zMSF076P4LUPR
	 xsIQt9I36MyylUrYM9lhUsD7Vbai2hm5ixEfmSQZY8+VbEVFMnrXa1WZFQ4+m58D3g
	 O27yHpWfjjLiwKBl4ZWreG7E53IMERLbWJFTRthg88g1LbaCCxuhmDCeNXZPq+Olwm
	 bUQX6sBdAfC9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZAAU-000000002Ft-26Xc;
	Tue, 08 Jul 2025 17:23:38 +0200
Date: Tue, 8 Jul 2025 17:23:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Aidan Stewart <astewart@tektelic.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: core: fix OF node leak
Message-ID: <aG03-g3gVMgErPIA@hovoldconsulting.com>
References: <20250708085817.16070-1-johan@kernel.org>
 <2bd769b7f66bca4e97dba57276f5a29acdabb655.camel@tektelic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd769b7f66bca4e97dba57276f5a29acdabb655.camel@tektelic.com>

On Tue, Jul 08, 2025 at 01:37:45PM +0000, Aidan Stewart wrote:
> On Tue, 2025-07-08 at 10:58 +0200, Johan Hovold wrote:

> > Make sure to drop the OF node reference taken when initialising the
> > control and port devices when the devices are later released.
> > 
> > Fixes: d36f0e9a0002 ("serial: core: restore of_node information in
> > sysfs")
> > Cc: Aidan Stewart <astewart@tektelic.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> Thanks for the fix. I think this also needs to go into -stable, as the
> previous changes have already landed there (6.12.36 and 6.15.5).

I left out the stable tag on purpose since this leak should not cause
trouble as, for example, these devices are typically registered at boot
and never deregistered.

It fixes an issue introduced in rc4 so it should preferably still go
into 6.16-final, though.

Johan
