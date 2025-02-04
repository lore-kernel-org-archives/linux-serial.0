Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D571DFEF;
	Tue,  4 Feb 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676561; cv=none; b=YQN3iODGWCN1n00+acqM4DEetR+vMsBmqzsB/XSSZfdEN2F+IV8kim6soIAGJf+wIMNxI7JEZfIfShRHsSonH3qZjWsPIUNMUZSRK0xBgxiMG6lrbC5fuTJroooAnZc9WDKR+aczDcOemtP7g6ERQ12/VfQ9zcuOMC6yvnidV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676561; c=relaxed/simple;
	bh=bLwezkiuYP2CwTv8x0MD7GzbrC2t1XbarOqGqwLxWgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRIP2mGEAA8rELX2oK+P4fpT5p/L4jmphQ8yJH+tOiTVZBskQu3QnQkVY6JCo64x1vAWDAVrqPK/YPIWC354lBzsyydYzf4Q5XfXtz/73gpfebSvLqphC5VsyVVuKA6znlFFLg2YuHacXy5FrdE7yxualInn/XvjpoK2AZqPAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuNMGPOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuNMGPOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A0C4CEE4;
	Tue,  4 Feb 2025 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738676560;
	bh=bLwezkiuYP2CwTv8x0MD7GzbrC2t1XbarOqGqwLxWgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuNMGPOfaHBcp65L5Tajv6hcbQ7Dok/6KjxW+SMYwnJq18guvN2jek3fVN2W/D6h3
	 EtIXvFmsBIShco3gcS16uA2hNMsidsEpZMWk6o0iXAPts3I2kLmEAS0eFa3RVR07IO
	 pxJ665OVc3euGwGXT/wD2QfORHF7o0c5av1BfrYY=
Date: Tue, 4 Feb 2025 14:42:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Subject: Re: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
Message-ID: <2025020422-reflected-huff-3334@gregkh>
References: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071819.1346672-1-andre.werner@systec-electronic.com>

On Tue, Jan 21, 2025 at 08:18:19AM +0100, Andre Werner wrote:
> The logical meaning of the previous version is wrong due to a typo.
> 
> If the IRQ equals 0, no interrupt pin is available and polling mode
> shall be used.
> 
> Additionally, this fix adds a check for IRQ < 0 to increase robustness,
> because documentation still says that negative IRQ values cannot be
> absolutely ruled-out.
> 
> Fixes: 104c1b9dde9d859dd01bd2d ("serial: sc16is7xx: Add polling mode if no IRQ pin is available")

Nit, this should be:
	Fixes: 104c1b9dde9d ("serial: sc16is7xx: Add polling mode if no IRQ pin is available")

I'll go fix up the fixes line...

thanks,

greg k-h
