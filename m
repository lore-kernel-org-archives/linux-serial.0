Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABE2AF0F
	for <linux-serial@vger.kernel.org>; Sat,  2 Mar 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412306; cv=none; b=QOzN1sH5IAFlvv2W1cj2/S0unSlBqG+mTbmypo2jk92b5Ys8eE6miz5WtNQ+Viieegstumbq+30HuFwMs5Pxf3Q8XcHdRh4KDSYF79KP1YEt1R5rAbfNHsYTfTR2gr3xlSj10eY1Np/gwXQjvbOa50wGddJREx8saWAMv8t94gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412306; c=relaxed/simple;
	bh=fB7Gy4PBvncnttryNkXLnQN0y/0qh7zc/IxZufJTxbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht8SBX1vbDahmTzSiNkLsK4wEQoaKYF/+8VaAh9Iug9SK/D5TokLTYPI7CW/ynMaKIFiU8RNLno4xqDBF2GYM8RaA3rMotc0cZ3B9xT4dr4/Dm5Nht7Y1jqlOjE2phWLUTyNdJGI+I7n39C1DzmfA1bA5i7fzTYRHJVGEnOwWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y89k0ERw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y89k0ERw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27FCC433F1;
	Sat,  2 Mar 2024 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709412306;
	bh=fB7Gy4PBvncnttryNkXLnQN0y/0qh7zc/IxZufJTxbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y89k0ERwMM1z8zU+PNO5Fv/QJRdbYkdGSkcPo8N2+NuiUKw9CeD0ZYmCRtK4/XmyS
	 4lyKYDPHUPXt67KMxXlSejwfBpL6CfwhmDdZPZjpeZ3EFB2huIzUEyFQjv39/3QVgy
	 5LDoDGKwzLz8TmvRzsNQ56j/ZLiksyv/IP+yjGbg=
Date: Sat, 2 Mar 2024 21:45:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: fix unicode buffer corruption when deleting
 characters
Message-ID: <2024030251-frolic-unequal-459a@gregkh>
References: <88n6qo5r-2986-r273-9n4p-pr77q314727r@syhkavp.arg>
 <2024022936-chloride-concert-12a6@gregkh>
 <3840o476-6p58-q897-101r-34n723p16oo1@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3840o476-6p58-q897-101r-34n723p16oo1@syhkavp.arg>

On Thu, Feb 29, 2024 at 05:10:56PM -0500, Nicolas Pitre wrote:
> On Thu, 29 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > On Thu, Feb 29, 2024 at 04:05:51PM -0500, Nicolas Pitre wrote:
> > > This is the same issue that was fixed for the VGA text buffer in
> > > commit 39cdb68c64d8 ("vt: fix memory overlapping when deleting chars
> > > in the buffer"). The cure is also the same.
> > 
> > Please spell out what the "cure" is here, so we don't have to do and
> > look up another commit somewhere else :)
> 
> This is an obvious single-line fix. Or, are people only reviewing commit 
> logs now?  ;-)

We always review them :)

> Revised commit log coming.

Thanks for the update.

greg k-h
