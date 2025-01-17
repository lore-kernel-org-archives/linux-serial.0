Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B325A658;
	Fri, 17 Jan 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114614; cv=none; b=QHt/aHy+iXkc9YoNWyf6Xciu5sGrQCwrvU9AzMCdNSxBGxs8W1+LxRMZcqplEArjgc3ZM5g9cP1ODbaSuT8QPowQ0MzOCqpeMnalvd+13MO1hMmUY/mHQLRhruiW0NztULdUggY2pYdiXrzypoYqtq0ubuwqacZQ0r4QpiQIxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114614; c=relaxed/simple;
	bh=uw0oxL/cdncbSTR7q7slu4yt628ZynwzCFOggcCb/70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5fyprzeoefScHZ1H498u24Kz9leQ/5dB4DoISEWRcnRsJvXaTkG5982PdeqhKfNzefdPSJ8CHPZ6/wimzr3U/cWZAV13Tq+iqCivbwBIiLM7ZPFFNOOw2P5hBAbxWKL1dOOACFOdHAWnHDdlwDFg+U9zKWtJGickrrjSpez76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ebPl3v2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ebPl3v2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC977C4CEDD;
	Fri, 17 Jan 2025 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737114614;
	bh=uw0oxL/cdncbSTR7q7slu4yt628ZynwzCFOggcCb/70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebPl3v2dBh6b/ucMYVZEZyvEqi41Rq1UmYBnZwc7O58d3ihXMq2LsW5NNVruv++EC
	 6FnFCGfafuPJ/baboHEzKr+CWOwh7idMFwCcDqSwvrjV79XHKNCmqIQvvbmGazs7Hb
	 9YhjgbThfchPr8ALX7t9oWt0sAdNv2avtdxPyHNU=
Date: Fri, 17 Jan 2025 12:50:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lech.perczak@camlingroup.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7] serial: sc16is7xx: Add polling mode if no IRQ pin is
 available
Message-ID: <2025011739-tavern-carpenter-86c3@gregkh>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
 <20250116083447.453615-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116083447.453615-1-andre.werner@systec-electronic.com>

On Thu, Jan 16, 2025 at 09:34:47AM +0100, Andre Werner wrote:
> Fall back to polling mode if no interrupt is configured because there
> is no possibility to connect the interrupt pin.
> 
> If no interrupt pin is available the driver uses a delayed worker to
> poll the state of interrupt status registers (IIR).
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner@systec-electronic.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This whole commit is already in my tree, why is it submitted again?

confused,

greg k-h
