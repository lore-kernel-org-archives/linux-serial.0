Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397C1362;
	Tue, 25 Feb 2025 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458037; cv=none; b=n0iQ5XEHuxxACrE/llUJn+AshqJev1VourTgusZIovIxIocF87Hn/HOoU/OvnymMhhOjIkH6z0u6RjHccGQ8EQp2QaK3/UdIu6Lc+eRDmQpVlBSrffU3CmT9v06/Wr6eVNqItqIgP2z7cW6D6+bd487efcIhnBB02hOCFCmsrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458037; c=relaxed/simple;
	bh=eUyOIgdhZEGdlkSyY9vqN1/2N2DmG9kzcX6jjLMiPEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSck53L33csAmJTqBAWZuPqwVsV7LeyUxoaMUKSsYn6ZvqE2TKkcEP1LtAHyQtYpbiwidZDv9PumbqbkBpNzPNgKWePFhjmE973Y/b2JDK/w9KTTHderRNj5G8oIp8/3QJCEVElIOuFAVfMcHKDUt0WajmYMUAgeU2imwJM77e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yrajGa6T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yrajGa6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D683C4CEDD;
	Tue, 25 Feb 2025 04:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740458036;
	bh=eUyOIgdhZEGdlkSyY9vqN1/2N2DmG9kzcX6jjLMiPEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yrajGa6T5whGU5YBXQ6oD5IjJJIhgM8Tv3j2Mc3ngdVFupSoPO0178DIDpgV/bPjQ
	 NyTvAvlyjL9THIz1KAwEiOk12eyt8P+sRqS6WgQrEo6P+BetaUs0Y5Jo0bhKj9CGDb
	 vp3MSh6NPAB4lykGwCM9uluC6LLnNrj1kG8HADgY=
Date: Tue, 25 Feb 2025 05:32:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Alan Mackenzie <acm@muc.de>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <2025022528-humble-chatter-4e7d@gregkh>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>

On Mon, Feb 24, 2025 at 09:08:50PM +0100, Jiri Slaby wrote:
> On 24. 02. 25, 19:22, Alan Mackenzie wrote:
> > Hello, Greg.
> > 
> > On Sun, Feb 23, 2025 at 08:47:53 +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
> > > > On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> > 
> > [ .... ]
> > 
> > > > But I think you are also asking why I use the console at all.  That's
> > > > a fair question which I'll try to answer.
> > 
> > > I'm not disputing using the console, it's the vt layer that I'm talking
> > > about.  The DRM developers have the long-term goal of getting rid of
> > > CONFIG_VT which will remove a ton of mess that we have overall.
> > > DRM-based consoles should provide the same functionality that a vt
> > > console does today.  If not, please let them know so that the remaining
> > > corner cases can be resolved.
> > 
> > Does a DRM based console exist at the moment?  I spent quite some time
> > looking for it yesterday, but found nothing.
> 
> I didn't read the thread, but are you looking e.g. for kmscon?

Yes, that is what I was referring to, but couldn't remember the name,
thanks for the pointer.

greg k-h
