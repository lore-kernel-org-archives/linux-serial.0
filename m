Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16C37E2EB;
	Wed, 14 Oct 2026 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953594; cv=none; b=lGywBDbPQvwTRdd2eXcD0Ik7ydc9QR6UHXlWpOXwaXoIqMtj/2p7oLVefBQB94KbHN5VC8no4AZJgF76wf11ou+ES84VhINroWZhG7U0bOfmMhc6oTbUg47AK565ujdtUoOHlhE7xxqqZojbZRsSs52sryF/zNsb8WAeepMseUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953594; c=relaxed/simple;
	bh=hklVXFpU2pSJrxrzCQk5ANGCs+7t7FzjTYHzKdijKbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuHCfCYe4scUHEGa6J6JusgdXW/1t5qMdewajJjaHkxiUDyiB31U8PONW6Plt+HSPXZkbn1EW+IlvS5flC2ZP0wF0ta1ZMW74a8Qajc2p9V02dEY+JNvoAogWSnTfJDDhLa/AL1C7ArRef5DKf8L3dWtZHVMDYkUAGyAYwYutUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzbKHHM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzbKHHM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5781F000FF;
	Wed, 14 Oct 2026 04:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791953592;
	bh=hklVXFpU2pSJrxrzCQk5ANGCs+7t7FzjTYHzKdijKbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lzbKHHM2V9LPJc6ljWUl7spbFkb71zTuckdnQm4HTN+hQdJKXuXJVALoS/MF/mDJ/
	 jP1li9V85veb17TJnuU8Te/HycZwgtyhnqsOtDZc7XTe5v8DyehaHH3rUyfnkaXf2x
	 DL+G9DCFZAJFPj43F3jiAucGoLraeCNpUGa3RmqY=
Date: Wed, 14 Oct 2026 06:53:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Donald Shannon <donalds@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Message-ID: <2026101444-corncob-wildcard-6616@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <2026101310-scuttle-unison-d4c3@gregkh>
 <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>

On Wed, Oct 14, 2026 at 11:38:45AM +0800, Jeremy Kerr wrote:
> FWIW, we did raise greybus as an approach to various HW vendors; I
> assume there were reasons behind OBMF-ICP, and assume some prior-art
> assesment was involved, but I don't have specifics for those reasons.

greybus is patent-encumbered free so there should not be any prior-art
issues involved with it and could work here just fine (with the added
bonus that you only need to write a tiny host bridge driver and then
suddenly all of the client drivers will "just work").

I strongly recommend that instead of going off and creating new specs
and protocols that ignore prior-art.

thanks,

greg k-h
