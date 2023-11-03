Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FCBC4332F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Nov 2023 05:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjKCFaR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Nov 2023 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKCFaP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 01:30:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74881AC
        for <linux-serial@vger.kernel.org>; Thu,  2 Nov 2023 22:30:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40837124e1cso55975e9.0
        for <linux-serial@vger.kernel.org>; Thu, 02 Nov 2023 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698989407; x=1699594207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlVR8QRqa6BNovguuOvjNcB2XbgZYpndIMlcSdyhIKk=;
        b=slzTSNZ6XVgZqNVm2h8qmjxlEf1f6Of3mlm35GSrxny0UWKazSIrxJ6HUiaY0/UtEq
         TTHl/Li0oS7JHel5au2E47ZlznT8OZo5HLepISJ/HdTkM/tRksDnlc8Jukc3eTAPIn/v
         LjI0/5Q6BUv4yQaiVbnrnfGk7tbXEsgIDnA/rUbhWFvQdZU1fdTAdTXlK4fih42LOEYT
         qf7G0SwOFfCsO5HAHwWcQyKzI9JGn5xBdTSXtgyEu5cr6SQH23v5l+2cdX448Y2hy9TF
         K0jtkPnSqmwk3lhGuefZcRX1cb0iUiOtn8zCc/LkF2dVvsNrYy7VMmAeZRbEApquHezG
         WBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698989407; x=1699594207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlVR8QRqa6BNovguuOvjNcB2XbgZYpndIMlcSdyhIKk=;
        b=lQ8zgwggWjE0byavthMpVcX0emnh6SKm/ORg1IrxAhoOFSsrAINSyLlWJk6ZMokwU+
         vUyv7lJfDLqCTfremzNRw5Wr/DzPGmFlGvoW9yE/JtPEaUi6mvlok29rpv+3J1bZwIuI
         9lZhlQwN5t3DYBZc5A6SiQ/6asCWPIn9Fntwr2RF2uY86jsc9h/oO3a3xxqr9TnndlVp
         DlKQZV5DoEcwc05G/Ug4b+G2OcoapyA2y5vMROhQMUVuWtAlNKHOL4CvsF06EOlcPaZA
         7fhvWd9T8I1pp2yACrd4Z18zx30EmGNcOPJqexikDsvr5Q+ceE10ViFLP8d8D/z0WJCV
         oHEQ==
X-Gm-Message-State: AOJu0Ywl90ihOU7ADMlG4WtLOsl23qmqZZSlk0cSFyd5nVy7GidVx/qJ
        heFEZPuxzc07g9zCnhsUjYjmHbJ7dLZrZCysA+uaIg==
X-Google-Smtp-Source: AGHT+IGq94xQCOfsk42Y0eMgQKqNGI9rcaWRUAUnjogydVsanIYh8uCplA5v4zGmBPgP5LfDgSLMYwgoR+uNOgOIb4g=
X-Received: by 2002:a7b:c8c6:0:b0:408:3725:b96a with SMTP id
 f6-20020a7bc8c6000000b004083725b96amr150219wml.0.1698989407031; Thu, 02 Nov
 2023 22:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
In-Reply-To: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Fri, 3 Nov 2023 10:59:54 +0530
Message-ID: <CAMTSyjpktaNQd+A9oOZiS6D0heGNV5KLPrqoCfzqU9bkgC74aQ@mail.gmail.com>
Subject: Re: tldp serial-howto subscribe link
To:     m.brock@vanmierlo.com
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Maarten,

I checked, it's mailing to majordomo@vger.rutgers.edu

Thanks,
Vamshi G.

On Thu, Nov 2, 2023 at 10:31=E2=80=AFPM <m.brock@vanmierlo.com> wrote:
>
> Hello,
>
> On the TLDP Serial HOWTO page 22.4 Serial Mailing List it says to mail
> to majordomo@vger.kernel.org to subscribe.
> However the link behind the visible text links to
> majordomo@vger.rutgers.edu
> This looks very dodgy to me.
> https://tldp.org/HOWTO/Serial-HOWTO-22.html
>
> Can anyone verify this?
>
> Maarten
>
