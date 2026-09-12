Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959543750D6
	for <linux-serial@vger.kernel.org>; Sat, 12 Sep 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178961; cv=pass; b=dF+xP1ixIP/4XkERBFw32384swwE1qSw1sKjhqCdEJB+vp2QtVtgJusQIh0kb/U2LquQR90Rb4gn5X7M8QBc74UIoxSRo/3aVqbCm2SP9JM+VXDePfx6nSsdZIgb3Ml/yHtryAkmGqWJ/uU/RUlXBQj4pvZHY3Sd0Qf4mGxJ8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178961; c=relaxed/simple;
	bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S25Vy6vnXY8fP2EXYhX9aT178l71WuYerZOAf7xzuX8934wmwatZQMibXzweKLNoiyA68SDtgJ9YVILwQpOw5tLQZbFCwhEo6OeQn3A6WicQYw6ECwGmV9/oUC68iiAVnFdhiEZav5uTzcyyZfpyu7uyf5dcIcjg4hTkiT5vgTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMm3dOKX; arc=pass smtp.client-ip=74.125.230.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMm3dOKX"
Received: by mail-qk2-f1.google.com with SMTP id d75a77b69052e-530178f21ffso10443001cf.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 19:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789178952; cv=none;
        d=google.com; s=arc-20260327;
        b=PAK7NZYWAmL81owsyZHuww0B0qGHWh3nRA6hJQeew7BKU9UiJu2zD9+2/QhDFFFlZh
         zMq60Is9Q8cruh4sca/D2NMfa9iwPbsxTkok7OZyBLBHmZVbVmVceMJPVxQ3kAWPBUCc
         5YZgP8soi4J+kjL5LX6Dsdu17afn1ghQnbnE78NT4ra2o9tit6YD9f0MUPGBKcyke1en
         691eEIsGtPZmIygHyno+XUz75uX465KSTyrSsTqaB2vXi7Z0vXetpT2HImrrDm1nPdgW
         e74xdcR9bWTbGUBMQl+nFM93KfkztqfWcSDeM1r1cFHe/KTg0S7lcF8rHcwBwZc665ow
         MR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        fh=Yxt7ZuE9EDTYhnpoDsrOdfR8EakodkXUAetK2lL5+ac=;
        b=mgwaUR9/id3bCcvimjcQJw4oPGsWiX0+kJCFgCKiPlby3RETwgADmDU6D1uts38cXa
         0nhpju2hO6J1yOp4U6T4xufXyGOVF8ea9tdIo2YzEkPAVYnj/6LpG7Cs/MBmXV4P7dCJ
         RrWfC8qi3m5wto9mc77tP3wPjUoT6KP7mema3ARvGXEoNHBhGUwW7BUuZvRhnke1InW/
         GL84lxcibOzdEWwRF9w0hbrBzvLteFLrJ8Aktk8u1AJoifqS+nKbhrYXOtpox5UP+tKy
         FbNocNawKOhf2uOmUxh1M+HW7VFNhy2KC9rokiYgimuUgzJlpI3PIUv8tVqf+3v9v57X
         HQKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789178952; x=1789783752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        b=JMm3dOKXg3dR288w9DJwRrPKB3jB2Gf5uWX+r2Jd94fqwUUkdUb0j8Tu/DNIpnF5Gh
         +fKPDYcxNdVvIY+oI2ffqgGRXi5h1VT2cDFU21lEdRPmkMTAiv42+Z+OtKGgD5VM/Hw2
         olMjymLuzbTX6+vI5HVpJmDgAGm4Xj31buSYpDWt7obqabhT3/TDoSX82s44Mepo45bw
         9EVfVjW2P2wKmCTKoPvXWS7dCezilyn/1AUEgdmFXRsV+uzBIrx06eXZlP9YpKSNmmFN
         GjTueV3c59yNLE0Nz57BNmZwVVs8eHNY3ZsfMatyrRcNs7h4QCgMHEsm6g/JMmx62Ecd
         Mt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789178952; x=1789783752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        b=MkR2kEul0Gaj8z013wtBreZAb3+HLm6vtRy6+xcicUuQmFfRY802AtCboMJ7vvNHXQ
         cxj8ZxFBODHNolwDrx42saBLZb44//ZYKNUg3iuxslZcO9bBev+JWDoGkEKX6COCZrrf
         lxx5dfJcoASX9Iw/6d0j4wLZ9Nn2L1BVEOvQVfov9gFNbHfd0js7RZTwpZfkRuS5CEv9
         UUObZfo7/ttl1uwEkPf4/kIgneEJEPYWwdfmQ7nz3WgEpphJk/fxmdZaRTvV+YtyoMQr
         XrOGvnR7fZSMGtk5QvH3StAIYJGi3jBqP9wZfxfW5KtMZVuwkP6gTh4ykV35WREd7GXj
         Z4gw==
X-Forwarded-Encrypted: i=1; AKwUvBwdAFGtQ01UNEctzkIPJBNmzoIWj9z+TN1PZoTzaXc3Nj9oWiu6+mzx2pYbzsX+Jt1Tej9xFbp2bgJM0+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mQETkEVlvb6A0L8nxonfG1ghFCeksjY1y1KwX7SToIK4pEvNvs
	PuvjXP6QgQmzbDao+rgKKfIL8lNKowPCioc51J2AAHVhc7MSTUAFVATzJuxoUxY1Si5rL75RwJx
	35K9sDlbswagPWyXPvizFNwsNPPghcMs=
