Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECAFCDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 22:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjJQWPJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 18:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJQWPJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 18:15:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2E10E
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 15:15:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so1413320f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697580902; x=1698185702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktiqJhaNnWcsiSGNM+O7S3VXUYzQWCbd8b7d5uvXGcE=;
        b=ZEUVpFAWmR+7LNoyMbNKbqlXDEm4/AKrGF59qoEbyuRtnEP7WOli++Xyd5Apjax7Sf
         56ELf+TZEtRRFhCwyItX3374mEA3OP4zHybGiiwyUyU2uj7uDdJ7LwnCLatEPImc53pA
         qcQViav69atCFXZyLJvz3HzdH9/khgTyXsJIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697580902; x=1698185702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktiqJhaNnWcsiSGNM+O7S3VXUYzQWCbd8b7d5uvXGcE=;
        b=cou71QIEr7I6di3MIx9Gkr/Re0DcvPV8ierltRjgG3+YEE6xjmiq7uO9kKItqXmTbE
         r4lbxsl4tTr9d/CxG8M0shp2R7ygsoRATMGuVpV3YrmyX9jlLXqFjfFrBM2Th/HHtl2x
         YUV+5rYAnyznjzCT6pCOrf98fVZs2dv9ouAYy0Mb4nExoMPpXmaSNXKrFHc1NbNlfwmr
         qBVD+OmjUJ5fBEcwX/qXwnAEvPTLRFaQ4Ul+IllDn5Yv8OPm1NNYCyP9MbXKY9pEYgPN
         TzPI6Kev0Yj9QU3fv5+iLu/wJFuvs8Wd4EMnu+uGkKICzrlDs0s70Oj81HJCTYRMnTnh
         8yww==
X-Gm-Message-State: AOJu0YzU5ofp6aW2yY6uY0tNK4BeBDh7JC7V3skxA6VBhu5VCSrTHG7f
        532MFpHlugOw0wE88FMXWEFUdQ==
X-Google-Smtp-Source: AGHT+IFcD584mZAgvTv5EGC18+zO/bg2J9E4Wz4b6TSboOWLzQ2Eveiz/8BdWHNYQbqZ7sqhtPHlXA==
X-Received: by 2002:a5d:4805:0:b0:32d:8982:ff12 with SMTP id l5-20020a5d4805000000b0032d8982ff12mr3353992wrq.7.1697580901859;
        Tue, 17 Oct 2023 15:15:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fa42:b755:fc77:86e9? ([2001:8b0:aba:5f3c:fa42:b755:fc77:86e9])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b0032d893d8dc8sm691378wrt.2.2023.10.17.15.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 15:15:01 -0700 (PDT)
Message-ID: <87cdf04bfd7997465dad157d9d81fc14ca7d122f.camel@linuxfoundation.org>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Tue, 17 Oct 2023 23:14:59 +0100
In-Reply-To: <20231017065616.GN27774@atomide.com>
References: <ZSPQY6UYg21Z0PnN@nuoska>
         <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
         <178DF50519C11C84.8679@lists.openembedded.org>
         <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
         <2023101516-unmolded-otter-e3e0@gregkh>
         <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
         <20231016063501.GL27774@atomide.com> <ZSzjNgdCH_wmB4u2@nuoska>
         <20231016072352.GM27774@atomide.com>
         <0d86deae37877258f46322d4d727903fca12ad21.camel@linuxfoundation.org>
         <20231017065616.GN27774@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2023-10-17 at 09:56 +0300, Tony Lindgren wrote:
> * Richard Purdie <richard.purdie@linuxfoundation.org> [231016 08:10]:
> > The port sometimes doesn't come up properly at boot.
> >=20
> > To be clear, the "\n\n" from the qemu side into the port doesn't seem
> > to help. The "echo helloB > /dev/ttyS1" inside the image does seem to
> > wake it up.=20
>=20
> So if I understand correctly, this issue still happens with kernel patche=
d
> with commit 81a61051e0ce ("serial: core: Fix checks for tx runtime PM
> state"), and the issue now only happens sometimes.

The issue has always been intermittent and it appeared to happen less
frequently with 81a61051e0ce added but it was hard to know if I was
imagining that.

> I wonder if the following additional change might help?

I've added it into testing and have not reproduced the failure with it
applied yet, locally or on our autobuilder. We need to sort some
release pieces which have been delayed by these issues and we're going
with a workaround for that. Once that is built I can get back to
testing this change more extensively, see if we can still provoke the
issue or not. It may take a day or two of testing before we know with
any certainty if the issue is resolved or not.

Cheers,

Richard


