Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBCE3C4B81
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581479; cv=none; b=tyGA03dPRXxhRAbMNVBMPP+FItxG8nor5Ux8vHXGvJlYD/c6t5mChjHlz5wa58MI0aksWGuQewInSN07kmmRoUcaH31+CpLHyKIMNCtRfj6WCy2RrXZ7iE/sPTpOhayaZyfdE6WaOczYMEspQyZUaObGMl632+hPPjzDUlvp7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581479; c=relaxed/simple;
	bh=dDHTNKZOwnE3CNHCeVtY1wit/6kzjJ5yOkt6faLtcOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMuu0MeC51YxPObPt1j34g9oogg5cwUj8YiEGP7Q1/ikpj74zBC4A+ugc9tbMKnTqQLSDY0fqta1FSzsMNhz8+XQzS4IBXvM5EfSg4itU6Mwl+RKVNoa7TYFjUQ4qZDVvu0z2j4XlvFneDPfYf3v/FHJFtBGJs1FlH5dr330NJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3UpWRP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3UpWRP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B474B1F00A3A;
	Tue, 16 Jun 2026 03:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781581477;
	bh=aH+x2q1OmkZMQzSooQ3QhyG6CxtQQtl+8Xz6k8T0aR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3UpWRP80+q6equkBld5DP1HSK8Dl0Gweec1+V9B+5In0I8FKkgN7k49UwXo3SLMt
	 ucWYkvdlCnq1ORmndmACHpbEcyz3z5x/MlaY3qVIxoH0DVrxDXbd6H2bY4E8wrjwMm
	 DLGUB5RtNnaBJBa7lVAnz4rUtNSHcUUmn5V2FMVk=
Date: Tue, 16 Jun 2026 09:13:33 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	stable@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	wander@redhat.com, chris.friesen@windriver.com,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 6.12.y 00/10] serial: 8250_dw: backport BUSY deassert
 series
Message-ID: <2026061641-cozy-creatable-9a9e@gregkh>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
 <c9f3545f-4522-4b78-7398-b364a4033a77@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9f3545f-4522-4b78-7398-b364a4033a77@linux.intel.com>

On Wed, May 13, 2026 at 01:16:31PM +0300, Ilpo Järvinen wrote:
> On Wed, 13 May 2026, Ionut Nechita (Wind River) wrote:
> 
> > From: Ionut Nechita <ionut.nechita@windriver.com>
> > 
> > Hi Greg, Ilpo,
> > 
> > This is v2 of the 8250_dw BUSY deassert backport to 6.12.y,
> > addressing Ilpo's review feedback on v1.
> 
> FYI, this came up yesterday related to guard()s vs unlock variants:
> 
> https://lore.kernel.org/linux-serial/cover.1778592805.git.jnilo@free.fr/

Yeah, I'm not going to take these now, I'd like to see a lot more
testing and some actual reasons why this is needed in this tree.  So far
windriver's track-record for backports is really low/bad so I'll just
drop them from my review queue right now.

thanks,

greg k-h
