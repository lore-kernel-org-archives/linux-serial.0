Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430C23767;
	Sat,  4 May 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838503; cv=none; b=cCCi07VenxZjkwbwYV//dUcXTn3QhveCJ6f+9JrRLlNuEpiaHf9rl5D/UMZbwTGYnhw0jYke3a4hA8tBrJ8nfs//4ncXDuLeCB6qVzUh3LhBGB6U7M5FlXp5PwrctV+lY8zz6yoyuW9HYhhx+vJhI8yFWCSrqA6kex2HNQyVOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838503; c=relaxed/simple;
	bh=gf6jZj0RO14a3jrqluReftPD7w24qIhL5Sxeb0U3J/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcE7PfymSNsYI9ENxD+pvTMHskGFiNBso17UWhBYJenmSrD0rJKVMqxWINLMW1BGN6i5cI/BLuW0+3sv+A2uM/b4BjZHpEmxfdYgcEgXlAM4BCv2NubYcYzjlKblfeKicQCBoyE7y2k1ns7fM/4GVKb0e7HkOUZ0l+hYf0KWX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLpODsBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLpODsBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB44C072AA;
	Sat,  4 May 2024 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838502;
	bh=gf6jZj0RO14a3jrqluReftPD7w24qIhL5Sxeb0U3J/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLpODsBImnuuTiIGuDLc5nSv4zX3Hq5le4elqtg4qDyEKucUDtganpmV4m7g0GKKH
	 cdhKsRIc2mh/WB8VuJHooo1rs4fvrHvvC+x4UtWvvlnXss25PBdv4TVKWmGKOdii/g
	 GM6Np9f0xVVHSiLdadx39WIYG6goVJ6aCmgllRHA=
Date: Sat, 4 May 2024 18:01:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 0/4] serial: exar: fix kbuild warnings and code style
Message-ID: <2024050429-disorder-revolver-5b74@gregkh>
References: <cover.1713533298.git.pnewman@connecttech.com>
 <20240502121809.30491a67@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502121809.30491a67@SWDEV2.connecttech.local>

On Thu, May 02, 2024 at 12:18:09PM -0400, Parker Newman wrote:
> On Fri, 19 Apr 2024 10:17:00 -0400
> Parker Newman <parker@finest.io> wrote:
> 
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > This is a series of small patches fixing kbuilds error and code style
> > issues based on feedback during review of main patches.
> >
> > Original patches thread:
> > Link: https://lore.kernel.org/linux-serial/cover.1713382717.git.pnewman@connecttech.com/
> >
> 
> These patches should not be required anymore. Andy Shevchenko has
> submitted a more comprehensive clean up patch set that makes this
> set unneeded.
> 
> Link: https://lore.kernel.org/linux-serial/20240502144626.2716994-1-andriy.shevchenko@linux.intel.com/

Thanks for letting me know, now dropped.

greg k-h
