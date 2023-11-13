Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C705C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 10:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKMKYn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 05:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKMKYn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 05:24:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384C10CA
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:24:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc58219376so37841175ad.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871080; x=1700475880; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvhfRiEn/JQ/sTat9S9kUx90eeVH90Jeof4YpqlmPq4=;
        b=jhgZtOmMRm/hv6JlLsYIZZub4JmSwhHGFA+g7Ht/Wal91kncf8aO2tBgZSBBMg+Ggt
         DoEC8l0+qDU9aF5xjyKLeMjYw6xEnsb4LogXmH6GX0JjLBulXlCha9TNUJllJACxcrPI
         upHo4VoqrWgPnQqzbvwc9efpRRshhA4e4sGCJzNTQKaOqs0jYkSVHCeNY9qjiQtHFhle
         KQSbSsiepUVYMd2WGcyZuT/bLWFgLm7ugSoKWngenlDT4i0t5lYOqffR2wUTBSximnwV
         adZSe6OKGV1d82hnJJ99PAEAePnDuRwgFZn7YNirpsEIJjkvkaP0vl45pSDvoaNK/vdG
         Hv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871080; x=1700475880;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvhfRiEn/JQ/sTat9S9kUx90eeVH90Jeof4YpqlmPq4=;
        b=F1/DDQ4Gm+2f8Jt/7+D4Uey65cxzFTPY/qFO8YWSWICnHeAjGSIp/F/nxXH683vvQn
         3mbVlY931VdWWTaDpxCVItBOe3yCzKJVzX4P2HcuVGkg8jzyCZ3jcv+cy/hadZAX2VJX
         9KuEhTI3LoOL5ON6WgEkX+89rgvSPS21xuRXoePSoPUccLDrGe/ZeCPntnbxLLzptjeK
         vJagyqK7IA7A3Nhn3RJfDebB3lLAxN/kPOVmhPLcueaYZZlw4DPsKyF8HH25YpG1ut7w
         +p5l4DlcEpuRm/60xHD5rGN3GQRYJJNn/dmYuAC8N+zS+cdB2S60CYkOgbDHBIYVh78k
         R3KA==
X-Gm-Message-State: AOJu0YxNsxIuF9JKQjcmmTfN/8F6B5QD+riAYvRQiIY3/v5SQzEprDwp
        GUPP6bEswGbVF+zKe2IylCOKRj2IbCg=
X-Google-Smtp-Source: AGHT+IFp3r/37Ybm8YpWjR6uPwy9Lo4Fr6duvRL/bVO2gkJqKbaaFPXEH9CwZdCEYm7+w5ZQDYLT1A==
X-Received: by 2002:a17:903:234a:b0:1cc:ab06:e6c8 with SMTP id c10-20020a170903234a00b001ccab06e6c8mr10155712plh.19.1699871079839;
        Mon, 13 Nov 2023 02:24:39 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902694900b001cc0e3a29a8sm3744725plt.89.2023.11.13.02.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 02:24:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Nov 2023 20:24:33 +1000
Message-Id: <CWXM06PV1CIJ.1DG4SJH21CJXP@wheely>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@pengutronix.de>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty: hvc: Make hvc_remove() return no value
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: aerc 0.15.2
References: <20231105214406.3765906-4-u.kleine-koenig@pengutronix.de>
 <20231105214406.3765906-5-u.kleine-koenig@pengutronix.de>
 <CWXL68T68A18.BZ8WHB15ZU2Y@wheely>
 <20231113095730.uein5ix7eduqvboq@pengutronix.de>
In-Reply-To: <20231113095730.uein5ix7eduqvboq@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon Nov 13, 2023 at 7:57 PM AEST, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Nov 13, 2023 at 07:45:27PM +1000, Nicholas Piggin wrote:
> > On Mon Nov 6, 2023 at 7:44 AM AEST, Uwe Kleine-K=C3=B6nig wrote:
> > > The function hvc_remove() returns zero unconditionally. Make it retur=
n
> > > void instead to make it obvious that the caller doesn't need to do an=
y
> > > error handling. Accordingly drop the error handling from
> > > hvc_opal_remove().
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > IIUC these are functionally no change, just tidying and removing
> > dead code?
>
> In case this isn't only a rethorical question: There is indeed no
> change in behaviour.

Thanks, it wasn't. Your changelog and code seemed to be quite clear,
I just wanted to confirm I didn't misread or misunderstand it.

Thanks,
Nick

> hvc_remove() returned always zero, so
>
> 	rc =3D hvc_remove(hp);
> 	if (rc =3D=3D 0) {
> 		... some code not changing rc ...
> 	}
> 	... some more code not changing rc ...
> 	return rc
>
> can be simplified to
>
> 	hvc_remove(hp);
> 	... some code not changing rc ...
> 	... some more code not changing rc ...
> 	return 0;
>
> Best regards
> Uwe

