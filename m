Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B82372696;
	Mon, 12 Oct 2026 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786832; cv=none; b=AklWajcbXVfB3BDVcUcfSq1581n+X6YcX3fRVCvOThwB5nxg1Y+/U5mJ+tp1L+iC+WrSuv9C1UZzuLEwmRMQPZHEn2ipifOH5KgrgZBI2zI6Mv1jcx6E4VTQzPjfwVIsyWW7q7R0Au2vnOIKDMbt7hXZS8mk90KZFvM/sB+PQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786832; c=relaxed/simple;
	bh=iy9P1h4aCWMimhNW/nBfPAd4CPUteaCCXeDAS1ztc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOflzOSUdDJIhWrCC0ddViYqXUZR86aT/5qFYHWN1+PQfEFmEpBNR5COtG5dcTEvcizYQVxNSdG8GyMWheAhH97aLfXZdZQmEyoHeyNf55pEkacSRdNemq7c6NtjdJ07gRhIzhokhmwOs+oeAxygnJxZs8lTyw160uY1EQTAa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjZSqCT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjZSqCT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464961F0089B;
	Mon, 12 Oct 2026 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791786830;
	bh=Cgm+CG0maZD2PsOGNp9ACZ/T088GgoZwMXbWOWX31uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjZSqCT2NQjwIFRrJa4K8RqTJ3DmbDVTPuK0l4C7fomfYpG4aFUEJZHCngTbh5QA7
	 1ySuGPMkrWtn5SU6+eWqhSXFhq2jFKNni3y0yZyLzICLbb8FMQ/ZNzmcK56d2WNNoS
	 0BLAAXnc7zcXE46g2reTtoBNCYr+gJqGxs1MYYFw=
Date: Mon, 12 Oct 2026 08:33:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: khaliforce <kforce@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: retain programmed timing for BUSY waits
Message-ID: <2026101202-bride-friction-454e@gregkh>
References: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>

On Mon, Oct 12, 2026 at 06:10:20AM -0000, khaliforce wrote:
> +	if (d->data.frame_time && d->data.frame_time_uartclk && p->uartclk) {
> +		scaled_frame_time = (u64)frame_time * d->data.frame_time_uartclk;
> +		scaled_frame_time = DIV_ROUND_UP_ULL(scaled_frame_time, p->uartclk);
> +		frame_time = min_t(u64, scaled_frame_time, U32_MAX);

This looks like a LLM wrote this, as min_t() is what they love to use.
Are you sure this is correct?

thanks,

greg k-h
