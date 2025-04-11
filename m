Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10B1F03F4;
	Fri, 11 Apr 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374571; cv=none; b=lNCaAKyNhR9SWkLPW9tsT2tlLAq5DhugvyhYCznUnMxgD5DM5IeDQj+bsV62eZhL4IPYyyR39WIMNwPmMnZ1dI1wiWSCYuXV4CkjxCHkSAMshJGbnAGjR1sR14R3ykUq3wrSL2VQH0d+p7XNp9W3OVVECCRQzaNIsLUgDz+dPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374571; c=relaxed/simple;
	bh=0p0WtuUIuf7k7dffz+TxreNjb4UxpioHyZ62oBvgPAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDIZjcaioCG9xBDCwdwuIBtuGBmpgBTztUNeqZRWsP3bfRChXlM2KfDINS8Al1R/0WCZmG7BhGhKExwZ+raw0ZwfJWMA8wb0I1liHsYnTDB+GZMCOuXOW02fkjFXuk5o4GWXifJFYNPxe1xgNqvg9zIOeVhgIq3UCtcgP3woms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwMZPMe7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwMZPMe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1860EC4CEE2;
	Fri, 11 Apr 2025 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744374570;
	bh=0p0WtuUIuf7k7dffz+TxreNjb4UxpioHyZ62oBvgPAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwMZPMe7xPAya3NyteXjOMB7XoNo5+OyPDpxhH+ynXKfExlkAjWswwZgTNW1x7a5g
	 LxVaiFVW7T/x0ecQNvhhF3828CVyGUpOZDKe5ZVa4YkWudqGgt29skDQaAZ0IV7ptg
	 +4WU9SFmCwIOJVHqYfD2esyxAUvT2THzCGQizZww=
Date: Fri, 11 Apr 2025 14:29:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
	arnd@kernel.org, cang1@live.co.uk, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fix uninitialized variable warnings
 in pci_oxsemi_tornado_get_divisor
Message-ID: <2025041110-simmering-bogus-7a1d@gregkh>
References: <20250411115048.34948-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411115048.34948-1-purvayeshi550@gmail.com>

On Fri, Apr 11, 2025 at 05:20:48PM +0530, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> 
> drivers/tty/serial/8250/8250_pci.c:1233 pci_oxsemi_tornado_get_divisor()
> error: uninitialized symbol 'tcr'.
> drivers/tty/serial/8250/8250_pci.c:1234 pci_oxsemi_tornado_get_divisor()
> error: uninitialized symbol 'quot'.
> drivers/tty/serial/8250/8250_pci.c:1238 pci_oxsemi_tornado_get_divisor()
> error: uninitialized symbol 'quot'.
> drivers/tty/serial/8250/8250_pci.c:1242 pci_oxsemi_tornado_get_divisor()
> error: uninitialized symbol 'cpr'.
> drivers/tty/serial/8250/8250_pci.c:1252 pci_oxsemi_tornado_get_divisor()
> error: uninitialized symbol 'cpr'.
> 
> Fix uninitialized variable usage in pci_oxsemi_tornado_get_divisor() that
> was triggering sparse warnings and potential undefined behavior. The
> variables tcr, cpr, and quot were used before being explicitly assigned
> values, leading to smatch warning in multiple lines of the function.

Are you really sure?  If you follow through the logic, it looks fine to
me.  What am I missing?  And why doesn't gcc or clang catch this?

> Initialize quot to 1, tcr to 16, and cpr to OXSEMI_TORNADO_CPR_DEF at the
> point of declaration. This ensures safe fallback values are used when these
> variables are not conditionally set later in the function, avoiding
> uninitialized access.

Where did these magic values come from?

thanks,

greg k-h
