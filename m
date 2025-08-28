Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89414A02;
	Thu, 28 Aug 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360315; cv=none; b=sZzsXbmWRGjaHJVYDo3V+tzE+UgKfJYb35bMuxSP0+WdesPUILQ7WI5UTyfRgap/qMTZSAbnJVhXrRyaKuuXk+hvsv91t/nkbiyDh2M9eQiQ+FtuRKapwdORc7MdvGvH57/HHA+IeXCdhKUQUXm1rtHJZaXApbnSvAkFgTVJUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360315; c=relaxed/simple;
	bh=3pVnhkV7A4UI6khLt2rITP6cMyGDi7jM6bsfrKIebMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpR4k2CjohYh9O/nxvompZS/52+iz9KKeqFyiVHaaQHEsrjEepVrj5iFU8rBLCpej+d+0Nc+VCMWvGieT1TWhsay5suzqTmoPOdJ+jYBvvwB2dYIkv5Cu4e/yL4AWfJeFVuFMAt07oJoY8zyITgYBvyvBtN6/zMDRxZNitvxslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zq0ThRZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zq0ThRZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C6CC4CEEB;
	Thu, 28 Aug 2025 05:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756360315;
	bh=3pVnhkV7A4UI6khLt2rITP6cMyGDi7jM6bsfrKIebMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq0ThRZNDL+78u25/7HGwU4BcC4a7SjimVlWSndDwzXou0ua2UwQj2raLkMP6haAN
	 vxv1UEjh2DemrVCMiTYLd3Z3tVGYdCtzM9JklEvJ1xow+WAsG9/0Bwf2GkZt1mkIjo
	 RIn8gy//byPjccvhg+x1p6l/WioecNwdu98LvjUI=
Date: Thu, 28 Aug 2025 07:51:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
	elder@riscstar.com, benjamin.larsson@genexis.eu,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_of: replace kzalloc with devm_kzalloc
Message-ID: <2025082817-laborious-provoke-2ac0@gregkh>
References: <20250827231105.126378-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827231105.126378-1-osama.abdelkader@gmail.com>

On Thu, Aug 28, 2025 at 01:11:05AM +0200, Osama Abdelkader wrote:
> Use devm_kzalloc for automatic memory cleanup.

Why?

I do not see a good reason here as to how this makes anything better
overall?  How was it tested?

thanks,

greg k-h
