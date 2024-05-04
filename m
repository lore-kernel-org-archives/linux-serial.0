Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647DAD2D;
	Sat,  4 May 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714796232; cv=none; b=VhNVn+JYmXYI6f2l762BtDb10aRL2qpp/3nN4KWCnK1JxtDLIajpHTbE/W+/sKaAdMKn1mxU/T5chvCkqTrCUM47OKfEpikZ6evUSMGv5qQAwGxK6Igjz7e3bd1yiMOzhfOc+mFjV7pXJlC8P3PevqRadllk78awdocYTRLOYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714796232; c=relaxed/simple;
	bh=b2lTUeDMgTot2tq51wa/9lK7Ivb8jkSSeQ3JX6w03A8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmxqLtpP1BBy4465BExO7OTkSBPrix54ZeCsPP+1qdbRIjKCxgodYAz6q1GgGTcM2PMbNdNAEsqCHP7cy46xFPHks/PkSoXi1WT982FC4wz/er2VqWd6+nfNa41NWUWCseINyleoqeHTOlTSrFAOShWIbk3JvhwuXXgCUY8/EAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY9yWJfP; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY9yWJfP"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5af2358c7e5so343839eaf.0;
        Fri, 03 May 2024 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714796230; x=1715401030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSo6zwOKqQsGcSGbmDOSdgFiHjnaPqYR6z7N4u/pMMc=;
        b=PY9yWJfP2W4ONOG3QVoirtlCuyTmGCzuGIj+BtfAA4uoW9tbkBnhzNQlzvAzxuhLa0
         vtTc3C+OykoLVvC339ByPH6OUnNbRa/VsSJRwuZ1QAxujBfdyXbmYplFNiQLI1lv6WF7
         /hx1ai7hEKstDdtrNz841iuCx1U5naSdIlFxgKi5YnP7Vq/UnSlAqUZBdC+5/Wx//ndD
         yYYQi3vYymu8SgGEZidRaQ5oEG4aRI7f2PXOa7TxV+rsXCEd6a6U32EvDArPXfYHl6Zr
         xbM/LxLRPYt8GALXW9cHBEJp0NasrH5BArTbSR3R4WvaKTxDQUd0IHN+Okyt7r++Fhwg
         XVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714796230; x=1715401030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSo6zwOKqQsGcSGbmDOSdgFiHjnaPqYR6z7N4u/pMMc=;
        b=Jz6yLvvuE52GTtmfask8jm7muO7zGzrDNL9V+UtWwNT6CpzmPUv3g+8F8NpldsdSLs
         UhVL7uXmKAsUWUvvudhNOEoPY6DVbFuJwJD2ynpVILWG1gw+q2CTIQCnfxa8ACrA+wT5
         iwEqVZRIiz1/ksn1Qkj0Tsm/rTr2XWwMKtCCPVqT68T3nnI4yJm0zCxeBR9PdsQahq5D
         rpQvt60CbaxbWz3PPfdxTndb5ntPleS3UQn79SYXzHWGG261rn9iFAOTlE+h6CliXRbw
         N9OuIBkHBoGBKarpBe2Y1YYqvFMJtb/Yz4jmOk0NHb/tWQmU1mKThgqE06gZh6SrOXye
         0AuA==
X-Forwarded-Encrypted: i=1; AJvYcCVO9ZtjMn112LRDNeGxjY7aPaeeqArFKVuYqX1bFgbUMpYaojv8xNhEDzyGNiDybwcBtYrcFKGfUy5jqiYkBWKQKgjLg0NNzuNnx/ol
X-Gm-Message-State: AOJu0YzYDQq2lKZ2NiJmV7QPc5wP8XTdsX23CAk243NTf3Ia8v4Gx2DX
	/ubOOKgLi2hoag96Tc4laYfNwGEs/OnYT+Q42Eye+QndvUYbIxWM
