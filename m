Received: from mail-qv2-f6.google.com (mail-qv2-f6.google.com [74.125.230.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB7374E64
	for <linux-serial@vger.kernel.org>; Sat, 12 Sep 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185580; cv=pass; b=c6x4JYIOKZWnW/0+Qm0dzCnv/Ldnww0q0cc9gSUeLbGK6U0ExR1UoXl/+bUx5uxW1VAlz49W+6XxhXTCbFyBpBJnIVG0glwksaBZXAEI/6LnCSAEUCNStv08xiY0AZ6Jqzib/22kcqJzqYOXGHoVNj78vH+WMJadnwEdM5HRoQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185580; c=relaxed/simple;
	bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj8dNAHRR50SZa4mER0K/cYTJfTM2GBVcpnSKSEt4q6qtJK1ev6VMzG90GFIaMABl2g2Gi1PtAzqvS26lxflZbyatbVj/lqdfBaL1uO75OXsoW0jm5cDgS/DdDCk3dPXy8OXik/phqhBKOtJZ2oQN8/1Y4MF2iHB9NEYi6obQuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUi99WX2; arc=pass smtp.client-ip=74.125.230.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUi99WX2"
Received: by mail-qv2-f6.google.com with SMTP id 6a1803df08f44-90cd0a3019eso6292126d6.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 20:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789185577; cv=none;
        d=google.com; s=arc-20260327;
        b=MjS8X5zvFYvWJdQrM09237HG41L3NrH/+2gnKwHg4Z2SZKhVSA5PlsObCjVy15iTPh
         +T2Md40ore/kZYVz/XPEn5nEawuk7sNU+gzuwAmu3pqOsSdf3wN36lSatZe7faPLP1F6
         afPs+xoIq7wNRy89FCHopirJv9di5oGWv38hpkoeAWNL3F/GCg5RDlIpokh/x6Z9dmJz
         rfpquVbx87HU0G9qXrUsVydiHw3FvUlbW873mFlZrh5k9nMIAy/jfujtUWbO4/3Yu7mI
         0TtM3RVhZBLVBR1WETHIQhbSpkyvui0OgGTkkBuANI0dfs85OFcLIiacmkdHF2/l8d4U
         gsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        fh=ByOFbIfGQ7AA7fM0hgAsD3piozTpsf2R9GS54hOks2k=;
        b=THQnG3gDhe2LXl2Ghp9Cfjn9b6RXlas6An7gAl+NOYWIaiDRKpe8Ub8ew8OkNMUcfc
         zqRrI0iC9Hsxv/9X8QHCz1aiEoufW2ouxM1GoQLlQChTtCCyZlgefCsyUwNXUxtNI/iF
         Sq73DKsTo/jGgqPwD9PwmV5wV0aZcazbD5SkgTq0rOi8VVWxtdKPJOdravwT3WFgPUyZ
         Ie8CKAPBbcRVX75sp5MYysFoXbLdDEn5k7q1s0UC1EKRYA4ZgdOs+4qFEFBOx6GcCY5k
         fX9oG+JI3/F6Ix+V88pOx5CUZbbf7dyo2O3HrEk4o10ZBJYCeJdJciLksyNzTRI8VbTP
         Gfdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185577; x=1789790377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=AUi99WX2mjCEnh94Mgz8UyqQU/oNEA9cIEKZBdzKT+z8ihWUMzk831dQkI3koNvu9G
         FOXv9hL+LCMEPxf/E6B6X3tqNMNit0enH6a996hZjF9P1W9Ca9u/JogjBROhVSBVKuKe
         i1ZglNYBRcPU+heleoHDLB4sNQG/UeUlV3ciG1mn4mte93xJ1PyBBaGWQo9SW/MmOyUE
         E2GuwCGaztMXULuWO9e3gDAe+xNSNVCpMSpRBjuIJOXYQi9Lt395uXUGN7PpUrH06Wk6
         hST40P8ADAOoVPLsm4F0dumn5utDUM8S2/msBC6ownOQBTLYS6vL4zC5VkaFucosXqdX
         tFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185577; x=1789790377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=c1iFRJBujj9vgm+UXXmxkT/2kTG0NYt5JmCEWAsdYh2ZoNxquOMrZi6RUbjcobc2pF
         sNO/4B76CcdY45BWXGPSK6udVjjB0gAHblxJ9VJ+Vs2V5CQqFVC3P3Fh66gtHkV4wb7X
         4xHfOcKC0q5zZEnbnyFEYXkUFwWdYZTXwRlRBV5dxrIy4DC6MmHxviDUHCY7wRQKYyN5
         lSIo1kDaNZYDp5rEJ/NkbtgAQgiV7C/a3gl5ZAvaErxPBhh2tIx6pJyJZvQtdPaWGMNL
         j7sbbJ/+7LjRISzjRBpNNJDkpujR+QYX+HnhKCgpTG7EqIr2T/9aH6XBmY3gSxxLs4gx
         KDSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlLoEDYGgNj2tB4ncJkZSIw+MYrqVCpqWPHRtynkQj9FTF7AkiVYbbaR6cUSHLYPjq/tUDVkO0ETHIkuw=@vger.kernel.org
X-Gm-Message-State: AFuF++lKH4qk84unXf7lZXbuJ4J5GQZf54rMWtc6pCEmDXS84iZOisNI
	hX5SyB76tcBkYYGKMbz+q+05hkXaeQNkUIpCq7KR1CFSxcoY1NY268O2sr+JK2vnaaX0fs1k37h
	u9yauEx2aNgyxZ3DE6ZGYSEbYDIDoFXs=
X-Gm-Gg: AYBFou3G+8BXiObyQVLkrAGfLcnfqem3hSIDt3zMQR+Mq9kgmoTkPK6E9PNWGy54zdg
	4LDDo0a0f5ip6L1fY7UhhgiKOLDxm7aYlYxFHDOr6NxzsiPTmmnK76rpsbQGUabjFlVUBeKLrpv
	GprZ6kL452x+0hulFnjddcrQvdKBIX6DU08WskaTW3EbLng1gAly41N75JWz6qy2TXtP++3CWDs
	J+o8CgQ2DXeLS0ZxBZgNmmsbMDPOlcSgL4n3tTEvAKU21IzUHWqeYTAbK6XvKyKVPdOxiHZVeh5
	b1EI/4o8a9qmmzaRrav1rrxolCYNISLcyt81NVhAnW87/nRdieXc9ZVO+1Dhcpt/JH3ki2Pz5jd
	pW/R6ZV822Urodst6Ub3Q/kusgK094AKNMeym7HuO
X-Received: by 2002:a05:6214:8446:b0:912:15a8:bd9f with SMTP id
 6a1803df08f44-91215a8ec1dmr55956796d6.7.1789185576987; Fri, 11 Sep 2026
 20:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <aqRI3N5FPX1dpIlk@gmail.com> <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
In-Reply-To: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 20:59:26 -0700
X-Gm-Features: AcwNN1VfZ_rXL-z6In5wMRJEgOMU7kPx8LknulegWooIebA5av8sYgSMw6by5S0
Message-ID: <CADkSEUhpe5sX=C5NfUrFMoP9fOGNiFaJ5QmEAVJ=80p8H8S9HQ@mail.gmail.com>
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

On Fri, Sep 11, 2026 at 7:08=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The Risc PC and NetWinder lost their audio drivers when OSS was
> removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
> working on an ALSA driver for the NetWinder but never finished it
> (IIRC it is in 2.6.0-rmk2 but probably doesn't work).

I just remembered someone wrote an ALSA driver that works on the ISA
card version of the WaveArtist, which would probably be easy to get to
work on the NetWinder:
https://lore.kernel.org/all/1440445816-28593-1-git-send-email-linux@rainbow=
-software.org/

Ethan
