Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEC3930C1;
	Wed, 17 Dec 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980388; cv=none; b=CxR0o5pzhuHJdZ9ASnPptjbvX57rMcJfAkGjYcL4i5olrQsWWZIWF8qgq8XCPrdCMPWZqpNQWz/0Extl0Kwiq0KyHuPXWxQr8mMHkFdYhEZTi0xZHz+AWPtw8b8HUqWKKbgV2JlcJw3FFYv8TVoos68/o6L8iQpqRKGlQH/zkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980388; c=relaxed/simple;
	bh=UspPA1mcPD39mhVQKtakNZ8ylsIy6x00G1m2+OmBByc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyhF7Y6JS/9T86urxrcnweRM+opTZgbLwG0mMf3mE26Hex7m4yspYASMXr7rJyDkxmvJPjJ8D2OF7D9CLXPEbI0aTPijHsmH24GU7Y6K+YnR5j2Re+1BLCtw4HRcmUoUI5EJROA2m2tb+cqjy1v1I88wC24RJQknsM8sAJB/Z+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9mRtmki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9mRtmki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4EC4CEF5;
	Wed, 17 Dec 2025 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765980387;
	bh=UspPA1mcPD39mhVQKtakNZ8ylsIy6x00G1m2+OmBByc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9mRtmki6bz/ocH/lmkDsWeCFHIUBgT1Z58xVClQzszdmoX9pcTxk3bLSHIkCoIfC
	 9+5mX/51eCrpxd3/gnVlTR7/LT37h4g/UmfarIeEzh2lcMMRsMpXQMg8oH/b3oWbgF
	 x7HWrlYwNyvVoFs25qTCDiaXobjSLwov2iDlwmu0=
Date: Wed, 17 Dec 2025 15:06:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: phasta@kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
Message-ID: <2025121710-audacious-slot-fa2f@gregkh>
References: <20251126091032.130787-2-phasta@kernel.org>
 <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
 <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de540d7789d0e9f77efde05fab4705b8d97245d8.camel@mailbox.org>

On Thu, Dec 11, 2025 at 02:57:46PM +0100, Philipp Stanner wrote:
> On Wed, 2025-11-26 at 09:02 -0800, Guenter Roeck wrote:
> > On 11/26/25 01:10, Philipp Stanner wrote:
> > > pcim_iomap_table() is deprecated. Moreover, its special usage in 8250,
> > > causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).
> > > 
> > > 8250's function serial8250_pci_setup_port() effectively maps the same
> > > BAR multiple times and adds an offset to the start address. While
> > > mapping and adding offsets is not a bug, it can be achieved in a far
> > > more straightforward way by using the specialized function
> > > pcim_iomap_range().
> > > 
> > > pcim_iomap_range() does not add the mapping addresses to the deprecated
> > > iomap table - that's not a problem, however, because non of the users of
> > > serial8250_pci_setup_port() uses pcim_iomap_table().
> > > 
> > > Replace the deprecated PCI functions with pcim_iomap_range().
> > > 
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net/
> > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > ---
> > > @Guenther: Can you please test this? I hope it fixes your issue.
> > 
> > Yes, it does. Thanks a lot for fixing this!
> > 
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> @Greg:
> Can you apply this?

Does not apply at all to 6.19-rc1 :(

Can you please rebase and resend?

thanks,

greg k-h
