Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F6C64ED6
	for <linux-serial@archiver.kernel.org>; Mon, 27 Feb 2023 20:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjB0UH1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjB0UHY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 15:07:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5230B2887F
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 12:07:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s26so30566991edw.11
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oqSuHyd58upkN+REe6cNpWdbGmeGTPNZYBxYA3mJCI=;
        b=QNq5ZFOBMWMe087lgTL0w/9PiBLy3Nqgwhna58XI6PQXysMgseTVTYmKejL+jeRj6j
         LelmxO5Bq2l/Ve5cGo4Y55I8VkmuHqpaJv/KH+UyDNN2QSR+eFT7p9LBG6z6Az7Y9+Sx
         PZvVkULrHJM3qoerf5FLEgJVvwSUyWSeZz22g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oqSuHyd58upkN+REe6cNpWdbGmeGTPNZYBxYA3mJCI=;
        b=AHXlMpycnlz8hMMVwLdovkhnLBHDAwAeKTOA2VeuxVO9FQnejmK+Ym/Dm0PsWgAXdD
         ecEjouLIiNX6TcP5IQfQ3Grbp8+Dx9fY8+MPGJ4Yru6kV7Gn2rb1nH0RW05kvuMwJ2tg
         Z1S+tD/1DnDan/oSM9vRRW9RjQn4OnI+u163UJmM7ZhhCHiJfBCVz8nie8IjBGfGK9T/
         NtIcBivj9dmTekXYnPF/BVB9oQhHP5D6FngHmEOl+/ejj327LHWTSZyqgIQdkaE2j0Tr
         mUG5fEu5Ndi+Bc/TSWLHCVNTtQpYx+Wzi1oPSYWycrm8DXHAAK2wXfHt6Zw/e7MO6XIy
         JCUA==
X-Gm-Message-State: AO0yUKWKtwSwtP2vmI/3khgSZbkIvoTGUq7gLNTI6vbHclax22yh82rA
        N0PFXVXf85pP5GYW3m9grwtxg6pqkDXUVvGLhbw=
X-Google-Smtp-Source: AK7set9Neb8opm1eEI2rzL8PLxOPEDA3QaoVEsOki30dB8ja4oKhgKM8KJVzkAMB/DgDVrPI758KsQ==
X-Received: by 2002:aa7:cb89:0:b0:4af:6c25:f04b with SMTP id r9-20020aa7cb89000000b004af6c25f04bmr853602edt.13.1677528425572;
        Mon, 27 Feb 2023 12:07:05 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id w30-20020a50d79e000000b004acb696a0f6sm3523281edi.91.2023.02.27.12.07.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 12:07:05 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id cq23so30813491edb.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2023 12:07:04 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr13023299ejx.0.1677528424547; Mon, 27 Feb
 2023 12:07:04 -0800 (PST)
MIME-Version: 1.0
References: <1677527001-17459-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1677527001-17459-1-git-send-email-george.kennedy@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 12:06:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjaz=muuHR-bS9KfELeMf56z1BS2ecB9isAKxf0EwqCYQ@mail.gmail.com>
Message-ID: <CAHk-=wjaz=muuHR-bS9KfELeMf56z1BS2ecB9isAKxf0EwqCYQ@mail.gmail.com>
Subject: Re: [PATCH] vc_screen: modify vcs_size() handling in vcs_read()
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

On Mon, Feb 27, 2023 at 11:43=E2=80=AFAM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Restore the vcs_size() handling in vcs_read() to what
> it had been in previous version.
>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Please also add a

   Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data
pointer in vcs_read() to avoid UAF")

or whatever it was that broke this, so that we have that context to
what the "previous version" actually was.

               Linus
