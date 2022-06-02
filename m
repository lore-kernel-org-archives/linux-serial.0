Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD80C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jun 2022 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiFBIf2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIf0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jun 2022 04:35:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2476C1FD9E2;
        Thu,  2 Jun 2022 01:35:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l204so7103074ybf.10;
        Thu, 02 Jun 2022 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fyv5qXxzRNlKcviUT5bygdy56T+SSeZ5/D4qh4GaJ0A=;
        b=qh3siJ0ZDSNbxxC4A4CsxhfazOwNXCJwRuTjBIKb3jsLY0Gq1yx3fW8iJeV1sjIj8B
         z/ffvyWHo+mt/46cfhhJk0/dHa8bF22XEMNbLklweze5HaMcSWyP5E4UMXDIQCGRWg6J
         l6ySKFNBJHuyZezDl6q2iu4Q7BBx34ivlbasf4AukcHYTrCDphbhISrYsBNnVbDsYSgd
         Ztj25La3vbV61aml3p+GRbIbAhvRA/uIVNTFlH7JCNInmfFlvgKYldXAoVzvibYV05pR
         CEX7etZUYaM3/A3J2QfUoojtvsZFZGRjI9yFWTz2pINn8QpxfKT5gxJ00LplH+Kew6i0
         wn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fyv5qXxzRNlKcviUT5bygdy56T+SSeZ5/D4qh4GaJ0A=;
        b=lXZzx6P4mq78qpscjM245Zpup7gDIMZhQGpI0qk89TuBGSDMlpsdRaU3K7Gq7fQCuq
         cO/cJDl2ogRv2tXWPzLy+IgvEZBHHORcQvbE1Uu4lxJCF/1xYEVJgibduiJQysmi5xNL
         uIiGFlFjEKP1N3xjgpRizTix5MMdOI/WWeExNHCeRvuUTyLgrtOCLNrJXXPI84buI7MD
         ImKwu6+bzE+P0A0UyvHYchLwVZ4hdvl4bRXnUWcxBM3qwWwjpkldE07cN6ptLIUaHbb7
         z8WnvzETrLGN5+O18KAaCxpKz1dlzYb2FL0971TimgAjvPe/t0T0hHk35y6O+p81YSzN
         AF6g==
X-Gm-Message-State: AOAM531jY3ogoLBZojZzgXgVRBQ+SQ5ASTtwq8vxP/hVxBDPP8aA+yv2
        r9avlEAu9OBYL9figWg+Aeal3yYsj1KWI5rvHlhMIGfT
X-Google-Smtp-Source: ABdhPJxH6XEghFHDdpos+Xl2mWZyzTjeqluvnrO3eIGlg1FS01vOR1J8dLdTBrMHRSpjEtnHIhUKVnkuiOvZbJ/AlGA=
X-Received: by 2002:a25:945:0:b0:65c:e3e8:b04 with SMTP id u5-20020a250945000000b0065ce3e80b04mr4091820ybm.441.1654158924403;
 Thu, 02 Jun 2022 01:35:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Thu, 2 Jun 2022 01:35:23
 -0700 (PDT)
In-Reply-To: <dbec85f5-7b28-3d0b-6b39-bd4296a49a70@kernel.org>
References: <20220531043356.8CAB637401A9@freecalypso.org> <20220531043655.DDF783740232@freecalypso.org>
 <dbec85f5-7b28-3d0b-6b39-bd4296a49a70@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Thu, 2 Jun 2022 00:35:23 -0800
Message-ID: <CA+uuBqacb3X+km-3EtdRxaWi0FvxZWCv8RpCo-+qaNkT-=JAgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] serial: core: add sysfs attribute to suppress
 ready signalling on open
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Jiri Slaby wrote:

> s@ttyS0@ttyS<x>@
> [...]
> sysfs_emit()? (Even if I know %d won't overflow PAGE_SIZE :P.)

Thanks for the feedback - saving it for v3 of my patch series.

Any comments, positive or negative, on the principal/philosophical
idea behind this proposed patch series?

M~
