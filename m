Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8127587E
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670216; cv=none; b=LCBmr2vK3fkchySkrAzO8tn7ft5JxcgGA8a0GwdmenG0+VgW9HElI9tRHQKZ3+GeytbYbqZ8ExE4MbnM6W2/ATAIu2IXVfh9nkNY1+GvJF+VTNrotx2BSzrn6XLQKCwWmTtJB6ETCcQBuIBsHsuFokNM1/HWfg374qhx1jChrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670216; c=relaxed/simple;
	bh=EMzPtBBJPsXJB9o5RLBIYvB5UGWZmsknLVSvH8VStZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFAxPbAJXVa2GFmX6kbI2dCAObkpO3Hqw0UplTqmdtLAMwvWXZIOXGsREmNocYEmK5zl61wfAC5aUxjgIWZHtkffeW8Lg1oFeHIVHdjyG2IHUEOFiU63+iAV7Ax1Kr9DfrUNvfESf7SEZpNRMJZMAThHCjeCoFKCkF/OxXrY6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hiefKpW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hiefKpW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE885C4CEEB;
	Wed, 20 Aug 2025 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755670216;
	bh=EMzPtBBJPsXJB9o5RLBIYvB5UGWZmsknLVSvH8VStZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiefKpW8jbv+OCda4tndzWNjGNRZC6ZWrwlGJVynoAeIbkTjRWahqLzkawaNgBaLz
	 uRPp9AmioO5PKhjZH/vpUrJunHMdHuyBsdc2CR0EFAD8uK5D3c2cwlyAvS+YxVs79Z
	 oQqpaSX6pV91Wur8Pyuh72zFAaOSxpfXTnIrxm7E=
Date: Wed, 20 Aug 2025 08:10:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: adriana@arista.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.rg,
	ilpo.jarvinnen@lininux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025082056-mango-unengaged-516a@gregkh>
References: <20250819190621.3452231-1-adriana@arista.com>
 <2025082055-daytime-lubricant-c017@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082055-daytime-lubricant-c017@gregkh>

On Wed, Aug 20, 2025 at 08:00:15AM +0200, Greg KH wrote:
> On Tue, Aug 19, 2025 at 12:06:21PM -0700, adriana@arista.com wrote:
> > This patch is proposing a custom configuration for Synopsys DesignWare
> > serial to be used by products with associated compatible string in the
> > device tree.
> 
> <snip>
> 
> you sent 2 v2 patches?  Which one is which?

Oops, no, I got 3 different ones?

Still confused,

greg k-h
