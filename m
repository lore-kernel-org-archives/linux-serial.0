Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34139A05F;
	Mon,  9 Mar 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055488; cv=none; b=rLj6F/Og2emTWbpBd5h5yqt7+rJLVdiB3F8rkm7tDVJke2EmD0Tgcut0ajkNkL38E9GJ9utGGcpSjZGtSmjSB5UGefStJ1pqeM71J10rx7ucx4Y45xn/X1u8/rHG+ztoGcRLoJrU0qgKZK7tZ6kAUnB7uM1vPhAz0x1vd/6uaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055488; c=relaxed/simple;
	bh=CH7QD5IBbHvptdXvBjbcev7GA9k8Wi2PYsnbl5+pvwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM9vhrURy6jaBY74aBGcAuUmldgmOexebzQiTikE4LejgbLiEGBawBTIFlA6/BuBw3pOMBqtc8VtAQEoQKoryRU3C+iDlnoJUInAuKga9XzdHNnR1hTXy+fY0qBG52tUecQIZ/HE0gF+X57xSEBT0igVbACgW3xoDtj2jXquJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzkPjDyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzkPjDyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115A0C4CEF7;
	Mon,  9 Mar 2026 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773055488;
	bh=CH7QD5IBbHvptdXvBjbcev7GA9k8Wi2PYsnbl5+pvwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzkPjDyHe01FadWpeYuqLvECY/ktaweHhD/cIFCugR4mhK5k5bFwMp0DGGogV5t9t
	 KJKRT2FmTYvRTo8+kZDx78WRM0WThJ+HIsDLLBz+sQpJXvXz7CGrRHV+qICVDkmHhF
	 AubvLklzS5yfAwz9lPF0Qi7nRdd50wP3X9QjPGl8=
Date: Mon, 9 Mar 2026 12:24:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: jcmvbkbc@gmail.com, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, conor+dt@kernel.org,
	robh+dt@kernel.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: remove drivers for espressif esp32
Message-ID: <2026030922-zippy-gloater-6487@gregkh>
References: <20260309111848.1516412-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111848.1516412-1-julianbraha@gmail.com>

On Mon, Mar 09, 2026 at 11:18:48AM +0000, Julian Braha wrote:
> Following the conversation here:
> https://lore.kernel.org/all/20260308131412.1102749-1-julianbraha@gmail.com/
> 
> There was an agreement to delete these drivers for now.

As this is going to be in the changelog, perhaps summarize that
agreement and write more here?

thanks,

greg k-h
