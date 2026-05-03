Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E3346A13;
	Sun,  3 May 2026 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787040; cv=none; b=P0liO2wTAVWppI+gMPN28iJA3evjGDnMa67CCBExIcO1/D1UgxcI9zLe0K7aHVWYfy/NhWPcYoGVTZhuFoTDASyho/+OGVVcz4gUYjAgM421EXreObbOtyBEZ+RAdnx72oiI8m/FmUcWTlpBoZG+bJ8s1pdxHPNC7PVxo/CISLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787040; c=relaxed/simple;
	bh=ktQFx+wmauplAHJrVf0ni9I6Q0rTlKQem2m0emsUYHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYUz8h2oH5n9CiOdRtPbGJhuVSmd/77SYjDKSP1OZXDJlP0lceV3IEk/IKSSP2hS8xA0qQlX4RFwPh+keCOXtOPjr0SL9Ewz+tw0HdynVPOFodKR5s9i3x1EZXskGU+6cnuRbP+ZZvyiqbZNi9W+Hqch19kKampimLQPjAjrY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gpEkbVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gpEkbVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1FC2BCB4;
	Sun,  3 May 2026 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777787039;
	bh=ktQFx+wmauplAHJrVf0ni9I6Q0rTlKQem2m0emsUYHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1gpEkbVwZu5/SY1Et6mDcSa3zISYgnrl0ejJM+f7e8sgngWc2G0egYZ4Qjl1kDS8S
	 DEWJm/mdrOtGg7YJs5TnIGdb7gn+vPQSmgZoDZYDWgTS2hJVpiWIMLXM5amr9XPghV
	 Y5v/2I8yJyeLgRio6GXEPMUQZAsI1hxEXgrPnKe4=
Date: Sun, 3 May 2026 07:43:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
Message-ID: <2026050340-kilogram-prissy-a833@gregkh>
References: <20260503030801.14080-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503030801.14080-1-enelsonmoore@gmail.com>

On Sat, May 02, 2026 at 08:07:38PM -0700, Ethan Nelson-Moore wrote:
> The synclink_gt driver was marked as broken in commit 426263d5fb40
> ("tty: synclink_gt: mark as BROKEN") in July 2023 because it had severe
> structural problems and there had been no evidence of users since 2016.
> Since then, no meaningful improvements have been made to the driver,
> and it is unlikely that will ever happen due to the lack of interest.
> Drop the driver and references to it in comments and documentation.
> Retain include/uapi/linux/synclink.h to avoid breaking userspace
> software.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> Changes from v1:
> - Retain UAPI header - the linux-raw-sys Rust crate generates bindings
> for it [1]

Then that means someone uses it somewhere.  Don't generate bindings for
something that will break because it is no longer in the tree :(

If no one does use it, then please get that project to fix their code so
that we don't break their build.

thanks,

greg k-h
