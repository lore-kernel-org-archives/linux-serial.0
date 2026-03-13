Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095481F1518;
	Fri, 13 Mar 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391089; cv=none; b=sQjAE34vq8yiB2wEbefQ9SPzWndBacxld04K09W0ud7+73/3ksChgTTehn8yIK8JvHfXVeQc3LIhQmDkijPgPXOtavxq5LbqTJwzmXLQoU16pin5Xd+CwAkxXWY9lwAMnhAL3TFEOkhrwcjlCSIgeGU8UkWngZO1eQPpNzLW1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391089; c=relaxed/simple;
	bh=+DQAZ2QqmDXChGxFSDzA3c7+G1FjFpYdpbI7ZxXSdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM88MM4Ujdubbfan9bJLyRhw0JY7zJgkaO9+m+8d55oJHfYshcDsq61jhyXEoyEyio7T825hLMqQGHc/tCc5Jf8wJ1FXa2LAjUZUDNk99tS7H37u1PZnQliLfHCai+1nwKKzKo0Kq/uOKpgRMqkBwza8RPT/wy/DBD8kH177Otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pfach8Sp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pfach8Sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED1FC2BC86;
	Fri, 13 Mar 2026 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773391088;
	bh=+DQAZ2QqmDXChGxFSDzA3c7+G1FjFpYdpbI7ZxXSdFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pfach8Sp1Xcohxx8uVuwVcIy5qgBTo0ewNjvIMbYYI8RKfFBdNrV5mp1olVwchEy8
	 fu7zCEvNgR3PSu6B8VbyhQ1mkfUFNR+86727gC/2ctCSp5LYYreUJl4A0udAyGsgHz
	 5W6sEiwabH7JEgUHUarO5nClAeqCyYyAiOy/Z6DY=
Date: Fri, 13 Mar 2026 09:38:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
Message-ID: <2026031324-require-cider-062d@gregkh>
References: <20260203045457.1049793-1-nico@fluxnic.net>
 <2026020851-bullhorn-glitch-0e37@gregkh>
 <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
 <2026021006-reenact-suave-c86c@gregkh>
 <p6r658p5-4q55-8pn6-q78n-107599qq653n@syhkavp.arg>
 <2026031225-daylong-uselessly-1821@gregkh>
 <69o09136-13nq-41sr-s3o8-s6sn68rq1s8o@syhkavp.arg>
 <2026031309-arena-obsessive-f68f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031309-arena-obsessive-f68f@gregkh>

On Fri, Mar 13, 2026 at 08:11:31AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 12, 2026 at 02:56:05PM -0400, Nicolas Pitre wrote:
> > On Thu, 12 Mar 2026, Greg Kroah-Hartman wrote:
> > 
> > > On Fri, Mar 06, 2026 at 01:26:56PM -0500, Nicolas Pitre wrote:
> > > > On Tue, 10 Feb 2026, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> > > > > > On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> > > > > > 
> > > > > > > Argh, sorry, I saw this patch series too late for this merge window.
> > > > > > > I'll review it after -rc1 is out.
> > > > > > 
> > > > > > Too bad.
> > > > > > 
> > > > > > But please at least consider  this one now
> > > > > > https://lkml.org/lkml/2026/1/27/1886
> > > > > > and queue it for the stable tree as well.
> > > > > 
> > > > > Sorry, that slipped through as well, I'll grab it after -rc1 is out and
> > > > > get it backported to stable kernels.
> > > > 
> > > > Ping.  ;-)
> > > 
> > > Sorry, am catching up now...
> > 
> > Thanks, appreciated.
> > 
> > Also please consider the patch fixing alt screen support linked above.
> > That one should go to stable afterwards.
> 
> That is very odd, I don't have a copy of it anywhere locally, sorry
> about that.  I'll queue it up later today.  Thanks for reminding me!

Now applied.  If I have missed anything else that is pending, please let
me know as my tty/serial patch queue is now empty.

thanks,

greg k-h
