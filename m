Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6D1C5F2E;
	Wed, 29 Jan 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162368; cv=none; b=NfDxVMH5apK7QLoToC6yhBIM1HT/HM1WtonDMWh7GGc8j2Mq2mW6WNnph4A1bbLEPu4LoqRPZYERoFn+2CKKLY02wP4dGb8RuvZAMyQ0oMCD3n0/fDvVQgJtsJRaC/D/Mw6bney4BwbX+NYhsR2HaYKaWRxniZxb1rKWLoVSVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162368; c=relaxed/simple;
	bh=rjpba0LFpYm6AyC0WzTszRjZtuSKA5sSBH8QdJgCQYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVxaA3nmzDubIGROgBagJt2Np4FhKGidLCwCEvdFbNdM6eRZlsNhawNlJM2vGM1Fdflo+rwLAH3aLRPNoTuJaw/B/LghRnaL3sROtO7udkVPY7R1uLrMRqgrHTOLUdwhTwe5ulnxEGwqA2clwW2fSJsmyXMNerUxsTAp+gFjPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD01Ib11; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD01Ib11"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so73274045e9.1;
        Wed, 29 Jan 2025 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738162363; x=1738767163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjpba0LFpYm6AyC0WzTszRjZtuSKA5sSBH8QdJgCQYc=;
        b=JD01Ib11AirVTN4dSQ0OyMCj0XnwTS0wVU3YXPFi7jQCsmppTObfA0LvIjoX8a7lfG
         1X98Rq7spxMGFKhGjBxaC2nKo4dwiYdd0snGSvvr+z5+3POJGoX8xSkb5VpgsAjOV6ad
         GBrU9gs0zW2c/gr2R8sU86kTMNumzy+fzCzUEIVKUj2yg1ihABkYFLb7bgHO5T7P282f
         X/N1qLlHc9gQ0JQkIyq7lF+mU2UcDq4cShIU6jvXkml0sawaW4MFcxy7tCrUoIcOSCeN
         FSxlS+A+4YMufI3dfH2cmIhT5UDEdnIfEg8MzfaVLNqiUhgevdWEWM3JTUiMed6wuX7d
         ixFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738162363; x=1738767163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjpba0LFpYm6AyC0WzTszRjZtuSKA5sSBH8QdJgCQYc=;
        b=R4taebWXUHzXA9fo0F/Xv3ir9Ga0EDbR9U8+0vNZLl8Hz9Iae86TqBeJY5K2cwNPUx
         2GzJmrnv5kWoJcVlCiEANL8Npw1Za6/NrAgoTNlGGAVwotYCBp0ccNdlbX4Ox9upByln
         LjhDQHg5dfD8VEM4114z4i92RmulbG/LaWwU2JICAi7x6bGB2EwHtmRHoZ6UWeT+c3ZW
         R/DB5Z06/IWmXb94NaYyDZslWvz53pujZ6Mz0ofGwu02j1xU+uNSnnwu6omXhSI/hHpc
         ACUSZiJA8z5QWDuMF4AR/V7owsgAClrAmopWqrIxkOT60P6LhisrQaudd7/fWzwNQILL
         LhqA==
X-Forwarded-Encrypted: i=1; AJvYcCVR1Ow4aRSM3Fvx+Se0+JhZ4mB6tvERX/DipXTyEB+lEV/dyAnYQltNBYTEdM6ny9cTwFVqKgD1RRCPhgd8@vger.kernel.org, AJvYcCVYxV2G5doJdqTB6tAuSX9h3+1/lideUWJoeD0tkBiDp2oBA796zwz5S32CpjjrBPEEGdFDw2G1iAt4z+A=@vger.kernel.org, AJvYcCW8DI3x+VvKMjOxEedoxjgETDqdD0g4FWfEkocH1yMYADXX4d43MhJFnnv03Mjo87JS6XeH8sxUEn9Eb8UZ@vger.kernel.org, AJvYcCXQmv5+YKy5M3iYoD1rL/bbzl4MAikTLRx9Cni2rn7jtN+5RvgcZoqXSwdFdM3xnKIf1RaVJ8LkDKeH@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5B7Ax9+dxzwdFSiUY03nWrkAuxPBLcqXs60lnaeYREmDr+aN
	LzChYLWEZUeDb7MBIZYv49ijxOYwfmZ7mS/UB8uQfDL/D7J84Bm8
X-Gm-Gg: ASbGncuUSijNVIamirg8UYTDvv2u7ZrX4r6Gc4cMObp7q0uLTgPePoS1SCZZpNrhmS3
	zn5heCfftErNiws/LM3NxEMCMgXe0oXwAQ7Yewyc62bUmhjQtk84ROjtSJ3XBLS1M6BeZx+u5Sd
	OmWtrGQHh0OE0r6vDrWScxle7sP7zQZP/O0y4FS9TWgGPgplqNZ83/UWFsY+eidCVMVi7dTc2Bc
	zs6w+Pq9jcU02T+PT7F+YBHxG8bxDT2KgWOmQ3XJEPjew8+ZNN5utnOW4F5BJAizjigQW5lgtkV
	SrjeYiJ/y+y/e7Jnx7i6zccbr1nnIJNlalNdRqVxZ/za3j08qkU2xqO4+5pkeY1Mc2Wqwvz/bTw
	Zhw==