X-Gm-Gg: AYBFou1eWSZtKfEHv+ea1SZwF3bLUkWA/gOOrkaUwg8uxF2huMC4gs5aO3Hmj1rNFJw
	Ln05Ock4Ym6lzak6UoLAS/1UHcNVsRv8xVdrfha7RpEwdqbiQJNgtyreqvgZXjrVArA6oY64cn0
	a+gXir+2fQd4fMWkH1S5JheFb/u/yWdThowGLKDcES788u5fXFAhi9w3+jPBVKvehW9083CzTlA
	z/UJ7WQ6FM14pxFlTNgYJroS6UTb3tCnWexqb3LxuCfUGIpyPY8UaVrjlp6FsO4w+Yzs8+ShaJ1
	Yn/0lnKmKEkv8hh/hXwNmtXqHJXOr3aZ5BqKlCfGI/JHEJgk9b/kvGZcZ4e/j4WuJRjgzj2hUep
	HN3iZQRIhHKSTuCD35UzEbcrDZBFbhTHK0ZRMmu6Q
X-Received: by 2002:ac8:5dc6:0:b0:530:d1d6:792d with SMTP id
 d75a77b69052e-530e7dd8ae5mr13590681cf.15.1789178947506; Fri, 11 Sep 2026
 19:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <aqRI3N5FPX1dpIlk@gmail.com>
In-Reply-To: <aqRI3N5FPX1dpIlk@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 19:08:55 -0700
X-Gm-Features: AcwNN1XgIQzd6k50BFzIHmb9Q0P_yN5Y-RnB_uEDdmfcLkrtltvi4fLr_oEAXtE
Message-ID: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Karl,

On Fri, Sep 11, 2026 at 11:43=E2=80=AFAM Karl Mehltretter
<kmehltretter@gmail.com> wrote:
> I've made a RiscPC emulator in the browser using QEMU and WASM. It boots
> Linux kernels and currently emulates a StrongARM RiscPC:

That's awesome. Are you planning to add support for the NetWinder to the b?

A couple things that I didn't see when I glanced through the code:

* QEMU needs to model the broken ldrh/strh instructions for the Risc
PC (but not the NetWinder). I am not sure exactly what their behavior
is on real hardware (though I have seen forum posts where people
investigated this - I'll let you know when I find them). For now, you
could just have them load/store a random value (:p). It would also be
helpful if it could print a warning when one of these instructions is
executed, to help people detect and remove instances of them in e.g.
JITs.

* On ARMv3, CP15 register c0 is write-only, and you don't model this.
This caused Linux on ARMv3 to be broken for a very long time before
support was eventually removed - it was broken even in 2.4.18-rmk4. A
patch to run Linux on the CL-PS7500FE (=3D ARM710 Risc PC on a chip,
used in the Acorn A7000+) works around this by keeping a copy of it:
http://webpal.bigbrd.com/patch-2.4.18-rmk4-wp3.gz. According to a
comment in later 2.4 versions, that approach won't work, but I don't
understand why. Also, the patch fails to fix other reads to the
register outside cpu_get_pgd() (I forget which ones).

A few things I know about early ARM hardware and Linux that might help you:

Before 2.6, ARM support in the mainline kernel was very incomplete
and, IIRC, unusable. To build a working kernel, you needed to apply a
patch from http://ftp.armlinux.org.uk/pub/linux/arm/kernel/. There are
no patches for versions newer than 2.4.27, but the 2.4.27 patch mostly
applies correctly to 2.4.37.11 (I didn't try to fully fix it up
though). The last patch that was released was 2.6.0-rmk2 - it has some
relevant changes like the CL-PS7500 PS/2 mouse driver. There is also
an unreleased 2.6.4 patch - I should ask RMK if he still has it.

The NetWinder development team shipped patches to their kernel with
additional features for the NetWinder (and other ARM hardware,
including Acorn). This is the last one:
http://www.netwinder.org/mirror/users/r/ralphs/kernel/patch-2.4.21-rmk1-nw1=
.gz
I don't think most of those changes ended up in mainline.

The Risc PC and NetWinder lost their audio drivers when OSS was
removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
working on an ALSA driver for the NetWinder but never finished it
(IIRC it is in 2.6.0-rmk2 but probably doesn't work).

> I used LLMs a lot while building it.

I don't use LLMs for environmental reasons, because they are often
inaccurate, and because I like using my own brain and don't want it to
atrophy, but we are all entitled to our own opinion.

> Your GCC work looks useful for this. I will look at building the RiscPC
> Linux kernel with it, and at emulating the original ARMv3 CPU too.

Great. Let me know if it works.

P.S. I have a few UI suggestions for the emulator:
* Make the display bigger and able to lock the mouse/keyboard and go
into fullscreen.
* Remove the LK201 keyboard - the NetWinder used a normal PC keyboard
(if you add it), and the Risc PC used an Acorn PS/2 keyboard (a normal
British PC keyboard but with no Windows key):
https://chrisacorns.computinghistory.org.uk/32bit_UpgradesA2G/Acorn_RiscPC_=
Keyboard.html.
Just keep virtual keys for the keys that you can't input in a web
browser.
* It should be possible to middle click using a modifier key if the
emulator ever runs Risc OS, because middle clicking is heavily used in
Risc OS.
* I think some of the explanatory text is unnecessary.
* The skeuomorphism is cute but inaccurately represents a Risc PC, and
I think it clutters the UI unnecessarily.

Ethan
