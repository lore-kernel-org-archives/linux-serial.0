Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AE15E5CA;
	Fri, 22 Nov 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318478; cv=none; b=t0m8exoNuUv+KhlzG6I3puxxy4EX22HSU9OK69xANAkXfM3ueNYtF0u9+ulT11b94bH717TYVqKo4m05VlmU5JPBmgKb37tkX47giCdPjBif/8ajk7HP9bo+NIOYb+8T/1Cp5EnrxPE7ayG/dmYfNJBAtdN+PZ+btZty4yReu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318478; c=relaxed/simple;
	bh=JFYgkSmnLeANkWfWjakLFqx6yo9Spcs5iuPUlcKJpBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=td/cnnkpxAPmUs6LiTTO73QwHOOoYXAo96zr3sS59G0G2uFklqCmXn/SgIkO4G8C7f4iLoehO04BrgwSJwfM/YIlPZZhOd0TlHYWhbuqwbKxhfqY96A2edqQMEA9Zi7+lUMNiWV30wmSORukWtjqPHQyOAtM9RzdbxeWlaxewSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NshzSmH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NshzSmH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F3C4CECE;
	Fri, 22 Nov 2024 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732318478;
	bh=JFYgkSmnLeANkWfWjakLFqx6yo9Spcs5iuPUlcKJpBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NshzSmH2IEadLX2z+JXJNGVHclm4bMilvJ/1k4nk4UtKCLobVdf8BL8QviXBf9F5f
	 brl9w+PxDWEmpHpP04LVs5NZScU+H7yBmny1jvHmB/b65i3r2l6jE7boGsYGC/jKE6
	 savrD7sS/03Usr5039uFihiBoDq7wIlshYmjNwuxIEj9AbDTP07VErqdBp9kWvSE4f
	 iEayicUtOl957jtVbtKL0Ru720ONQ6vVep+JnpGbzMM8FA8Wcs3V421pSvg1WXs/yE
	 bbKEoBs0zo72Rm57avnmRnMG0sK8qXCYJVsMTFNAZl66N1eD/1CxW73gggg/rF8wSc
	 odRlbFiGBaSjw==
Message-ID: <ddcbade39fb8a4dcac57c66c59fcc0b4d56dcaa6.camel@kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
From: Niklas Schnelle <niks@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Niklas Schnelle
 <schnelle@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby	
 <jirislaby@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, linux-serial@vger.kernel.org, Arnd
 Bergmann	 <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Date: Sat, 23 Nov 2024 00:34:34 +0100
In-Reply-To: <92c2c05a-be0d-4017-a766-62832668512d@roeck-us.net>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
	 <20240405152924.252598-2-schnelle@linux.ibm.com>
	 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
	 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
	 <92c2c05a-be0d-4017-a766-62832668512d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-22 at 09:07 -0800, Guenter Roeck wrote:
> On 11/22/24 07:35, Niklas Schnelle wrote:
> > On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:
> > > On Fri, Apr 05, 2024 at 05:29:24PM +0200, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and
> > > > friends at
> > > > compile time. We thus need to add HAS_IOPORT as dependency for
> > > > those
> > > > drivers using them unconditionally. For 8250 based drivers some
> > > > support
> > > > MMIO only use so fence only the parts requiring I/O ports.
> > > >=20
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ...
> > > > @@ -422,10 +443,12 @@ static void set_io_from_upio(struct
> > > > uart_port *p)
> > > > =C2=A0=C2=A0	up->dl_write =3D default_serial_dl_write;
> > > > =C2=A0=20
> > > > +	default:
> > > > +		WARN(1, "Unsupported UART type %x\n", p-
> > > > >iotype);
> > >=20
> > > So, according to this patch, the serial uart on microblaze,
> > > nios2,
> > > openrisc, xtensa, and possibly others is not or no longer
> > > supported.
> > >=20
> > > WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470
> > > serial8250_set_defaults+0x1a8/0x22c
> > > Unsupported UART type 0
> > >=20
> > > Any special reason ?
> > >=20
> > > Guenter
> >=20
> > So according to the warning the p->iotype is 0 which is UPIO_PORT.
> > For UPIO_PORT the switch above the WARN would pick io_serial_in()
> > and
> > io_serial_out() as handlers. These use inb() respectively outb() to
> > access the serial so I don't see how they would work with
> > !HAS_IOPORT
> > and it most definitely won't work for s390.
> >=20
> > Now for Microblaze Kconfig says to select HAS_IOPORT if PCI so I'd
> > assume that it can use inb()/outb() and maybe the PCI requirement
> > is
> > not correct if this isn't a PCI device and it used to work with
> > inb()/outb()? For nios2, openrisc, and xtensa they don't select
> > HAS_IOPORT so either it really won't work anyway or they should
> > select
> > it. Can you tell us more about the devices involved where you saw
> > this?
> >=20
>=20
> This is seen when booting the affected architectures with qemu.
>=20
> Logs:
>=20
> https://kerneltests.org/builders/qemu-microblaze-master/builds/327/steps/=
qemubuildcommand/logs/stdio
> https://kerneltests.org/builders/qemu-nios2-master/builds/314/steps/qemub=
uildcommand/logs/stdio
> https://kerneltests.org/builders/qemu-openrisc-master/builds/301
> https://kerneltests.org/builders/qemu-xtensa-master/builds/311/steps/qemu=
buildcommand/logs/stdio
>=20
> Guenter
>=20

Am I seeing it right that despite the warning and the code setting
no_serial_in / no_serial_out the console=3DttyS0 in the above qemu boots
still worked? Also for example in the nios2 case I see the warning 4
times. So this makes me wonder since the warning is new is it possible
that set_io_from_upio() has been called with an invalid / all
zero port before but it was invisible.

The way I'm reading __serial8250_isa_init_ports() and in particular the
first loop if nr_uarts is e.g. 5 in the nios case but only the first
entry in serial8250_ports[] has the IOMEM 8250 it will still call
serial8250_setup_port() on the 4 other unintalized/zero elements which
would explain the iotype being 0. And as far as I can see nr_uarts is
just set to the value of CONFIG_SERIAL_8250_RUNTIME_UARTS in
8250_platform.c.

I may be totally off though this console_init() stuff has me a little
confused and it's been a long day.

Regards,
Niklas
