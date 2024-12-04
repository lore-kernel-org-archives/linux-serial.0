Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAC202C3D;
	Wed,  4 Dec 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335614; cv=none; b=NnD1J9TYzPEtu7iObCKjnIWrb9t0TAS4d5V9/jTuQ4TBOdz7b9D/2ftDpSaoJh+NDMNP1w1NPNugvu6bCSIU3i6mrwSJbTRJyq/56VtEwv/7HFRsZDWycoVCgtyg92+joST6BG0pdGzjCzZeA3tJ0d24S/EUy7h8QbKzdzqQtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335614; c=relaxed/simple;
	bh=BzdpRSI6bTwBmCu3ueQwkbr9uSAZ4xHSZF+RLh4Fh7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aktm5RyGFSH7UWpuO3eDl8vFseJqb5UQd+4J1Xls1fF9ZfIB85OFhJu9HoSvDzP6ndKGzQWDYa/Cc6gl9TCEalfHO/Fbf8AhSyRuK18mybX1fgRZaNU+oolNVIQUVdng/8w2YBxo+QFx+BnudrRoh3KBtOsXh0w/cSwR/1VxZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X0LAUChE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0LAUChE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0433C4CECD;
	Wed,  4 Dec 2024 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733335613;
	bh=BzdpRSI6bTwBmCu3ueQwkbr9uSAZ4xHSZF+RLh4Fh7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0LAUChEwCPgA/VV4AdrWeghoSmRJwM3kFdlmCvtH1sNdyQjGIku5l02DRS+r+4JP
	 fH/F8RLqBOUhqLV+npZVhKCAXL4NH5dcHgGDyXVzD7ZJP5FYT16/Q6KmeJpKzdypuF
	 XfezvmK2NKWu3YyUX2XYRW69SCu4R4ksQOT7R70M=
Date: Wed, 4 Dec 2024 19:06:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: n3rdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024120408-moneyless-stood-cda2@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <20241129041549.778959-2-bluescreen_avenger@verizon.net>
 <2024120401-grapple-saddlebag-e674@gregkh>
 <1791540.X513TT2pbd@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1791540.X513TT2pbd@nerdopolis2>

On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > initialized by console_initcall() and selected as a possible console
> > > device.
> > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > 
> > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > real name here, sorry.  I can't do anything with these (including
> > reviewing them), until that happens.
> > 
> Oh, I thought that I didn't need a real name
> 
> I found a recent thread that seems like it suggests that I thought
> https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> https://drewdevault.com/2023/10/31/On-real-names.html[2]
> Or do I need to wait for that change to the guideline be merged?

That change has been merged a long time ago, but as far as I can tell,
this signed-off-by you used here does not meet this category.

thanks,

greg k-h
