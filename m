Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3F1114;
	Wed, 16 Jul 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687044; cv=none; b=ASEgRjmJNkTql8JyMnSpU0fzWNnL74//O4oUfp9zn+++4uhNA6Uzyh/Mpgwa4cVONFbvAaPyTY+y9QGnO7VPf2WBvF+vFKzvzT297uMF0jOXdv0XdThNyjAjiD1THWjr/6l/mVKT6kM8vqXXYvEShwiWKnkE53EmIXJe69vh8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687044; c=relaxed/simple;
	bh=r2DRgij26xF5m6ZdI1q8r2pxawboAB2+pBWnHW4lsNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTNgENsJP4+c0/KRZszTrNm7ddlDShcw7Jf3xxpJ5cLo0GeSRzA5y6WhrVTxlKNp0knerfpCqC6p1p3/CdgLZZoHX5kq8rIxAGNLHCCQZDlUkQQcJmOntMv0WNPhB7C6GyAlUcoz6oEaPooLL+ojzHCdBwb4HCZxoA6OzOtOQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Gy2t0WPv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Gy2t0WPv"
Received: from [IPV6:2601:646:8081:9482:6dc:b955:47cb:dcbb] ([IPv6:2601:646:8081:9482:6dc:b955:47cb:dcbb])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56GHUYEe1625675
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 16 Jul 2025 10:30:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56GHUYEe1625675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752687035;
	bh=0trOfPgTp1BfkTElS9aX20q6MRULueSy68TJTaUES2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gy2t0WPvdz+He897EQMoQcH0JfPQeIHBqi7z44XsIN5Nrj6G4/vvwFJYYRm27clDo
	 wettSG+p998Gz9erjq+lCC4bX7EDQCaZC2J6tccHwtKXmMJlAYAkggSHjdwQafbtwB
	 YMf8KY3V0t4TStJrxg6GbjwY4G96l6b41D1Go02EWCvHFbOZWvIzmKWaIucPeSKZrg
	 d+TpGHKh7CSjGdMeD7btX/B6WkA/u6RhXn5RhGNTc1c/1ghMNxh71cMozKMrk8UiKO
	 88hdbru2v4FgWDxViL+nQ9hYQlK1xwJBW65aWDlrsUiSsXBlEYrXfHzn+se/6UWkcg
	 E7ByWA8+U735A==
Message-ID: <927f2d40-1004-4738-a1bc-0000d4d3e179@zytor.com>
Date: Wed, 16 Jul 2025 10:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
 <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-07-16 09:17, Oliver Neukum wrote:
> 
> If you really wanted to use that API as it is right now, you'd
> have breaks racing with each other and, worse, with open()
> and close().
> Are you sure POSIX says nothing about how to handle such cases?
> 

This is the POSIX definition for tcsendbreak():

NAME

    tcsendbreak — send a break for a specific duration

SYNOPSIS

    #include <termios.h>

    int tcsendbreak(int fildes, int duration);

DESCRIPTION

    If the terminal is using asynchronous serial data transmission,
tcsendbreak() shall cause transmission of a continuous stream of
zero-valued bits for a specific duration. If duration is 0, it shall
cause transmission of zero-valued bits for at least 0.25 seconds, and
not more than 0.5 seconds. If duration is not 0, it shall send
zero-valued bits for an implementation-defined period of time.

    The fildes argument is an open file descriptor associated with a
terminal.

    If the terminal is not using asynchronous serial data transmission,
it is implementation-defined whether tcsendbreak() sends data to
generate a break condition or returns without taking any action.

    Attempts to use tcsendbreak() from a process which is a member of a
background process group on a fildes associated with its controlling
terminal shall cause the process group to be sent a SIGTTOU signal. If
the calling thread is blocking SIGTTOU signals or the process is
ignoring SIGTTOU signals, the process shall be allowed to perform the
operation, and no signal is sent.

RETURN VALUE

    Upon successful completion, 0 shall be returned. Otherwise, -1 shall
be returned and errno set to indicate the error.

ERRORS

    The tcsendbreak() function shall fail if:

    [EBADF]
        The fildes argument is not a valid file descriptor.
    [EIO]
        The process group of the writing process is orphaned, the
calling thread is not blocking SIGTTOU, and the process is not ignoring
SIGTTOU.
    [ENOTTY]
        The file associated with fildes is not a terminal.

--- ---

The only other mentions of BREAK I can find are the BRKINT and IGNBRK
flags, respectively.

>
> You'd probably have to start a timer in the driver in send_break().
> That timer would need to be properly handled in disconnect(),
> pre/post_reset() and suspend()
> That API is really not nice to use.
> 

That's why I said if that is what is needed, it really belongs in the
tty core.  That's where the current internal delay is, after all.

	-hpa

