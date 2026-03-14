Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B6218ACC;
	Sat, 14 Mar 2026 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475642; cv=none; b=U9vFz3UrHeL8X5oqpj9yHtY4kQSzJ/Wkw5QjktBv7V3b/XeYE/IAdDaNN728EJbIWECeEBoRxSdXmQOdbte64OSstG7iqsSHnE4tkdqI4B1Riyr/aoxlFlxK05NglX03rvKZMf++7dZDjPt9dFIGTUzZwFac6+iAKuUi/qFnWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475642; c=relaxed/simple;
	bh=Jr+5cgMiAUUNJAgyGN6yrMcokuqC5ucllxrv9NJuasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHBxBykYL6CZg8hyn+2Zm+aZ4mOHFeVAEE9dLuNHd6v9nMOMt8JrNet+RqQeZds+m3lR0wrZNCoRK0tmqXYZk/54uXLqxHdsJDb2U6QXW3OsCd1cOsp9Y3k2nrOr3otRMCWDafhczl4EfuM48vvUrICwWL5MiR/GXGO1lun/PqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJpp2KXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJpp2KXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FFC116C6;
	Sat, 14 Mar 2026 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773475641;
	bh=Jr+5cgMiAUUNJAgyGN6yrMcokuqC5ucllxrv9NJuasw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xJpp2KXnj/sdVFiitzlT96JIR7diILb3HDO33emQX3r4XSXWy7OSmTnsY/GcdaGLR
	 XWMmda/+hJWUup1Qd+CBnDCu52jpILNx2OoCBrLJv9wNiHbI9sAwgfAu00t1oBKjKf
	 iCblesinfCKHhCZTjWUcxI1ny6179S8OyiJ0odPA=
Date: Sat, 14 Mar 2026 09:07:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
Message-ID: <2026031402-absence-graph-af5d@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>

On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> Add rust private data to `struct serdev_device`, as it is required by the
> rust abstraction added in the following commit
> (rust: add basic serial device bus abstractions).

why is rust "special" here?  What's wrong with the existing private
pointer in this structure?  Why must we add another one?

thanks,

greg k-h
