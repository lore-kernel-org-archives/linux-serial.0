Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278124E77EE;
	Mon, 19 Oct 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410414; cv=none; b=g/oR+BYsDJrvVLccgz68lGoWLNP8wZs/JQmxZ4BIqRQQVb1NvrQDV4SHfwEFlZfmmGxmtV/39WHcj4VXNHxL6rCTf89Q7zGsy4ZFCz0rZ8gy4GreN5Go8HeZ0P1Nz0Dvm4G0ZDacN7tZO/Tr7UP9YBlSRKKR409vkoHctCAf+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410414; c=relaxed/simple;
	bh=Q78jVVF27/tia9GyJPlPgwlO69qamC9QNBY4baVk94c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPHgQBV8KAZAN0usfO7aV8cDPZUPeXmfyl94As+7iah5fUk6R4hl/E9wt3aq1C6NL05ApT7ICtuGT6lu0IB1KHkFKDS9Qrd0BibDBzOiQ48IOP2WmwXV9Pw3ElldqFl3V/tR5oqdR48BjRrQNw0XGuE9K6D3p9vRaq3POclXlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s+I708qW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s+I708qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281031F000C4;
	Mon, 19 Oct 2026 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792410412;
	bh=sEg8gMyf63bO7kjfIqyA3W8zKJLpl7Nu/2h5dBpBCHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s+I708qW1eKPrQkcT3wbw3Vwa6ebSJCDppUYuLy3OGCZjkbmtmVDM65yMNU4JMux6
	 wlQjJ1ASLZf7nRnP5EiDIfPLmR2YKo7UB8TpgBusbha6CqJv0PNEvX11jC322HMXxh
	 FQ0nKy+9R0FnD2am9Qz3pbzoetr6OYzonAuplMtM=
Date: Mon, 19 Oct 2026 13:46:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: LI xiao <lixiao0@hdu.edu.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: tty: timbuart: tasklet may trigger UAF during remove
Message-ID: <2026101954-snarl-frenzy-da86@gregkh>
References: <AHQArwC2LDgmty1sqnW35KqM.1.1792408152646.Hmail.252270051@hdu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AHQArwC2LDgmty1sqnW35KqM.1.1792408152646.Hmail.252270051@hdu.edu.cn>

On Mon, Oct 19, 2026 at 07:09:12PM +0800, LI xiao wrote:
> Hello,
> I suspect a tasklet lifetime race in the timbuart driver.

<snip>

Great!  Can you please provide a working patch for this issue as you
have a reproducer for it?

Also, html emails are rejected by the mailing lists, as you have seen.
Please read the kernel documentation for how to fix up your email client
to work properly.

thanks,

greg k-h
