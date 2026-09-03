Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FE349CFF
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410479; cv=none; b=klQkEl7kDBTLHStOflj8oEQVPVCjZPU/3Wp3WfKSquNfTh5LZerI3t/TZ3ATA/3v2pFboFJ/Jy/OCLxZ/wWxGoIAh1YozF9XMhOhXdewiD8FRo/oSkLUU3DVomD9/M5HZEZMODkJsrmDaGZNGyue4C1GFeojrf2u0SoWAsvKMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410479; c=relaxed/simple;
	bh=OND0w7zrYzQQfAH1tzfSSqZzMKCffkJ2CeBmdt1K1Ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KPJgEEL7SKY7q7Q/nTKrtXQs3Rs++Hgm9L/p99MbKeDc7bNQ7etsw8N+fMwzSv3Ubw5usxHIsccghGQNCtaMMxSlwNkks85ChU/3LpOBo6I9rI3l9xWbdfhdTf4rsPWt3lbyqn+bAuUn5DOHj6gXXtNSqaD6UV5L2ojb8/1GxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0XT3nwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0XT3nwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8701F000E9;
	Thu,  3 Sep 2026 04:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788410478;
	bh=DmqihUeZgN5VMon4nCB5pT2wbnL+QBf3bT3LwvpGAWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0XT3nwjZUrM9x8h/dgzwBbfoLdQPuX66Qq82S+bD+00suGNf4sOb1Db7cyz4CN+i
	 03xMCSUD2+H1ej1Hb5mIYyo7l+FaR1p1hRG4vZh3PUbDq+xysTxCKYP5cjEFSSvhX3
	 vlIlERhBwoTfnY0JZbJVxO+hVsbsDFbtW9NsxTkE/3C00uCIc9gXRylt1ICjSVk84+
	 GiRDCJtPILH6DJz4OsMp0H90NerDVMXxephsiS3q4TF1yTho+YDN7YcTQAXcDLT524
	 1gMf+aNs4fCJ05/njgSKO06qpT2pa+zGobtbPPrWlcGV3TWqceTVBlihVYU7STJ8do
	 ll+vA5MnOs0vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] USB: serial: fix break_ctl() NULL-pointer
 dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adriano Cordova" <adrianox@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260903042429.130320-2-adrianox@gmail.com>
References: <20260903042429.130320-1-adrianox@gmail.com>
 <20260903042429.130320-2-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:41:17 +0000
Message-Id: <20260903044117.CC8701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch's atte=
mpt to fix it is flawed. The newly added lockless state check of USB_STATE_=
NOTATTACHED in `serial_break` leaves a Time-of-Check to Time-of-Use (TOCTOU=
) race window, failing to completely prevent Use-After-Free or NULL-pointer=
 dereference vulnerabilities upon concurrent device disconnect.
- [High] This problem wasn't introduced by this patch, but while the patch =
aims to prevent calling into the driver after disconnect, it completely omi=
ts other TTY operations in the generic usb-serial driver, leaving them vuln=
erable to the same Use-After-Free crashes.
--

commit 35b2c0cc5ee711aab91cfbffe24f9565620f8f65
Author: Adriano Cordova <adrianox@gmail.com>
USB: serial: fix break_ctl() NULL-pointer dereference

This commit attempts to fix a NULL-pointer dereference by checking if the
USB device is detached before calling into the sub-driver's break_ctl
callback.

Link: https://syzkaller.appspot.com/bug?extid=3D473d7477c523b41d4046

> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-ser=
ial.c
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -532,6 +532,9 @@ static int serial_break(struct tty_struct *tty, int b=
reak_state)
>  {
>  	struct usb_serial_port *port =3D tty->driver_data;
> =20
> +	if (port->serial->dev->state =3D=3D USB_STATE_NOTATTACHED)
> +		return -ENODEV;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless check
leave a Time-of-Check to Time-of-Use (TOCTOU) race window?

If the thread executing serial_break() in drivers/usb/serial/usb-serial.c
evaluates USB_STATE_NOTATTACHED to false and gets preempted, could a
concurrent usb_disconnect() finish port_remove() and free driver-private
data before the thread resumes?

>  	dev_dbg(&port->dev, "%s\n", __func__);
> =20
>  	if (port->serial->type->break_ctl)
>  		return port->serial->type->break_ctl(tty, break_state);

[Severity: High]
This is a pre-existing issue, but does this still execute the sub-driver's
break_ctl() function on freed memory or a NULL pointer if the race condition
described above triggers during a concurrent TIOCSBRK or TIOCCBRK ioctl?

Additionally, this is a pre-existing issue, but while this patch aims to
prevent calling into the driver after disconnect in serial_break(), what
protects other TTY operations in the generic usb-serial driver from the
same Use-After-Free crashes?

For example, serial_tiocmget() unconditionally calls into sub-drivers
without checking for disconnect:

drivers/usb/serial/usb-serial.c:serial_tiocmget() {
    ...
	if (port->serial->type->tiocmget)
		return port->serial->type->tiocmget(tty);
    ...
}

Similar unprotected calls appear to happen in serial_ioctl(),
serial_tiocmset(), serial_throttle(), and serial_unthrottle(). Can these
also be triggered by an unprivileged user spamming concurrent TTY ioctls
(like TIOCMGET) while the physical device is unplugged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903042429.1303=
20-1-adrianox@gmail.com?part=3D1
