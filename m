Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5ED42AA4;
	Sat, 30 Nov 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981195; cv=none; b=p9SCDA5tVAxtztf89bK76TazTtgjQsGn/plzCVTVtNrBa7kDZQiykY1DIgbX/v/+jTBOwkQUS56ltfI5wa2cYFjlm+NmQ9UWfRoQa/sLinZtJb7KGgSSJDpAEf7wcVXXtP9f4SPTQu/VvkRdZxE3+ffwTusbXrr1NjtuHmaayrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981195; c=relaxed/simple;
	bh=Lyc3mKQH782g5MAGATjSEsWC8NbYEDRLbMns1o58Uvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2DjLw8g0LyzyZU3IQuGqQ95MYeRczTGfEI78vDrD7oLGplvXSudfXxN7rBXHA0UFvuNcJ6tmGiPkyrMhPd/oPNe/qxvBUIf5MvHLWmncI7SZO68ahB32x+RLd38ExImnpZ1QIzHfem8lMQ21CylFlAdqMkCBKshUAZfGW485Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAXfdKvN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAXfdKvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0FC4CECC;
	Sat, 30 Nov 2024 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732981195;
	bh=Lyc3mKQH782g5MAGATjSEsWC8NbYEDRLbMns1o58Uvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAXfdKvN4gcXnV34JvKgrR4nWW9bOm9S8M9Zr7JYfaxTPTdaEj77ifbjl7tfxWo1q
	 60Jn/gLaDxMRjvYk8CopLPWmtMeuYfYzLvgZZMUn1rvO3Q0I8TsD7VYaxpN2zuTzWm
	 LbftE09H+BrryiXMFkQmy3nFHHNHfxpDlCvPFb5k=
Date: Sat, 30 Nov 2024 16:39:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
Message-ID: <2024113014-onward-deflator-f9ca@gregkh>
References: <Z0lCihhE75lE9Zjd@kroah.com>
 <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
 <2024113002-countless-stilt-ff36@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024113002-countless-stilt-ff36@gregkh>

On Sat, Nov 30, 2024 at 04:35:35PM +0100, Greg KH wrote:
> On Fri, Nov 29, 2024 at 12:28:07PM -0800, Linus Torvalds wrote:
> > On Thu, 28 Nov 2024 at 20:26, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > TTY / Serial driver updates for 6.13-rc1
> > 
> > Greg - I've dropped this pull request since it sounds like it will
> > need a bit of fixup.
> > 
> > But holler if you prefer I take it as-is and I guess we can fix it up later.
> 
> Please take it as-is, I'll send a revert right after -rc1 is out to
> resolve this (it's only for early-console for one serial port type.)

Oh let me just revert it now and send you a new pull request...
