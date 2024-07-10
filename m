Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF1190673;
	Wed, 10 Jul 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618810; cv=none; b=JrqBAvwHB9c1OzgxFUiwUWyIyuORTFfFQAO64wBIObIj70WrMr7+OHJQM/3k13js6kRCI4DqQw4t4oiSdLWTKiHSBILvs04bD+mILusP52joUeDVd2dOMZ+zcQlc4RR3YU2A6/L4pJRe6uRtLnG0oqJrTjGDsVSMG62mbqK7s04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618810; c=relaxed/simple;
	bh=KLq/YBxo8i9fPeOf0/APuvNk+ktCben/txQXDLZ1oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWQe7TdvHnRT1gGJ02X9fJgd4ADgMIRKxiDKrPQ9i+b8H/OWJN2csYlgr+XHQu6gTR4/A04UDbRnLl3yh/XM+U7Zkx14F3Ef+ZFMG4kE1rec5cHGpr1s+J+JTIVfn2ggp9HdWKtQ0eIUyFaAA14du9R3fDBpIjrXI7wmMJSQ3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n3cY/H6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n3cY/H6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B976CC32781;
	Wed, 10 Jul 2024 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720618810;
	bh=KLq/YBxo8i9fPeOf0/APuvNk+ktCben/txQXDLZ1oz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3cY/H6jyMdMnJ549TffWKHs1+JXEYfbICoqs79P44zfctQKuuFn6E2W9fcY5e6nU
	 U2zj4IVpZ5LbTS7ziu5hoQjFjmPsqnoxA9QY204M283trCeVg4K+qrdqBE25VRoCr+
	 bmCH+Tu+8TCQ6dNWKedmgVT9jiHAzDbMayxIld/w=
Date: Wed, 10 Jul 2024 15:40:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung: add clock comment for earlycon on
 gs101
Message-ID: <2024071030-gravy-backwater-88ec@gregkh>
References: <20240710-samsung_tty-gs101earlycon-v1-1-bd0f8481542a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-samsung_tty-gs101earlycon-v1-1-bd0f8481542a@linaro.org>

On Wed, Jul 10, 2024 at 02:33:29PM +0100, André Draszik wrote:
> As pointed out in [1] before, the hand-over between earlycon and serial
> console is fragile due to clocking issues:
> 
>     ... causing earlycon to stop to work sometime into the boot for two
>     reasons:
>     * peric0_top1_ipclk_0 requires its parent gout_cmu_peric0_ip to be
>       running, but because earlycon doesn't deal with clocks that
>       parent will be disabled when none of the other drivers that
>       actually deal with clocks correctly require it to be running and
>       the real serial driver (which does deal with clocks) hasn't taken
>       over yet
> 
>     The console UART, and I2C bus 8 are on the same cmu_peric0 controller,
>     and that cmu_peric0 has two clocks coming from cmu_top, ip and bus. For
>     I2C8 & UART to work, both of these clocks from cmu_top need to to be on
>     as they are the parent of the i2c8-(ip|pclk) and uart-(ip|pclk) each.
> 
>     The bootloader leaves those clocks running, yes. So earlycon works (for
>     a while).
> 
>     At some point into the boot, one of two things happens:
>     1) Linux will load the i2c driver. That driver does clock handling
>     (correctly), it will initialise and then it has nothing to do, therefore
>     it disables cmu_peric0's i2c8 ip and pclk clocks. Because at that stage
>     nothing appears to be using the cmu_peric0's ip clock (the real serial
>     driver hasn't initialised yet), Linux decides to also disable the parent
>     ip clock coming from cmu_top.
> 
>     At this stage, the earlycon driver stops working, as the parent ip clock
>     of the uart ip clock is not running any more. No serial output can be
>     observed from this stage onwards. I think what is probably happening is
>     that the console uart FIFO doesn't get emptied anymore, and earlycon
>     will simply wait forever for space to become available in the FIFO (but
>     I didn't debug this).
> 
>     Anyway, the boot doesn't progress, the system appears to hang. In any
>     case it's not usable as we have no other means of using it at this stage
>     (network / usb / display etc.).
> 
>     2) Alternatively, the UART driver will load at this stage. Again, it
>     will tweak the clocks and after probe it will leave its clocks disabled.
>     The serial console driver hasn't taken over at this stage and earlycon
>     is still active. Again, the system will hang, because IP and PCLK have
>     been disabled by the UART driver. Once the serial console is enabled,
>     clocks are being enabled again, but because earlycon is still waiting
>     for progress, the boot doesn't progress past disabling ip and pclk. It
>     never gets to enabling the serial console (re-enabling the clocks).
> 
>     So in both cases we get some output from earlycon, but the system hangs
>     once the first consumer driver of an IP attached to cmu_peric0 has
>     completed probing.
> 
>     ...
> 
>     If earlycon is not enabled in kernel command line, everything works
>     fine, the kernel buffers its messages and once the real serial console
>     driver starts, all messages since boot are being printed.
> 
> As requested, add a comment to the code for posterity, so the
> information is not lost. The patch referenced in the comment can be
> found at [2].

That should also be in the comment in the .c file, right?  Along with
the git id that you feel should be reverted?

thanks,

greg k-h
