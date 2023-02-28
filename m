Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEA5C7EE23
	for <linux-serial@archiver.kernel.org>; Tue, 28 Feb 2023 02:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjB1Cku (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 21:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Ckt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 21:40:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540128842
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 18:40:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so34337052edb.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677552047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S33amPXBgEdvAj5aotTxFER/po/FAxTdpekQddcRdP0=;
        b=cB0BrIfjrop8bEcPOyvgb7LRJi+neqLR6Haz3iEUxPsoCCvokD73MOmauWFEXF/T+z
         wIJTU387LfgT4pYFvWLALxtIYcQo1ljsvKL5/wSo+b20kizlEcanOud7TTMMBpL9wKu9
         yVfIiIHIiCYTg1DYwUR5h4D2Wbsbn2ZtWZnHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677552047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S33amPXBgEdvAj5aotTxFER/po/FAxTdpekQddcRdP0=;
        b=GnoGklscs+dNjFB4xvPGvOmnssSBHCq59bPI965qpMK06SFRHOsf74zmdk6oSpXDPq
         w0/GLu0kmxlY9MlfDQx4eX+B2ixN1IbEM5yMZ971Ra7x9TbiM5DXe1MjgnUhbqaNlOuq
         5kHQK8wF53UVeoyJJb1IjRofYhRDyBPIYFK+TbXxF+UDZJ5j2MpI3YZwP72Mk45ejVyi
         a3BT2tuBNm7sjbJwj18czyoLj0uBf7k8/zX+TIonLxMhHDd80Ldg78LIGK+LfmiKget5
         linqSznx7XAh+Ntu8mHugDoSCswc0B3jnc66ahjxEjyh8yCOjAzLE74NmyyIqgzVEuHv
         J1pg==
X-Gm-Message-State: AO0yUKUqr1KPC75nOB+DVISMIgIf7h/l0rl0lwXT0UUmzcvJt9kC5G+b
        mlGGXeeraEHC3TzKQM/RgcotPnETsTToyoB5bEQ=
X-Google-Smtp-Source: AK7set+ZYH5ulgiG0as1q1oVyCFb1X4ntH63kCRJx+OszIPguSpHG0f89DLW2dEn3F2QiNAU9uMHfQ==
X-Received: by 2002:aa7:c507:0:b0:4ae:eab6:9ff8 with SMTP id o7-20020aa7c507000000b004aeeab69ff8mr1749343edq.13.1677552046762;
        Mon, 27 Feb 2023 18:40:46 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m20-20020a509314000000b004af5aa16fcasm3165361eda.66.2023.02.27.18.40.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 18:40:45 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o15so31593744edr.13
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 18:40:45 -0800 (PST)
X-Received: by 2002:a17:906:79a:b0:8b8:aef3:f2a9 with SMTP id
 l26-20020a170906079a00b008b8aef3f2a9mr413714ejc.0.1677552045260; Mon, 27 Feb
 2023 18:40:45 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
 <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de> <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
 <64981d94-d00c-4b31-9063-43ad0a384bde@t-8ch.de>
In-Reply-To: <64981d94-d00c-4b31-9063-43ad0a384bde@t-8ch.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 18:40:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3KimdZnsU5j7fPgPCpDj3QaZvmu5CXRsAE=NiOjmAXw@mail.gmail.com>
Message-ID: <CAHk-=wi3KimdZnsU5j7fPgPCpDj3QaZvmu5CXRsAE=NiOjmAXw@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 27, 2023 at 6:18=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Tested-By: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> (Or feel free to use my patch from above and fixup the goto/break line)

Done.

              Linus
