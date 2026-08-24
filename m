Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D241E6DF;
	Mon, 24 Aug 2026 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576180; cv=none; b=mAJSFhlQmZPTXyEameaOzV7wU/BzpMa0XuuO47tzBBvXq+cVdOEcMwYGWuyZ+c+pLrfl3F1gwwT0dm7IaqZNPD0t2eyR2kygs3tIdhxd3nTY0ZS6GhH6Xxx7QbWif3gaiVgkqqx/JC+MAY0XMf3KrgyOZP8BNZbLHntMJti8hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576180; c=relaxed/simple;
	bh=IoarnWeIjQqr6S8xH4L4ZE/KLdk403AwZOqMUkkyXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPTMivo8ZB0Re5ExNgdiGp7QSs2iXKQX52QTNccAVGpW5T8LMw5ffLCFOGzZWjPx2JOXOXK2BkfxtNWwuuWIuvUIFIIIPlTf6zXqBwKhVWf1KjE5mAb2DbO0PGbUhkeIJVGQBKG03v3bgG7iQ8wwbCixuyN2vh4K7uKOcAaCDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhrT0uqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhrT0uqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7DE1F000E9;
	Mon, 24 Aug 2026 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787576178;
	bh=ZlKJybPZln08teQ74v/t//Uja9GDcCDomQxjHdCEHYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WhrT0uquVOeRUhcVElZ3deIezuHE4JCWLXRGRBZXHeNmFJve1QaDNWO4ziNn/h8OU
	 MrhBXezsocKshndGhZaBtxDiI/EFhGDfzDU4GNgrVWH7eoGxONzA6I8pigaiFQBdPE
	 sX5WxB7EKy4WpI2gyXL04Ib3jWEyxQ2Q7SbIXuG4=
Date: Mon, 24 Aug 2026 14:56:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Jiri Slaby <jirislaby@kernel.org>,
	chandana.chiluveru@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Praveen Talari <ptalari@qualcomm.com>
Subject: Re: [PATCH] serial: qcom-geni: Drop unsafe rx_buf realloc from
 setup_fifos()
Message-ID: <2026082458-lung-knelt-e760@gregkh>
References: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com>

On Mon, Aug 24, 2026 at 04:15:14PM +0530, Praveen Talari wrote:
> The RX buffer is allocated once during probe using a fixed DMA_RX_BUF_SIZE
> and is DMA-mapped for the lifetime of the port. However, setup_fifos()
> attempts to reallocate rx_buf whenever the reported RX FIFO depth changes.
> Since the DMA mapping is not re-established after reallocation, the buffer
> pointer may change while the DMA engine continues using the stale DMA
> address. This can result in RX DMA targeting memory that no longer
> corresponds to the active buffer, leading to invalid DMA accesses and
> potential memory corruption.
> 
> The RX FIFO depth is unrelated to the size of rx_buf. The buffer is
> allocated independently using DMA_RX_BUF_SIZE and all RX DMA paths consume
> it at that fixed size. As such, resizing the buffer based on FIFO depth
> changes provides no functional benefit.
> 
> Signed-off-by: Praveen Talari <ptalari@qualcomm.com>
> ---
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Why is this signed-off-by twice, with different email addresses?

confused,

greg k-h
