Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174F3A8723;
	Mon,  7 Sep 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765251; cv=none; b=eHUGgXzU6OPFiFy136jyCVm0mitlD5yWPrcJUZYmZofDSG5pq/trWrgIqg6TY44XQBIAlLVnytsL4ROS/FxDGGW8ztf2++/aGZu/jc/mupdWHVbWfv0Cj94Ry/ckK6vXAupuHQ0Z9qn0r0nO13oyo8fa176Cmww8Be0r3oiFN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765251; c=relaxed/simple;
	bh=s3t7UZvKcoE0q40AayfQdCfI+5jOSJwDSBcjRpD3Bac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1AB3phvuwDtVzaoMhF+5huVrQZn99NGw6YgrQM3HI2cEpte1BJrOjLXm92iM+6nHQcq5hXpta+MJ6pU5lGI5w4Py6gbHIxG+4EqlOmi2lAXw0c+v13hqkKkxIN4QjBnXLEGn/2TV/Ipgty2H11cqjOJpOszRPLyOvfv9WUDKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXutvjL2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXutvjL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25C71F00A3A;
	Mon,  7 Sep 2026 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788765245;
	bh=H/ltupeo3vFABejAEzGfcZ9c1QR+1Il7Lyb+kDlfwko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TXutvjL2oMBeX6HI1/m0zPrzRTrFIEj7oy4AsoRhKuAfbu5jvApQuIMN+e4g+01/y
	 YakSA5KtFECGpalMBlghdSz5Aeyhnb5t8WgdbY51DtcDsVk5dhLTZCneHB9GRxpB0I
	 UQyh2p9areeieAxWU650N5iBXIQBkx76qydGeDdUsZkzgt+0mIL7lA3gX6OYKN+rjj
	 u+GMuELtuGGz/V82HVxUGYdti2dmCRX+I3sfm5NvXi9xWUep6Y+rHdKsHOPEp7MaMY
	 dvN9WWTyi6dgwt9+2Znh4ZhvOac9FbwBPVhrhJJaX9iRpBYdtxMREUTbvD9ZFamdqa
	 EzUjpqV7rR2+w==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3TYJ-00000000QhL-1uNR;
	Mon, 07 Sep 2026 09:14:03 +0200
Date: Mon, 7 Sep 2026 09:14:03 +0200
From: Johan Hovold <johan@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/4] serial: fix ioctl hangup race
Message-ID: <ap5kO8Q_aLy2a1fe@hovoldconsulting.com>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-3-johan@kernel.org>
 <20260907070034.DF3B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907070034.DF3B01F00A3A@smtp.kernel.org>

On Mon, Sep 07, 2026 at 07:00:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] uart_set_ldisc misses the tty_io_error(tty) check while holding port->mutex, allowing hardware access after the port has been shut down.

This looks valid so I'll include uart_set_ldisc() in a v4 in a couple of
days.

Johan
