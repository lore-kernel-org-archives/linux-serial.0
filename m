Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5C1F9F7A;
	Wed,  4 Dec 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326908; cv=none; b=kIwEQPGvfeyOws/AKI757D1mzFZfQbL6z9/9U/2r+Yhr4KLSiXNAmxcpv+Ktlsv887KAwy6ErVZDlFAsbBngjm5nHne7IrL/jfVsIXN81kC8kFyJ0Fy2T6d8CMp6oFMxO6W3wd9o6PL/UIUUMY7Lb3GCOxL3+hBVX2AVe/v5LFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326908; c=relaxed/simple;
	bh=3mJQUjkFYRa2kKanyQLpq6EX59p67DE/Op3hPgUcRGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt78hjlShfqosQ1yh3Lv/1J9jkQYhH7U7NLS4tCel1ujfdFbbdYqW+WkWpm8+MmTvNL7NA/HKzC5afz5uEJ+PA+yZf+I+U5TwbkG9fd5N35jggruaknFFXzRT/OOfEGD7e9Z6jnBg4TmkdH+Qg/qTb3r7C8vDTJpvNfKiToiTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bo9J0JpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bo9J0JpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8323CC4CECD;
	Wed,  4 Dec 2024 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733326908;
	bh=3mJQUjkFYRa2kKanyQLpq6EX59p67DE/Op3hPgUcRGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bo9J0JpGdHb7q1VRCIoxRbe+XO+bWe36dGAa3Yl/OyOkRcx5sLd0VHiBXtDlHCLkX
	 iR1jzgZ+QD6JEpmdYKTI7xcYfRiSxIFyS5VvwWlm+wwWFsP8Ar/JkUBSTgSRK8AqMW
	 44O6I+oz0Yyy76geqqODYyf70MODaNYIqkI34A7M=
Date: Wed, 4 Dec 2024 16:41:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: n3rdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024120401-grapple-saddlebag-e674@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <20241129041549.778959-2-bluescreen_avenger@verizon.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129041549.778959-2-bluescreen_avenger@verizon.net>

On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> initialized by console_initcall() and selected as a possible console
> device.
> Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>

Meta-comments, we need a blank line before the s-o-b line, AND we need a
real name here, sorry.  I can't do anything with these (including
reviewing them), until that happens.

thanks,

greg k-h
