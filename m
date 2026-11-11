Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794413801;
	b=mCMNyMM+Ibn6gWvXwbnFzvI/gfg2EY08ZlNCyhP2rQjH2Sr+mqsKQXqDZNC1fYWCfsOv
	 ccA9KvfxfSTZDMsi9RO4PVjWno4gSS+BIV8q2ZNu5O0dSZ/Hf/OYVButNKN9Cs9uSYM8L
	 7rngljk5Nv3CT5R0G+MSko913OgxIyoVc+27IOeGnhPYzBj4Q9H42BA8HVbTVdfd7Iaiz
	 ioKKTVBV0txCx96oqjbctPUq2Xbp2l0C9XiXVnGaaesKXhLw6HO68FpKYSQ3kjL0u28o9
	 LUc+o1GoVdgCCrgCyZEOaMjpGlvQT6U48zfr7WyYH7oDIIpPTMjnV6UTVjEXZQEUxDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LstdQ1KayOvKvBdXTZ++PJBU/OdNbClhnjMs5/mc9b8=;
	b=l3dei/+aSkq+yb/rBwd+q+NHPzwcsHQFjTxKnnghFepfHssmzUEnbW6RpuMUfovnHxey
	 Q/me7WmAAWFnb+gUZLDDXyI7UmnjL2fSLMOpa9xuupsNDyNrRUQiB1tpkX9MTxvdFkoAE
	 IIsNRxS474kGEHE7CSJYEuXMSxIgsnyzhwc+6uxz/NAjuJVGaw0W0FlsHfjh1VJdF3T7D
	 bQlOAB2fwwZHTzNJltggBuksslGU2pm0TMzxgzbwKRk6CkS8OTXvL1dLFvXXetE+YfWnH
	 A/KkI3vdjMLi0lzfz2bugquI46JeXGMJ2F8Omzjq+xkAsBYL8R+yGaIaQn5G+gD27MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JxN7fWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF01606A893
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 16:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF01606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JxN7fWT
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-54f873cbe2aso33612761cf.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 08:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794413800; cv=none;
        d=google.com; s=arc-20260327;
        b=Dw0/OsR4BQYiRukGwhrtGOIGsWUYmTCUTTZLgexj5CCoYhy9/dJzGLJ9/9n6OirZPW
         jWR5NMZNtCL5OYKEc9cGn1sbuxitfoWaFIWG6/XVMRw3WKEaNzEia4hxNpkOKAwNq5wQ
         h4k0TcFEMilAEKZaNeXzKaM7DJ8jAR5FvqtcqTEexuQh8lcOwtl/OTzwPx54NXbzyqsu
         oX/KZZeZksNs6O6PFRJuF5bWWMvL9ZdAoaOT6lPqFYW7ZkM2nsomnc0HOsM/1JoViTFD
         Z1Ym8lBop4x6iisKxkIKWUGCvWXLYadO2C0l10FV9j6XMe1asa3K3F4BTob0QrsdSV3i
         QLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LstdQ1KayOvKvBdXTZ++PJBU/OdNbClhnjMs5/mc9b8=;
        fh=cI/tzm+8oxUT9/GO7L7M9IzaEHe2H4mxPsSoIeSTNko=;
        b=sJvjkWqYSBd3uVX+pEDU7CdMm6ZFJ3nVqvcyAIHuim11QtbSZRlH7I7AoPmwECa5Wf
         OT2PkAghft8UD/iyhGo6CIomBt+mKMxtspnhaRMLPhCyf/k44wg3gXQaPVkqZ+02b5K2
         /Mnbn2dwwNVH25Tx5EW4o3wcKzwaTTABe7dfFC294RGUPIiu95emwJGVCKCxho9SiCBJ
         4KMglOQYhuwegHEAZWbQCZo6lQujkWSqNgoJ5h7yURliNbYp+fb9jW5NPD9nb+osnqZk
         +VoV/rUEkTySJkzgYsVuxVdy+0solgrGkyoSoQ3psLUsY0Vw4ngr7L2DfBl0zYX5gBay
         Gy3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794413800; x=1795018600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LstdQ1KayOvKvBdXTZ++PJBU/OdNbClhnjMs5/mc9b8=;
        b=0JxN7fWTeKWIsx7m78aKG+Z2QcLJcr5M6BuEFEQqqNXAgAExJkgaSdP6nqWFybkMEK
         yuydX1NB4Tf8IXzRDDsX9jws7uMFamu0Ga2IM0Ma6FDwXBJgVde8rnnjrkFGDM5x/NCM
         ZwJjId2+BdtRNm9Nr1/R5kcvOC2Ut9vRWNmEc36BlpOuNhxPKSTnNKwzMEsXQeJK4Urv
         ogvZYbHTnZ0ZvOTngleZOddIiislZRdunvX9XufiUZ/L1UIWnQDJmFN8Rk0NPwg5dijb
         Gb/LWn7z4eVYBK9hGTx4yNWCfa7B8MFUOw0fs8KCn9NHyrhJZCOe+CGLVIaZOXKOGEtS
         64Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413800; x=1795018600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LstdQ1KayOvKvBdXTZ++PJBU/OdNbClhnjMs5/mc9b8=;
        b=eVCFb9n8MVz9aU68Unf7G7P+tZpfds3YjoLZi1JJEo7+w2GeEm90aTSDNRj7yezrwI
         pPIsj3DQ12vkEozHchNErcQwli1KXl0aq6ZtSlbtJhVDSd5ApbpI/ULRl25BA9H+m177
         20DarwM1j4OFNKh+7egbrGYbckmt/bcZ5X8AHvrWP1sLMiCCOLjn/fTjUWqwQbwZl9RB
         /NmRCMZDankYWsIWjemeEZqoISh7Y5gqgPSVQ3YuOylyN3ozSNq/2iBWcQhpp/gzgifO
         lnvkYll/SRVl7TzgvBAkvIHcNEwXRfw7inZIu+KyXma96hSmx7flW4EEscAbjfcnk9ok
         8Pvg==
