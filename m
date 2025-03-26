Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095861F1911;
	Wed, 26 Mar 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997696; cv=none; b=efRFLN57ggQ79f4nyd1MhiZHhedN/lL1hteFxChqi5nkxS5Q/AxAaMXuuEoiCj5PRyLNcgMmAqNMXalzQzQOFTJl2vr9rSeQ43aH+08W/a7SPS5CvQhfTtfhnvEo03KyneYef/TuhupxSpQxZq513yscNo6LunZyiqq7nnx//KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997696; c=relaxed/simple;
	bh=989IQiIJbUGeYCOqHQ5m99x2ck7xqLvAnyiQgY9BNRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfmpHWa2j9tOfNfRakNcXsVYUSx+9bfsDqls8fObhbQ5wbOyBhoWq7l8I7VsJRZ96gqQhmg1EOZaq24ff2H8IsmQCdBNIbS4Ziq8xhluIe3wVr4t5ac4QXNQwfFw8xTNY8/6v0t3s82S+bQDiGzjmA/KBInqDaqdL/mqchx50/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv2nYNW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv2nYNW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A1C4CEE5;
	Wed, 26 Mar 2025 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742997695;
	bh=989IQiIJbUGeYCOqHQ5m99x2ck7xqLvAnyiQgY9BNRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mv2nYNW25z6dw8rrxtKX25U1rB7auiKqNq4fNCUuAPJcq3g3f/FjnJYQXa5za21DR
	 Edya9OzxY4KKd3cblmK3gelpjRx8MRpUy15jyegUrbAFBxBxEYVItG2kIxPwS2wfNu
	 yrzn8VNtgOpaqvrJtwpEpXTLZ+74Lru7iGbRiR1M=
Date: Wed, 26 Mar 2025 15:01:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Elodie Decerle <elodie.decerle@nokia.com>
Cc: jacmet@sunsite.dk, jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub.lewalski@nokia.com
Subject: Re: [PATCH v2] tty: serial: uartlite: register uart driver in init
Message-ID: <2025032651-quote-kettle-6457@gregkh>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
 <20250326100504.1246-1-elodie.decerle@nokia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326100504.1246-1-elodie.decerle@nokia.com>

On Wed, Mar 26, 2025 at 11:04:57AM +0100, Elodie Decerle wrote:
> From: Jakub Lewalski <jakub.lewalski@nokia.com>
> 
> When two instances of uart devices are probing, a concurrency race can
> occur. If one thread calls uart_register_driver function, which first
> allocates and assigns memory to 'uart_state' member of uart_driver
> structure, the other instance can bypass uart driver registration and
> call ulite_assign. This calls uart_add_one_port, which expects the uart
> driver to be fully initialized. This leads to a kernel panic due to a
> null pointer dereference:
> 
> [    8.143581] BUG: kernel NULL pointer dereference, address: 00000000000002b8
> [    8.156982] #PF: supervisor write access in kernel mode
> [    8.156984] #PF: error_code(0x0002) - not-present page
> [    8.156986] PGD 0 P4D 0
> ...
> [    8.180668] RIP: 0010:mutex_lock+0x19/0x30
> [    8.188624] Call Trace:
> [    8.188629]  ? __die_body.cold+0x1a/0x1f
> [    8.195260]  ? page_fault_oops+0x15c/0x290
> [    8.209183]  ? __irq_resolve_mapping+0x47/0x80
> [    8.209187]  ? exc_page_fault+0x64/0x140
> [    8.209190]  ? asm_exc_page_fault+0x22/0x30
> [    8.209196]  ? mutex_lock+0x19/0x30
> [    8.223116]  uart_add_one_port+0x60/0x440
> [    8.223122]  ? proc_tty_register_driver+0x43/0x50
> [    8.223126]  ? tty_register_driver+0x1ca/0x1e0
> [    8.246250]  ulite_probe+0x357/0x4b0 [uartlite]
> 
> To prevent it, move uart driver registration in to init function. This
> will ensure that uart_driver is always registered when probe function
> is called.
> 
> Signed-off-by: Jakub Lewalski <jakub.lewalski@nokia.com>
> Tested-by: Elodie Decerle <elodie.decerle@nokia.com>

If you forward on a patch from someone else, you also have to sign off
on it.  Please read our documentation for what this means.

> 
> Changes since v1:
> - Remove mutex lock in uart_register_driver
> - Move uart driver registration to init function (Greg's feedback)

The changes stuff goes below the:

> ---

line.

Again, our documentation should explain this.

thanks,

greg k-h
