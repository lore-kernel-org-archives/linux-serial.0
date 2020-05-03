Return-Path: <SRS0=CAi2=6R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF9C28CBC
	for <linux-serial@archiver.kernel.org>; Sun,  3 May 2020 07:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706CF2073E
	for <linux-serial@archiver.kernel.org>; Sun,  3 May 2020 07:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sacZDSjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgECHVD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 3 May 2020 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgECHVC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 3 May 2020 03:21:02 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7787BC061A0C
        for <linux-serial@vger.kernel.org>; Sun,  3 May 2020 00:21:02 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c16so8336762ilr.3
        for <linux-serial@vger.kernel.org>; Sun, 03 May 2020 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lxZr5u8pK6Z0N3cPUw9BD0J+PKLsMzGVcFGMpZzdRuU=;
        b=sacZDSjpjAffHvVigi5UP8XeEqn512f9fOxTohoIItv3dB21nWoO2qW2ogRapF7axM
         YuO7z118ed/CqOOaPWAVyRNIZJpx5Vl/qs5EO3r0coP23iMX7M1hSLFdsf0ayPKBB3x+
         1tqW5DNKo+3uJgHMSVaxvUrsGxgyEA1SsOX+wfumM3L6ghJ/MDxcgk+0QQz0IVODRqeD
         aXkmy90F5t0Ok6MvcZuamxcMxv9CXL/G8yy1cWmEtHCfG/9Tc08pwAG/OkYcAOIPYEr5
         cMVfH15OffsFojz928vVeJT/jMI//wV4m63kzEeCFyAvjJI72QsoJYfkrbq1F6moX0Cb
         uHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=lxZr5u8pK6Z0N3cPUw9BD0J+PKLsMzGVcFGMpZzdRuU=;
        b=OZWHf0T+XNfRoo40EsJqLaD8f79GaLIgx+RYaEDoxp4yoADfKoYj/yae+BVe2sUqbN
         xXI9zsK01tZPP9kVVbjKgKDSTYQURNfVCVW7DnfZhvhjlJ7qQzUHhyl/o9t+boV0xjPx
         PA/i6AHdtpjoeUYq8a89f6ryl6rPV3FKMHYYIz//R6crw6Vcdr1nMPfRhGlFcraE48u8
         oWEftdlzHqVaaf2weeEJ4TPxnou0mYN4zlEZTVG/cB1hE7gJNazUjCM0JnuChnIVajgI
         g8snZ3oQi9nDxHEvTEJtBrRlCGbamOtDBTVheNgXVTbB77SZbUhPER7XDmWy6IbjvEyl
         Cl/A==
X-Gm-Message-State: AGi0PuYto+D3yHlnaxqaJiyHnifkCZzZEL5wZ56VJ6UG5dLSVgV9m/7N
        QDTGhzmqQeHje0M8LcVnjuFNktvBejKjqstDcXbcqPNl
X-Google-Smtp-Source: APiQypLNTEg/R+0irF1KtmQT86KRN9/xC+Wa6PEYz0xO2M76CfTuJWFsTk91Z5fK00b0tNJLkEEarQw9B557XWXuGR0=
X-Received: by 2002:a92:3c0f:: with SMTP id j15mr10790813ila.201.1588490461655;
 Sun, 03 May 2020 00:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSR4cs_pVwH1Tcf4-pyKr3-TPtvS34Av-2jGA7L4MmTX-_4rw@mail.gmail.com>
In-Reply-To: <CAFSR4cs_pVwH1Tcf4-pyKr3-TPtvS34Av-2jGA7L4MmTX-_4rw@mail.gmail.com>
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Sun, 3 May 2020 15:20:50 +0800
Message-ID: <CAFSR4ctg3xM_Z+oqVWjA9+hy+Cc33FfVqa5LgFAEkgUO1RxX1A@mail.gmail.com>
Subject: Fwd: Possible null pointer dereference in con_init()
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I am a security researcher, my name is Dongyang Zhan. I found a potential b=
ug.

I hope you can help me to confirm it.

Thank you.

In Linux 4.10.17, function con_init() in /drivers/tty/vt/vt.c forgets
to handle the failure of the memory allocation operation (e.g.,
vc_cons[currcons].d =3D vc =3D kzalloc(sizeof(struct vc_data),
GFP_NOWAIT)).

Source code and comments=EF=BC=9B
vc_cons[currcons].d =3D vc =3D kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
tty_port_init(&vc->port);
visual_init(vc, currcons, 1);
vc->vc_screenbuf =3D kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
vc_init(vc, vc->vc_rows, vc->vc_cols,
currcons || !vc->vc_sw->con_save_screen);

If the allocation fails, dereferencing vc will cause a null pointer derefer=
ence.
