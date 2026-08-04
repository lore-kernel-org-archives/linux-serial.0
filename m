Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091E377A88;
	Tue,  4 Aug 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850320; cv=none; b=aoW48mpgodPhnQMXnQEUfVo2Vc/PMEYe5phD4V9nxrHpAMTph/ZcZ40+B4kwpMHXyvtApCH2h8jozxrXFP9siofJkiFwfKwJbjegp5rJuyvuudtpPTy0XNGNAqPWgGX2mdF1CM0n0PcTY09zmYXS3mD03A3tp8ezLz/oAEHgwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850320; c=relaxed/simple;
	bh=N2/DyItSBSM/svBTg+YhJMy7XpdlEktvm9BaAuGsaVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUREXUImzgANhnygGDOdkKEq2v7TGZTiRFTp8SGzZiWl28scAl0P8lBoHGNzpRefqJE9fP8WVHT8CpVRE0Fhval2gUT9ZluIoqpxqLOjLHN9uftr9CsxEBUbR3UQYmG+ccGaB13AA/TWzf8mCrx3vcJLeY2zHgGrq2mjKcGCN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OaIqrhoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OaIqrhoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FEF1F000E9;
	Tue,  4 Aug 2026 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785850318;
	bh=gP2YyHJlYTTGcm5xnKYvRRxd29PnJkWYm9/gFEwp5Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OaIqrhoU7E97s/Y/leEK7QuWHxasOl+KU73NUjXI/TsclgbjTfxspUuoz15rgd3j5
	 wHS9y/cyQmFw6eHBLD7y3TAAs6KeWupOlVLqlsYJ8muomjZ1mVozaLs7hqyGYt2+Mn
	 8X7RaiFho5SSI0vbw60YSI86vf64CfAVQ7DF1NpE=
Date: Tue, 4 Aug 2026 15:31:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH] tty: moxa: remove driver.
Message-ID: <2026080434-bundle-syrup-582d@gregkh>
References: <2026080345-unmapped-sliced-49f2@gregkh>
 <7a3538e1-444d-42f5-b48a-0a8eb9f2625f@kernel.org>
 <2026080429-deforest-snowiness-90ad@gregkh>
 <0bcdcb38-78b1-47e9-9a4c-4df0bb8380c6@kernel.org>
 <1d3fb866-afb9-4bdb-86f3-a5611bc141ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d3fb866-afb9-4bdb-86f3-a5611bc141ae@kernel.org>

On Tue, Aug 04, 2026 at 12:19:40PM +0200, Jiri Slaby wrote:
> On 04. 08. 26, 12:18, Jiri Slaby wrote:
> > On 04. 08. 26, 11:57, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 04, 2026 at 07:12:01AM +0200, Jiri Slaby wrote:
> > > > On 03. 08. 26, 14:52, Greg Kroah-Hartman wrote:
> > > > > This is a very old driver, and no known hardware is still
> > > > > around for it,
> > > > > and the company says they do not need it anymore, so let's remove it as
> > > > > the LLMs are starting to poke at it and find "interesting" things which
> > > > > will just waste everyone's time given it's not actually used.
> > > > > 
> > > > > So let's drop it.  If someone really needs it, it can come back in the
> > > > > future, in a more "modern" way, as the style here is very old...
> > > > > 
> > > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > > Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > > > > Link:
> > > > > https://lore.kernel.org/all/afqyY8FQ8ZfpH48_@moxa-ThinkCentre-
> > > > > M90t/
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > LGTM, there are leftovers though:
> > > > MAINTAINERS
> > > > 18341:MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
> > > 
> > > As you said, that one documents the mxser.c file, not moxa.c, so should
> > > I just remove both and this entry too?
> > > 
> > > And the .rst file needs to go, right?
> > 
> > SMARTIO/INDUSTIO = mxser is supposed to stay.
> > INTELLIO = moxa is being removed.
> 
> That being said, the "/INTELLIO" part should go.

Great, will do that, thanks!

greg k-h
