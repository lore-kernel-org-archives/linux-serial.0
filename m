Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4666C64ED6
	for <linux-serial@archiver.kernel.org>; Tue, 28 Feb 2023 00:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjB1ANe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjB1ANd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 19:13:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133F1A971
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 16:13:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f13so33060103edz.6
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 16:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6auFiAxxwFQX0LU6IDVQBC5x+vKf3oYBXM0DErxZxvI=;
        b=WyRCq92RDe+UQsw+OulHf91BjcSh0ZNcWIbjV9bQZb41Z5ufwDP0Oxl6fp/ndxnXK3
         cHegcYVt5f5F/axkxTafznwrGmwop0xP/cRiStZBrVWwF1KXAhgXbcmSlyLnKNvE4HVD
         CQ+szfvnAjeZKLQSztoCSWslwKGDwJAgTNWRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6auFiAxxwFQX0LU6IDVQBC5x+vKf3oYBXM0DErxZxvI=;
        b=Y8Jwu1/8d43js8FR59r9yws/5m4T94riTZJa6cOHuUYaKWDocvXG3uZ55KIhxqnT8k
         fOx3q8Glv8f0/bZgeMiOEwWCPljSbQNCJrk65cxqv4NPJnjB1Dkcdmk6J+boLoJN8DJt
         sAzhk+aQgBhgAA1cEoq30Z4d31V9yvvQ0M57cjNi9gXAmURlji5d74TWC7a3AIz6Z96c
         mOfXBuzMvNWOyfym7kinjTTONR2qGD3TaFIGUaNsWRnF82BW4vhnzIcbOzR0UbSEn3Hc
         40loJLG9GXbclr+NOg81HUP/WYp40ZCiEuyLz7wPg+aC4OkeAd2uOwtGT4ZrO1MUklQs
         xz5A==
X-Gm-Message-State: AO0yUKVn5dX0C/N75NseWIPgtQM7+qw9Nu5zp0Fduz6nRjmn8ifiJ/Q1
        j7gX7xXyRWkC5jHQa4HvNghAidVPmAF4GnZ3RhE=
X-Google-Smtp-Source: AK7set8VUb3aScYvowGSnB8Dvr1ySeXm+UvQZ4JBTT2rPzbCtv3vxp3OujHnCYhOHSL+6yaFCCe/UQ==
X-Received: by 2002:a05:6402:5484:b0:4af:6e63:b9c6 with SMTP id fg4-20020a056402548400b004af6e63b9c6mr10380757edb.1.1677543197478;
        Mon, 27 Feb 2023 16:13:17 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id g1-20020a50d5c1000000b004ad745b8506sm3741932edj.34.2023.02.27.16.13.16
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:13:16 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id f13so33059850edz.6
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 16:13:16 -0800 (PST)
X-Received: by 2002:a17:906:d9ca:b0:8f1:4c6a:e72 with SMTP id
 qk10-20020a170906d9ca00b008f14c6a0e72mr277841ejb.0.1677543196114; Mon, 27 Feb
 2023 16:13:16 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 16:12:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggVYzViaq47Ms7Aw54UaB4fr9FiiKcr3zCqAkMePcXuw@mail.gmail.com>
Message-ID: <CAHk-=wggVYzViaq47Ms7Aw54UaB4fr9FiiKcr3zCqAkMePcXuw@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@weissschuh.net, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 27, 2023 at 12:22=E2=80=AFPM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Restore the vcs_size() handling in vcs_read() to what
> it had been in previous version.

I took this one directly since I'd been involved in the discussion the
whole time, so we can just close this issue.

           Linus
