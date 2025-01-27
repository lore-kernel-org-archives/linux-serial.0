Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF09179BF;
	Mon, 27 Jan 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973375; cv=none; b=lv18mX3JyeAxtVEKmgJxlJLsPpNMXtc2Aymx3SSFFKoJAxNRrDsBFc1lGJiQ0UREnzUcT8ZHEn/hrAV0WhBXLH6hifY1JPBETSW9PRYMSGAN3+wk8pj6aA4UYAezH80LYSt2YRA8PltmMTXBHXETezDkus70nYoQxjuCNPz79cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973375; c=relaxed/simple;
	bh=YILHhU34OGB5WGf3KiV5GSpQC5EsmezsSrCF5ss68Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg1jjUnXVJcCuO158kPcU3m0aT4Zd/xjyVrjJcy+yQr+WJYQylrqMIVnQ0NXDCq6pI0yu+PkN6e/u3UqXR6WL2Qr+RSRAlLYWFJsLXfY7VZLA8F27nkssyg00t4eCHItGRmeMOgZt72gZERhPuZpmodRbWqoeQlqvBfVkPdfK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v38tgpwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v38tgpwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A50C4CED2;
	Mon, 27 Jan 2025 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737973374;
	bh=YILHhU34OGB5WGf3KiV5GSpQC5EsmezsSrCF5ss68Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v38tgpwpB9prDeM8+ZAp93XEZAyAcnRzssQeIn1p0n+ojFfdBMvdIdIa/XbzHZ3Vz
	 ekSgy8Rl5/THH4LM1dSscepSiDzBUBDnav2nOlleCepaRRYR8HDdywHkn9g4X1QYp7
	 eM5ZTbh28VfusMW4JamnTrvSM3LQ8UMfUg6Yu270=
Date: Mon, 27 Jan 2025 11:21:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is
 disabled
Message-ID: <2025012735-lustrous-finalize-d47f@gregkh>
References: <20250126163115.3200308-1-eleanor15x@gmail.com>
 <2025012604-undamaged-earring-d16c@gregkh>
 <Z5dD5Fz2vf-nnjvg@eleanor-wkdl>
 <2025012726-macaroni-unbiased-e6c3@gregkh>
 <Z5da0aCupnXRvjr9@eleanor-wkdl>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5da0aCupnXRvjr9@eleanor-wkdl>

On Mon, Jan 27, 2025 at 06:07:13PM +0800, Yu-Chun Lin wrote:
> On Mon, Jan 27, 2025 at 10:12:47AM +0100, Greg KH wrote:
> > > So I should remove of_match_ptr and add the CONFIG_OF as a dependency
> > > for the configuration. Correct?
> > 
> > I don't know, but putting #ifdef in .c files is not the correct solution
> > at all.
> 
> I fixed the build warning this way because I saw it was done the same way
> in these three files:
> 
> drivers/tty/serial/samsung_tty.c 
> drivers/tty/serial/mps2-uart.c
> drivers/tty/serial/altera_jtaguart.c

Those too should be fixed properly.

> Or maybe we can add __maybe_unused to avoid the warning?

No, again, no other bus has this issue, please fix the macros properly.

thanks,

greg k-h
