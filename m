Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A6380FF6
	for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269310; cv=none; b=hcBy8D07ghFgnZi26ZWxiO28LPrsu+FMIYYwGt4c1Kiws2kDLWrTdwBCl9Wkg9ng67U9mTP7XZQjiFwtIUji0+6QleYiHDkqhoibPrxcehoU7hy0XAuaFE57exQTUTrcAhiILWFwJNk5E/axMfc3NAN8et+WMRdZ8JL6H1uZpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269310; c=relaxed/simple;
	bh=UtldySaucpx0WiT2hf6Tf+4ZCCDvPTnOPP4X9Lh8abA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPe93WDLg+vOu9HfTCeK5JfP6V8jQ0XnV25lCTRfeOVNDbw48TmHcvRt53+/atX46Rm55Q1tBH4Ifrvh7LPYT2tJ/Ak6YkNiNcS42LmZAUfRkn8MgHVlSYsg7EJjAoAE+/fqF4oBn96HYuhV2XEEOv4sv4rOdtuqkDmpy8VCy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZuaQxtwk; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuaQxtwk"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso226498e0c.0
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787269308; x=1787874108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UtldySaucpx0WiT2hf6Tf+4ZCCDvPTnOPP4X9Lh8abA=;
        b=ZuaQxtwk9QgFL63o3jR+JWOU6Jap93UIguWZSl4GW8MlGodrJNgcJ1c3b7W55XyKhY
         OeDiaZo5jIEjqg57FEhk7kX79O52m/n6Xi4zp8u+j5JfDypjdWttKQ6bVJvYEoHySMOw
         I4Ed32JmSidpcjvMxE0EU+75Elaz9c+rY2wVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269308; x=1787874108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtldySaucpx0WiT2hf6Tf+4ZCCDvPTnOPP4X9Lh8abA=;
        b=Lr/iSrTDKiHPEqp4apU3GlOwZCDWlLH/w0thxxBJ80lIeeH4kk2/LNWhkDbMKogtIN
         w/RCa0v/XqqttxaJU8+QUTjJNBh0SNA0EjUGd45dBKZvZmF4HF0kK8O1j8uFgubcESZx
         TmJQtIzKlVLEPe0irZe2wPXt6ROVvqrdltzuQuPjiwiknPh2hm6wyrbCfbpxqiIuvyRb
         F8bt9g6xiGXnJrBsRFSP7ZwoZy38dQxydz1qn8OftZs1/Kt2JqN/nW9Bs/wc0bfILJGV
         fktvod2sfIVxPHANmAN+vUXOs64z91zyNtUXRhx7irWsBhw2Arn9PVRBdavAF6QxIHeF
         okJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjXa7DXmjhKi6nHPenzjs/yqiYYoXXcCBfu26hSBDOvx0wqqWtbhWkavAP5Hi8JSiFAO00LAGUyU2XZvo=@vger.kernel.org
X-Gm-Message-State: AFuF++mogizjjIZylckRWB0InwnWN4/VDQ7rgXKdixd2HsN1KVxFFLpt
	4OH7dwxdNaS4e0YRz1dspHKogsoz9Sba0ReunLqn2R+nOktUq4OB+Moi/Dv8ziwaVMR8OLz4vjv
	/3B4=
X-Gm-Gg: AR+sD11Vv47dD/Y6UFhPBwswcCN7OnBuVLRID56I8YAkU02FX3NvlWkQ/2z18fS3dbg
	+v0cfsbZH1cWm8uAMRF4iRAeF1t7RxaKC/4FaVGEONiOb8KuyjOS+Ed5WddOK8f0MOD0dQtQlFw
	609r/rDr7YK9bx+0qsrPs02T6qNaeBklotXN48TCEVUkEw/vvLjph40EnXsXloG/gZbnIiHbhyd
	cxovJHjHrcO2k0DOhYXXLn5oC0DNvtP9P3FOKhuzgG3+AA/0wJwPcnVWKt4jtelSeNDPEMkOaIN
	8TZk2M1OGUoRfL/wAVEc6VyUvwsb8MyQG1jqoWDTHwl82J0RpPTHRHffWbLNxd4koq04wSHhcl4
	HZ+ce8UidPCVn+GNlK3VhDZzmXXVBb8SyVx/5K9BdGMQco7Q+CGVt09H8GkJ4/N1AOApVLiCZe3
	klwYyWeDq4a9t6Igeb+jZ3W5ZgsQ+IpBBVPfdhiUDZy7PHRtLqbf1BbGntlFafacXoB+PGwfaqs
	e1CCHfD9W5uvrT3uHljcepeJVQ=
