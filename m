Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252403DB626;
	Thu,  1 Oct 2026 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844309; cv=none; b=PiiY1Rhv6gaKT+abbJr81VgEvCsUCbVQ+/vU3TTPIlAphzeX5Agi11y3xQBlUuJ0PSnBPPG4Z7ZQSiTXE9A/Yj/cUm9wjTPUzzVLjjtKx7wyb/ePYveEQOeU7gauKzkssKpP6XXIfBX29NE5FA/xVe8Fygjpp6d8cns2QW4g1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844309; c=relaxed/simple;
	bh=AW73VSbTnDxUJbrzGPe5Lxf47svXwwaiUm8d4EFr5yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW+vXREfqfnvY0DE1WK31uakvCOLqTbZMaWkB98FzbA8h3wxlVc9ugfQUXWbA79bYhrRijBXewUbEfjort2hPVq7guWENiJyJk0sOVxyb7h32DyznK3ToazHDfS8lZPmxPOZIiPV2Ej1dKpJ9XdSixKWRB+BCePFyoCRELjWPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTiwQFsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTiwQFsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157511F000FF;
	Thu,  1 Oct 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844307;
	bh=gKfEG8QCBi+EkydhyBHP45AhFfxZuKGfAP2C3xABDoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTiwQFsX5pi5tTgeWr+QpBSsBmk0QrTJpijz0u6ubv6BthjGv3VP5djjzKSrMIPmT
	 cQHBRdqR5A2x3aUiqkIGegwf5c+CgtdbsBNOIWYV2Ql8m6tzWlAl0QqoikFhcg0AQZ
	 hTjNOFzOgho5BRsJcns9T8xj9YeER3hIOhal1RD4=
Date: Thu, 1 Oct 2026 10:45:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:FREESCALE QUICC ENGINE UCC UART DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
Message-ID: <2026100132-geology-shingle-d005@gregkh>
References: <20260927204317.21546-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927204317.21546-1-rosenp@gmail.com>

On Sun, Sep 27, 2026 at 01:43:17PM -0700, Rosen Penev wrote:
> Avoid calling irq_dispose_mapping() by letting the platform_device
> machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> and other errors. Handle before any allocation or anything to avoid
> dealing with gotos.

I can't really parse this, what is the bug here that you are fixing?

> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: move platform_get_irq() earlier.

Why?

thanks,

greg k-h
