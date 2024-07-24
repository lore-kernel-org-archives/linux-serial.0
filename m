Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BDD29E
	for <linux-serial@vger.kernel.org>; Wed, 24 Jul 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803898; cv=none; b=q6b/OenQhStTv+bAeE29ec213UkAVrfbUzMB+RW2GCDpt5ocv5IDB05W/L4QsbjAUAbPoUFJUp9gJYGdSjKqBozdBdIEHXlSv+8nMeVR0DnaFpZt/uFHSx3ugfxDzBx9zadktPMiTQ7OD/tWpnpz/uEM1Z4yDxEQqUcLSL7aVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803898; c=relaxed/simple;
	bh=LQws0NuvH3NBthAwn8emkDGzLstYx6iNjY0Enn2a2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj1kaaSuRudyLLFWXPJ7z89hnoHduyPOOjBDkmCD4LKF5h8cnVJPeLGUgwxNTVv3F3zFTFTIp3DbFzbZQe2gpw9wEJ30OQcd7cjfSCGluKJASUsNidGaeerkAVo3N+91/V7kGQva8xTOMmQGWAL0TQ61HxlE068F3xHOEHjmWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XOhb4wFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XOhb4wFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF0C32782;
	Wed, 24 Jul 2024 06:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721803897;
	bh=LQws0NuvH3NBthAwn8emkDGzLstYx6iNjY0Enn2a2rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOhb4wFnUQbQk50op+aORGAIlePDoIL5/5fGD+1jf8ixrvg9E12PG/QS1SyOkO8AU
	 +79QttnDoHUcZt2P5PwJ1TfRhvZnbFJ3NDhoVyQ9Z8jMAm63VLtsnatwRx6Ps4XJ+c
	 Ipe4JhYXtMp9H1vRQU86SOGkuk0emeAk9+IGqDzw=
Date: Wed, 24 Jul 2024 08:51:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stsp <stsp2@yandex.ru>
Cc: linux-serial@vger.kernel.org
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <2024072452-pegboard-undying-4245@gregkh>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>

On Sun, Jul 21, 2024 at 02:52:31PM +0300, stsp wrote:
> Hi!
> 
> I've noticed that one of my progs failed
> to work with serial ports. To distinguish
> between real serial ports and PTS nodes,
> it tried TIOCMBIC, checking errno for EINVAL.
> 
> Obviously that behaviour was changed
> and now ENOTTY is returned. Besides
> being backward-incompatible, I think this
> is also wrong because isatty() returns 1
> on such FDs.
> 
> Here's the test-case:
> socat PTY,link=/tmp/ttyS20,raw,echo=0,b9600
> PTY,link=/tmp/ttyS21,raw,echo=0,b9600
> 
> Then run this program:
> 
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
> 
> int main() {
>   int fd, err;
>   int data = TIOCM_DTR | TIOCM_RTS;
>   fd = open("/tmp/ttyS20", O_NONBLOCK);
>   if (fd == -1) {
>     perror("open()");
>     return 1;
>   }
>   err = ioctl(fd, TIOCMBIC, &data);
>   if (err && errno == ENOTTY && isatty(fd))
>     printf("Test FAILED: ENOTTY for tty fd\n");
>   return 0;
> }
> 
> 

What caused this change/regression?  And does any real-world programs
rely on this?  What exactly are you trying to determine with this ioctl
test?  Is there a different way to determine that?

thanks,

greg k-h
