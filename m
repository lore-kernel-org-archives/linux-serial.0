Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2180B;
	Sat, 16 Nov 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731777601; cv=none; b=Jua/cbhbn00qkwR2jzpM9XoDpR7rtfx5upDuWBoi2ZOJEQQvzLDMwpR/Sfe6e8COcjSYWeM/Fhql89vsLi3EzyPhzb4TFhbhWD4VJBCXeXrRBP+ZjrbT88bvgFtfLIax2K8MALZsb7wazgCxEA68cLzbTsc4vTqrOnDIw+zvlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731777601; c=relaxed/simple;
	bh=yqI+iGQw0KKBlMGT5ZrpKAwYDUZLMe1fnYU3dBtqako=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBpFepFkZLPrDiiAazWC50tuxaMQiUihJ9kncrqoxV2GHBEnLSBuool6QnT75kWvsc/Rs9i+7/X7SSZZR6d+ciBBU4fU9r5y2YqMVmPA5ewWqYncdwsE819qTpf8ib2L+Vgae2NW5iwNkrCGcz4x3ah3yzS4uikRH9lMwLAbk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEHLCnJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yEHLCnJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26596C4CEC3;
	Sat, 16 Nov 2024 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731777600;
	bh=yqI+iGQw0KKBlMGT5ZrpKAwYDUZLMe1fnYU3dBtqako=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yEHLCnJ+MZrzDtRrxiqoa/P/Wcs51HrOV9Ko+MbzQxXO+iL9dQE13amIPhm/mlKw8
	 7GxKp+5fYrJlhA7USCJ73Nti6ZPHbvaIm3nrZSAk/PCwKmpyUxMhV4cYPcKEd6oZgA
	 6NE/zDaNySVUpw94EiPGTkX6uDZZbYYY9tmSbRgk=
Date: Sat, 16 Nov 2024 18:19:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial 00:06: Runtime PM usage count underflow!
Message-ID: <2024111656-try-flatten-b215@gregkh>
References: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>

On Sat, Nov 16, 2024 at 06:07:27PM +0100, Borislav Petkov wrote:
> Hi folks,
> 
> got a box here which says:
> 
> [    4.654361] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    4.660820] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    4.668313] printk: legacy console [ttyS0] disabled
> [    4.676903] serial 00:06: Runtime PM usage count underflow!
> [    4.677175] serial 00:06: disabled
> [    4.677264] serial 00:06: unable to assign resources
> [    4.677356] serial 00:06: probe with driver serial failed with error -16
> [    4.677923] printk: legacy console [ttyS0] disabled
> 
> Any suggestions?

Look in the bios, that seems to be the "old" pnp serial device?  Does it
really have a serial port on the board?  Is it enabled properly?

That is odd, what's the chance that someone didn't enable it in acpi
somehow?

> I'd like to use the serial cable to catch dmesg but somehow the driver doesn't
> like the chip...

It should be the bog-standard 16550 PNP device, check the resource
settings somewhere?  Sorry I can't think of anything else at the
moment...

greg k-h