X-Google-Smtp-Source: AGHT+IHYiD8HHU7c3CPRRKT9FNr4EOClWP6a4zZA9f98b+kcMuPfszC9bzeA10N9+9WO3BBUe4NS9g==
X-Received: by 2002:a05:600c:3b14:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-438dc3c237dmr29171655e9.8.1738162363114;
        Wed, 29 Jan 2025 06:52:43 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc11ae6sm26173045e9.6.2025.01.29.06.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:52:41 -0800 (PST)
Date: Wed, 29 Jan 2025 15:52:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: "krzk@kernel.org" <krzk@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	"robh@kernel.org" <robh@kernel.org>, "robert.marko@sartura.hr" <robert.marko@sartura.hr>, 
	"arnd@kernel.org" <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, 
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add bindings for
 nvidia,tegra264-utc
Message-ID: <5j3fhrauu7j4vdal4yi34yj5egxe42i3aj4ezuc5oblhz6nfca@ebewyvonecj5>
References: <20250128064633.12381-1-kkartik@nvidia.com>
 <20250128064633.12381-2-kkartik@nvidia.com>
 <20250128-amusing-squirrel-of-gaiety-b3ba97@krzk-bin>
 <ae6132b93ac30a1f7b2721066a0e0eddc01745d5.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5smhkbxpyhajfnuz"
Content-Disposition: inline
In-Reply-To: <ae6132b93ac30a1f7b2721066a0e0eddc01745d5.camel@nvidia.com>


--5smhkbxpyhajfnuz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add bindings for
 nvidia,tegra264-utc
MIME-Version: 1.0

On Wed, Jan 29, 2025 at 07:30:55AM +0000, Kartik Rajput wrote:
> Thanks for reviewing the patch Krzysztof!
>=20
> On Tue, 2025-01-28 at 08:52 +0100, Krzysztof Kozlowski wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On Tue, Jan 28, 2025 at 12:16:32PM +0530, Kartik Rajput wrote:
[...]
> > > +=C2=A0 nvidia,utc-fifo-threshold:
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > +=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This property specifies the UTC TX an=
d RX client FIFO
> > > threshold in
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 terms of occupancy.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This property should have the same va=
lue as the burst size
> > > (number
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of characters read by the Tegra UTC h=
ardware at a time from
> > > each
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client) which is configured by the bo=
otloader.
> >=20
> > Title says this is a client, so quite confusing. Anyway, why is this
> > board specific?
>=20
> The client FIFO threshold should match the burst size configured in the
> UTC controller by bootloader. This value could change depending on what
> bootloader has programmed. Hence, this is moved to the device-tree.
>=20
> >=20
> > Also, missing constraints, missing units. Why common serial
> > properties
> > are not applicable?
> >=20
>=20
> I do see current-speed defined in serial-peripheral-props.yaml, that
> can be used here. I also see "rx-threshold" and "tx-threshold"
> properties defined in serial.yaml, maybe those can be utilized here. I
> will update this in v2.

I suppose "rx-threshold" and "tx-threshold" could be used instead of the
custom "nvidia,utc-fifo-threshold" property. It looks like the hardware
has separate values for the threshold in both directions, so this would
give us a more accurate description (though from the current state of
affairs it looks like both are always going to be the same).

I'm not so sure about "current-speed", though. There's no concept of
speed for the UTC, right? It's effectively backed by a physical UART
that will run at a certain speed, but given that it will multiplex data
=66rom a variety of sources, "current-speed" will not be accurate in many
cases.

Thierry

--5smhkbxpyhajfnuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeaQLMACgkQ3SOs138+
s6Emlg/+MkWZTsiltrG5WOU7FROD1BNtrTMJM1miRG4fNtVf7fSd6xOYPi6Xp+gn
0fYzToqmpBRNMhQTdEUcmMz/3uKRWC/29BiyV44aBjpb3u/jj7d1DP/B8E/iTuZM
2ifUzL5QnHVz93Ew4uDsrVxfVSsjzDzeEV148wkiO/liWVWW+rJw7cL+sINssmnN
g3hYzXNOWA/9DzPdcxydHHe6lh+DNf4cn5cf4jaW7r9HPmXQpLDkmp8lSbqbJYkJ
I0awauUXVXiZroUqmy+ubyEqFWYzvbFAvrEkyocgPVgheDOndWyauf/wKUsDvWKv
uFzRO8ypLqYp880+J9vsBoo8MjNCWQayZ3PjwT5vF7wga41ZDKxPMOJNb//l/zw5
0R2ru9glO+fuf019SEqnx6tVbIsK0++4CVOe9jtfhQPsrHPOGk7RYvoR7R8FYh0J
l6sPLCuS0DZWeG5MvttwlO2iwS/luOhbNL7FZSRWKmaEiT0Sbnry81GdO4kz4WdK
avOtQM6yOwJ7q1NRfwd2YnSTW7dIntYVrmajJ3iErL+HjVGKJXA9kHMLUybBvSXT
CAu4y7GKBPucmZ1+jbRZpAWZz5Fyd0YNNFIugsOUq4yuMb+YvBH3SlRj/DcfMR3F
ATH8aYHFke6IuNYBwg4ycUBti2oZTuIjojlisbz0bywwKtgldjY=
=MV3R
-----END PGP SIGNATURE-----

--5smhkbxpyhajfnuz--
