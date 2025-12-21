Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECA2FD7BC;
	Sun, 21 Dec 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333410; cv=none; b=Rv0D5O0399v600PjDfVIhfAkLhrcWFRRdXReq4SphWkmDGva24toPt1bbiIx3jagiYwQGmR8P4Ue8ktESojJ9hVUTrYYbjTBE66ZTOAWk3MAUmg+82Qet8WkDSJ/SPshuytHHpDq+2abzw38oR5VumsN13FUIxtZX3gtn9+VWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333410; c=relaxed/simple;
	bh=63SV5MtiGNclPbWJuIetiNKCBpbB8ccwAYIK5iM2FcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhYn+R698NjNuKhSMdEglzRO30OoAoqx2LwLfimxP8xXdKpbT3BF3WdTX9zMWWqD+AHGh1z/tAnrDCNZuJ4qSuoOSVetZsFyKmhFutq8FZMCNA2wlg9JH5D96uuL9HoQvQCQ+s9DVuZbp/xrdEMb5kg557JIMR0kKGayQnEylc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEMYUC+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEMYUC+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B0C116C6;
	Sun, 21 Dec 2025 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766333409;
	bh=63SV5MtiGNclPbWJuIetiNKCBpbB8ccwAYIK5iM2FcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEMYUC+HhiLakzl85MKZq2czeUzAB6pJVP+du2KK9c0dw8Mx5PRj1JZD4QpBtpoSB
	 SlLy5yV0L/6lMixRcchutVdcyZG3gFQmD3xaECcavngxkwy2AGOgL9iyPRe0WD9Ozx
	 H15Z2uPy5BiqzOr75mYJn2aNSk/s12T240TyTo8I=
Date: Sun, 21 Dec 2025 17:10:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kari Argillander <kari.argillander@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
Message-ID: <2025122138-saucy-unexpired-0b98@gregkh>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-rust_serdev-v1-1-e44645767621@posteo.de>

On Sat, Dec 20, 2025 at 06:44:05PM +0000, Markus Probst wrote:
> From: Kari Argillander <kari.argillander@gmail.com>
> 
> The serdev core has an internal is_serdev_device() helper, but it was
> not accessible to drivers. Make it public by declaring it in serdev.h
> and exporting the symbol so that modular serdev drivers can rely on it
> instead of duplicating type checks.
> 
> This allows example future Rust serdev abstraction to have
> 
>     TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>

But why is that going to be needed?

> That way using bus is easy for other substystems. Also some other
> subsystems expose similar function:
> 
>   - bool is_usb_device(const struct device *dev)
>   - bool dev_is_pci(const struct device *dev)

Yes, and usually that's not a good idea, unless you have a bus with
multiple types of devices on it.  I don't think serdev has that, does
it?

Only under special circumstances should this be required, so I'm curious
as to why you would ever have a pointer to a struct device and not
"know" that it is of this type?  Who is passing that to you?

thanks,

greg k-h
