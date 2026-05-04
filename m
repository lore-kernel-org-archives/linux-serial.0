Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B92153D8;
	Mon,  4 May 2026 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875902; cv=none; b=j+f37izlHdfCEk6VEU2SudLmf29MB4RJCCGGNhc2S7FItpKbB6Au0jxOhSLiY2K9xCy9zCBqhJuP3b14UVnRZ8SlPKBpM3HDkfpX7ytdtaWI+j6tP0SWXaHYUcrFuFZMBcsPBtGkDSIZtHtLPC2SsQJhdDzpsWqRodeUPwJMjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875902; c=relaxed/simple;
	bh=HiDQvzsgCp2zqdwpLBizDxSsrpuxti6bbhLVZ0rNJ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Wa3JlmyHl9lJTaCo9aZs3We7CHulD9LwWGTH0zHKk6/x1JeJwrhocmeDSXmXpAuGuKLAQ16X0QUu22MDTDEKQ2ZRSyqkmXji8o2CJ8KDNksDgJwsWMKXdBt5Rvyli61nUFlnNM1DYBNT5N3AmJtuokvEJj6A/UGVrarfepjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EWbAj2kT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWbAj2kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAB9C2BCB8;
	Mon,  4 May 2026 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777875902;
	bh=HiDQvzsgCp2zqdwpLBizDxSsrpuxti6bbhLVZ0rNJ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWbAj2kTzrgLolBRrkFHrVZZJWwH6DKoAhK+SvqrmoJ1EAPwa5T+2NrVJBVVmSYjv
	 u/6WPil1WLlPmex3YEJd+4DpyabnFpOdGe/SU5XNsUyJhDKeJxzkR2rNCjCiarAayx
	 X+ffyb4pq7YuMJ9dnCUKDPJ40YaEGce1jPoTKRL8=
Date: Mon, 4 May 2026 08:24:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
	Peng Fan <peng.fan@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in
 start_rx_dma
Message-ID: <2026050410-frozen-fondue-5476@gregkh>
References: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
 <20260503194921.3449864-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503194921.3449864-1-shitalkumar.gandhi@cambiumnetworks.com>

On Mon, May 04, 2026 at 01:19:21AM +0530, Shitalkumar Gandhi wrote:
> Hi Greg,
> 
> Any update on this? It has Frank's Reviewed-by but I don't see
> it queued in tty-next or tty-testing yet.

What is "this"?  I see no context here :(
