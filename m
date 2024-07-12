Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4516F849;
	Fri, 12 Jul 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789202; cv=none; b=Efl7rjuYxLC+yY2m9/c1gMrqBcbxR42yyZjqKoQiLkkob1Ae2XjGkh1K2MF069w3WJJIvinErgz/6XLYVSTJjEkCp64GpIGAjFBVeJ8Ic8U/2QtcZWx9cAotxOmicbEkSvhI0HfgBeefCU5EaTRFggbSn3mOkf6rBz+QLcvA+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789202; c=relaxed/simple;
	bh=idYjcjfqqg4sJhFU7CwSp+sEJTPpFGhm/mbOWBtbF9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1KS6qNarG/NTmyDwnXINPO5WkIBbCpo0hz+8zS0e4BiIS9arCXKmtemhqkWvo6Ew243YTS30TxWYS9Cch55ORsVdwb35iCSFrVwSiPxCOPO3ahXch4rMxRBDagn31+P5vTqokLdnjZaY8ZWFD1H9irJKfWBIqj7xX1JWPnU6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZ3wK8U/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ3wK8U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C40C32782;
	Fri, 12 Jul 2024 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720789201;
	bh=idYjcjfqqg4sJhFU7CwSp+sEJTPpFGhm/mbOWBtbF9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZ3wK8U/kQZAIj+uVqIl9gGN9SFQ8WDTj1HSo67l0Q4KCAzo/JUN7ft2gcb/OX9y9
	 edzGN8Lj/eZULrJvLNAhDkTDahq5LyH1A3rolDWa9dBgc8dFhLb52dYyPSyBkVVXde
	 q0qy6pSbuMupZOUdmEIioiFaOZtpbhdkEjTmzKT8=
Date: Fri, 12 Jul 2024 14:59:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: When /dev/console is a disconnected /dev/ttyS0, TCGETS on
 /dev/console results in EIO (Even if TIOCCONS is called on a PTY)
Message-ID: <2024071238-underarm-impulsive-dc1b@gregkh>
References: <8411114.T7Z3S40VBb.ref@nerdopolis2>
 <8411114.T7Z3S40VBb@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8411114.T7Z3S40VBb@nerdopolis2>

On Fri, Jul 12, 2024 at 08:52:15AM -0400, nerdopolis wrote:
> Hi
> 
> Background:--------------------------------------------------------------------
> This issue becomes evident on VT-less kernels. As when there is no /dev/tty0
> device, the console defaults to being /dev/ttyS0 instead. Although this can
> also be replicated if booting a standard kernel with 'console=ttyS0' and ensure
> nothing is plugged into /dev/ttyS0.
> 
> This issue prevents systemd from logging to the console.
> systemd when logging to /dev/console, long story short it calls isatty() on
> /dev/console, and when /dev/console is actually /dev/ttyS0, and nothing is
> connected to /dev/ttyS0, isatty() fails on /dev/console due to an input/output
> error, causing systemd to not log the console output, because it rejects
> /dev/console as not being a terminal.
> 
> 
> This is noticed on a VT-less system with Plymouth. Plymouth calls the TIOCCONS
> ioctl on a pty device it requests, to redirect console output, and in newer
> versions, it displays the console logs on its own without the assistance of a
> VT.
> 
> This part of it works, Plymouth is able to 'see' what gets written to
> /dev/console, log output from processes that write to /dev/console directly
> (for example 'echo hi > /dev/console") do appear in plymouth's
> /var/log/boot.log, it is just that systemd is not writing to /dev/console
> because isatty() fails to report /dev/console as a tty device.
> 
> The alternate fix in for systemds https://github.com/systemd/systemd/pull/33690[1]
> is believed to be that when TIOCCONS is called on a PTY, or another terminal
> device, that trying to call TCGETS on /dev/console should no longer result
> in an error.
> 
> 
> Replicating the issue:---------------------------------------------------------
> 
> This program replicates it:
> -------------------------------------------------------------------------------
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
> #include <string.h>
> 
> int main(void)
> {
>         int fd;
> 
>         if (getuid() != 0) {
>                 printf("Must be root\n");
>                 return 1;
>         }
> 
>         fd = open ("/dev/console", O_RDONLY);
>         if (!isatty(fd)) {
>                 printf("err on /dev/console: %s\n", strerror(errno));
>         }
>         return 0;
> }
> -------------------------------------------------------------------------------
> 
> When the kernel console is /dev/ttyS0 and /dev/ttySO has no device connected,
> it prints "err on /dev/console: Input/output error"
> 
> When I strace it, the relevant line is:
> ioctl(3</dev/console<char 5:1>>, TCGETS, 0x7f...) = -1 EIO (Input/output error)

Do you have a proposed kernel change for this that solves this for your
tests here?

thanks,

greg k-h
