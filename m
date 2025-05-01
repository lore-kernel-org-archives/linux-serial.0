Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68562609F5;
	Thu,  1 May 2025 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746076812; cv=none; b=RIK3clEUFJO5gL9qyi1Dvp3p6uDq6I0veCpozJ8zm6aOkeJ31NjjuEZlz0UXE405pjplyDpcKor8GkU1kz2/W4sH9oxRCetXtkBGVsf4CSfon3NLPgeIDt8qLQhUdwKLA2/KfuDkkE4ZINTKmQjkcv3o0DXemy+ax3LwzyJrl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746076812; c=relaxed/simple;
	bh=SD2YZveBQSiM3ORkc+0l2DqG126xuniIbMcJ5Fep+cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTlO73IgRXtrbzVx9la+n793xjLnX7FrhuKYQAb+EoJi3wqT4W5xv0rjTsGW4GUos1ntJw/2UnvecSrmiEUPgMSb7YqgQbtYcCrLPIiE3BaJeD0ZVKiDmkHqltmXIRnllxDT7mea/hTIQYv8JXh+itGKymdKAgio9mNN5jsuVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfPQ0Uks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfPQ0Uks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D02AC4CEE3;
	Thu,  1 May 2025 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746076809;
	bh=SD2YZveBQSiM3ORkc+0l2DqG126xuniIbMcJ5Fep+cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zfPQ0Uks2IK2009Fc7pWSTrhIfNidB6KK/7YC+cJkmyWzZb+/w6T7Rq/NksFDPYW0
	 LcfawarKNUpo6zDIkSInGjgs0KU+F5K7VOQYGfGC3mhgmy5W4ztJirj11Vq5iZB6AL
	 vB97OI4Q9tBC1c37+J8kjxszDEWg/LdeOfKACOdA=
Date: Thu, 1 May 2025 07:18:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC 0/2] Introduce PRU UART driver
Message-ID: <2025050103-graduate-anteater-e6f6@gregkh>
References: <20250501003113.1609342-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501003113.1609342-1-jm@ti.com>

On Wed, Apr 30, 2025 at 07:31:11PM -0500, Judith Mendez wrote:
> This patch series is sent as an RFC to get some initial comments
> on the PRU UART driver.
> 
> The ICSSM modules on am64x SoC and the PRUSS module on am62 SoC or am335x
> SoCs have a UART sub-module. This patch series introduces the driver and the
> corresponding binding documentation for this sub-module.
> 
> The DTS patches for adding PRU nodes and enabling PRU UART will be added
> in a later v1 version of the series if accepted.
> 
> This driver has been previously tested on the following boards:
> am64x SK, am62x SK, and am335x SK boards.

Why is this "RFC"?  What needs to be done to make it something that you
actually feel works properly and should be merged?

thanks,

greg k-h
