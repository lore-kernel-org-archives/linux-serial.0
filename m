Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00693346E44;
	Fri, 17 Jul 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285499; cv=none; b=kQOLnOTFeyu9VUwbAsXWQlXeJmr59HAZyaNo6HjqNTJwlEhbuXz47C97GzH0HtXpjhP+ecbmXXVQdie/H2n/hX+/F+R6Dftus0TsICVmBz3CAHF38YoX27Xudddw5iS45TSQkDs6yBH4cUsb1lWFGqHOcaQ1vYfxfypir0K60kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285499; c=relaxed/simple;
	bh=VBtl4xmDYXPlAlbzRQu9py+TfAFNeaDQE0JzP04jdlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g23O5dvHdV6ojsQrN6bUdpbI+tw61UH9fAtAx8S8D5gn4/AwIZG4V0Mb+c4YZc2om4DF0f4SDBjdLkKbaXqQkXwyLVtjuZf4FdCqko3LUyH5nsecH5EThJVMjYjgwnQeDaDL5fNepxhCXQsDFc0SsSP1EBxD4tZeMctmTcLognE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x7OMGhTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x7OMGhTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A01F000E9;
	Fri, 17 Jul 2026 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285497;
	bh=h60eZoJ9WewwJ/3FIvLY/VJPOVXjVJd1obVMlqiLscQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=x7OMGhTWgV3F88+IFDdx51gIN0a4poXXt4xaWtNEeBmEZ0x5K58xVrjue+TfwBNKS
	 uweWLwQ7byaWP6CxjzM1U2vdggP91Dz19Dyf5tXw3l6POzf7FA7zW0RXsf2hYXY+/i
	 j8gmlw2+0esoAU7hJCnm8anC/ja0NjqKn2Lci/Ik=
Date: Fri, 17 Jul 2026 12:51:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
Message-ID: <2026071722-scheming-charcoal-1d26@gregkh>
References: <20260717071616.91423-1-kmehltretter@gmail.com>
 <2026071743-number-headfirst-bcca@gregkh>
 <8a4b1bb8-57ec-4746-8c98-3bcc13e9ffd9@app.fastmail.com>
 <aloCa9hBXW_7I-QQ@unknown748F3CBA5068>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aloCa9hBXW_7I-QQ@unknown748F3CBA5068>

On Fri, Jul 17, 2026 at 12:25:26PM +0200, Karl Mehltretter wrote:
> On Fri, Jul 17, 2026 at 10:04:17AM +0100, Arnd Bergmann wrote:
> > On Fri, Jul 17, 2026, at 09:22, Greg Kroah-Hartman wrote:
> > >
> > > What about testing builds?
> > 
> > The driver only builds on arm32 or arm64, and there is little
> > value of build-testing it on armv4/v5.
> > 
> Oh I already sent a v2 with COMPILE_TEST before reading this.
> I'm happy with either version.

I'll take the v1 now, thanks,

greg k-h