X-Received: by 2002:a05:6122:50c:b0:5bd:b27c:bade with SMTP id 71dfb90a1353d-5c5ff6f5c08mr981394e0c.5.1787269307808;
        Thu, 20 Aug 2026 16:41:47 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276e712sm7491662e0c.9.2026.08.20.16.41.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 16:41:45 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-74aa416ebb1so175458137.1
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 16:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+J+TjoT4MUXkqiYgQP8549A3r7ImhMob2uvMsPaxjbV7nwv/2uVOUIi0aMpC5TjR5I+CEVKf0EY8pwLE=@vger.kernel.org
X-Received: by 2002:a05:6102:5809:b0:76f:eaa2:6fa7 with SMTP id
 ada2fe7eead31-77a623259d3mr898151137.2.1787269303777; Thu, 20 Aug 2026
 16:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll> <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com>
 <CAD++jLnQGy_LvRxMjq1s2Hs9Hn4LNTFZ0W17zC1YLs5StwfqMg@mail.gmail.com>
 <CAD=FV=VuVdq_=TQmONJZak84S2c2-2yQ8DS0k_odYsUfg0C+rQ@mail.gmail.com>
 <CAD++jL=VLzW-4eB=izJwaTJ+6xObk9+AQGTDK6ABdrGX4K3vAg@mail.gmail.com>
 <CAD=FV=VsiQfoGYHw3D2xmV=Jedu+cmqEfrCk0mkKFzsrRCQcTg@mail.gmail.com> <CAD++jLkJq0t8sC6_S4LHERbTTiUanKh32QJtdDtUZrXdDEHgMg@mail.gmail.com>
In-Reply-To: <CAD++jLkJq0t8sC6_S4LHERbTTiUanKh32QJtdDtUZrXdDEHgMg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Aug 2026 16:41:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjWd8fRuByAUn-mk-fMJqJN9wrzxAsYH7yYY3XxoDFqA@mail.gmail.com>
X-Gm-Features: AcwNN1W02_U2EPpwN5r9pV16wwm63sX1fk_h0bppJD-El35NE0PVzCZcm5fPTEs
Message-ID: <CAD=FV=WjWd8fRuByAUn-mk-fMJqJN9wrzxAsYH7yYY3XxoDFqA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 20, 2026 at 12:04=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> This is where the imperialistic ambition of device tree
> kicks in: the piece of software - be that a manufacturing
> run-it-once piece of code - that produced said calibration
> should have *also* used device tree to find the thing it
> was to calibrate. Supposedly looping over all UFS devices
> in the device tree and calibrating them one at a time,
> something like this.

Sure. I guess this is one way to look at the root of the problem. The
firmware doesn't itself consume the device tree. It has its own
independent ways to know what hardware is present. Trying to get
Pixel's firmware to use device tree is pretty far out of scope, but I
do see how this fundamental disconnect can be seen as the root fo the
problem.


> "I have a random piece of calibration data and only I know
> which UFS it is for, so I am going to encode that knowledge
> into the device tree as an alias."

To be fair, it's not encoding the calibration as an alias. It's using
an alias to _find_ the node where it can put the calibration data. ;-)


> I don't know if this solves your problem other than saying
> "go with any hack because this takes place in an imperfect
> world", but at least it points out how this kind of problems
> collide with some of the core philosophy of device tree.

LOL. Yeah, I think at this point I'm ready to give up and just
hardcode the path that we hope we'll end up with upstream. ...and if
we're not allowed to have an "empty UFS node" for now, I guess I'll
just have to have the first detect that it's running on an upstream
device tree and have it not fail if it can't find the UFS node. Ugly,
but it'll get us booting and I guess will be uncontroversial.

-Doug
