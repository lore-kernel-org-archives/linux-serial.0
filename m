Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED113A86A;
	Mon, 24 Jun 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236253; cv=none; b=ZJBAJGU6InyS47mO0cKcniVwrmuRubC6tzueCdXba1egBecQLafjUaB2VOgwvxjtMUAk/fAtuaKrNJo7QLA1T4mnyRXOHyKnuPJxQo4g6OMIE/sh7ErKQYdw6DBp4WrewCjn+8B2Donky/0yCF7UK2sD+2YMZos10AIxLVQ9Ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236253; c=relaxed/simple;
	bh=1cgL7/UMBWpOqRwOkjepbWNoCYLDMNABKYbz44Gt3QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCD4NSgJRCTdoj8/aIQ25yZ/Au6v7PTKrlJVXh9g9IbZQXECNU/ULl9/eB1Sko9rc/V9gZwA8xe87CuS75kFRFPNJmKXljwxhdF3hjbPP7PVbN0WBZYmUcXiUZTq+SWk4f19BAlvrmY93TxfZNlEuIRhFYLv0RQHfGsspKPLaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyDIt5HE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyDIt5HE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041FBC2BBFC;
	Mon, 24 Jun 2024 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719236252;
	bh=1cgL7/UMBWpOqRwOkjepbWNoCYLDMNABKYbz44Gt3QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zyDIt5HEof/y1y+siBNeA+CSVAOtQkc4PceG9oHrEwwTmy6b2ocTDk/30VP3X8YPc
	 pEJLtDoCiF/WvE3suQRNlGaJTTj/D82Ju0KFqRpSsTPNNJrIpbBrbfGFhL60ue1psN
	 wN3AeWBgzxuD3EtI+ZssAl+2taleGAQfxpyORExc=
Date: Mon, 24 Jun 2024 15:37:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v2] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <2024062404-avoid-grieving-a3fa@gregkh>
References: <20240614054554.80-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614054554.80-1-ychuang570808@gmail.com>

On Fri, Jun 14, 2024 at 05:45:54AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The pdev->dev.of_node can be NULL if the "serial" node is absent.
> Add a NULL check to return an error in such cases.
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

You forgot a "Reported-by:" line as Dan did report this to you.

> ---
>  drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Also, no info as to what changed from v1 :(

thanks,

greg k-h
