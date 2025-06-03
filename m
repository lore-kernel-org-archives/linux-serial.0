Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5F173;
	Tue,  3 Jun 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924478; cv=none; b=Eh2sC4VCG31QyZqS0dUrerqy8NTNREJURwo37MZXM8vrMuRLOmA2u6DNGfsKMDVn02gwHVeH7Z4ENUbPmazlYbDNESyPFvZzlmNXUgUYfHxheEONIID9ehHxG/X2IaqKjQWkGDjb7Sa2w5wWGpIuVs0msv9WZjUhwhhTgsW7y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924478; c=relaxed/simple;
	bh=vwpS/NAzO8W4+QBxXTNVB2WtWH1BaoyxzN0+T9/yp24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfN2wLy8PeAbJiNWLJdNVkcteJxlCklOrfEZuleMPWezcaS94GXSP1WeB2RV5o3n3QGmW7DnFacTV7QzEtxqvFyxlSDeYfO1BU0yS2zz0l2PNVOcIlYrD3ymI0jO4hRAw9iaJYaKmt3uobrGfo6UsTDuQRBEaO1LPSKXB0FHrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVMCkZKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVMCkZKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC26FC4CEED;
	Tue,  3 Jun 2025 04:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748924478;
	bh=vwpS/NAzO8W4+QBxXTNVB2WtWH1BaoyxzN0+T9/yp24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVMCkZKM1Tg9S3GtCgIk1us7yncOe6/1LuUOFUtgHy22+fOlwdffn//G3UHj0VgOW
	 ERPD4EfJojy5NFzlG87kQgBLFqd7sKj+GyzPM/oiI4p0OP4gPb5Cpj6rZW5wpk3xrc
	 OxsLrXeRO6hFnAxvvIJE732G/5lJwj5hsGiv9I/0=
Date: Tue, 3 Jun 2025 06:21:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: Re: [PATCH v7 1/4] serial: 8250: fix panic due to PSLVERR
Message-ID: <2025060339-panhandle-grandkid-4574@gregkh>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
 <CAEEQ3wnEN0GVjmGTGoRa2eTGnKoQ2gp3okx8m_XcgiwMvGwzPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEQ3wnEN0GVjmGTGoRa2eTGnKoQ2gp3okx8m_XcgiwMvGwzPg@mail.gmail.com>

On Tue, Jun 03, 2025 at 09:54:29AM +0800, yunhui cui wrote:
> Hi All,
> 
> Gentle ping. Any comments on this patchset?

My bot responded to you when you sent it a few days ago.  Please see
what it said then as to what is going on at the moment.

