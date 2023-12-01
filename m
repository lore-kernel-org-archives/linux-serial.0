Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aknrodqp"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A502AD48;
	Fri,  1 Dec 2023 03:59:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D652FE000A;
	Fri,  1 Dec 2023 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701431948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo1HW2RbWjsXr4I+NcN2RIgPr28kFzpwIsFkOjIb1/c=;
	b=aknrodqpRG28RyGgGka+xHoWLNUVL0+VgCHlH3dl8FAyFZ4vciFVq5dxSMV8DE6pj6Yg4N
	67gm8OISrrdTcXYKjI3Mvo9GQo+dIu89iK6JJwA7HFtKmS0uhGQ/35nkgJBfREPcFQHUGE
	NbX+2R73R2fuUYLP2zkoFL4VeJcy7z8c7eD8Evik1rI+C3KPcOjIycS9qkEAkeC4i20W2T
	AkL+F14wiuquY3YC660bGdvSCx3HtkT0uwAt8cZA8unonCahx4l7nWPqSK0m8/fwj+snm3
	8RVzvODTGH4NSO1P7g0IfPWwV6yo2PWQ6UbrcbOGsKxmE3QI5GCUxBSlcaXxkQ==
Date: Fri, 1 Dec 2023 12:59:04 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 imx@lists.linux.dev, joe@perches.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, zbigniew.lukwinski@linux.intel.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 7/7] tty: i3c: add TTY over I3C master support
Message-ID: <20231201125904.6c8128b1@xps-13>
In-Reply-To: <20231130224408.3591288-8-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
	<20231130224408.3591288-8-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Thu, 30 Nov 2023 17:44:08 -0500:

> In typical embedded Linux systems, UART consoles require at least two pin=
s,
> TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> present, we can save these two pins by using this driver. Pins is crucial
> resources, especially in small chip packages.
>=20
> This introduces support for using the I3C bus to transfer console tty dat=
a,
> effectively replacing the need for dedicated UART pins. This not only
> conserves valuable pin resources but also facilitates testing of I3C's
> advanced features, including early termination, in-band interrupt (IBI)
> support, and the creation of more complex data patterns. Additionally,
> it aids in identifying and addressing issues within the I3C controller
> driver.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v4 to v5
>     - send in i3c improvememtn patches.

This is not what I said, I believe this patch and the previous patch
should be sent separately.

Thanks,
Miqu=C3=A8l
