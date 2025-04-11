Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64C1607B4;
	Fri, 11 Apr 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383071; cv=none; b=hL1DDKh8Z3sIn2R08E4uvfmtqHj3ZtQMJdeTYGvP6TiTJQGG9dS3oxF69rm6TglGkOfnEqkVitXxv6U5qgJkFe9E2FWW4CuI2eSMt3jG9O9HADdaMbx/VTSFFfSoSOQcGUPzyHC6N3vsk4nqHM2cLCDR89GGF3jJ+NFf2AcxNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383071; c=relaxed/simple;
	bh=81S6wOJP1VnNdXdYyAE93ipZ1LRgTWNjf0eOBLLx8nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnb9adQTkTh901dFCdATXVgAtkzG86sJ5I1oV8KTcMmkKIg3kE/ZoiN4zXdcRsC4i44gfAEnqQ3Oo1hzCzhlqXqOHUwRqiThvfaoC/+Nr0v54PVGz9K4XjGU2iH68J1iAKLZ3LZEsBwIB1tK0Vh/p+2ob19vGL/4U5eHYjHnVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=viwH2lyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="viwH2lyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0501FC4CEE2;
	Fri, 11 Apr 2025 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744383070;
	bh=81S6wOJP1VnNdXdYyAE93ipZ1LRgTWNjf0eOBLLx8nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=viwH2lyofr0YYVPfgi+tONS9CaNHP30vhDF4UxXC9J6A2X/I4Hd+xUdEI4r2ip9n7
	 Bhdd8Wvo/V52wWNl7XRq6ykauHrBpg+gSYjYaGj/qaD9eSZO6QY9iCccO8NwupqAed
	 dQwPaxWCvWBdZHf7L4pdEpBBzZAK/cGxVfZluKb4=
Date: Fri, 11 Apr 2025 16:51:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: Re: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Message-ID: <2025041157-supply-joyfully-8b9c@gregkh>
References: <20250321073950.108820-1-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321073950.108820-1-sherry.sun@nxp.com>

On Fri, Mar 21, 2025 at 03:39:47PM +0800, Sherry Sun wrote:
> Do some cleanup for lpuart driver, no functionality change.
> 
> Changes in V4:
> 1. Fix unused variable 'sport' warning in patch#2 reported by kernel test robot.
> 
> Changes in V3:
> 1. Add the change to covert unsigned char to u8 in the first patch as Jiri suggested.
> 
> Changes in V2:
> 1. Add the third patch to rename the register variables as Jiri suggested.
> 
> Sherry Sun (3):
>   tty: serial: fsl_lpuart: Use u32 and u8 for register variables
>   tty: serial: fsl_lpuart: use port struct directly to simply code
>   tty: serial: fsl_lpuart: rename register variables more specifically
> 
>  drivers/tty/serial/fsl_lpuart.c | 472 ++++++++++++++++----------------
>  1 file changed, 231 insertions(+), 241 deletions(-)
> 
> -- 
> 2.34.1
> 

None of this applies to 6.15-rc1, what went wrong?
