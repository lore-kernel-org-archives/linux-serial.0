Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006619D89A;
	Sat, 15 Jun 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432325; cv=none; b=VMmkey4kWUwJa9tq2MWtqHg64QJX0dVwfnmqzRQ0LGBDn70QSx6fj2u0kCAtVOdQRgkGSTlVZ4HdrtTyJNwlPRrmnFQDDOOfJNtYL4Jm4CtOWhPm0Z3x/+CLQfZehG9Kh99y8W8hBplakyyT2F64j8m4VKo40fKgf9jjFeDGgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432325; c=relaxed/simple;
	bh=wUDzTZAcFgqMo7Vchp9Bb7fHO8cLL3h9QNHdzUzdTxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCKNcakNURKV+7mAxQr+qOf2DiXVHh1wstThylxfa6tqJvn/95j8VFMbqEr5H0Aj0FR6GZO0KXa/WBLzTNuNUR9OAkNZEnQe9T9iFOtnfNqooJto2fEB1FmpQ3QGcY+cIjtFKeRPQxE5F2tivroi+3nrXrEbb07pCF02S7M37lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flXAQD/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flXAQD/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F6C116B1;
	Sat, 15 Jun 2024 06:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718432324;
	bh=wUDzTZAcFgqMo7Vchp9Bb7fHO8cLL3h9QNHdzUzdTxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flXAQD/SbDxL86CWc9TeHXz/wqtS/fuZoOQvxmCRKSq8oxDeQzbs8WrdldmTePHec
	 KC7n2iCqCIHCfs6Au8JTqfiwH6mzfQKIT4X1bkFN/bsQEgJb7TTEcckjUgigZwxNUL
	 UJlfQe+12F7b7v4a/Y9mkuPBrXWNhAPfgOLEMu58=
Date: Sat, 15 Jun 2024 08:18:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with
 the device
Message-ID: <2024061500-jeep-upchuck-6b3a@gregkh>
References: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
 <2024061406-simmering-sanded-17ef@gregkh>
 <Zm0odLN7ZJ/qI1nX@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm0odLN7ZJ/qI1nX@localhost.localdomain>

On Sat, Jun 15, 2024 at 01:36:52PM +0800, Crescent CY Hsieh wrote:
> On Fri, Jun 14, 2024 at 11:07:29AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 14, 2024 at 05:03:22PM +0800, Crescent Hsieh wrote:
> > > Normally, the number of ports is indicated by the third digit of the
> > > device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> > > device with 2 ports.
> > > 
> > > However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> > > ports, but the third digit of the device ID is `6`.
> > > 
> > > This patch introduces a function to retrieve the number of ports on Moxa
> > > PCI serial boards, addressing the issue described above.
> > > 
> > > Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_pci.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > What commit id does this fix?
> 
> None, it's just a normal patch, I might have mistakenly added the "fix"
> tag.

You say "fix" twice in the subject line, and it looks like it actually
does resolve a problem in the current code.

Or is this all just a "cleanup" change?

confused,

greg k-h
