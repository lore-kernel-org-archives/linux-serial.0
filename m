Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63A241CB0;
	Fri, 25 Apr 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581164; cv=none; b=XaC9BfSDJDsquiobifzJ9MdOhoMFwU+dVwGESnbt544DR3Azq/NIDZVVdrcARW+Jo79IjuUfpnUiyl/mosqSzH9OW30MkR8QXA9WXsCdGwhI9VAY9xJuFxlr4ides3BwTv6eGsnW9qHC5te2yfD1ZCfCMatvKBNaPgCREUor47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581164; c=relaxed/simple;
	bh=EdIVNlrBhMPbcOu7pJo016eI1srQnax7e5HkwLJSElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgZaSIAK4r4NSevI/8s8ZcvuRkEwpmhnUklrXfjs5dYnDiK1WxoHMLj+aeDybix1CL0FeoLiiRONSXMslRuPhoH0wn2erLlsh1Il1134eKpi7JPCYR0z6OG2C9T0woxqVtupMnU65yTrc82Pij7xh+2jZZtnvcL7Z+NfORBfPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s8E3NSus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s8E3NSus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AFDC4CEE4;
	Fri, 25 Apr 2025 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745581163;
	bh=EdIVNlrBhMPbcOu7pJo016eI1srQnax7e5HkwLJSElE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8E3NSus2voUjY9ZXKYq+ar8kmV6wlfkMxQELxDZTpdAbjTqgJsZ3bbiMuWYnJM+y
	 iAy5PcZl5N8zSx1NsqM7F8psWxV2ZNEu+kytpf7knXbXrMlbRoS/VqLeFGsq9C9O3f
	 mmIo9h6dyAqbgjAqFJfo3M9akE9mV4zEcqUG84kI=
Date: Fri, 25 Apr 2025 13:39:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Faraz Ata <faraz.ata@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, alim.akhtar@samsung.com,
	jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, dev.tailor@samsung.com,
	rosa.pila@samsung.com
Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
Message-ID: <2025042508-statute-pleading-df6f@gregkh>
References: <CGME20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d@epcas5p2.samsung.com>
 <20250417043427.1205626-1-faraz.ata@samsung.com>
 <d350841c-3560-4511-a866-9490737e48f7@kernel.org>
 <06cb01dbaf5a$1ea1a8b0$5be4fa10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cb01dbaf5a$1ea1a8b0$5be4fa10$@samsung.com>

On Thu, Apr 17, 2025 at 11:02:24AM +0530, Faraz Ata wrote:
> Hello Krzysztof
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: Thursday, April 17, 2025 10:50 AM
> > To: Faraz Ata <faraz.ata@samsung.com>; alim.akhtar@samsung.com;
> > gregkh@linuxfoundation.org; jirislaby@kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> > soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > serial@vger.kernel.org; dev.tailor@samsung.com; rosa.pila@samsung.com
> > Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
> > 
> > On 17/04/2025 06:34, Faraz Ata wrote:
> > > ExynosAutov920 SoC supports 18 UART ports, update the value of
> > UART_NR
> > > to accommodate the same.
> > >
> > > Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
> > > ---
> > > Changes in v3:
> > > - Fixed review comments from Krzysztof
> > 
> > Which ones? What changed?
> > 
> While sending v2  change log was missed unintentionally.
> Added missed change log in v3.

Can you add this properly and send a v4?

thanks,

greg k-h
