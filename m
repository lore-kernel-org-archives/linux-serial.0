Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C547CC68;
	Fri,  6 Mar 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828995; cv=none; b=dgyKyVr8EPubEkYS4Z+pKKCFjiVuL8dgOjij4M4i3z/9+68ASspFbkco7g31DvPFcMzP9PFLZTP89XLvI8InqhOjdHRALal97sKFe2w7RByux18Ejx9fp0FgyBjTwBf0zUiv0XeUQzHJ/rpdm+gNRcb1+P0evfwohSEKlZKIQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828995; c=relaxed/simple;
	bh=nw+Pw4hNc3wnNMmLgdRw5pKtliePPxGsNsPNNNI9154=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NFRNyJfZVDfUZmKsC7VcYsD7giIblDBPWwCwZoQyUSfvTXXySzU44KUnPr93kMudmi4VIvfN94kwO89/FLQOLCwNuGgJRtAI0VFnIiobDUFS+NkWmVhUPALh7MvfGisxOdKLYnlpHSUzsllIf23IRFLil2w597hGtppgVbQ10uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT6udhdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT6udhdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF436C4CEF7;
	Fri,  6 Mar 2026 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772828994;
	bh=nw+Pw4hNc3wnNMmLgdRw5pKtliePPxGsNsPNNNI9154=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DT6udhdEfjFSJxbNZYMAAaFgjgq3iUadKJFHSNKvvhKJWKINFRqT1IkW0ayW/C8Wc
	 SPg3iD1/qh7c9V13lHrdPkWvhN1RkDfnb1YM7kG4vpZerf+PXFkHH/3eIp3VwGQJVZ
	 zJTiADESMMXyeriapiK0pPNYhM357332X6ZY0PYAphipf4I166qSGrtcMtuLSa2Jr4
	 nint6XA//f6aHfCNIGyxZ9bzleDsKNHtiHUlrpTL9IrwkSfK4qrKWbm63KZO2AxESG
	 +Levw1Hpq/GURssTb4/M/iK1pNPZQVQDXcwPCEOwkSNmetrym8lyXWSOOMrXA15WcQ
	 OURpb62mjXZgA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 21:29:47 +0100
Message-Id: <DGVZFDLUCD1K.2L6EG0GJ4LWX7@kernel.org>
Subject: Re: [PATCH v2 2/4] serdev: add private data to serdev_device
Cc: "Rob Herring" <robh@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de>
 <20260306-rust_serdev-v2-2-e9b23b42b255@posteo.de>
In-Reply-To: <20260306-rust_serdev-v2-2-e9b23b42b255@posteo.de>

On Fri Mar 6, 2026 at 8:35 PM CET, Markus Probst wrote:
> Add private data to `struct serdev_device`, as it is required by the
> rust abstraction added in the following commit
> (rust: add basic serial device bus abstractions).
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  include/linux/serdev.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 5654c58eb73c..b591af23faf0 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -33,12 +33,13 @@ struct serdev_device_ops {
> =20
>  /**
>   * struct serdev_device - Basic representation of an serdev device
> - * @dev:	Driver model representation of the device.
> - * @nr:		Device number on serdev bus.
> - * @ctrl:	serdev controller managing this device.
> - * @ops:	Device operations.
> - * @write_comp	Completion used by serdev_device_write() internally
> - * @write_lock	Lock to serialize access when writing data
> + * @dev:	 Driver model representation of the device.
> + * @nr:		 Device number on serdev bus.
> + * @ctrl:	 serdev controller managing this device.
> + * @ops:	 Device operations.
> + * @write_comp	 Completion used by serdev_device_write() internally
> + * @write_lock	 Lock to serialize access when writing data
> + * @private_data Private data for the device driver.

I think this is a bit misleading, as the driver's device private data is st=
ored
in the embedded struct device. This seems to be more about having a place t=
o
store private data of the Rust abstraction.

So, you may want to name this something along the lines of rust_private_dat=
a.
Additionally, you should make it very clear that this field must not be use=
d by
drivers directly (i.e. C drivers could easily be tempted to abuse this).

>   */
>  struct serdev_device {
>  	struct device dev;
> @@ -47,6 +48,7 @@ struct serdev_device {
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
>  	struct mutex write_lock;
> +	void *private_data;
>  };
> =20
>  static inline struct serdev_device *to_serdev_device(struct device *d)
>
> --=20
> 2.52.0

