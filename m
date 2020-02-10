Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2818C35254
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 18:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762920715
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="f41NLCMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBJSjO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:39:14 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36242 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJSjO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 13:39:14 -0500
Received: by mail-vs1-f66.google.com with SMTP id a2so4838834vso.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2020 10:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkofZ98GV9LrfTaHrQ4QXlvW8pxoiPCKhSeZwyB4myE=;
        b=f41NLCMZXey4Ys9A7uP5rM9ZV2mSGKtW4NtWxbjNETiTUOUdIJNqz8nbHeSOvyv2wh
         61gNGEMmqTXeEtKWvlalwKkev2VYjDsl9ytHugeSN4WTO9AdMo8NsrVQIb9bcy3iyxs6
         da1077AlGkSdO+VrqL3xsuHnOs2DV+kaKX+o8WWTCRQGgiLatxztTE++MOfAyBcS5+uT
         0A6uBB6NM+HS1/0iM0aVAzcb3KA1SwMB7LGd3d+z3H5NehWluDsDk/0f6qh4hFMTTdzw
         Hm2JQ/XucerYluY1Fpi7W6WHWcV99glkrmsZZxhdQmcc1G5c+QFXR/VqAlEKkjt1b231
         df/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkofZ98GV9LrfTaHrQ4QXlvW8pxoiPCKhSeZwyB4myE=;
        b=gkv1yG8LUHjp7W396vdp69tTZdPstzqwRc4eoGE2XhHlw2uWYO2BvgkJlOxP/Pycqw
         H6sHcgy49wgpnjSBQ9A9RikdTRmmQfcEMKRXuBaw77m/XXfLGnNKHpf1MH48LbQWb8eB
         m2PJHrQturHMGXVaZQCxB5Skc2yt3zSJr7S3tTeeHlTxJar8mmr5UWQ9YfZUalH9wtfO
         edZLcfEta9C9VB0yWxo/hHrckpBafBpx2Vqj9Yg17cYuMbcIJAT/PRl3eQ3tjBK3ogcl
         puq6LmyCEUNQFoppLQSDuMYTQ/w0UI0AdE1blTg+Hg576sWCWCUT3Z3siz+PZZoGQWQ4
         gGOw==
X-Gm-Message-State: APjAAAWWygm+JNkjQQH+fCbWE6wEuR+FxqxSe9vsj6rFFF5PUvJHoZ36
        23L0Qf9qrjI13xealWuizfv9GM4jdeCdFrLWxetyoQ==
X-Google-Smtp-Source: APXvYqylS31EeYY2TQEyhA2fZwtOWVmw0I810y+f36CA662rAeY9S7L2kcOPcBQ2w32A7f/Jm9+pPA3P3wkATxmK+F8=
X-Received: by 2002:a05:6102:22e7:: with SMTP id b7mr7433450vsh.57.1581359950389;
 Mon, 10 Feb 2020 10:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20200210174942.14182-1-ghilliard@kopismobile.com>
 <20200210174942.14182-3-ghilliard@kopismobile.com> <20200210181156.fbq66yazb5j5quvn@pengutronix.de>
In-Reply-To: <20200210181156.fbq66yazb5j5quvn@pengutronix.de>
From:   George Hilliard <ghilliard@kopismobile.com>
Date:   Mon, 10 Feb 2020 12:38:59 -0600
Message-ID: <CALM8J=f1HV8BucyLVAz8cje392F98uOPoYdOMTSL0970eJnAcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: imx serial: Implement support for reversing TX
 and RX polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 10, 2020 at 12:11 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Feb 10, 2020 at 11:49:42AM -0600, George Hilliard wrote:
> > (confidentiality spam)
>
> Hmm, sad, I would have had some review feedback that should be addressed
> before application of the patch. As I only noticed the footer after
> looking at the patch, it was already too late to stop me reviewing it.
> As I don't have an expressed permission I will at least not share it
> (and I expect that Greg will also refuse to apply a patch with such a
> footer).
>
This is fixed now. Apologies - added without my knowledge. Should I
simply resend a v2 without the notice?  Happy to CC everyone else you
included.

George
