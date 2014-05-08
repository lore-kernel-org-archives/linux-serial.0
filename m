From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Fwd: Issues with parity error handling in s3c2410 serial driver
Date: Thu, 8 May 2014 13:31:10 +0200
Message-ID: <CABDcavZyCDPpt1MTGpJfgaYnG=oaHcmB-Sqe=PC1SWuQhf-iTg@mail.gmail.com>
References: <CABDcavZnY8-uNhYZkvCEy5sdbAQB2vgcYq1PFiNwpvxj32Xn2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:41719 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaEHLbL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 May 2014 07:31:11 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so10667533wib.0
        for <linux-serial@vger.kernel.org>; Thu, 08 May 2014 04:31:10 -0700 (PDT)
In-Reply-To: <CABDcavZnY8-uNhYZkvCEy5sdbAQB2vgcYq1PFiNwpvxj32Xn2Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hello all,

I think I have found some issues with the handling of parity errors in the
s3c2410 serial driver (drivers/tty/serial/samsung.c)

1.
The driver defines S3C2410_UERSTAT_PARITY as 0x1000
(see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung.c#L265)

However, at least in the S3C2440, the correct value should be 0x02.
This matches the definition in include/linux/serial_s3c.h for the S3C2443 (see
http://lxr.free-electrons.com/source/include/linux/serial_s3c.h#L165)

2.
The driver currently contains code to detect parity errors, but this code is
guarded by the following check:

if (unlikely(uerstat & S3C2410_UERSTAT_ANY)) {
...
}

And the definition of S3C2410_UERSTAT_ANY in include/linux/serial_s3c.h
does not include the parity bit.

This means that the code that currently checks for parity errors in the serial
driver won't actually be run when a parity error occurs. I think that this is a
bug and that S3C2410_UERSTAT_ANY should also contain the parity bit

3.
The code that detects parity errors does not increment the parity error
counter in the serial_icounter_struct structure. Other errors (framing and
overrun) are accounted for -- it is just the parity error that is not traced
(see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung.c#L277).

This means that parity errors will not be reported via the TIOCGICOUNT
ioctl call.


Can someone comment on the above?

Thank you,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
