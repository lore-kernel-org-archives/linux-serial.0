Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BD3438B5;
	Sat, 23 May 2026 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515231; cv=none; b=MTAwblVlXOYxxtpYPp2/T47mzwvNc4iL4wA2Iu6az6oTCPvpf3cWPhsfsnst59WpT2IRn6VdFmiPoVOU8zxwF8Zty4PHTogbY0g5EFVvSya9Zvz+rp4Ucd1L9RdYnAvloe6GQJ0f+QtL5MibOMfhmgIUCdA5u3SxrbY27CAlMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515231; c=relaxed/simple;
	bh=MXIY6l97tR55QyeX2VEz2DQUUhL3kSBh9Wd5y+y1ngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfu2xXdhIFUE5z7jqAK0SQkYBtjIvhIW3VntroloANSlvZdVSgqiXUmLPWSvDHyfncE5W/7wmQ94pDzV+LdKLRKMkETlXGc4oAXv7ZtZHW8GXzfSsBu+eZ2KkM1oLVOIkbB0J2OJvrGHAV8MiaxhL3u5wTx6muFfHSp+rQpZl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdhn4eD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdhn4eD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A0A1F000E9;
	Sat, 23 May 2026 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779515229;
	bh=y/1aL6buhhJBjhbquNQM//2DOfH+rUk/z6aU7VoDjNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qdhn4eD6W7oUiZepqLS7xPGjcH5WAHMeC++P64B6zffuMgSHDbRhaZTdjymgzKGBa
	 hHX/QCphw1FeCIiAtT9V/qK/cVO/L4ptJRgSoU76Jbg+2BgfOaETIXxEBHp0lBvm5F
	 kyZzCF9tbSD62YyYIkNzCsXZNa4FKwCeoy9/hBQo=
Date: Sat, 23 May 2026 07:47:12 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Matthias Feser <mfe@kbsgmbhfr.onmicrosoft.com>
Cc: Moteen Shah <m-shah@ti.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>,
	"msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Message-ID: <2026052316-drown-guidable-0e7f@gregkh>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
 <BE3P281MB55154E3A7B5BF556B6020ADFEE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE3P281MB55154E3A7B5BF556B6020ADFEE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>

On Fri, May 22, 2026 at 12:37:25PM +0000, Matthias Feser wrote:
> On AM33xx RX DMA only triggers when the FIFO reaches the
> configured threshold (typically 48 bytes). For smaller bursts
> no DMA request is issued and the FIFO is drained by RX timeout.
> 
> In this case __dma_rx_do_complete() can legitimately see count == 0.
> 
> The current code exits early in this case and does not clear
> dma->rx_running, leaving the DMA state inconsistent. This can
> prevent RX DMA from restarting and may cause
> omap_8250_rx_dma_flush() to fail, marking DMA as broken.
> 
> Fix this by clearing dma->rx_running once the DMA transfer has
> completed or been terminated, even if no data was transferred.
> 
> Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
> Reviewed-by: Moteen Shah <m-shah@ti.com>
> ---
> Changes in v4:
> - Add blank line before dma->rx_running as suggested

Please properly start a new thread, don't have this patch be in reply to
another one, the "Re:" in it is a bit odd, don't you think?

And what commit id does this fix?  Should it be backported to stable
kernels?  If so, how far back?

thanks,

greg k-h
