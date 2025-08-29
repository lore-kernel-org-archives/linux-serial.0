Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000E1EF363;
	Fri, 29 Aug 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471460; cv=none; b=YaPOJA/hqoAkV4h1Y0sEOnpIHmZfNiiULfnT5Q1Q+4n4SKYNhybUcWe1St1mIiaCS0LQTt3MaLrv0M/fex+mc2MeprHwbqt+kvgysTkISxGUIfr3JncKdnoH0EAZlcypqcP+uPXZ5+hnHJUlMy6FsyFMa5H4LLdNs0j3Vb5dA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471460; c=relaxed/simple;
	bh=q+VhF28RtyL1S5TOwzdG7E1Xo4u9QIVdLAO5XptXZmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcggGIMJZQXhBouQBVOxyG5p3gSedtVGVjx5Q/KCN3gccGSREaaC4fTBKhyPFs4as7TmTFm3+tQJgHHg3ZqZF2VYNWYPST8uZ7nA1GYsFRdfjGwKJeCRXq8pPxXTvmuROZ7gypIPC9gaXCueDbA/2IUPV0120KSjwD2ybpYX8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0RxwnvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0RxwnvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C24C4CEF0;
	Fri, 29 Aug 2025 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756471458;
	bh=q+VhF28RtyL1S5TOwzdG7E1Xo4u9QIVdLAO5XptXZmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0RxwnvOSpBmQwjMa15hw8ERPY0TF24c3W2JNVbDLNIu6nzGeEEhg4OtwPWyIgZwm
	 9hh5v2/x7/cDn4Ow38pF3PwmH75U8MoNKnyZb5P11wms7OOcT+lWHZmqqqdP9CNbZr
	 mOEa+XNr6Z+xkl3htMXGVjMSDJopxlKDpUWVVU9I=
Date: Fri, 29 Aug 2025 14:44:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
	elder@riscstar.com, benjamin.larsson@genexis.eu,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_of: replace kzalloc with devm_kzalloc
Message-ID: <2025082908-charbroil-saline-ef5f@gregkh>
References: <20250827231105.126378-1-osama.abdelkader@gmail.com>
 <2025082817-laborious-provoke-2ac0@gregkh>
 <27562003-b129-4dea-818c-2e81176f842b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27562003-b129-4dea-818c-2e81176f842b@gmail.com>

On Fri, Aug 29, 2025 at 11:49:41AM +0200, Osama Abdelkader wrote:
> 
> On 8/28/25 7:51 AM, Greg KH wrote:
> > On Thu, Aug 28, 2025 at 01:11:05AM +0200, Osama Abdelkader wrote:
> >> Use devm_kzalloc for automatic memory cleanup.
> > Why?
> >
> > I do not see a good reason here as to how this makes anything better
> > overall?  How was it tested?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for the feedback, the change to devm_kzalloc ensures the allocated
> memory is tied to the device's lifetime. This removed the need for explicit
> kfree() calls in the remove path and avoids potential leaks in probe error 
> paths.

But there are no existing errors, so why change working code?

> It also aligns the driver with others in the 8250 subsystem which 
> already use devm-managed resources.

This code is older than the devm api :)

> For testing, I built the kernel and booted it on QEMU riscv with of_serial
> enabled. The driver probed successfully and the serial console worked as
> expected, also tested unbinding/rebinding the driver via sysfs to confirm
> no leaks or errors occur.

But did you test the error paths?  That is what you changed here.

And changes like this, for old, working, code, is usually not needed
unless you are fixing a bug somewhere.

thanks,

greg k-h