X-Forwarded-Encrypted: i=1; AL+hErHcvQaDLGg8pKUl/5E8z70zwLpyqQCN69m82FQY1Vmi65ESa78nqY5jvw2mw3Bc8KNYicu91yxQ41ndSrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z94Xp+q/huVsTKZOWlgCrK6r5yRAWFmzBoucDkgWYxXIVJYZML/
	X7zsz5kYmoyXYPZTysHQBm2vMMRp2QDjboy8XRiSLDZEVCLMv0JEIH23/gcAAFYuWZtp4eyccc+
	8a4AutZbC4IN6q0E4wjRTYWSRiFIAyLg=
X-Gm-Gg: AYBFou0yG30JXDt04bmczyza3dkIdi7Ly10wbrlg/98sb7HW4JUbrdUaNyxzveB0xFA
	sUNObXplQX5no7laPB08BefHOGokZqBsjEqBfd3rx+G2WXdFYRLCoCtJP2+ZPEVRghNqKrERwkh
	f89xNPi4Fz/G9gBd8NhAagFsEOM5gwpXo3IKHnnjX1Tv47ne18WKLf+qRcnSlUBybbyr7X6UXf/
	EPDwgYUd4RYYvOA95glQ76FZrwGRQc6/vMXToQxmEqT0hpuJshuB4rmwUo/v5b3lx2wzmw43aw7
	tLxTWhaYZ9sFMzkMQps1Py1cbZg2DSOAkyV6kTfCkEBqhU3eAyl9vU3Lu5GjyF3wjREH3skF/Ip
	RBL3hMzUXMfXHdR2UsDucCbfgQji356lyFukK+Agi1xuMRz8Iwm5NanxTMmcYOoe4r+vf
X-Received: by 2002:ac8:59cc:0:b0:537:f05d:abef with SMTP id
 d75a77b69052e-556c1d519e6mr45516351cf.54.1794413800061; Wed, 11 Nov 2026
 08:16:40 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260917155834.2161361-1-vulab@iscas.ac.cn> <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
 <1794138380.2883200.vulab@iscas.ac.cn>
In-Reply-To: <1794138380.2883200.vulab@iscas.ac.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Nov 2026 20:16:29 +0400
X-Gm-Features: AclHuK_TvAgrqod0P7IPbUF8DOI19D1hjrLWu98p4t7n70-06Rpy9qCBuSwEasU
Message-ID: <CABjd4YxYzrxakckCaNODgrCWUfx77J0h3D+gbV95p7_gt1kiog@mail.gmail.com>
Subject: Re: [PATCH] serial: vt8500: Use devm_clk_get_enabled()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux@prisktech.co.nz, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wentao,

On Sun, Nov 8, 2026 at 4:15=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> Hi Alexey,
>
> Sorry for the very late reply. Working through the review comments I got
> in September has taken me far longer than it should have.
>
> Your suggestion was right, but the leak fix went in before I could act on
> it: it is commit 9d8955281d92 ("serial: vt8500: Fix clock reference leak
> in vt8500_serial_probe()") in mainline, and it kept the clk_put() you
> asked me to replace. It has been backported to the stable trees by now as
> well. So the patch below is not a v2 of that one, which would only resend
> something that is already applied, but a follow-up that does the
> conversion on top of it.
>
> devm_clk_get_enabled() gets the clock and enables it in one call and
> registers the disable and put with devm, so both the manual error handlin=
g
> and the clk_put() go away. Probe now returns the error code from the cloc=
k
> lookup instead of a hard-coded -EINVAL, and the clock is released
> automatically through devres. The success path is unchanged and nothing
> else in the driver is touched.
>
> For the record on where this came from: the candidate came from our stati=
c
> analysis tooling, and DeepSeek and GPT-6.1 Sol were used to audit it and =
to
> help write the change. I reviewed the result and I am responsible for it.
> The patch is build-tested only: it compiles cleanly with W=3D1 for arm
> (vt8500_v6_v7_defconfig, CONFIG_SERIAL_VT8500=3Dy) and passes
> checkpatch.pl --strict; I have no VT8500 hardware to test it on.
>
> Thanks for the review,
> Wentao
>
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Wentao Liang <vulab@iscas.ac.cn>
> Date: Sun, 8 Nov 2026 11:41:30 +0000
> Subject: [PATCH] serial: vt8500: Use devm_clk_get_enabled()
>
> vt8500_serial_probe() gets the clock with of_clk_get() and enables it
> with clk_prepare_enable(), so the reference has to be dropped by hand on
> the error path, and the clock is never disabled or released afterwards,
> even though the rest of the probe is devm-managed.
>
> Use devm_clk_get_enabled() instead, which gets and enables the clock in
> one call and registers the teardown with devm. The manual error handling
> and the clk_put() can then go, and probe returns the actual error code
> from the clock lookup rather than a hard-coded -EINVAL.
>
> The clock still stays enabled as long as the port is in use, so the
> success path is unchanged.

Thanks for the patch, but you missed the sign-off line, without which
it cannot be taken any further. The concern raised by Sashiko in its
reply is also valid. The whole bitmap is quite an eye sore frankly, so
it should probably just go anyway.

Let me take a stab at these - I'll put you in Cc.

Best regards,
Alexey