X-Google-Smtp-Source: AGHT+IGdvZsYHYLwNI4cw0uRqUHM3E2Fqp+63lsTFTNCHPScphYrAOc4ufA4UUrHI6VTXtoHVAw+yw==
X-Received: by 2002:a05:6358:988f:b0:18a:78c2:7ccf with SMTP id q15-20020a056358988f00b0018a78c27ccfmr5238421rwa.13.1714796229852;
        Fri, 03 May 2024 21:17:09 -0700 (PDT)
Received: from [192.168.5.213] ([101.229.120.80])
        by smtp.gmail.com with ESMTPSA id d14-20020a63f24e000000b0060063c4be3bsm3911940pgk.14.2024.05.03.21.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 21:17:09 -0700 (PDT)
Message-ID: <15e9c1278505677e813df48190a5cd9c200453c3.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] platform/surface: aggregator: Defer probing when
 serdev is not ready
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>
Date: Sat, 04 May 2024 12:17:05 +0800
In-Reply-To: <ZjUY7xPXszBulKap@smile.fi.intel.com>
References: <20240503030900.1334763-1-weifeng.liu.z@gmail.com>
	 <20240503030900.1334763-2-weifeng.liu.z@gmail.com>
	 <ZjUY7xPXszBulKap@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy,

On Fri, 2024-05-03 at 20:03 +0300, Andy Shevchenko wrote:
> On Fri, May 03, 2024 at 11:08:46AM +0800, Weifeng Liu wrote:
> > This is an attempt to alleviate race conditions in the SAM driver where
> > essential resources like serial device and GPIO pins are not ready at
> > the time ssam_serial_hub_probe() is called.  Instead of giving up
> > probing, a better way would be to defer the probing by returning
> > -EPROBE_DEFER, allowing the kernel try again later.
> >=20
> > However, there is no way of identifying all such cases from other real
> > errors in a few days.  So let's take a gradual approach identify and
> > address these cases as they arise.  This commit marks the initial step
> > in this process.
>=20
> ...
>=20
> > +	/*
> > +	 * The following step can fail when it's called too early before the
> > +	 * underlying UART device is ready (in this case -ENXIO is returned).
> > +	 * Instead of simply giving up and losing everything, we can defer
> > +	 * the probing by returning -EPROBE_DEFER so that the kernel would be
> > +	 * able to retry later.
> > +	 */
>=20
> You can add the following to the
> serial_core.c (at the top after the headers)
>=20
> #undef ENXIO
> #define ENXIO __LINE__
>=20
> And I'm pretty much sure it will point out you to the uart_port_activate(=
).
> If it's the case you may elaborate this in the comment.
> Otherwise you may add the same hack to other files and find the culprit.

Indeed, uart_port_activate() is the function where we gets errno -
ENXIO.  Please see the cover letter [1] of this series:


  ssam_serial_hub_probe()
  serdev_device_open()
  ctrl->ops->open()	/* this callback being ttyport_open() */
  tty->ops->open()	/* this callback being uart_open() */
  tty_port_open()
  port->ops->activate()	/* this callback being uart_port_activate() */
  Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.

What confuses me is that when ssam_serial_hub_probe() (probe callback
of a serdev driver) gets called and tries to open the provided serdev
device by serdev_device_open(), it simply fails to open it...  The
serdev device is not the kind of auxiliary devices but the main device
this driver is to manage.  And I don't find other serdev driver doing
this sort of checking and returning -EPROBE_DEFER thing when opening
serdev device.  Thus, from the perspective of a newcomer to this area,
I think this phenomenon is somewhat abnormal.  Maybe somehow the
initializing of the UART device and probing of serdev driver are
interleaved...

Andy, do you have any idea what's going wrong here?  Or do you think
this is an expected behavior?

>=20
> Also it might be that we add some error code substitution inside serdev c=
ore.
> At least there more data is available to make the (better) decision.
>=20

Agree.  If failing in serdev_device_open() is common in a serdev
driver, we'd better handle it properly inside serdev core and convey
explicit semantics to the caller.

Best regards,
Weifeng

[1]
https://lore.kernel.org/linux-serial/20240503030900.1334763-1-weifeng.liu.z=
@gmail.com/T/#m40d73c44bf92ad45e4fca5ed5f01f9c11e30adb1
