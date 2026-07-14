Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827E3E1680
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011612; cv=pass; b=e2TgAchfWANimtz+/2/sJL92zDq/1TbW9lTWuN9rX4E+jxMDxMja8MP0W6B/qCWwZnZTMBakTBE4yKThJERsv2TCXzUtYEHiTKa8OLII1JNvxAZSWFpBoXL6S5Wgo40lbAVSkpeiGT5x3MEYgIwrZV6gcZ7QNfStJ8YGVi9ijoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011612; c=relaxed/simple;
	bh=evGdp8hY4UsToY/uvp7yLFJq32Ens/R4w8zKdD+5dMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHYPJgiItUjxQ9v3nVqd2Hb+87bKd/ZQurv9dhCKh22NZhegD1471zHGeLt4q1w84PCqWRzBG5qgCrggNAp45Av9BgrB7V8VxO8D8XI18Ncl6qvr6qJ02aNnt3Gd3wXo+zrWRnLQOPhzEVg/wDX4xkMKB1Vghewuwx/eRjuCQ4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Ndji3Yyx; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Ndji3Yyx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4720d22c94aso553014f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2026 23:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011609; cv=none;
        d=google.com; s=arc-20260327;
        b=jSmkgm0oIbArfJU1YKFyMY+TL8V8pCdsH+ENSE1BmPsfSY8C5bgDp5bE1q+nmtkL1g
         6j7AYXckYrfZ0KdvfgeZDIAHhCqNk1w2FgrPdT2/CDahjDQ9MrjdcB/9WkmcZIfTKxyt
         Z/cYGOrzbu1OJtEBaOhG91pcppOAId+3L/QKJ8GChG5VSghSPOESMfz590gzrrIlYa2c
         BC955zR1JuzCHilmajFk1C6reDW2V+gS10m6OxxFHZYDMd9Tp8PX3Gy4SSoc0nYdjfr9
         8Z2mK6T8rnxUv9VhyxZPD7aL3xrUYjI18kqkFfiJiq8FLgm1ms+Yxgdu/JFyd6pNx2BV
         cH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        fh=YalVDSZ3TS8w1NmYNeM17HFPYQ8jU199diqcmG/lCp4=;
        b=mL85N7WVlmH5pxCjtKQx+qS1uWEdLU0mxtVs7OjzfO7nMKizvtiovY14xshdzpOe4W
         xq1ltsF7zE9OQqPx3wVLoeDnPsevb9YtHk+dKF06/2ZSxz6NpFjxv1NcUVBEK2OS4ciB
         57T8Vdz9GWsgJiBh3hSbLnyfZ7FOjp5L9eqJQQavGJMkWu9ZKc50M1GsY8F81qftOJuM
         u30zznEnfwJfXuVrhA46PrbvsxXJ9VFC+vNsadyqOlJMCiz1vsHlskPnBqnNMtNpAASp
         u1YBTP5nbIU39YukzOWaabPVag3+/rpPNHbHN8CrsuoTjNXkZ3/v1pb5xWbq2/qmepOz
         +2dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784011609; x=1784616409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        b=Ndji3YyxsJOovUrMDTckN8L20MRTCpcyhu/ilunu+dMPAfLUvrfV6r5+s9YKUgmMCS
         16DJlxsYB612DGhdWNhD2xfiUhPNyiXYh4MmB/YG1+7G7Ric38ha1js7V7s/mVceYNUv
         xcX0oUftCkVd+cRG9Cb9xaA08UBtnHjV5wjjEuFgz7k519f8mDXoGk0g0YiKkIQ8adDa
         kUqdPZqLWJkVycEOfO+zkewd2BYs/VLajiJ/yh4b8mtMp6SHuL4gJZd8ZAHGt7KOy6kO
         PXNl2L4ax0vGKvtp9HEvRH62vlEh6uSlu+MVco9qWw++zJ7/J7FLB1NY/5chJUukHy9m
         2k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011609; x=1784616409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRIKFgzkF61kYnLz7Ci2gKmTsN7do9uyOR/32IqtdZ8=;
        b=FWsDOgiTCHWTaqFxgCPdbwL+bhgpTz4zG7XZJHocyfsX04mPK4Rjztg90xPaJxDLkd
         qHxytbfswxahL7w9Zp8AihI3hMUGmttMpH0DICeFtjdF+E58GIot554L7JaHnW6g2ptn
         Voe0rfccFD/SRVGGmI1/WpPecfXVi9Fb7mKf/3HwmvUIf42Zk9Eod/NrIj/9NJuSyeME
         oh/dZZ9UOkQM5SW/N8lCPvjY76tVBH+myfjbRPEzqqNsr+9qG77VXGPSVwfw2rAi5B4n
         OypC8WNgQu6+DUUViMo2cMmsG7Ungnre5gCrHyZjBqTqMIHCLv/YWghJvkQkEH0uaTHj
         q5eQ==
X-Forwarded-Encrypted: i=1; AHgh+RrL9QwjvR/IwXtBJA1MOQoCy2EwNaLonza2L9efIGNrfjvbn3gejCdg6vpencsjfRWVQ9nYyADdZrZqYm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBE1uKd3uaJ/Dmv51CHLEWUum4MPx5dy/atcZh4DeBXMO/gVB
	cE6ETl43pp/5Orw2hjHzSi6MUb1Ye5bNsp8+tPhCbTIa94HIZZgEnhsfmUnDjHuBuUgcZLfHoyz
	m+hiZK7pFRpNlBJTs93TgwMVYsB0b0ZmnX2/zKLHh/A==
X-Gm-Gg: AfdE7clPd4rDt4B+YUT54MH1FiTA7vjss4wx3NOT+yAvWn4W3uLYXdgJzYFg2UyMlAa
	3mONkXsZsIAWh8rVEQij7jszqcKoChAiDG9EUek5fANjwgHMmx2pRUd87xcKUUJR58FeUoWcY9t
	aW0gfly5nSe9bQ4ECzrTtdS0FfW7qbXRukkBdYvveesCReFMfC6aHTeS44istzEDvgdWg59OOvp
	tax3l/Khc3/bib2bzag0Eb1PpKXrAu7iT/Iw1nZEdBdFapcYShxLdtP1ilqY2HMLaEApZ536/Mp
	tvJYRcFm6E/qL3+ADSZZbsEymBvWmRZ3yBaBJQHRQrqRFps3Hq8fl3b9wg==
X-Received: by 2002:a05:6000:2c03:b0:46f:f12b:e457 with SMTP id
 ffacd0b85a97d-47f2dcc333cmr14446794f8f.21.1784011608749; Mon, 13 Jul 2026
 23:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
 <eaef5bcc-99df-4549-8d37-fb3d127c414e@kernel.org>
In-Reply-To: <eaef5bcc-99df-4549-8d37-fb3d127c414e@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:46:38 +0200
X-Gm-Features: AUfX_myOLR4_eYCcAMsMsFbuxCuEv8cibreksrI0hciTFLsi2wYi7z1DbvBt6s4
Message-ID: <CAFi2wKaO9ea77KP3hjoaruMgU8oVbbtuAmXK8p-12HRdRFOACQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

> > ...
> > +
> > +enum aspeed_platform_id {
> > +     ASPEED,
>
> What is this good for?

Unecessary, it's removed now.

>
> > +};
> > +
> > +static const int vuart_msi_index[2] =3D { 16, 17 };
> > +static const int vuart_port_addr[2] =3D {0x3f8, 0x2f8};
>
> Sort of inconsistent spaces. Both arrays should be unsigned anyway. And
> for the latter, u16 should be enough.

True. Acknowledged.

> > ...
> > +
> > +     vuart_ioport =3D vuart_port_addr[idx];
> > +     /* ASPEED BMC device shift addresses by 2 to the left */
> > +     vuart_ioport =3D vuart_ioport << 2;
>
> Simply:
> vuart_ioport <<=3D 2;
> ? Or join the two lines?

Joined the two lines.

> > ...
> > +static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] =3D {
> > +     { PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID),
> > +             .class =3D 0xFF0000, .class_mask =3D 0xFFFF00,
>
> PCI_CLASS_OTHERS << 16

Acknowledged

> > ...
> thanks,
> --
> js
> suse labs

Thanks for the review. Applied everything for the next revision.

Regards,
Gr=C3=A9goire
